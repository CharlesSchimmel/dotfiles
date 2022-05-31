#!/bin/bash

# to be used with:
# au BufNewFile $vimwikidir/*.md :silent 0r !$vimwikidir/template.sh '%'

filename="$(basename "$@" '.md')"
# don't forget that the 3-character date prefix IS case-sensitive...
prefix="$(printf "%s" "$filename" | sed 's/^\([a-z][0-9a-c][0-9a-z]\).\+/\1/g')"
rest_of_title="$(printf "%s" "$filename" | sed 's/^[a-z][0-9a-c][0-9a-z]\(.\+\)/\1/g')"
title_cased="$(echo $rest_of_title | sed -e 's/.*/\L&/; s/[a-z]*/\u&/g' -e 's/^[l-z]../\U&/g')"
title="$title_cased"

cat << EOF
---
title: $title
date: $(date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
---
EOF
