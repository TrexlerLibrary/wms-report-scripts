# an awk script for extracting course reserves items
# (major props to http://ferd.ca/awk-in-20-minutes.html for the inspiration/confidence)
#
# usage
#   awk -f <this file name> <report filename> > reserves-inventory.txt
#

BEGIN {
  # update the field separator to OCLC's bar
  FS  = "|"
  OFS = "|"
}

# if we're on the first line, output the headers we're using
NR == 1 {
  print $13,                  # Item Barcode
        $11,                  # OCLC Number
        "Regular Location",   # $3, Shelving Location
        "Reserves Location",  # $4, Temp Shelving Location
        $8,                   # Title or Description
        $9,                   # Textual Holdings (vol, copy, etc)
        $7,                   # Author
        "Courses",            # pulled from $16, Public Note
        $17,                  # Current Status
        $19,                  # Issued Count
        $20,                  # Issued Count YTD
        $21                   # Last Issued Date
  next
}

# Items that are placed on Reserve are given a Temporary Location of:
# - Lending Services Desk - 2 Hour Reserves
# - Lending Services Desk - 4 Hour Reserves
# - Lending Services Desk - 1 Day Reserves
#
# So we'll look at that field for a string that matches `/Reserves/`
$4 ~ /Reserves/ {
  # we're storing information about what courses this item is on reserve for
  # in the Public Notes field, which is $16 according to our lil' chart.
  # notes are delimited by carets (`^`)
  split($16, pub, "^")

  # loop through the notes and extract our courses (that look like `ENG 101 - Professor`)
  # being careful not to store duplicates (see below).
  for (p in pub) {
    note = pub[p]

    # will match `ENG 101` or `ENG-101`
    if (note ~ /^[A-Za-z]+[- ][0-9]{3,}/) {
      # sometimes OCLC will append an ellipsis (`...`) to the end of an otherwise
      # duplicated note. this will remove it.
      sub(/\.{2,}$/, "&", note)

      # only retain this note if it hasn't been already
      if (!notes[note]) { notes[note] = true }
    }
  }

  print $13, $11, $3, $4, $8, $9, $7, join(notes, "^"), $17, $19, $20, $21

  # clear out the `notes` array for the next time through
  delete notes
}

# join an array to a string using a delimiter (`j_joiner`).
# felt the need to use janky variables b/c awk only has
# global variables and I was running into problems using `arr`
# in multiple spots.
function join(j_arr, j_joiner) {
  j_output = ""

  for (j_arr_a in j_arr) {
    if (j_output == "") {
      j_output = j_arr_a
    } else {
      j_output = j_output j_joiner j_arr_a
    }
  }

  return j_output
}
