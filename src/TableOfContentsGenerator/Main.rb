module TableOfContentsGenerator
	class Main
		def initialize
			@input_file = nil
			@generator  = nil
		end

		def start
			@input_file = get_input_file
			@generator  = get_generator
			handle_output
		end

		def get_input_file
			input_file = Pathname.new './README.md'
			input_file = Pathname.new [ARGUMENTS[:keywords][:input_file]].flatten.first  if (ARGUMENTS[:keywords].key? :input_file)
			input_file = DIR[:entry].join input_file  unless (input_file.absolute?)
			validate_input_file input_file
			return input_file
		end

		def validate_input_file input_file
			abort([
				"#{__FILE__}:",
				"Error: File #{input_file} doesn't exist or is a directory.",
				"       Aborting."
			].join("\n"))  unless (input_file.file?)
		end

		def get_generator
			return TableOfContentsGenerator::Generator.new @input_file
		end

		def handle_output
			output_file = nil
			if    (write_to_file?)
				output_file = get_output_file
			elsif (overwrite_input_file?)
				puts([
					"#{__FILE__}:",
					"Overwriting input-file #{@input_file}."
				].join("\n"))
				output_file = @input_file
			else  # Write to stdout
				write_output_to_stdout
				return
			end
			validate_output_file output_file
			write_output_to_file output_file
		end

		def write_to_file?
			return ARGUMENTS[:options].key? :output_file
		end

		def get_output_file
			return ARGUMENTS[:options][:output_file]
		end

		def overwrite_input_file?
			return ARGUMENTS[:options].key? :overwrite
		end

		def validate_output_file output_file
			abort([
				"#{__FILE__}:",
				"Error: An output file must be given with option --output.",
				"       See --help for more information.",
				"       Aborting."
			].join("\n"))  unless (!!output_file)
			abort([
				"#{__FILE__}:",
				"Error: File #{output_file} is a directory.",
				"       Aborting."
			].join("\n"))  if (File.directory? output_file)
		end

		def write_output_to_stdout
			output = get_output
			puts output
		end

		def write_output_to_file _file
			output = get_output
			file   = File.new _file, ?w
			file.write output
			file.close
			puts([
				"#{__FILE__}:",
				"Successfully written to #{_file}!"
			].join("\n"))
		end

		def get_output
			output = nil
			if    (write_full_file?)
				output = get_file_content_with_toc
			else  # Only write Table of Contents
				output = @generator.gen_toc
			end
			return output
		end

		def write_full_file?
			return ARGUMENTS[:options].key? :full
		end

		def get_file_content_with_toc
			toc               = @generator.gen_toc
			lines             = get_file_lines
			line_index        = get_line_index_for_toc_from_lines lines
			lines[line_index] = toc + "\n"  if (!!line_index)
			lines.insert 0, (toc + "\n\n")  if (!line_index)
			return lines.join('')
		end

		def get_file_lines
			return File.readlines @input_file
		end

		def get_line_index_for_toc_from_lines lines
			line_index   = nil
			regex        = (ARGUMENTS[:options][:full] || "/^#{Regexp.quote TOC_TITLE}$/").to_regex
			line_index ||= lines.map.with_index do |line, index|
				next index  if (line.match? regex)
				next nil
			end .reject { |x| !x } .first  unless (regex.nil?)
			return line_index
		end
	end
end
