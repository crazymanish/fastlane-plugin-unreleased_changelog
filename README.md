## Fastlane `unreleased_changelog` plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-unreleased_changelog)  [![Twitter: @manish](https://img.shields.io/badge/contact-@manish-blue.svg?style=flat)](https://twitter.com/manish_rathi_)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-unreleased_changelog`, add it to your project by running:

```bash
fastlane add_plugin unreleased_changelog
```

## About unreleased_changelog
A fastlane plugin to manage unreleased changelog using a YML file. 🚀

This plugin is inspired by and based on [Keep a CHANGELOG](http://keepachangelog.com/) project. [Keep a CHANGELOG](http://keepachangelog.com/) proposes a standardised format for keeping change log of your project repository in `Changelog.yml` file. This file contains a curated, chronologically ordered list of notable changes for each version of a project in human readable format.

Since [Keep a CHANGELOG](http://keepachangelog.com/) project proposes a well-defined structure with _sections_ (e.g.: `[Unreleased]`, `[0.3.0]`) and _subsections_ (`Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`) it opens up an opportunity to automate reading from/writing to `Changelog.yml` with [`fastlane`](https://fastlane.tools). 

## YML changlog file structure
`Changelog.yml` file must follow structure proposed by [Keep a CHANGELOG](http://keepachangelog.com/) project. 

```yml
Unreleased:
  Added:
  - added new feature 1.1
  - added new feature 2.1
  Removed:
  - removed deprecated feature XYZ
  Fixed:
  - bug-fix 3
[0.1.0-Release] - 2020-04-30:
  Added:
  - added new feature 1
  - added new feature 2
  Fixed:
  - bug-fix 1
  - bug-fix 2
```

## Actions
`fastlane-plugin-unreleased_changelog` consists of 5 actions enabling you to manipulate `Changelog.yml` from [`fastlane`](https://fastlane.tools).

### 🔎 ensure_unreleased_changelog

Ensures the content of the `Unreleased` section from your project's `Changelog.yml` file. Raises an exception if `Unreleased` section found empty, **print** the `Unreleased` section changelog if found.

``` ruby
ensure_unreleased_changelog	# Raises an exception if `Unreleased` section is empty
```

``` ruby
ensure_unreleased_changelog(
  file_name: 'custom_changelog_file_name',	# Specify the custom YML changelog file name (dafault `changelog`)
  show_diff: false	# Show the `Unreleased` section changelog, if found. (dafault true)
)
```

### 📝 add_unreleased_changelog

Add a new entry inside your `Unreleased` section of your project's `Changelog.yml` file.

``` ruby
add_unreleased_changelog(
  entry: "added new feature" # Add new changelog entry inside `Unreleased` section's `Addded` _subsections_
)	
```

``` ruby
add_unreleased_changelog(
  entry: "bug-fix 1", # New changelog entry for `Unreleased` section
  type: "Fixed"  # Add new changelog entry inside `Fixed` _subsections_ (dafault `Added`)
)	
```

``` ruby
add_unreleased_changelog(
  entry: "bug-fix 1", # New changelog entry for `Unreleased` section
  type: "Fixed",  # Add new changelog entry inside `Fixed` _subsections_ (dafault `Added`)
  file_name: 'custom_changelog_file_name'	# Specify the custom YML changelog file name (dafault `changelog`)
)	
```

### ✂️ delete_unreleased_changelog

Delete an entry from your `Unreleased` section of your project's `Changelog.yml` file. Very handly, if your `Changelog.yml` contains Project tickets i.e JIRA ticket(s) etc and you want to automatically delete some changelog entry based on JIRA ticket number. 

``` ruby
delete_unreleased_changelog(
  entry: "some feature number" # Delete changelog entry from `Unreleased` section
)	
```

``` ruby
delete_unreleased_changelog(
  entry: "bug-fix 1", # Delete changelog entry from `Unreleased` section
  file_name: 'custom_changelog_file_name'	# Specify the custom YML changelog file name (dafault `changelog`)
)	
```

### 📮get_unreleased_changelog

Get all the `Unreleased` section changelog of your project's `Changelog.yml` file. It will ruturn the Array for hash for `Unreleased` section's _subsections_ (`Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`). Based on your workflow you can do what-ever you want with `Unreleased` changelog. 💪🏻

``` ruby
get_unreleased_changelog
```

``` ruby
get_unreleased_changelog(
  file_name: 'custom_changelog_file_name'	# Specify the custom YML changelog file name (dafault `changelog`)
)	
```

### 🕹stamp_unreleased_changelog

Stamps the `Unreleased` section with provided tag in your project `Changelog.yml` file and sets up a new `Unreleased` section above it for upcoming release.

``` ruby
stamp_unreleased_changelog(
  tag: 'v0.1.0'	# The tag, (usually a git-tag name) for stamping the `Unreleased` section
)	
```

``` ruby
stamp_unreleased_changelog(
  tag: 'v0.1.0',	# The tag, (usually a git-tag name) for stamping the `Unreleased` section
  file_name: 'custom_changelog_file_name'	# Specify the custom YML changelog file name (dafault `changelog`)
)	
```

## Example

You have to **remember to keep your Changelog.yml up-to-date** with whatever features, bug fixes etc. your repo contains and let [`fastlane`](https://fastlane.tools) do the rest. 

``` ruby
desc "Upload a iOS beta build to Testflight with changelog."
lane :beta do
  ensure_unreleased_changelog	# Making sure changelog exist!
  
  gym # Build the app and create .ipa file
  
  changelog = get_unreleased_changelog # Get changelog
  pilot(changelog: changelog) # Upload beta build to TestFlight with changelog
  
  version_number = get_version_number # Get project version
  build_number = get_build_number # Get build number
  git_tag_name = "#{version_number}-#{build_number}-beta-release"
  
  stamp_unreleased_changelog(tag: git_tag_name) # Stamp Unreleased section
  git_commit(path: ".", message: "#{git_tag_name} Beta release") # git commit `Changelog.yml` file
  
  add_git_tag(tag: git_tag_name)  # Add git tag
  push_to_git_remote # Push `Changelog.yml` file and git-tag to remote 
  
  slack(message: "Hi team, we have a new beta build #{git_tag_name}, which includes the following: #{changelog}") # share on Slack
end
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
