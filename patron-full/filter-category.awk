# filter-category.awk
#
# Filter patrons by their Borrower Category type
#
# usage:
#   awk -v category=Student /path/to/Patron_Report_Full
#
# Add multiple categories using a comma delimiter
#
#   awk -v category=Student,Faculty /path/to/Patron_Report_Full

BEGIN {
  FS = "|"
  OFS = "|"

  if (!category) exit

  if (category ~ /,/) {
    split(category, CATEGORIES, ",")
  } else {
    CATEGORIES[1] = category
  }
}

NR == 1 {
  print $0
  next
}

{
  for (c in CATEGORIES) {
    if ($7 == CATEGORIES[c]) {
      print $0
      next
    }
  }
}
