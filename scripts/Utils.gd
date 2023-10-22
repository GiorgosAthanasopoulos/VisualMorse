extends Node

var CopyResults = preload("res://scripts/CopyResults.gd")

const PYCW: String = "./assets/utils/pycw.exe"
var text_to_morse_map: Dictionary = {
	"a": ".-",
	"b": "-...",
	"c": "-.-.",
	"d": "-..",
	"e": ".",
	"f": "..-.",
	"g": "--.",
	"h": "....",
	"i": "..",
	"j": ".---",
	"k": "-.-",
	"l": ".-..",
	"m": "--",
	"n": "-.",
	"o": "---",
	"p": ".--.",
	"q": "--.-",
	"r": ".-.",
	"s": "...",
	"t": "-",
	"u": "..-",
	"v": "...-",
	"w": ".--",
	"x": "-..-",
	"y": "-.--",
	"z": "--..",
	"0": "-----",
	"1": ".----",
	"2": "..---",
	"3": "...--",
	"4": "....-",
	"5": ".....",
	"6": "-....",
	"7": "--...",
	"8": "---..",
	"9": "----.",
	" ": "/",
}
var morse_to_text_map: Dictionary = {}
var prosign_map: Dictionary = {
	"AR": ".-.-.",
	"IMI": "..--..",
	"HH": "........",
	"SOS": "...---...",
	"BT": "-...-",
}
var reverse_prosign_map: Dictionary = {}
var position: float = 0.0


func _ready():
	for key in text_to_morse_map:
		morse_to_text_map[text_to_morse_map[key]] = key
	for key in prosign_map:
		reverse_prosign_map[prosign_map[key]] = key


func set_music_volume(value: float) -> void:
	GlobalVariables.musicVolume = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(GlobalVariables.musicBusStr), linear_to_db(value)
	)


func set_sound_volume(value: float) -> void:
	GlobalVariables.soundVolume = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(GlobalVariables.soundBusStr), linear_to_db(value)
	)


func set_master_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func text_to_morse(text: String) -> String:
	var res: String = ""

	for word in text.strip_edges().split(" "):
		if prosign_map.has(word):
			res += prosign_map[word]
			continue
		else:
			word = word.to_lower()
			for ch in word:
				if text_to_morse_map.has(ch):
					res += text_to_morse_map[ch] + " "
		res += " / "

	return res


func morse_to_text(morse: String) -> String:
	var tmp: String = ""
	var res: String = ""

	for ch in morse:
		if ch != " ":
			tmp += ch
			continue

		if reverse_prosign_map.has(tmp):
			res += reverse_prosign_map[tmp]
		elif morse_to_text_map.has(tmp):
			res += morse_to_text_map[tmp]
		tmp = ""

	if reverse_prosign_map.has(tmp):
		res += reverse_prosign_map[tmp]
	elif morse_to_text_map.has(tmp):
		res += morse_to_text_map[tmp]

	return res


func generate_morse_audio(morse: String) -> void:
	for ch in morse.to_lower():
		if not text_to_morse_map.has(ch):
			morse = morse.replace(ch, "")
	var cmd = PYCW
	var args = [
		"-t",
		morse,
		"-s",
		GlobalVariables.wpm,
		"-n",
		GlobalVariables.frequency,
		"-v",
		GlobalVariables.soundVolume,
		"-r",
		GlobalVariables.sampleRate,
		"-o",
		GlobalVariables.morseFilename.replace("res://", "./")
	]
	var output = []
	OS.execute(cmd, args, output, true)
	for line in output:
		print(line)


func load_audio_stream_from_file(filePath: String) -> AudioStream:
	var audioBytes = FileAccess.get_file_as_bytes(filePath)
	var audioStream = AudioStreamWAV.new()
	audioStream.format = 1
	audioStream.mix_rate = GlobalVariables.sampleRate
	audioStream.stereo = true
	audioStream.data = audioBytes
	return audioStream


func pause_music() -> void:
	position = BackgroundMusicScene.get_playback_position()
	BackgroundMusicScene.stop()


func resume_music() -> void:
	BackgroundMusicScene.play(position)


func mask_solution(solution: String, mask: String = "*") -> String:
	var res: String = ""

	for ch in solution:
		if ch == " ":
			res += ch
		else:
			res += mask

	return res


func analyze_text_solution(correct: String, input: String) -> CopyResults:
	var correct_letters: int = 0
	input = input.strip_edges()

	for i in range(len(correct)):
		var current_correct: String = correct.substr(i, 1)
		var current_input: String = input.substr(i, 1)

		if current_correct == " " or current_input == " ":
			continue
		if current_correct == current_input:
			correct_letters += 1

	var results: CopyResults = CopyResults.new(
		correct_letters, float(correct_letters) / len(correct) * 100
	)
	return results


func get_rand_int(low: int, high: int) -> int:
	var rng = RandomNumberGenerator.new()
	return rng.randi_range(low, high)


func generate_random_alpabet() -> String:
	var rng: int = get_rand_int(0, 12)  # 6 rearrangements of the alphabet
	const alphabet: String = "abcdefghijklmnopqrstuvwxyz"

	if rng == 1:
		# normal alphabet
		return alphabet
	elif rng == 3:
		# normal alphabet - reversed
		return "zyxwvutsrqponmlkjihgfedcba"
	elif rng == 5:
		# every other letter
		return "acegikmoqsuwybdfhjlnprtvxz"
	elif rng == 7:
		# every other letter - reversed
		return "bdfhjlnprtvxzacegikmoqsuwy"
	elif rng == 9:
		# vowels first
		return "aeiouybcdfghjklmnpqrstvwxz"
	elif rng == 11:
		# consonants first
		return "bcdfghjklmnpqrstvwxyzaeiouy"
	else:
		# random
		var res: String = ""

		while len(res) != 26:
			var rand_letter: String = alphabet.substr(get_rand_int(0, len(alphabet) - 1), 1)
			if rand_letter not in res:
				res += rand_letter

		return res


func generate_random_numbers() -> String:
	var rng: int = get_rand_int(0, 8)  # 6 rearrangements of the numbers
	const numbers: String = "01234567890"

	if rng == 1:
		# normal
		return numbers
	elif rng == 3:
		# normal - reversed
		return "9876543210"
	elif rng == 5:
		# even numbers first
		return "0246813579"
	elif rng == 7:
		# odd numbers first
		return "1357902468"
	else:
		# random
		var res: String = ""

		while len(res) != 10:
			var rand_number: String = numbers.substr(get_rand_int(0, len(numbers) - 1), 1)
			if rand_number not in res:
				res += rand_number

		return res


func generate_random_prosigns() -> String:
	var length: int = 8 * 2
	var res: String = ""

	while len(res) < length:
		var rand_prosign: String = prosign_map.keys()[get_rand_int(0, len(prosign_map.keys())-1)]
		res += rand_prosign + " "

	return res.strip_edges()


func generate_random_alphabet_numbers() -> String:
	const chars: String = "abcdefghijklmnopqrstuvwxyz01234567890"
	var length: int = get_rand_int(8, 26)
	var res: String = ""

	while len(res) != length:
		var rand_char: String = chars.substr(get_rand_int(0, len(chars) - 1), 1)
		if rand_char not in res:
			res += rand_char

	return res


func generate_random() -> String:
	const chars: String = "abcdefghijklmnopqrstuvwxyz01234567890"
	var length: int = get_rand_int(8, 26)
	var res: String = ""

	while len(res) != length:
		if not get_rand_int(0, 10) < 3:
			var rand_char: String = chars.substr(get_rand_int(0, len(chars) - 1), 1)
			if rand_char not in res:
				res += rand_char
		else:
			var rand_prosign: String = prosign_map.keys()[get_rand_int(
				0, len(prosign_map.keys()) - 1
			)]
			if rand_prosign not in res:
				res += rand_prosign

	return res
