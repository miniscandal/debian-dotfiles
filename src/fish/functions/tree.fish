# File: tree.fish
# Description: Custom function to display directory structure using eza.

function tree --description 'Custom function to display directory structure using eza'
    set -l args --tree --level=2

    if test "$argv[1]" = -m
        set -e argv[1]
        env LC_ALL=C eza $args --color=never $argv
    else
        eza $args --icons $argv
    end
end
