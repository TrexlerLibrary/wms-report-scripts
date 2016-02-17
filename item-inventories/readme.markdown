# `Item_Inventories` scripts

## [`course-reserves.awk`][cr]

Filter for items whose `Temp Shelving Location` contains "Reserve"

### usage

    awk -f course-reserves.awk /path/to/Item_Inventories

[cr]: ./course-reserves.awk


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
