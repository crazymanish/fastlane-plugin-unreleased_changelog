require 'fastlane/action'
require_relative '../helper/unreleased_changelog_helper'

module Fastlane
  module Actions
    class AddUnreleasedChangelogAction < Action
      def self.run(params)
        require 'yaml'

        changelog_file_name = "#{params[:file_name]}.yml"
        UI.important("Adding unreleased changelog: \"#{changelog_file_name}\" 🚥")

        # finding changelog file path
        changelog_file_path = Helper::UnreleasedChangelogHelper.changelog_file_path(changelog_file_name)
        unreleased_section_name = Helper::UnreleasedChangelogHelper.unreleased_section_name

        # opening the changelog file
        changelog = YAML.load_file(changelog_file_path)

        # finding the unreleased changelog
        unreleased_changelog = changelog[unreleased_section_name] || {}

        # adding a new entry in changelog file
        (unreleased_changelog[params[:type]] ||= []) << params[:entry]

        # saving the changelog file
        changelog[unreleased_section_name] = unreleased_changelog
        File.open(changelog_file_path,"w") do |file|
          file.write changelog.to_yaml
        end

        UI.success("Successfully added a new entry in unreleased changelog. 📝")
      end

      def self.description
        "Add a new entry in unreleased changelog"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :entry,
                                       env_name: "FL_ADD_UNRELEASED_CHANGELOG_ENTRY",
                                       description: "The changelog entry in string format",
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :type,
                                       env_name: "FL_ADD_UNRELEASED_CHANGELOG_TYPE",
                                       description: "The type of changelog i.e Added, Fixed, Security etc (default: Added) ",
                                       default_value: "Added"),
          FastlaneCore::ConfigItem.new(key: :file_name,
                                       env_name: "FL_ADD_UNRELEASED_CHANGELOG_FILE_NAME",
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
          'add_unreleased_changelog(entry: "Some changelog entry")',
          'add_unreleased_changelog(entry: "Some changelog entry", type: "Fixed")',
          'add_unreleased_changelog(entry: "Some changelog entry", type: "Fixed", file_name: "changelog_file_name")'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
