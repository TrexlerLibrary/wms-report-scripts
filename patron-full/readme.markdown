# `Patron_Report_Full` scripts

## [blocked-patrons.awk][bp]

Simple filter to return all blocked patrons

### usage

    awk -f blocked-patrons.awk /path/to/Patron_Report_Full

Pass `-v header=0` to skip printing header

    awk -v header=0 -f blocked-patrons.awk | wc -l

## [fines-filter.awk][ff]

Filter out patrons with fines over $n. If n's not provided, filters out _all_
patrons with fines.

### usage

    awk -f fines-filter.awk /path/to/Patron_Report_Full

Use the variable `amount` to set the fine threshold.

    awk -v amount=50 -f fines-filter.awk /path/to/Patron_Report_Full

will only pass through patrons whose total fines is over $50


[bp]: ./blocked-patrons.awk
[ff]: ./fines-filter.awk

## Report column headings
(Dates are in `YYYY-MM-DD HH:MM:SS`)

Column `n` # | Heading
-------------|------------
1            | Inst_Symbol
2            | First Name
3            | Last Name
4            | Gender
5            | Date of Birth
6            | Patron Barcode
7            | Borrower Category
8            | Home Branch
9            | Home Address
10           | Secondary Home Address
11           | Locality or City
12           | State or Province
13           | Postal Code
14           | Telephone Number
15           | Email Address
16           | Is Verified
17           | Total Fines
18           | Created On
19           | IDP
20           | Expiration Date
21           | IdatSource
22           | Is Blocked
23           | Username
24           | Checkout Date
25           | Last Updated On
