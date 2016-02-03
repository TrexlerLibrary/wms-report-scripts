# filter-created.awk
#
# extract only items that have been added (no `Item Deleted Date`)
#
# usage:
#   awk -f filter-created.awk <report filename>
#
# pass `-v headers=0` before the file to exclude headers
#   awk -v headers=0 -f filter-created.awk <report filename>

BEGIN {
  FS = "|"
}

NR == 1 {
  if (headers == "0" || headers == "false")
    next
  else
    print $0

  next
}

$12 == "" { print $0 }
