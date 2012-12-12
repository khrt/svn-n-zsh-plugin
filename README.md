#SVN-n
Improved version of SVN plugin provided with the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).

###Example
For `agnoster` zsh theme:

```
prompt_svn() {
  if svn_is_inside; then
    ZSH_THEME_SVN_PROMPT_DIRTY='±'
    local ref dirty
    if svn_parse_dirty; then
      dirty=$ZSH_THEME_SVN_PROMPT_DIRTY
      prompt_segment yellow black
    else
      prompt_segment green black
    fi
    echo -n "⭠ $(svn_branch_name) $(svn_rev)$dirty"
  fi
}

...

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_svn
  prompt_end
}
```

====
Based on `oh-my-zsh/plugins/svn.plugin.zsh`.
