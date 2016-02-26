# shelving-location.awk
#
# Filter items by shelving location
#
# usage:
#   awk -v location="Main Collection" -f shelving-location.awk /path/to/Item_Inventories
#
# In it's default "loose" mode, the `location` can use regex:
#
#   awk -v location="^Main" -f shelving-location.awk /path/to/Item_Inventories
#   awk -v location="(2|4) Hour Reserves" -f shelving-location.awk /path/to/Item_Inventories
#
# To enable strict matching, set `strict=1`. This mode uses the `==` operator to
# match against the Shelving Location column.
#
#   awk -v strict=1 -v location="Main Collection" -f shelving-location.awk /path/to/Item_Inventories
#
# The above will pass items in `Main Collection`, but will skip `Main Collection - Reference`.

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
}

NR == 1 {
  print $0
  next
}

{
  for (l in LOCATIONS) {
    if (STRICT_MODE == 1) {
      if ($3 == LOCATIONS[l]) {
        print $0
        next
      }
    } else {
      if ($3 ~ LOCATIONS[l]) {
        print $0
        next
      }
    }
  }
}
