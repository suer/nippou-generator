require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "date"
require "fileutils"

module Nippou
  module GoogleCalendar
    class API
      def initialize(config)
        @config = config
      end

      def prepare
        prepare_token
      end

      def list(since_date: Date.today)
        events_by_day = {}
        events(since_date: since_date).each do |event|
          start_date, start_time = if event.start.date
            [event.start.date, '00:00']
          elsif event.start.date_time
            [event.start.date_time.strftime('%Y-%m-%d'), event.start.date_time.strftime('%H:%M')]
          end
          finish_time = if event.end.date
            '23:59'
          elsif event.end.date_time
            event.start.date_time.strftime('%H:%M')
          end
          events_by_day[start_date] = [] unless events_by_day[start_date]
          events_by_day[start_date] << "- #{start_time}-#{finish_time} #{event.summary}"
        end

        markdown = '**Calendar**'
        markdown << "\n"
        Hash[events_by_day.sort].each do |date, summaries|
          markdown << "- #{date}\n"
          markdown << summaries.map {|s| "  #{s}"}.join("\n")
          markdown << "\n"
        end
        markdown << "\n"
        markdown
      end

      private
      attr_reader :config

      def events(since_date:)
        service = Google::Apis::CalendarV3::CalendarService.new
        service.client_options.application_name = 'nippou-generator'
        service.authorization = authorize
        config.gcal_calendar_ids.map do |calendar_id|
          option = {
            max_results:   100,
            single_events: true,
            order_by:      'startTime',
            time_min:      since_date.rfc3339,
            time_max:      (Date.today + 1).rfc3339
          }
          response = service.list_events(calendar_id, option)
          response.items
        end.flatten
      end

      def authorizer
        client_id = Google::Auth::ClientId.from_file(config.gcal_credentials_path)
        token_store = Google::Auth::Stores::FileTokenStore.new(file: config.gcal_token_store_path)
        Google::Auth::UserAuthorizer.new(client_id, Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY, token_store)
      end

      OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze

      def prepare_token
        url = authorizer.get_authorization_url(base_url: OOB_URI)
        puts "access your browser to\n#{url}\nthen set config file yaml of gcal.code"
      end

      def authorize
        authorizer.get_credentials('default')
      end
    end
  end
end
