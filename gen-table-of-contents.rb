#!/bin/env ruby

require 'bundler'
Bundler.setup

require 'argument_parser'

require 'awesome_print'
require 'byebug'

ROOT = File.expand_path File.dirname(__FILE__)
DIR = {
	src: File.join(ROOT, 'src')
}

require File.join DIR[:src], 'handle_arguments'
require File.join DIR[:src], 'TableOfContentsGenerator'
