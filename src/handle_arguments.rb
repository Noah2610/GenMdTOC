VALID_ARGUMENTS = {
	single: {
		help:        [[?h],                  false],
		output_file: [[?o],                  true]
	},
	double: {
		help:        [['help'],              false],
		output_file: [['output','out','of'], true]
	},
	keywords: {
		input_file:  [:INPUT]
	}
}

ARGUMENTS = ArgumentParser.get_arguments VALID_ARGUMENTS
