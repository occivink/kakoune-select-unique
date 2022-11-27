try %{
    require-module select-unique
} catch %{
    source select-unique.kak
    require-module select-unique
}

define-command assert-selections-are -params 1 %{
    eval %sh{
        if [ "$1" != "$kak_quoted_selections" ]; then
            printf 'fail "Check failed"'
        fi
    }
}

edit -scratch *select-unique-test-1*

exec ifoo<space>bar<space>baz<space>foo<esc>
exec '%s\w+<ret>'
exec -save-regs '' 'Z'

exec 'z'
select-unique
assert-selections-are "'foo' 'bar' 'baz'"

exec 'z'
select-unique -strict
assert-selections-are "'bar' 'baz'"

exec 'z'
select-unique -reverse
assert-selections-are "'foo'"

exec 'z'
select-unique -strict -reverse
assert-selections-are "'foo' 'foo'"

delete-buffer

#edit -scratch *select-unique-test-2*
#
#reg dquote abcdefghijklmnopqrstuvwxyz0123456789~`!@#$%^&*()_+-=[]{}\|;':"/.>?,<,
#exec 'R'
#exec '%s.<ret>'
#exec -save-regs '' 'Z'
#
#delete-buffer
