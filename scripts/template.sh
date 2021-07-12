#!/bin/bash

set -e
# to be used with:
# au BufNewFile $vimwikidir/*.md :silent 0r !$vimwikidir/template.sh '%'

filename=$(basename "$@" .md | xargs)
title="$(printf "%s" "$filename" | sed -e 's/.*/\L&/; s/[a-z]*/\u&/g' -e 's/^[l-z]../\U&/g')"

cat << EOF
---
title: $title
date: $(date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
---
# $title
EOF
