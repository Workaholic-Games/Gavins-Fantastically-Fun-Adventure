extends Button
class_name InputRemapButton

@export var action : String
@export var action_event_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_mode = true
	_toggled(false)
	
func _toggled(toggled_on: bool) -> void:
	if !action or !InputMap.has_action(action):
		return
	
	if toggled_on:
		text = "Awaiting Input"
		return
	
	if action_event_index >= InputMap.action_get_events(action).size():
		text = "Unassigned"
		return
	
	var input = InputMap.action_get_events(action)[action_event_index]
	if input is InputEventJoypadButton:
		return
	elif InputEventKey:
		if input.physical_keycode != 0:
			text = OS.get_keycode_string(input.physical_keycode)
		else:
			text = OS.get_keycode_string(input.keycode)

func _unhandled_input(event: InputEvent) -> void:
	if !InputMap.has_action(action) or !is_pressed():
		return
	
	if event.is_pressed() and (event is InputEventKey or event is InputEventJoypadButton):
		var action_events_list = InputMap.action_get_events(action)
		if action_event_index < action_events_list.size():
			InputMap.action_erase_event(action, action_events_list[action_event_index])
			
		InputMap.action_add_event(action, event)
		action_event_index = InputMap.action_get_events(action).size()-1
		button_pressed = false
		release_focus()
		
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		button_pressed = false
		release_focus()
		return
