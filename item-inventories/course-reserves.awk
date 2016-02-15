# course-reserves.awk
#
# filter for items whose Temp Shelving Location contains "Reserve"

BEGIN {
  FS  = "|"
  OFS = "|"
}

NR == 1 {
  print $0
  next
}

$4 ~ /Reserves/ {
  print $0
}
