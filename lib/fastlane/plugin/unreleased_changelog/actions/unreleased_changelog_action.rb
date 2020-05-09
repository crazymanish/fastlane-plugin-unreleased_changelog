require 'fastlane/action'
require_relative '../helper/unreleased_changelog_helper'

module Fastlane
  module Actions
    class UnreleasedChangelogAction < Action
      def self.run(params)
        UI.message("The unreleased_changelog plugin is working!")
      end

      def self.description
        "A fastlane plugin to manage unreleased changelog using a YAML file. 🚀"
      end

      def self.authors
        ["Manish Rathi"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "UNRELEASED_CHANGELOG_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
