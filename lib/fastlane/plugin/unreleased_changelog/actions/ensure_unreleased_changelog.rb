require 'fastlane/action'
require_relative '../helper/unreleased_changelog_helper'

module Fastlane
  module Actions
    class EnsureUnreleasedChangelogAction < Action
      def self.run(params)
        # reading unreleased changelog
        unreleased_changelog = GetUnreleasedChangelogAction.run(file_name: params[:file_name])

        # checking unreleased changelog
        is_empty_unreleased_changelog = true
        changelog_types = Helper::UnreleasedChangelogHelper.changelog_types
        changelog_types.each do |changelog_type|
          is_empty_unreleased_changelog = false unless unreleased_changelog[changelog_type].nil?

          # printing unreleased changelog, if needed.
          if params[:show_diff]
            self.print_unreleased(unreleased_changelog, changelog_type)
          end
        end

        UI.user_error!("No unreleased changelog found 🔥🛑") if is_empty_unreleased_changelog
      end

      def self.print_unreleased(changelog, type)
        require 'terminal-table'

        changelog_type = changelog[type]

        if changelog_type.nil?
          UI.important("Unreleased \"#{type}\" changelog does not exist! ⁉️")
        else
          UI.success("Unreleased \"#{type}\" changelog found! 🍻")

          formatted_changelog = changelog_type.map {|changelog| [changelog]}
          table = Terminal::Table.new(title: "Unreleased \"#{type}\" changelog", rows: formatted_changelog)
          puts table
        end
      end

      def self.description
        "Raises an exception if there are no unreleased release notes changelog"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file_name,
                                       env_name: "FL_ENSURE_UNRELEASED_CHANGELOG_FILE_NAME",
                                       description: "The YML file name to your release changelog, (default: 'changelog')",
                                       is_string: true,
                                       default_value: "changelog"),
          FastlaneCore::ConfigItem.new(key: :show_diff,
                                       env_name: "FL_ENSURE_UNRELEASED_CHANGELOG_SHOW_DIFF",
                                       description: "The flag whether to show the unreleased changelog if found",
                                       optional: true,
                                       default_value: true,
                                       is_string: false)
        ]
      end

      def self.authors
        ["crazymanish"]
      end

      def self.example_code
        [
          'ensure_unreleased_changelog',
          'ensure_unreleased_changelog(file_name: "changelog_file_name")'
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
