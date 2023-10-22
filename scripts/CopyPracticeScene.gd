extends Node2D

var CopyResults = preload("res://scripts/CopyResults.gd")

@export var lobbyScene: String
var solution: String


func _ready():
	Utils.pause_music()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(lobbyScene)


func _on_generate_button_button_up() -> void:
	var selected_idx: int = (
		$ParentMarginContainer/ContentVerticalContainer/ModeSelectionOptionButton.get_selected_id()
	)

	if selected_idx == 0:
		# Alphabet
		solution = Utils.generate_random_alpabet()
	elif selected_idx == 1:
		# Numbers:
		solution = Utils.generate_random_numbers()
	elif selected_idx == 2:
		# Prosigns
		solution = Utils.generate_random_prosigns()
	elif selected_idx == 3:
		# Alphabet + Numbers
		solution = Utils.generate_random_alphabet_numbers()
	elif selected_idx == 4:
		# Random
		solution = Utils.generate_random()

	Utils.generate_morse_audio(solution)
	$Morse.stream = Utils.load_audio_stream_from_file(GlobalVariables.morseFilename)

	$ParentMarginContainer/ContentVerticalContainer/IOHorizontalContainer/InputTextEdit.text = (
		Utils.mask_solution(solution)
	)


func _on_verify_button_button_up() -> void:
	$Morse.stop()

	var input: String = (
		($ParentMarginContainer/ContentVerticalContainer/IOHorizontalContainer/OutputTextEdit.text)
		. strip_edges()
	)

	if input == solution:
		$SuccessPanel.show()
	else:
		var statistics: CopyResults = Utils.analyze_text_solution(solution, input)
		$FailurePanel/ParentMarginContainer/ContentVerticalContainer/ResultsTextEdit.text = (
			"Solution: "
			+ solution
			+ "\nCorrect Letters: "
			+ str(statistics.correct_letters)
			+ "/"
			+ str(len(solution))
			+ "\nPercentage: "
			+ "%.2f" % statistics.percentage
			+ "%\n"
		)
		$FailurePanel.show()


func _on_play_button_button_up() -> void:
	$Morse.play()


func _on_stop_button_button_up() -> void:
	$Morse.stop()


func _on_reveal_button_button_up() -> void:
	$ParentMarginContainer/ContentVerticalContainer/IOHorizontalContainer/InputTextEdit.text = solution


func _on_close_button_button_up() -> void:
	$SuccessPanel.hide()


func _on_failure_close_button_button_up() -> void:
	$FailurePanel.hide()
