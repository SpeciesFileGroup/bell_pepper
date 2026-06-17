## [Unreleased]

## [0.1.3] - 2026-06-17
 - Allow Ruby 4.0.0:
    - Relaxed `required_ruby_version` to `>= 2.5.0, < 5.0`
    - Added Ruby 4.0.0 to the CI matrix
    - Bumped `faraday-follow_redirects` upper bound to allow 0.5+ (which lifts the Ruby < 4 cap)
    - Dropped the `bundler` development dependency
    - Added `irb` development dependency (no longer in stdlib)
 - Updated license from NCSA to MIT

## [0.1.2] - 2024-09-12
 - Removed Gemfile.lock
 - Bumped development depency versions to avoid CVE-2024-43398

## [0.1.1] - 2023-04-17
- Updated Faraday version

## [0.1.0] - 2022-01-20

- Initial release
