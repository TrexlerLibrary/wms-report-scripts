# shelving-location.awk
#
# filter items by shelving location
#
# usage:
#   awk -v location="Main Collection" -f shelving-location.awk /path/to/Item_Inventories
#
# To enable loose matching, set `loose=1`. This mode uses regex to match against
# the Shelving Location column.
#
#   awk -v loose=1 -v location="Main" -f shelving-location.awk /path/to/Item_Inventories
#   awk -v loose=1 -v location="(2|4) Hour Reserves" -f shelving-location.awk /path/to/Item_Inventories

BEGIN {
  FS = "|"
  OFS = "|"

  if (!location) {
    exit
  }

  if (location ~ /,/) {
    split(location, LOCATIONS, ",")
  } else {
    LOCATIONS[1] = location
  }

  LOOSE_MODE = (loose == "1" || loose == "true") ? 1 : 0
}

NR == 1 {
  print $0
  next
}

{
  for (l in LOCATIONS) {
    if (LOOSE_MODE == 1) {
      if ($3 ~ LOCATIONS[l]) {
        print $0
        next
      }
    } else {
      if ($3 == LOCATIONS[l]) {
        print $0
        next
      }
    }
  }
}
