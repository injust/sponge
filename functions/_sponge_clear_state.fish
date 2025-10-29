function _sponge_clear_state
    set -ge _sponge_current_command
    set -ge _sponge_current_command_exit_code
    set -ge _sponge_current_command_previously_in_history
end
