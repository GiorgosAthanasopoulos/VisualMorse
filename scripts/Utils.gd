extends Node


const PYCW: String = "./assets/utils/pycw.exe"
var text_to_morse_map : Dictionary = {
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
var morse_to_text_map : Dictionary = {}
var prosign_map : Dictionary = {
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
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(GlobalVariables.musicBusStr), linear_to_db(value))


func set_sound_volume(value: float) -> void:
	GlobalVariables.soundVolume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(GlobalVariables.soundBusStr), linear_to_db(value))


func set_master_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func text_to_morse(text: String) -> String:
	var res : String = ""
	
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
	var tmp : String= ""
	var res : String = ""
	
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
	var args = ["-t", morse, "-s", GlobalVariables.wpm, "-n", GlobalVariables.frequency, "-v", GlobalVariables.soundVolume, "-r", GlobalVariables.sampleRate, "-o", GlobalVariables.morseFilename.replace("res://", "./")]
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
