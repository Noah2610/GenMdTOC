module TableOfContentsGenerator
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
			## Generating the header HTML id:
			#   1) Get lowercase header text, without HASHES (get_header_title)
			#   2) Strip string - Remove trailing whitespaces (at beginning and end of line)
			#   3) Convert all SPACES (not all whitespaces) to DASHES ('-')
			#   4) Remove all non-word characters, including UNDERSCORES, except for DASHES
			title = get_header_title.downcase
			id    = title.strip.gsub(' ', ?-).gsub(/[^\w-]|_/, '')
			return "##{id}"
		end
	end
end
