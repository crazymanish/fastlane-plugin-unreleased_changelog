require 'fastlane/action'
require_relative '../helper/unreleased_changelog_helper'

module Fastlane
  module Actions
    class DeleteUnreleasedChangelogAction < Action
      def self.run(params)
        require 'yaml'

        changelog_entry = params[:entry]
        changelog_file_name = "#{params[:file_name]}.yml"
        UI.important("Deleting \"#{changelog_entry}\" from the unreleased changelog 🚥")

        # finding changelog file path
        changelog_file_path = Helper::UnreleasedChangelogHelper.changelog_file_path(changelog_file_name)
        unreleased_section_name = Helper::UnreleasedChangelogHelper.unreleased_section_name

        # opening the changelog file
        changelog = YAML.load_file(changelog_file_path)

        # finding the unreleased changelog
        unreleased_changelog = changelog[unreleased_section_name]

        # deleting entry from unreleased changelog
        changelog_types = Helper::UnreleasedChangelogHelper.changelog_types
        changelog_types.each do |changelog_type|
          delete_changelog(changelog_entry, changelog_type, unreleased_changelog)
        end

        # saving the changelog file
        File.open(changelog_file_path,"w") do |file|
          file.write changelog.to_yaml
        end

        UI.success("Successfully deleted \"#{changelog_entry}\" from the unreleased changelog. 🔥")
      end

      def self.delete_changelog(entry, type, unreleased_changelog)
        if unreleased_changelog[type]
          unreleased_changelog[type] = unreleased_changelog[type].reject do |changelog|
            changelog.include?(entry)
          end

          unreleased_changelog[type] = nil if unreleased_changelog[type].to_a.empty?
        end
      end

      def self.description
        "Delete changelog entry from unreleased changelog"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :entry,
                                       env_name: "FL_DELETE_UNRELEASED_CHANGELOG_ENTRY",
                                       description: "The changelog entry in string format",
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :file_name,
                                       env_name: "FL_DELETE_UNRELEASED_CHANGELOG_FILE_NAME",
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
          'delete_unreleased_changelog(entry: "Some changelog entry")',
          'delete_unreleased_changelog(entry: "Some changelog entry", file_name: "changelog_file_name")'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
