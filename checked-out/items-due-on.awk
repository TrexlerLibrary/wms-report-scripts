# items-due-on.awk
#
# checks for items that are coming due, or are due in `n` days
# (`n` can be positive or negative)
#
# (For BSD (and similar OS's, looking at you OS X), you probably want to
# use the neighboring file, `items-due-on-bsd.awk`)
#
# usage:
#   awk -f items-due-on.awk /path/to/All_Checked_out_items
#
# passing the variable `n` to awk will allow you to set the due date to compare
# against (use `+n` to set n days in the future, use `-n` for n days previous).
#
# ex.
#   awk -v n=-2 items-due-on.awk /path/to/All_Checked_out_items
#   awk -v n=+2 items-due-on.awk /path/to/All_Checked_out_items
#
# NOTE: Only passing a number (and no sign) will set the date to that number.
# (passing `n=7` will set the date to the 7th of the current month)
#
# NOTE: This script requires awk to have the `mktime` function, which isn't
# present in at least Mac OS X (see https://discussions.apple.com/thread/3302970).
# Using gawk is a handy alternative (available through Homebrew on OS X).

BEGIN {
  FS = "|"
  OFS = "|"

  if (!n) {
    n = "+0"
  }

  cmdMin = "date -d \"" n " day\" \"+%Y %m %d 00 00 00\""
  cmdMax = "date -d \"" n " day\" \"+%Y %m %d 23 59 59\""

  cmdMin | getline datespecMin
  close(cmdMin)

  cmdMax | getline datespecMax
  close(cmdMax)

  COMP_TIME_MIN = mktime(datespecMin)
  COMP_TIME_MAX = mktime(datespecMax)
}

NR == 1 {
  if (headers != "false" && headers != "0")
    print $0

  next
}

{
  DD = $9

  gsub(/-|:/, " ", DD)
  time = mktime(DD)

  if (time >= COMP_TIME_MIN && time <= COMP_TIME_MAX) {
    print $0
  }
}
