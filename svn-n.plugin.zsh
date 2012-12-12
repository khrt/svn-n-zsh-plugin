
function svn_prompt() {
    if svn_in; then
        local ref dirty
        if svn_parse_dirty; then
            dirty=$ZSH_THEME_SVN_PROMPT_DIRTY
        fi
        echo -n "$(svn_branch_name) $(svn_rev)$dirty"
    fi
}

function svn_in() {
    if $(svn info >/dev/null 2>&1); then
        return 0
    fi
    return 1
}

function svn_working_copy() {
    if svn_in; then
        svn info 2> /dev/null | awk -F: '/^Working/ { print $2 }'
    fi
}

function svn_parse_dirty() {
    if svn_in; then
        if $(svn status $(svn_working_copy) 2> /dev/null | \
            grep -Eq '^\s*[ACDIM!?L]');
        then
            return 0
        fi
    fi
    return 1
}

function svn_repo_name() {
    if svn_in; then
        svn info | sed -n 's/Repository\ Root:\ .*\///p' | read SVN_ROOT
        svn info | sed -n "s/URL:\ .*$SVN_ROOT\///p"
    fi
}

function svn_branch_name() {
    if svn_in; then
        svn info 2> /dev/null | \
            awk -F/ \
            '/^URL:/ { \
              for (i=0; i<=NF; i++) { \
                if ($i == "branches" || $i == "tags" ) { \
                  print $(i+1); \
                  break;\
                }; \
                if ($i == "trunk") { print $i; break; } \
              } \
            }'
    fi
}

function svn_rev() {
    if svn_in; then
        svn info 2> /dev/null | sed -n s/Revision:\ //p
    fi
}

