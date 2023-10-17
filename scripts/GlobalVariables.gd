extends Node


@export var frequency : int = 800
@export var wpm : int = 12
@export var musicVolume : float = 0.3
@export var soundVolume : float = 0.7
@export var musicBusStr : String = "Music"
@export var soundBusStr : String = "Sound"
@export var muteWhenUnfocused : bool = true
@export var sampleRate : int = 48_000
@export var morseFilename: String = "./morse.wav"
