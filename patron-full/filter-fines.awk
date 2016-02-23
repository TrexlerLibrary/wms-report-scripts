# filter-fines.awk
#
# Filter out patrons with fines over $n. If n's not provided, filters out
# _all_ patrons with fines
#
# usage:
#   awk -f filter-fines.awk /path/to/Patron_Report_Full
#
# Use the variable `amount` to set the fine threshold.
#
# ex.
#   awk -v amount=50 -f filter-fines.awk /path/to/Patron_Report_Full
#
# will only pass through patrons whose total fines is over $50.

BEGIN {
  FS = "|"
  OFS = "|"

  if (amount) {
    FINE_THRESHOLD = sprintf("%f", amount)
  } else {
    FINE_THRESHOLD = sprintf("%f", 0)
  }

  # need to add 0 to cast to number
  FINE_THRESHOLD = (FINE_THRESHOLD + 0)
}

NR == 1 {
  print $0
  next
}

{
  AS_FLOAT = sprintf("%f", $17)
  AS_FLOAT = (AS_FLOAT + 0)

  # need to add 0 to cast to number
  comp = FINE_THRESHOLD < AS_FLOAT

  if (comp == 1)
    print $0
}
