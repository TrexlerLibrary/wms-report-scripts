# `Item_Inventories` scripts

## [course-reserves.awk][cr]

Filter for items whose `Temp Shelving Location` contains "Reserve"

### usage

    awk -f course-reserves.awk /path/to/Item_Inventories

## [shelving-location.awk][sl]

filter items by shelving location

### usage

    awk -v location="Main Collection" -f shelving-location.awk /path/to/Item_Inventories

To enable loose matching, set `loose=1`. This mode uses regex to match against
the Shelving Location column.

    awk -v loose=1 -v location="Main" -f shelving-location.awk /path/to/Item_Inventories
    awk -v loose=1 -v location="(2|4) Hour Reserves" -f shelving-location.awk /path/to/Item_Inventories

[cr]: ./course-reserves.awk
[sl]: ./shelving-location.awk


## Report column headings

awk `$` var | heading name
------------|-------------
1           | Inst_Symbol
2           | Holding Location
3           | Shelving Location
4           | Temp Shelving Location
5           | Item Type
6           | Call Number
7           | Author
8           | Title or Description
9           | Textual Holdings
10          | Material Format
11          | OCLC Number
12          | ISBN
13          | Item Barcode
14          | Cost
15          | Staff Note
16          | Public Note
17          | Current Status
18          | Loan Date Due
19          | Issued Count
20          | Issued Count YTD
21          | Last Issued Date
22          | Last Inventoried Date
23          | Item Deleted Date
