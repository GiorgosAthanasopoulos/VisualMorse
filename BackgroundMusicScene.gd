extends AudioStreamPlayer


@export var masterBusStr : String


func _notification(what: int) -> void:
	if $"/root/GlobalVariablesScene" != null:
		if $"/root/GlobalVariablesScene".muteWhenUnfocused:
			if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
				$"/root/UtilsScene".set_master_volume(linear_to_db(0))
			elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
				$"/root/UtilsScene".set_master_volume(linear_to_db(1))
