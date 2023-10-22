extends Node2D

@export var mainMenuScene: String
@export var morseToTextScene: String
@export var textToMorseScene: String
@export var copyPracticeScene: String
@export var sendPracticeScene: String

var freeToGoBack: bool = false


func _ready() -> void:
	Utils.resume_music()


func _process(_delta: float) -> void:
	if not Input.is_key_pressed(KEY_ESCAPE):
		freeToGoBack = true
	else:
		if freeToGoBack:
			get_tree().change_scene_to_file(mainMenuScene)


func _on_text_to_morse_button_button_up() -> void:
	get_tree().change_scene_to_file(textToMorseScene)


func _on_morse_to_text_button_button_up() -> void:
	get_tree().change_scene_to_file(morseToTextScene)


func _on_copy_practice_button_button_up() -> void:
	get_tree().change_scene_to_file(copyPracticeScene)


func _on_send_practice_button_button_up() -> void:
	get_tree().change_scene_to_file(sendPracticeScene)
