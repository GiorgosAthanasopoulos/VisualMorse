extends Node2D

@export var lobbyScene: String

var morsePosition: float = 0.0


func _ready() -> void:
	Utils.pause_music()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(lobbyScene)


func _on_generate_button_button_up() -> void:
	$"ParentMarginContainer2/ContentVerticalContainer/IOHorizontalContainer/OutputTextEdit".text = (
		Utils
		. morse_to_text(
			(
				$"ParentMarginContainer2/ContentVerticalContainer/IOHorizontalContainer/InputTextEdit"
				. text
			)
		)
	)
	Utils.generate_morse_audio(
		$"ParentMarginContainer2/ContentVerticalContainer/IOHorizontalContainer/OutputTextEdit".text
	)
	$Morse.stream = Utils.load_audio_stream_from_file(GlobalVariables.morseFilename)


func _on_play_button_button_up() -> void:
	$Morse.play()


func _on_pause_button_button_up() -> void:
	morsePosition = $Morse.get_playback_position()
	$Morse.stop()


func _on_resume_button_button_up() -> void:
	if not $Morse.playing:
		$Morse.play(morsePosition)


func _on_stop_button_button_up() -> void:
	$Morse.stop()
