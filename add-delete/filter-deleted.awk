# filter-deleted.awk
#
# extract only items that have been deleted (have an `Item Deleted Date`)
#
# usage:
#   awk -f filter-deleted.awk <report filename>
#
# pass `-v header=0` before the file to exclude header
#   awk -v header=0 -f filter-deleted.awk <report filename>

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

$12 != "" { print $0 }
