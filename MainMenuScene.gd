extends Node2D


@export var lobbyScene : PackedScene
@export var optionsScene : PackedScene


func _on_exit_button_button_up() -> void:
	get_tree().quit()


func _on_options_button_button_up() -> void:
	get_tree().change_scene_to_packed(optionsScene)


func _on_play_button_button_up() -> void:
	get_tree().change_scene_to_packed(lobbyScene)
