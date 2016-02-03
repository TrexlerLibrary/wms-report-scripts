# to-json.awk
#
# emits newline-delimited json objects from a report
# (useful for piping)
#
# usage: awk -f to-json.awk <report filename>

BEGIN {
  FS  = "|"
  OFS = ""
}

# at headers, store for later
NR == 1 {
  split($0, HEADERS, FS)
  next
}

{
  # escape quotes + backslashes
  gsub(/"|\\/, "\\\\&")

  split($0, ROW, FS)
  printf "{"

  COUNT = 1

  for (r in ROW) {
    KEY = HEADERS[r]
    VAL = ROW[r]
    COUNT++

    # OCLC uses the caret (^) to delimit multiple values,
    # so we'll split these into arrays

    if (VAL ~ /\^/) {
      VAL_ARR_STR = "["
      AT_FIRST = 1

      split(VAL, VAL_ARR, "^")

      for (v in VAL_ARR) {
        PREFIX = (AT_FIRST == 1 ? "" : ",")
        VAL_ARR_STR = VAL_ARR_STR PREFIX "\"" VAL_ARR[v] "\""

        if (AT_FIRST == 1) { AT_FIRST = 0 }
      }

      VAL = VAL_ARR_STR "]"
    }

    # we'll need to wrap values that _aren't_ arrays in quotes

    else {
      VAL = "\"" VAL "\""
    }

    printf "\"%s\": %s%s", KEY, VAL, (COUNT <= NF ? "," : "")
  }

  printf "}\n"
}
