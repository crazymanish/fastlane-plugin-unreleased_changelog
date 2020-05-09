require 'fastlane/action'
require_relative '../helper/unreleased_changelog_helper'

module Fastlane
  module Actions
    class StampUnreleasedChangelogAction < Action
      def self.run(params)
        require 'yaml'

        changelog_file_name = "#{params[:file_name]}.yml"
        UI.important("Stamping unreleased changelog: \"#{changelog_file_name}\" 🚥")

        # finding changelog file path
        changelog_file_path = Helper::UnreleasedChangelogHelper.changelog_file_path(changelog_file_name)
        unreleased_section_name = Helper::UnreleasedChangelogHelper.unreleased_section_name

        # update unreleased release-notes changelog with release_name
        changelog = YAML.load_file(changelog_file_path)
        stamping_changelog = {params[:tag]=> changelog[unreleased_section_name]}
        changelog.delete(unreleased_section_name)

        # create new unreleased release-notes changelog section for upcoming release
        upcoming_release_changelog = {unreleased_section_name=> nil}
        upcoming_release_changelog.merge!(stamping_changelog)
        upcoming_release_changelog.merge!(changelog)

        # save release notes changelog file
        File.open(changelog_file_path,"w") do |file|
          file.write upcoming_release_changelog.to_yaml
        end

        UI.success("Successfully stamp the unreleased changelog with \"#{params[:tag]}\" tag. 🕹")
      end

      def self.description
        "Stamp unreleased changelog"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :tag,
                                       env_name: "FL_STAMP_UNRELEASED_CHANGELOG_TAG_NAME",
                                       description: "The tag, (usually a git-tag name) for Unreleased section",
                                       verify_block: proc do |value|
                                         UI.user_error!("No Unreleased tag given inside input params") unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :file_name,
                                       env_name: "FL_STAMP_UNRELEASED_CHANGELOG_FILE_NAME",
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
          'stamp_unreleased_changelog(tag: "v1.0.0")',
          'stamp_unreleased_changelog(tag: "v1.0.0", file_name: "changelog_file_name")'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
