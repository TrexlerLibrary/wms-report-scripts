# `All_Checked_out_items` scripts

## [items-due-on.awk][ido]

checks for items that are coming due, or are due in `n` days
(`n` can be positive or negative)

### usage
    awk -f items-due-on.awk /path/to/All_Checked_out_items

Passing the variable `n` to awk will allow you to set the due date to compare
against (use `+n` to set n days in the future, use `-n` for n days previous).

    awk -v n=-2 items-due-on.awk /path/to/All_Checked_out_items
    awk -v n=+2 items-due-on.awk /path/to/All_Checked_out_items

### notes

* Only passing a number (and no sign) will set the date to that number.
  (passing `n=7` will set the date to the 7th of the current month)
* Depending on what `date` program your OS uses, you'll have to
  uncomment/comment the `cmd` variable's definition in the BEGIN block.
  The difference is in how to define a new date by string ('-d "+2 day"
  vs '-v "+2d"' flags)
* NOTE: This script requires awk to have the `mktime` function, which isn't
  present in at least Mac OS X (see https://discussions.apple.com/thread/3302970).
  Using gawk is a handy alternative (available through Homebrew on OS X).


## Report column headings
(Dates are in `YYYY-MM-DD HH:MM:SS`)

awk `$` var | heading name
------------|-------------
1           | Inst_symbol.Holding Location
2           | OCLC Number
3           | Item Barcode
4           | Title or Description
5           | Material Format
6           | Shelving Location
7           | Call Number
8           | Policy Name
9           | Loan Date Due
10          | Loan Date Checked Out
11          | Status
12          | Patron Barcode
13          | First Name
14          | Last Name
15          | Gender
16          | Home Address
17          | Locality or City
18          | State or Province
19          | Postal Code
20          | Telephone Number
21          | Email Address
22          | Borrower Category
23          | Patron Expiration Date

[ido]: ./items-due-on.awk
