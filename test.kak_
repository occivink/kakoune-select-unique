try %{
    require-module select-unique
} catch %{
    source select-unique.kak
    require-module select-unique
}

define-command assert-selections-are -params 1 %{
    eval %sh{
        if [ "$1" != "$kak_quoted_selections" ]; then
            printf 'echo -debug %%arg{1} ; '
            printf 'echo -quoting shell -debug %%val{selections} ; '
            printf 'fail "Check failed" ; '
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

edit -scratch *select-unique-test-2*
# make sure that unusal characters work OK
# the input is:
# ascii punctuation followed by alphanum characters followed by ascii punctuation again
reg dquote %{<,?>./":';|\{}[]=-+_()*&^%$#@!`~abcdefghijklmnopqrstuvwxyz0123456789~`!@#$%^&*()_+-=[]{}\|;':"/.>?,<}
exec 'Rs.<ret>'
exec -save-regs '' 'Z'

exec 'z'
select-unique
exec '<a-_>'
assert-selections-are "'<,?>./"":'\'';|\{}[]=-+_()*&^%%$#@!`~abcdefghijklmnopqrstuvwxyz0123456789'"

exec 'z'
select-unique -strict
exec '<a-_>'
assert-selections-are "'abcdefghijklmnopqrstuvwxyz0123456789'"

exec 'z'
select-unique -reverse
exec '<a-_>'
assert-selections-are "'~`!@#$%%^&*()_+-=[]{}\|;'\'':""/.>?,<'"

exec 'z'
select-unique -strict -reverse
exec '<a-_>'
# the two resulting blocks are not contiguous, we now have two selections
assert-selections-are "'<,?>./"":'\'';|\{}[]=-+_()*&^%%$#@!`~' '~`!@#$%%^&*()_+-=[]{}\|;'\'':""/.>?,<'"

delete-buffer
