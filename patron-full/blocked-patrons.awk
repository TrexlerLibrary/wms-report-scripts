# blocked-patrons.awk
#
# simple filter to return all blocked patrons
#
# usage:
#   awk -f blocked-patrons.awk /path/to/Patron_Report_Full
#
# pass `-v header=0` to skip printing header
# ex.
#   awk -v header=0 -f blocked-patrons.awk | wc -l

BEGIN {
  FS = "|"
  OFS = "|"
}

NR == 1 {
  if (headers != "false" && headers != "0")
    print $0

  next
}

$22 == 1 {
  print $0
}
