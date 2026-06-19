extends CanvasLayer

@export var player : CharacterBody3D
@export var title : CanvasLayer
@export var cursor : Sprite2D

func _on_sensitivity_value_changed(value: float) -> void:
	Global.sensitivity = value

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	if value == -20:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)

func _on_fov_value_changed(value: float) -> void:
	Global.fov = value

func _on_back_pressed() -> void:
	hide()
	if player:
		player.paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if title:
		title.show()
	if cursor:
		cursor.show()
