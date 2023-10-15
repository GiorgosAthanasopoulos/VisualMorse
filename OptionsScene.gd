extends Node2D


@export var mainMenuScene : String


func _ready():
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MusicVolumeSlider.value = $"/root/GlobalVariablesScene".musicVolume
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/SoundVolumeSlider.value = $"/root/GlobalVariablesScene".soundVolume
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/FrequencySlider.value = $"/root/GlobalVariablesScene".frequency
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/WPMSlider.value = $"/root/GlobalVariablesScene".wpm
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MusicVolumeLabel.text = "Music Volume (" + String.num($"/root/GlobalVariablesScene".musicVolume) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/SoundVolumeLabel.text = "Sound Volume (" + String.num($"/root/GlobalVariablesScene".soundVolume) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/FrequencyLabel.text = "Frequency (" + String.num($"/root/GlobalVariablesScene".frequency) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/WPMLabel.text = "WPM (" + String.num($"/root/GlobalVariablesScene".wpm) + ")"
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MuteWhenUnfocusedCheckbox.button_pressed = $"/root/GlobalVariablesScene".muteWhenUnfocused


func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file(mainMenuScene)


func _on_music_volume_slider_value_changed(value):
	$"/root/GlobalVariablesScene".set_music_volume(value)
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/MusicVolumeLabel.text = "Music Volume (" + String.num(value) + ")"


func _on_sound_volume_slider_value_changed(value):
	$"/root/GlobalVariablesScene".set_sound_volume(value)
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/SoundVolumeLabel.text = "Sound Volume (" + String.num(value) + ")"


func _on_frequency_slider_value_changed(value):
	$"/root/GlobalVariablesScene".frequency = value
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/FrequencyLabel.text = "Frequency (" + String.num(value) + ")"


func _on_wpm_slider_value_changed(value):
	$"/root/GlobalVariablesScene".wpm = value
	$ParentMarginContainer/ContentVerticalContainer/SettingsVerticalContainer/WPMLabel.text = "WPM (" + String.num(value) + ")"


func _on_check_box_toggled(button_pressed):
	$"/root/GlobalVariablesScene".muteWhenUnfocused = button_pressed
