# notes.awk
#
# Passes items if Public/Staff note fields match query
#
# usage:
#
#   awk -v note="On display" -f notes.awk /path/to/Item_Inventories
#
# In its default "loose" mode, the `note` field can be a regular expression
#
#   awk -v note="Contains [0-9]+ discs" -f notes.awk /path/to/Item_Inventories
#   awk -v note="^!" -f notes.awk /path/to/Item_Inventories
#
# To use "strict" mode (which uses `==` for matching), use the `-v strict=1` flag
#
#   awk -v note="Contains 7 discs" -v strict=1 -f notes.awk /path/to/Item_Inventories
#
# Use the `type` variable to specify which note field to look in (both are
# searched by default)
#
#   awk -v note="On display" -v type="staff" -f notes.awk /path/to/Item_Inventories
#   awk -v note="Part of Alumni collection" -v type="public" -f notes.awk /path/to/Item_Inventories

BEGIN {
  FS = "|"
  OFS = "|"

  if (!note && !type)
    exit

  type = tolower(type)

  if (type == "staff") {
    # Staff Note field: $15
    FIELDS[1] = 15
  } else if (type == "public") {
    # Public Note field: $16
    FIELDS[1] = 15
  } else {
    FIELDS[1] = 15
    FIELDS[2] = 16
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
  for (f in FIELDS) {
    if (f == "")
      next

    split($FIELDS[f], NOTES, "^")
    for (n in NOTES) {
      if (STRICT_MODE == 1) {
        if (NOTES[n] == note) {
          print $0
          next
        }
      } else {
        if (NOTES[n] ~ note) {
          print $0
          next
        }
      }
    }
  }
}
