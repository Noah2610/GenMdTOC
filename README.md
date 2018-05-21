# Markdown Table of Contents Generator
A simple Markdown Table of Contents Generator script.

## Table of Contents _(Generated)_
- [Markdown Table of Contents Generator](#markdown-table-of-contents-generator)
  - [Table of Contents _(Generated)_](#table-of-contents-generated)
  - [Usage](#usage)

## Usage
```
USAGE:
  gentoc [OPTIONS...] [INPUT-FILE]

  INPUT-FILE
    Markdown file to generate Table of Contents from.
    If ommited, it is set to './README.md'.
    By default, it will generate the Table of Contents
    and print only the table to stdout.
  OPTIONS
    --help, -h
      Print this help and exit.
    --output, --out, --of, -o OUTPUT-FILE
      Write output to file OUTPUT-FILE.
      Without this option, it will output to stdout.
    --overwrite, -O
      Overwrite file INPUT-FILE with output.
      Basically use INPUT-FILE as OUTPUT-FILE.
      Useless if --output is given.
    --full, -f [REGEX]
      Generate Table of Contents and output original markdown file
      with Table of Contents overwriting the first line matching the
      regular expression REGEX. If REGEX is ommited it is set to
      --title 's value with a '^' and a '$' added to the start and end
      of the string, respectively.
      If no match is found it will be prepended to the top of the file.
      The REGEX can be given with slashes or without. With slashes,
      you have the ability to pass regex options. For example:
        --full /^##\s+Table of Contents\s*$/i
    --title, -t [TITLE]
      Title for Table of Contents. Ommit TITLE or set to empty string
      to not add a title to the table.
      Default value:
        --title '## Table of Contents _(Generated)_'
  EXAMPLES
    Generates Table of Contents from ./README.md and writes to ./OUT.md
      $ ./gentoc -o OUT.md
    Generates Table of Contents and outputs README.md file content with the
    Table of Contents inserted at the first line that matches the regex for -f
      $ ./gentoc -f '/^\s*Table of Contents goes here!\s*$/i'
    Does the same as above, except it prepends Table of Contents to
    the start of the file
      $ ./gentoc -f
    Generate Table of Contents from ./README.md, put it in the proper position,
    give proper title, and overwrite ./README.md with the resulting file
      $ ./gentoc ./README.md -f '/^## Table of Contents _\(Generated\)_$/' -t '## Generated Table of Contents!' -O
```
