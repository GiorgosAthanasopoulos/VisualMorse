extends Node2D


@export var lobbyScene : String


func _ready():
	Utils.pause_music()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(lobbyScene)


func _on_generate_button_button_up() -> void:
	# TODO:
	#	- depending on option button selected option
	#	generate randomized solution (presented as * 
	#	instead of actual character to the user).
	#	- store solution to variable in scene.
	#	- generate_morse_audio
	# NOTE:
	#	- to generate randomized solutions create helper
	#	functions in Utils.gd
	pass 


func _on_verify_button_button_up() -> void:
	$Morse.stop()
	# TODO:
	# 	- compare input to solution
	# 	- show results to user with a popup


func _on_play_button_button_up() -> void:
	$Morse.play()


func _on_stop_button_button_up() -> void:
	$Morse.stop() 
