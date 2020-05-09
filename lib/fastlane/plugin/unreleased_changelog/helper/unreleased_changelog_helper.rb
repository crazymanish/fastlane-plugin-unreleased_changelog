require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class UnreleasedChangelogHelper
      # class methods that you define here become available in your action
      # as `Helper::UnreleasedChangelogHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the unreleased_changelog plugin helper!")
      end
    end
  end
end
