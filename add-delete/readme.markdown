# `Circulation_add_delete` scripts

## [filter-created.awk][fc]

Extract only items that have been added (no `Item Deleted Date`)

### usage
    awk -f filter-created.awk /path/to/Circulation_add_delete

Pass `-v header=0` before the file to exclude header

    awk -v header=0 -f filter-created.awk /path/to/Circulation_add_delete

## [filter-deleted.awk][fd]

Extract only items that have been deleted (have an `Item Deleted Date`)

### usage

    awk -f filter-deleted.awk /path/to/Circulation_add_delete

Pass `-v header=0` before the file to exclude header

    awk -v header=0 -f filter-deleted.awk /path/to/Circulation_add_delete


[fc]: ./filter-created.awk
[fd]: ./filter-deleted.awk

## Report column headings

awk `$` var | heading name
------------|-------------
1           | Inst_Symbol.Holding Location
2           | Title or Description
3           | OCLC Number
4           | Call Number
5           | Cost
6           | Last Modified Date
7           | Item Type
8           | Item Barcode
9           | Holding Location
10          | Shelving Location
11          | Created Date
12          | Item Deleted Date
13          | Issued Count
14          | ACQ Insert Date
15          | ACQ Invoice
16          | ACQ Fund Code
