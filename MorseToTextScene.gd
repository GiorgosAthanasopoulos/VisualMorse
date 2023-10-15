extends Node2D

@export var lobbyScene : String


func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(lobbyScene)
