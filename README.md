# kakoune-select-unique

[kakoune](http://kakoune.org) plugin for filtering selections based on their content. Similar in spirit to the `uniq` shell utility, but for kakoune.
See also [kakoune-sort-selections](https://github.com/occivink/kakoune-sort-selections) for a complementary plugin.

## Setup

Add `select-unique.kak` to your `autoload` directory: `~/.config/kak/autoload/`, or source it manually.

## Usage

The plugin adds a single command:
```
select-unique [-strict] [-reverse]
```

The command filters out selections based on their content. By default it filters out any repeated occurrence of a selection, ensuring that all remaining selections are unique between one-another. In case of duplicates, only the first occurrence is kept.  
If the `-strict` parameter is passed, **all** instances of selections that occur multiple times in the input are filtered out, including the first one.  
If the `-reverse` parameter is passed, the selections that are unique are instead filtered, and the duplicates kept. This is similar to the difference between the keys `<a-K>` and `<a-k>`.  

One major difference with the `uniq` utility is that selections do not need to be consecutive to be considered unique.

### Example:

Given the input `[foo] [bar] [baz] [foo]` (selections are represented using `[..]`), calling the command with different parameters will result in the following remaining selections:

```
select-unique                  => [foo] [bar] [baz] foo
select-unique -reverse         => foo bar baz [foo]
select-unique -strict          => foo [bar] [baz] foo
select-unique -strict -reverse => [foo] bar baz [foo]
```

## License

[Unlicense](http://unlicense.org)
