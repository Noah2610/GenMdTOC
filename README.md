# Generate Markdown Table Of Contents

---

___Work In Progress...___

---

## Usage
```
USAGE:
  gen-table-of-contents [OPTIONS...] INPUT-FILE

  INPUT-FILE
    Markdown file to generate Table of Contents from.
    By default, it will generate the Table of Contents
    and print only the table to stdout.
OPTIONS:
  --help, -h
    Print this help and exit.
  --output, --out, --of, -o OUTPUT-FILE
    Write output to file OUTPUT-FILE.
    Without this option, it will output to stdout.
  --overwrite, -O
    Overwrite file INPUT-FILE with output.
    Basically use INPUT-FILE as OUTPUT-FILE.
  --table-of-contents, -t
    Only generate and output the Table of Contents.
    This is the default behaviour.
  --full, -f [REGEX]
    Generate Table of Contents and output original markdown file
    with Table of Contents overwriting the first line matching the
    regular expression REGEX. If REGEX is ommited, either overwrite
    existing Table of Contents in markdown file if present/found,
    otherwise prepend to the top of the file.
```
