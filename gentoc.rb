#!/bin/env ruby

require 'bundler'
Bundler.setup

require 'argument_parser'

require 'awesome_print'
require 'byebug'


ROOT = Bundler.root
DIR = {
	src:    ROOT.join('src'),
	readme: ROOT.join('README.md')
}

require DIR[:src].join 'extensions'
require DIR[:src].join 'handle_arguments'
require DIR[:src].join 'TOCGenerator'
require DIR[:src].join 'TOCHeader'
require DIR[:src].join 'TOCMain'

TOC_MAIN = TableOfContentsGenerator::Main.new
TOC_MAIN.start
