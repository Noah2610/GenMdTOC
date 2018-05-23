# TODO: Clean-up this messy method
def get_help_text_from_readme
	file          = DIR[:readme].to_s
	lines         = File.readlines file
	usage_regex   = /\A#+\s*usage\s*$/i
	block_regex   = /\A```.*$/
	usage_started = false
	block_started = false
	return lines.map do |line|
		if    (block_started)
			if (line.match? block_regex)
				usage_started = false
				block_started = false
			else
				next line
			end
		elsif (usage_started)
			if (line.match? block_regex)
				block_started = true
			else
				usage_started = false
			end
		else
			usage_started = true  if (line.match? usage_regex)
		end
		next nil
	end .reject { |x| !x } .join('')
end

HELP_TEXT = get_help_text_from_readme

VALID_ARGUMENTS = {
	single: {
		help:            [[?h],                  false],
		output_file:     [[?o],                  true],
		overwrite:       [[?O],                  false],
		full:            [[?f],                  true],
		title:           [[?t],                  true],
		min_header_type: [[?n],                  true]
	},
	double: {
		help:            [['help'],              false],
		output_file:     [['output','out','of'], true],
		overwrite:       [['overwrite'],         false],
		full:            [['full'],              true],
		title:           [['title'],             true],
		min_header_type: [['min-header'],        true]
	},
	keywords: {
		input_file:  [:INPUT]
	}
}

ARGUMENTS = ArgumentParser.get_arguments VALID_ARGUMENTS

# Print help and exit
if (ARGUMENTS[:options][:help])
	puts HELP_TEXT
	exit
end
