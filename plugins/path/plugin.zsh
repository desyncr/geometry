# Color definitions
GEOMETRY_COLOR_EXIT_VALUE=${GEOMETRY_COLOR_EXIT_VALUE:-magenta}
GEOMETRY_COLOR_PROMPT=${GEOMETRY_COLOR_PROMPT:-white}
GEOMETRY_COLOR_ROOT=${GEOMETRY_COLOR_ROOT:-red}
GEOMETRY_COLOR_DIR=${GEOMETRY_COLOR_DIR:-blue}

GEOMETRY_PROMPT_PREFIX=${GEOMETRY_PROMPT_PREFIX-$'\n'}
GEOMETRY_PROMPT_PREFIX_SPACER=${GEOMETRY_PROMPT_PREFIX_SPACER-" "}

GEOMETRY_SYMBOL_PROMPT=${GEOMETRY_SYMBOL_PROMPT-"▲"}
GEOMETRY_SYMBOL_EXIT_VALUE=${GEOMETRY_SYMBOL_EXIT_VALUE-"△"}
GEOMETRY_DIR_SPACER=${GEOMETRY_DIR_SPACER-""}
# Misc configurations
GEOMETRY_PROMPT_SUFFIX=${GEOMETRY_PROMPT_SUFFIX-""}
GEOMETRY_SYMBOL_SPACER=${GEOMETRY_SYMBOL_SPACER-" "}

PROMPT_GEOMETRY_COLORIZE_SYMBOL=${PROMPT_GEOMETRY_COLORIZE_SYMBOL:-false}
PROMPT_GEOMETRY_COLORIZE_ROOT=${PROMPT_GEOMETRY_COLORIZE_ROOT:-false}

# Symbol definitions
GEOMETRY_SYMBOL_RPROMPT=${GEOMETRY_SYMBOL_RPROMPT-"◇"}
GEOMETRY_SYMBOL_ROOT=${GEOMETRY_SYMBOL_ROOT-"▲"}

# Combine color and symbols
GEOMETRY_EXIT_VALUE=$(prompt_geometry_colorize $GEOMETRY_COLOR_EXIT_VALUE $GEOMETRY_SYMBOL_EXIT_VALUE)
GEOMETRY_PROMPT=$(prompt_geometry_colorize $GEOMETRY_COLOR_PROMPT $GEOMETRY_SYMBOL_PROMPT)

if $PROMPT_GEOMETRY_COLORIZE_SYMBOL; then
  GEOMETRY_COLOR_PROMPT=$(prompt_geometry_hash_color $HOST)
  GEOMETRY_PROMPT=$(prompt_geometry_colorize $GEOMETRY_COLOR_PROMPT $GEOMETRY_SYMBOL_PROMPT)
fi

geometry_prompt_path_setup() {}

geometry_prompt_path_check() {}

geometry_prompt_path_render() {
  if [ $? -eq 0 ] ; then
    PROMPT_SYMBOL=$GEOMETRY_SYMBOL_PROMPT
  else
    PROMPT_SYMBOL=$GEOMETRY_SYMBOL_EXIT_VALUE
  fi

  # TODO make plugin root.zsh
  if $PROMPT_GEOMETRY_COLORIZE_ROOT && [[ $UID == 0 || $EUID == 0 ]]; then
    GEOMETRY_PROMPT=$(prompt_geometry_colorize $GEOMETRY_COLOR_ROOT $GEOMETRY_SYMBOL_ROOT)
  fi

  echo "$GEOMETRY_PROMPT_PREFIX$GEOMETRY_PROMPT_PREFIX_SPACER%${#PROMPT_SYMBOL}{%(?.$GEOMETRY_PROMPT.$GEOMETRY_EXIT_VALUE)%}$GEOMETRY_SYMBOL_SPACER%F{$GEOMETRY_COLOR_DIR}%3~%f$GEOMETRY_DIR_SPACER$GEOMETRY_PROMPT_SUFFIX"
}