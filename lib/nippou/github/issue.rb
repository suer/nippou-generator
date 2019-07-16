module Nippou
  module Github
    class Issue
      attr_reader :updated_at, :closed_at, :title, :url, :repository, :state, :labels
      def initialize(issue)
        @title = issue.title
        @url = issue.html_url
        @repository = issue.repository_url.split('/').last
        @updated_at = issue.updated_at
        @closed_at = issue.closed_at
        @state = issue.state
        @labels = issue.labels
      end

      def to_markdown(with_status: false)
        "[#{title}](#{url}) #{with_status ? status : ''}"
      end

      private
      def status
        if state == 'closed'
          '(Merged)'
        elsif wip?
          '(WIP)'
        elsif review?
          '(REVIEW)'
        end
      end

      def wip?
        has_label?('WIP')
      end

      def review?
        has_label?('REVIEW')
      end

      def has_label?(label_name)
        labels.any? { |label| label.name == label_name }
      end
    end
  end
end
