extends AudioStreamPlayer


@export var masterBusStr : String


func _notification(what: int) -> void:
		if GlobalVariables.muteWhenUnfocused:
			if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
				Utils.set_master_volume(linear_to_db(0))
			elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
				Utils.set_master_volume(linear_to_db(1))
