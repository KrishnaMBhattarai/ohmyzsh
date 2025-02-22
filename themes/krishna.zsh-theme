# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg_bold[green]}%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"

# Function to show the Git branch and status
git_branch() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    local git_status=""
    if git diff --quiet && git diff --cached --quiet; then
      git_status=$ZSH_THEME_GIT_PROMPT_CLEAN
    else
      git_status=$ZSH_THEME_GIT_PROMPT_DIRTY
    fi
    echo "%{${fg[green]}%}[git::$branch$git_status]%{$reset_color%}"
  fi
}

# Function to show virtual environment info
virtualenv_info() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "%{${fg[yellow]}%}($(basename "$VIRTUAL_ENV"))%{$reset_color%} "
}

# Function to update the prompt
update_prompt() {
  PROMPT="%{${fg_bold[green]}%}[ %{${fg[green]}%}%D{%H:%M:%S} %{${fg_bold[green]}%}] %{${fg[cyan]}%}%n%f@%F{green}%m%f:%F{magenta}%~%f "
  PROMPT+=$(virtualenv_info)  # Add virtualenv info
  PROMPT+=$(git_branch)       # Add Git branch info
  PROMPT+=" $ "
}

# Ensure the prompt is updated with Git info before the prompt is displayed
precmd_functions+=(update_prompt)

# Call update_prompt to ensure prompt is set on the first load
update_prompt
