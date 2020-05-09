# unreleased_changelog plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-unreleased_changelog)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-unreleased_changelog`, add it to your project by running:

```bash
fastlane add_plugin unreleased_changelog
```

## About unreleased_changelog
A fastlane plugin to manage unreleased changelog using a YAML file. 🚀

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

### 🕵🏻 ensure_unreleased_changelog

Ensures the content of the `Unreleased` section from your project's `Changelog.yml` file. 

``` ruby
ensure_unreleased_changelog	# Raises an exception if Unreleased section is empty
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


## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

**Note to author:** Please set up a sample project to make it easy for users to explore what your plugin does. Provide everything that is necessary to try out the plugin in this project (including a sample Xcode/Android project if necessary)

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
