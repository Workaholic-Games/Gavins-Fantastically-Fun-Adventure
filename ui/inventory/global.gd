extends Node
var inventory : Array = []

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, 0)
