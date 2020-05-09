require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class UnreleasedChangelogHelper

      def self.unreleased_section_name
        return 'Unreleased'
      end

      def self.changelog_types
        return ['Added', 'Changed', 'Deprecated', 'Removed', 'Fixed', 'Security']
      end

      def self.changelog_file_path(changelog_file_name)
        # finding the git repo root path
        repo_path = Fastlane::Actions::sh("git rev-parse --show-toplevel").strip

        # finding the release-notes changelog file path
        changelog_file_paths = Dir[File.expand_path(File.join(repo_path, "**/#{changelog_file_name}"))]

        # no changelog found: error
        if changelog_file_paths.count == 0
          UI.user_error!("Could not find a #{changelog_file_name} 🛑")
        end

        # too many changelog found: error
        if changelog_file_paths.count > 1
          UI.message("Found #{changelog_file_name} files at path: #{changelog_file_paths} 🙈")
          UI.user_error!("Found multiple #{changelog_file_name} 🛑")
        end

        UI.success("Found #{changelog_file_name} file at path: #{changelog_file_paths.first} 💪🏻")

        return changelog_file_paths.first
      end

    end
  end
end
