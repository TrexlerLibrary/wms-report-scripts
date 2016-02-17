# All-purpose scripts

## [sort.awk][so]

sort a report by a field #; includes the headers. if no `field` is passed
the default `sort` field will be used.

### usage

    awk -v field=12 -f sort.awk /path/to/report

## [to-json.awk][tj]

emits newline-delimited json objects from a report (useful for piping)

### usage

    $ awk -f to-json.awk /path/to/report

Use the variable `nd` to toggle off newline-delimited mode
(results will be returned wrapped in a JSON array)
set to `0` or `false`

    $ awk -v nd=false -f to-json.awk /path/to/report
    $ awk -v nd=0 -f to-json.awk /path/to/report

Use the variable `clean_headers` to pass headers through
untouched (otherwise, they're converted to snake_case). as
with `nd`, use `0` or `false`

    $ awk -v clean_headers=false to-json.awk /path/to/report
    $ awk -v clean_headers=0 to-json.awk /path/to/report


[so]: ./sort.awk
[tj]: ./to-json.awk
