# filter-created.awk
#
# extract only items that have been added (no `Item Deleted Date`)
#
# usage:
#   awk -f filter-created.awk <report filename>
#
# pass `-v header=0` before the file to exclude header
#   awk -v header=0 -f filter-created.awk <report filename>

BEGIN {
  FS = "|"
  OFS = "|"
}

NR == 1 {
  if (header == "0" || header == "false")
    next
  else
    print $0

  next
}

$12 == "" { print $0 }
