require 'fastlane/action'
require_relative '../helper/unreleased_changelog_helper'

module Fastlane
  module Actions
    module SharedValues
      GET_UNRELEASED_CHANGELOG_INFO = :GET_UNRELEASED_CHANGELOG_INFO
    end

    class GetUnreleasedChangelogAction < Action
      def self.run(params)
        require 'yaml'

        changelog_file_name = "#{params[:file_name]}.yml"
        UI.important("Reading unreleased changelog: \"#{changelog_file_name}\" 🚥")

        # finding changelog file path
        changelog_file_path = Helper::UnreleasedChangelogHelper.changelog_file_path(changelog_file_name)
        unreleased_section_name = Helper::UnreleasedChangelogHelper.unreleased_section_name

        # opening the changelog file
        changelog = YAML.load_file(changelog_file_path)

        # finding the unreleased changelog
        unreleased_changelog = changelog[unreleased_section_name]

        Actions.lane_context[SharedValues::GET_UNRELEASED_CHANGELOG_INFO] = unreleased_changelog
        return unreleased_changelog
      end

      def self.description
        "Get the unreleased changelog"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file_name,
                                       env_name: "FL_GET_UNRELEASED_CHANGELOG_FILE_NAME",
                                       description: "The YML file name to your release changelog, (default: 'changelog')",
                                       is_string: true,
                                       default_value: "changelog")
        ]
      end

      def self.authors
        ["crazymanish"]
      end

      def self.example_code
        [
          'get_unreleased_changelog',
          'get_unreleased_changelog(file_name: "changelog_file_name")'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
