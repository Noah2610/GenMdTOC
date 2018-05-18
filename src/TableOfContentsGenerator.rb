module TableOfContentsGenerator
	TOC_TITLE = '## Table of Contents _(Generated)_'
	PADDING   = '  '
	PREFIX    = '- '

	class Header
		def initialize line
			@original_line = line
			set_values
		end

		def get_line
			padding = PADDING * [(@type - 1), 0].max
			prefix  = PREFIX
			return "#{padding}#{prefix}[#{@title}](#{@id})"
		end

		private

		def set_values
			@type  = get_header_type  # Type of header as integer (1 -> '#'; 2 -> '##'; ...)
			@title = get_header_title
			@id    = get_header_id
		end

		def get_header_type
			hash_signs = @original_line.match(/\A\s*(#+).+$/)[1]
			return hash_signs.size
		end

		def get_header_title
			title = @original_line.match(/\A\s*#+\s*(.+)\s*$/)[1]
			return title
		end

		def get_header_id
			title = get_header_title.downcase
			#id    = title.strip.gsub(' ', "\00").gsub(/(^\W+)|(\W+$)/, '').gsub("\00", ' ')
			id    = title.strip.gsub(/[^\w]/, ?-)
			return "##{id}"
		end
	end

	class Generator
		def initialize input_file
			@input_file = input_file
			validate_input_file
			process_input_file
		end

		def generate_table_of_contents
			title     = TOC_TITLE
			toc_lines = @headers.map do |header|
				next header.get_line
			end
			return "#{title}\n#{toc_lines.join("\n")}"
		end

		alias :generate_toc :generate_table_of_contents
		alias :gen_toc      :generate_table_of_contents
		alias :gen          :generate_table_of_contents

		private

		def validate_input_file
			abort([
				"#{__FILE__}:",
				"Error: A Markdown file must be given.",
				"       See --help for more information."
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
			return @content.select do |line|
				next line.match? /\A {0,3}#+.+$/
			end
		end
	end
end

TOC = TableOfContentsGenerator::Generator.new [ARGUMENTS[:keywords][:input_file]].flatten.first
puts TOC.gen_toc
