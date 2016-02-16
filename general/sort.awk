# sort.awk
#
# sort a report by a field #; includes the headers. if no `field` is passed
# the default `sort` field will be used.
#
# usage
#   awk -v field=12 -f sort.awk /path/to/report

BEGIN {
  FS = "|"
  OFS = "|"

  # field needs to be numeric
  if (field ~ /^[0-9]+$/) {
    SORT_FIELD = field
  } else {
    SORT_FIELD = "false"
  }
}

NR == 1 {
  print $0
  next
}

{
  CMD = "sort --ignore-case --field-separator=\"|\""

  if (SORT_FIELD != "false") {
    CMD = CMD " -k " SORT_FIELD
  }

  print $0 | CMD
}
