module TableOfContentsGenerator
	TOC_TITLE           = ARGUMENTS[:options][:title] || '## Table of Contents _(Generated)_'
	MIN_HEADER_TYPE     = [ARGUMENTS[:options][:min_header_type].to_i, 1].max
	PADDING             = '  '
	PREFIX              = '- '
	SMALLEST_HEADER_TYPE = 1
	class Generator
		def initialize input_file
			@input_file = input_file
			validate_input_file
			process_input_file
		end

		def generate_table_of_contents
			title = "#{TOC_TITLE}\n"
			adjust_headers
			toc_content = @headers.map do |header|
				next header.get_line
			end .join("\n")
			return "#{title}#{toc_content}"  unless (toc_content.empty?)
			return ''
		end

		alias :generate_toc :generate_table_of_contents
		alias :gen_toc      :generate_table_of_contents
		alias :gen          :generate_table_of_contents

		private

		def validate_input_file
			abort([
				"#{__FILE__}:",
				"Error: A Markdown file must be given.",
				"       See --help for more information.",
				"       Aborting."
			].join("\n"))  unless (!!@input_file)
			abort([
				"#{__FILE__}:",
				"Error: File #{@input_file} doesn't exist or is a directory.",
				"       Aborting."
			].join("\n"))  unless (File.file? @input_file)
		end

		def process_input_file
			@content = get_content_from_input_file
			@headers = get_headers_from_content
		end

		def get_content_from_input_file
			return File.readlines @input_file
		end

		def get_headers_from_content
			return get_header_lines.map do |line|
				next Header.new line
			end
		end

		def get_header_lines
			in_block = false  # For detecting when inside code block (``` ... ```)
			return @content.select do |line|
				in_block = !in_block  if (line.match? /\A *```.*$/)
				next !in_block && line.match?(/\A {0,3}#+.+$/)
			end
		end

		def adjust_headers
			filter_headers
			adjust_header_indents
		end

		def filter_headers
			@headers.reject! do |header|
				next header.get_type < MIN_HEADER_TYPE
			end
		end

		def adjust_header_indents
			smallest_header_type = get_smallest_header_type
			decrease_header_types_by smallest_header_type - SMALLEST_HEADER_TYPE
		end

		def get_smallest_header_type
			return @headers.map { |header| next header.get_type } .min || SMALLEST_HEADER_TYPE
		end

		def decrease_header_types_by amount
			return  if (amount == 0)
			@headers.each do |header|
				header.decrease_type_by amount
			end
		end
	end
end
