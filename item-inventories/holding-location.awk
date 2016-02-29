# holding-location.awk
#
# Filter items by holding location symbol
#
# usage:
#   awk -v location="Storage" -f holding-location.awk /path/to/Item_Inventories
#
# In its default "loose" mode, the `location` can use regex:
#
#   awk -v location="ABC" -f holding-location.awk /path/to/Item_Inventories
#   awk -v location="AB(C|D)" -f holding-location.awk /path/to/Item_Inventories
#
# To enable strict matching, set `strict=1`. This mode uses the `==` operator to
# match against the Holding Location column.
#
#   awk -v strict=1 -v location="ABC" -f holding-location.awk /path/to/Item_Inventories
#
# The above will pass items in `ABC`, but will skip `ABCD`.

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

  STRICT_MODE = (strict == "1" || strict == "true") ? 1 : 0

  if (STRICT_MODE == 0) {
    IGNORECASE = 1
  }
}

NR == 1 {
  print $0
  next
}

{
  for (l in LOCATIONS) {
    if (STRICT_MODE == 1) {
      if ($2 == LOCATIONS[l]) {
        print $0
        next
      }
    } else {
      if ($2 ~ LOCATIONS[l]) {
        print $0
        next
      }
    }
  }
}
