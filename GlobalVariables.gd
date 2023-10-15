extends Node


@export var frequency : int
@export var wpm : int
@export var musicVolume : float
@export var soundVolume : float
@export var musicBusStr : String 
@export var soundBusStr : String 
@export var muteWhenUnfocused : bool


func set_music_volume(value):
	musicVolume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(musicBusStr), linear_to_db(musicVolume))


func set_sound_volume(value):
	soundVolume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(soundBusStr), linear_to_db(soundVolume))
