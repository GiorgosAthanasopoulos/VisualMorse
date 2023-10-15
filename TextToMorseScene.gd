extends Node2D


@export var lobbyScene : String
var morsePosition: float = 0.0


func _ready():
	$"/root/UtilsScene".pause_music()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(lobbyScene)


func _on_generate_button_button_up() -> void:
	$"ParentMarginContainer/ContentVerticalContainer/IOHorizontalContainer/OutputTextEdit".text = $"/root/UtilsScene".text_to_morse($"ParentMarginContainer/ContentVerticalContainer/IOHorizontalContainer/InputTextEdit".text)
	$"/root/UtilsScene".generate_morse_audio($"ParentMarginContainer/ContentVerticalContainer/IOHorizontalContainer/InputTextEdit".text)
	$Morse.stream = $"/root/UtilsScene".load_audio_stream_from_file($"/root/GlobalVariablesScene".morseFilename)
	

func _on_play_button_button_up() -> void:
	$Morse.play()

func _on_pause_button_button_up() -> void:
	morsePosition = $Morse.get_playback_position()
	$Morse.stop()


func _on_resume_button_button_up() -> void:
	if not $Morse.playing:
		$Morse.play(morsePosition)
