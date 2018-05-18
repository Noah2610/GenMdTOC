VALID_ARGUMENTS = {
	single: {
		help:        [[?h],                  false],
		output_file: [[?o],                  true],
		overwrite:   [[?O],                  false],
		only_toc:    [[?t],                  false],
		full:        [[?f],                  true]
	},
	double: {
		help:        [['help'],              false],
		output_file: [['output','out','of'], true],
		overwrite:   [['overwrite'],         false],
		only_toc:    [['table-of-contents'], false]
	},
	keywords: {
		input_file:  [:INPUT]
	}
}

ARGUMENTS = ArgumentParser.get_arguments VALID_ARGUMENTS
