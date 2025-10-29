function sponge_filter_matched \
    --argument-names command

    for pattern in $sponge_regex_patterns
        if string match -rq $pattern -- $command
            return
        end
    end

    return 1
end
