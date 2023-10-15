extends Node2D


@export var lobbyScene : String


func _ready():
	$"/root/UtilsScene".pause_music()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(lobbyScene)
