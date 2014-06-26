#!/usr/bin/zsh
# Wrapper for shell scripting in the arc language.

arc_dir=$(dirname "$(readlink -f "$0")")
racket -f $arc_dir/asv.scm $*
