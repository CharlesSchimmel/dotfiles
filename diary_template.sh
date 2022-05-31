#!/bin/bash

# to be used with:
# au BufNewFile $vimwikidir/*.md :silent 0r !$vimwikidir/template.sh '%'

filename="$(basename "$@" '.md')"
day_of_week="$(date +%w)"
last_filename="$(ls -tr "$HOME/notes/diary" | tail -n 1)"
last_file="$HOME/notes/diary/$last_filename"
yesterdate="$(basename "$last_file" .md)"

last_contents="$(sed -n '/# ToDo/,//p' "$last_file" | grep -v '<<')"

if [[ $day_of_week -eq 5 ]]; then
    next_file="$(date --date "next Monday" +%Y-%m-%d)"
else
    next_file="$(date --date "tomorrow" +%Y-%m-%d)"
fi

cat << EOF
---
title: $filename
tags: daily
---

# Events
* 

$last_contents

[<< yesterday]($yesterdate) | [tomorrow >>]($next_file)
EOF
