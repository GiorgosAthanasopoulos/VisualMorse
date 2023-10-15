extends AudioStreamPlayer


@export var masterBusStr : String


func _notification(what):
	if $"/root/GlobalVariablesScene" != null:
		if $"/root/GlobalVariablesScene".muteWhenUnfocused:
			if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index(masterBusStr), linear_to_db(0))
			elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index(masterBusStr), linear_to_db(1))
