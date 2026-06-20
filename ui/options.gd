extends CanvasLayer

@export var player : CharacterBody3D
@export var title : CanvasLayer
@export var cursor : Sprite2D



func _ready() -> void:
	$"VBoxContainer/Window Mode Button".get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST

func _on_sensitivity_value_changed(value: float) -> void:
	Autoload.sensitivity = value

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	if value == -20:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)

func _on_fov_value_changed(value: float) -> void:
	Autoload.fov = value

func _on_back_pressed() -> void:
	hide()
	if player:
		Autoload.paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if title:
		title.show()
	if cursor:
		cursor.show()

func _on_window_mode_button_item_selected(index: int) -> void:
	Autoload.window_mode = index
	match Autoload.window_mode:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if Autoload.window_mode == 0:
			Autoload.window_mode = 1
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			Autoload.window_mode = 0
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
