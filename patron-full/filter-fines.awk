# filter-fines.awk
#
# Filter out patrons with fines compared to $n. If n's not provided, filters out
# _all_ patrons with fines
#
# usage:
#   awk -f filter-fines.awk /path/to/Patron_Report_Full
#
# Use the variable `amount` to set the fine threshold. Use the variable `op` to
# change the comparison operation. By default, the operation used is greater-than
# equal-to (>=). Allows symbolic operators ("<", "<=", ">", ">=", "==") and
# alphabetical operators ("gt", "gteq", "lt", "lteq", "eq").
#
# ex.
#   awk -v amount=50 -f filter-fines.awk /path/to/Patron_Report_Full
#
# will pass through patrons whose total fines is greater-than or equal-to $50.
#
# ex.
#   awk -v amount=50 -op="==" -f filter-fines.awk /path/to/Patron_Report_Full
#
# will only pass through patrons with total fines equaling $50

BEGIN {
  FS = "|"
  OFS = "|"

  if (amount) {
    FINE_THRESHOLD = sprintf("%f", amount)
  } else {
    FINE_THRESHOLD = sprintf("%f", 0)
  }

  DEFAULT_OPERATION = "GTEQ"

  # use if/else statements instead of switch b/c some versions of (g)awk
  # may be compiled without switch

  op = tolower(op)

  if (!op) {
    OPERATION = DEFAULT_OPERATION
  }

  else if (op == "<" || op == "lt") {
    OPERATION = "LT"
  }

  else if (op == ">" || op == "gt") {
    OPERATION = "GT"
  }

  else if (op == "==" || op == "eq") {
    OPERATION = "EQ"
  }

  else if (op == "<=" || op == "lteq") {
    OPERATION = "LTEQ"
  }

  else {
    OPERATION = DEFAULT_OPERATION
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

  # since gteq is default, check it first
  if (OPERATION == "GTEQ") {
    if (AS_FLOAT >= FINE_THRESHOLD)
      print $0
  }

  else if (OPERATION == "LT") {
    if (AS_FLOAT < FINE_THRESHOLD)
      print $0
  }

  else if (OPERATION == "GT") {
    if (AS_FLOAT > FINE_THRESHOLD)
      print $0
  }

  else if (OPERATION == "EQ") {
    if (AS_FLOAT == FINE_THRESHOLD)
      print "EQ" $0
  }

  else if (OPERATION == "LTEQ") {
    if (AS_FLOAT <= FINE_THRESHOLD)
      print $0
  }

  # an error case we shouldn't get to
  else next
}
