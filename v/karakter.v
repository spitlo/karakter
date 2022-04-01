module main

import os
import flag
import rand
import sets

const is_pipe = (os.is_atty(0) == 0)

struct Settings {
pub mut:
	obfuscation_level int
	set map[rune]string
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)

	description := [
		'Add a little character to your text by substituting visually similar glyphs for letters a-z and A-Z.',
		'There are three ways to supply input text to this script:',
		'\t1) Add a file as argument',
		'\t2) Add word or words as arguments',
		'\t3) Pipe text to it',
	].join('\n')

	fp.application('karakter')
	fp.version('0.1.0')
	fp.description(description)
	fp.skip_executable()

	obfuscation := fp.string('obfuscation', `o`, '', 'Level of obfuscation, "lo" or "hi". Defaults to medium.')
	style := fp.string('style', `s`, '', 'Obfuscation style, "ft" for fairytale, "cp" for cyberpunk, "lm" for loudmouth or "mt" for moneytalk. Defaults to a kitchen sink mix of styles.')
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
		if additional_args.len > 0 {
			file := additional_args[0]
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

	mut settings := Settings{
		obfuscation_level: match obfuscation {
			'lo' { 10 }
			'hi' { 100 }
			else { 50 }
		}
		set: match style {
			'cp' { sets.cyberpunk }
			'ft' { sets.fairytale }
			'lm' { sets.loudmouth }
			'mt' { sets.moneytalk }
			else { sets.standard }
		}
	}

	lines := full_text.trim_right('\n\r').split_into_lines()
	mut handled_lines := []string{}
	for line in lines {
		handled_lines << handle_line(line, settings)
	}

	println(handled_lines.join('\n'))
}

fn handle_line(line string, settings Settings) string {
	mut characters := line.runes()
	mut handled_line := []rune{}
	for character in characters {
		handled_line << handle_character(character, settings)
	}
	return handled_line.string()
}

fn handle_character(character rune, settings Settings) rune {
	handled_character := match character {
		`A`...`z` {
			if rand.intn(100) < settings.obfuscation_level {
				chars := settings.set[character]
				if chars.len > 0 {
					runes := chars.runes()
					rnd_index := rand.intn(runes.len)
					runes[rnd_index]
				} else {
					character
				}
			} else {
				character
			}
		}
		else { character }
	}
	return handled_character
}
