module main

import os
import flag

const is_pipe = (os.is_atty(0) == 0)

fn main() {
	mut fp := flag.new_flag_parser(os.args)

	fp.application('karakter')
	fp.version('0.1.0')
	fp.description('Add a little character to your text')
	fp.usage_example('')
	fp.skip_executable()

	obfuscation := fp.string('obfuscation', `o`, '', 'Level of obfuscation, "lo" or "hi". Defaults to medium.')
	style := fp.string('style', `s`, '', 'Obfuscation style, "ft" for fairytale or "cp" for cyberpunk. Defaults to a kitchen sink mix of styles.')
	// Check if this is a pipe. If it is, we don’t require additional args.
	// If not, assume (but confirm) that the argument is a file.
	// If it’s not a file, take it as input.
	mut full_text := ''
	if is_pipe {
		full_text = os.get_raw_lines_joined()
	} else {
		mut additional_args := fp.finalize() or {
			println(fp.usage())
			// Why doesn’t exit() work here?
			return
		}
		if additional_args.len > 1 {
			file := additional_args[1]
			full_text = os.read_file(file.trim_space()) or { '' }
			if full_text.len == 0 {
				// File read failed, assume additional args are words to handle.
				full_text = additional_args.join(' ')
			}
		} else {
			println(fp.usage())
			exit(0)
		}
	}

	println('Text to handle:')
	println(full_text)

	obfuscation_level := match obfuscation {
		'lo' { 10 }
		'hi' { 100 }
		else { 50 }
	}
	obfuscation_style := match style {
		'cp' { 'cyberpunk' }
		'ft' { 'fairytale' }
		else { 'default' }
	}

	println('Obfuscation level: $obfuscation_level')
	println('Obfuscation style $obfuscation_style')
}
