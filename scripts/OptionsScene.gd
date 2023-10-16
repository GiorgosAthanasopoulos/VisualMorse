extends Node2D


@export var mainMenuScene : String


func _ready() -> void:
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MusicVolumeSlider.value = GlobalVariables.musicVolume
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/SoundVolumeSlider.value = GlobalVariables.soundVolume
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/FrequencySlider.value = GlobalVariables.frequency
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/WPMSlider.value = GlobalVariables.wpm
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MusicVolumeLabel.text = "Music Volume (" + String.num(GlobalVariables.musicVolume) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/SoundVolumeLabel.text = "Sound Volume (" + String.num(GlobalVariables.soundVolume) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/FrequencyLabel.text = "Frequency (" + String.num(GlobalVariables.frequency) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/WPMLabel.text = "WPM (" + String.num(GlobalVariables.wpm) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MuteWhenUnfocusedCheckbox.button_pressed = GlobalVariables.muteWhenUnfocused


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(mainMenuScene)


func _on_music_volume_slider_value_changed(value: float) -> void:
	Utils.set_music_volume(value)
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MusicVolumeLabel.text = "Music Volume (" + String.num(value) + ")"


func _on_sound_volume_slider_value_changed(value: float) -> void:
	Utils.set_sound_volume(value)
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/SoundVolumeLabel.text = "Sound Volume (" + String.num(value) + ")"


func _on_frequency_slider_value_changed(value: float) -> void:
	@warning_ignore("narrowing_conversion")
	GlobalVariables.frequency = value
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/FrequencyLabel.text = "Frequency (" + String.num(value) + ")"


func _on_wpm_slider_value_changed(value: float) -> void:
	@warning_ignore("narrowing_conversion")
	GlobalVariables.wpm = value
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/WPMLabel.text = "WPM (" + String.num(value) + ")"


func _on_check_box_toggled(button_pressed: bool) -> void:
	GlobalVariables.muteWhenUnfocused = button_pressed
