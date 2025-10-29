# Sponge version
set -g sponge_version 1.1.0

# Allow to repeat previous command by default
if not set -Uq sponge_delay
    set -U sponge_delay 2
end

# Purge entries both after `sponge_delay` entries and on exit by default
if not set -Uq sponge_purge_only_on_exit
    set -U sponge_purge_only_on_exit false
end

# Add default filters
if not set -Uq sponge_filters
    set -U sponge_filters sponge_filter_failed sponge_filter_matched
end

# Don't filter out commands that already have been in the history by default
if not set -Uq sponge_allow_previously_successful
    set -U sponge_allow_previously_successful true
end

# Consider `0` the only successful exit code by default
if not set -Uq sponge_successful_exit_codes
    set -U sponge_successful_exit_codes 0
end

# No active regex patterns by default
if not set -Uq sponge_regex_patterns
    set -U sponge_regex_patterns
end

# Attach event handlers
functions -q \
    _sponge_on_prompt \
    _sponge_on_preexec \
    _sponge_on_postexec \
    _sponge_on_exit

# Initialize empty state for the first run
function _sponge_install --on-event sponge_install
    set -g _sponge_current_command ''
    set -g _sponge_current_command_exit_code 0
    set -g _sponge_current_command_previously_in_history false
end

# Clean up variables
function _sponge_uninstall --on-event sponge_uninstall
    _sponge_clear_state
    set -e sponge_version
end
