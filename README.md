# GenTOC

## Description
A simple __Markdown Table of Contents Generator__ script.

## Table of Contents _(Generated)_
- [Description](#description)
- [Usage](#usage)
- [Installation](#installation)
- [Development](#development)
  - [Dependencies](#dependencies)
  - [TODO](#todo)

## Usage
```
USAGE:
  ./gentoc [OPTIONS...] [INPUT_FILE]

  INPUT_FILE
    Markdown file to generate Table of Contents from.
    If ommited, it is set to './README.md'.
    By default, it will generate the Table of Contents
    and print only the table to stdout.

  OPTIONS
    --help, -h
      Print this help and exit.

    --output, --out, --of, -o OUTPUT_FILE
      Write output to file OUTPUT_FILE.
      Without this option, it will output to stdout.

    --overwrite, -O
      Overwrite file INPUT_FILE with output.
      Basically use INPUT_FILE as OUTPUT_FILE.
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
        --title '## Table of Contents _\(Generated\)_'

    --min-header, -n [HEADER_SIZE]
      Only include headers with size HEADER_SIZE or smaller.
      HEADER_SIZE is an integer, representing the size of the header.
        1 -> #      (largest)
        2 -> ##
        ...
        6 -> ###### (smallest)
      The default value is 1.
      Although 6 is the smallest header size for markdown,
      there is nothing stopping you from using a higher number,
      and it will act as expected.

    --include-title
      By default, the script will not generate a Table of Contents entry for
      a header matching the --title value, unless this option is given.

  EXAMPLES
    Generates Table of Contents from ./README.md and writes to ./OUT.md.
      $ ./gentoc -o OUT.md

    Generates Table of Contents and outputs README.md file content with the
    Table of Contents inserted at the first line that matches the regex for -f.
      $ ./gentoc -f '/^\s*Table of Contents goes here!\s*$/i'

    Does the same as above, except it prepends Table of Contents to
    the start of the file.
      $ ./gentoc -f

    Generate Table of Contents from ./README.md, put it in the proper position,
    give proper title, and overwrite ./README.md with the resulting file.
      $ ./gentoc ./README.md -f '/^## Table of Contents _\(Generated\)_$/' -t '## Generated Table of Contents!' -O

    Similar to above, but with less specification. More universally applicable.
    Overwrites ./README.md with inserted Table of Contents either replacing the
    previous Table of Contents header, or prepending to the top of the file.
      $ ./gentoc -Of

    Same as above, except it only includes headers of size 2 (##) or smaller (###...).
      $ ./gentoc -Ofn 2
```

## Installation
Clone the repository with
```
$ git clone https://github.com/Noah2610/GenTOC.git
```
Then install the dependencies with
```
$ cd ./GenTOC; bundle install
```
And that should be it!  
Now you'll be able to execute `./gentoc` to run the script.  
Until I turn this project into a proper gem with an executable attached,  
I recommend you _sym-link_ `./gentoc` to some path accessible from your  
shell; check your `$PATH` environment variable.

---

## Development
This script is written in __Ruby__ version __2.5__  
It will probably work with version 2.4, but probably not with 2.3 or lower.

### Dependencies
You will need to have __Ruby__ version __2.4__ or higher and  
__ruby-bundler__ installed.

__GenTOC__ uses my _(old, due for a re-write)_ [argument parser gem][argument-parser-gem-page]  
to parse command-line arguments.

### TODO
- Specifying the indent level _(in spaces)_ to be used.  
Currently hard-coded: `'  '` _(two spaces)_
- Specifying the prefix for TOC entries.  
Currently hard-coded: `'- '` _(markdown list item)_
- Fix `--include-title`; it doesn't work 100% as specified:  
the option should only include the TOC entry to the new TOC title, but if  
`--title` and `--full` values differ, and `--include-title` is given,  
it will _only_ generate the TOC entry for the replaced `--full` matched header,  
which has no use. It should generate a link to the _new_ `--title` header.
- Only process headers after line matching a regex
- Clean-up `get_help_text_from_readme` method in `src/handle_arguments.rb`
- When matching TOC header title in existing markdown file, instead of just  
replacing that line, replace the following TOC with new TOC.

[argument-parser-gem-page]: https://github.com/Noah2610/ArgumentParser
