#!/usr/bin/env fish

set colors \
    "red" \
    "green" \
    "yellow" \
    "blue" \
    "magenta" \
    "cyan"

set splashes \
    "Running on pure Nix and caffeine ☕️" \
    "Welcome to the shell — may your derivations build cleanly." \
    "fish > bash" \
    "The command line is your canvas." \
    "Evaluating life… and Nix expressions." \
    "Piping dreams into reality." \
    "No errors, only features in disguise." \
    "git commit -m 'hello world'" \
    "Your prompt is ready for adventure!" \
    "✨ May your caches stay warm." \
    "🐟 Just keep typing, just keep typing…" \
    "Welcome aboard, captain." \
    "The tide is high, but your shell is higher." \
    "Surf’s up in /home!" \
    "Caught a new session in the wild." \
    "Reeling in productivity…" \
    "Dropping into the deep shell." \
    "You got this." \
    "It’s a good day to hack something cool." \
    "Take a deep breath — the terminal awaits." \
    "Small steps, big commits." \
    "You are the sudo of your own destiny." \
    "Stay curious. Stay weird." \
    "Remember to git push your dreams." \
    "All systems nominal. Probably." \
    "Kernel says hi." \
    "Don’t forget to rm -rf impostor syndrome." \
    "Arch users say hi. Nix users say reproducibly hi." \
    "You’re in a declarative mood today."

if test -f ~/.config/fish/splashes
    set splashes (cat ~/.config/fish/splashes)
end

set prompt_color $colors[(random 1 (count $colors))]
set splash $splashes[(random 1 (count $splashes))]

function fish_greeting
    echo -s -e \
        (set_color $prompt_color) \
        "\n$splash\n" \
        (set_color normal)

end

function git_prompt
    if test (fish_git_prompt)
        set --local git_branch \
            (string replace --regex --all '\(|\)' '' (fish_git_prompt))
        echo "$git_branch "
    end
end

function fish_prompt
    set --local user_char '$'
    if fish_is_root_user
        set --local user_char '#'
    end

    set --local workdir (string replace --regex "^$HOME" '~' $PWD)

    echo -s \
        (set_color --background $prompt_color) \
        (set_color --bold black) \
        " $workdir " \
        (set_color normal) \
        (set_color $prompt_color) \
        ' ' \
        (git_prompt) \
        (set_color normal) \
        "$user_char "
end

# Keybinds

bind \cy accept-autosuggestion


# Aliases

alias man="man -P 'nvim +Man!'"

