# `Item_Inventories` scripts

## [course-reserves.awk][cr]

Filter for items whose `Temp Shelving Location` contains "Reserve"

### usage

    awk -f course-reserves.awk /path/to/Item_Inventories


## [notes.awk][no]

Passes items if Public/Staff note fields match query

### usage

    awk -v note="On display" -f notes.awk /path/to/Item_Inventories

In its default "loose" mode, the `note` field can be a regular expression

    awk -v note="Contains [0-9]+ discs" -f notes.awk /path/to/Item_Inventories
    awk -v note="^!" -f notes.awk /path/to/Item_Inventories

To use "strict" mode (which uses `==` for matching), use the `-v strict=1` flag

    awk -v note="Contains 7 discs" -v strict=1 -f notes.awk /path/to/Item_Inventories

Use the `type` variable to specify which note field to look in (both are
searched by default)

    awk -v note="On display" -v type="staff" -f notes.awk /path/to/Item_Inventories


## [shelving-location.awk][sl]

Filter items by shelving location

### usage

    awk -v location="Main Collection" -f shelving-location.awk /path/to/Item_Inventories

In its default "loose" mode, the `location` can use regex:

    awk -v location="^Main" -f shelving-location.awk /path/to/Item_Inventories
    awk -v location="(2|4) Hour Reserves" -f shelving-location.awk /path/to/Item_Inventories

To enable strict matching, set `strict=1`. This mode uses the `==` operator to
match against the Shelving Location column.

    awk -v strict=1 -v location="Main Collection" -f shelving-location.awk /path/to/Item_Inventories

The above will pass items in `Main Collection`, but will skip `Main Collection - Reference`.


[cr]: ./course-reserves.awk
[no]: ./notes.awk
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
