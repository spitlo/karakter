module main

import os
import cli { Command, Flag }

fn main() {
	mut cmd := Command{
		name: 'karakter'
		description: 'Add a little character to your text'
		usage: 'karakter'
		version: '0.1.0'
		execute: karakter
	}

	cmd.add_flag(Flag{
		flag: .string
		required: false
		name: 'obfuscation'
		abbrev: 'o'
		description: 'Level of obfuscation, "lo" or "hi". Defaults to medium.'
	})

	cmd.add_flag(Flag{
		flag: .string
		required: false
		name: 'style'
		abbrev: 's'
		description: 'Obfuscation style, "ft" for fairytale or "cp" for cyberpunk. Defaults to a kitchen sink mix of styles.'
	})

	cmd.setup()
	cmd.parse(os.args)
}

fn karakter(cmd Command) ? {
	obfuscation := cmd.flags.get_string('obfuscation') ?
	style := cmd.flags.get_string('style') ?
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
