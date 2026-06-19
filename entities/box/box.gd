extends StaticBody3D
@export var has_inventory : bool = true
var played : bool = false
var inventory_opened : bool = false



func interact():
	inventory_opened = !inventory_opened
	if inventory_opened == true:
		$Inventory.show()
	else:
		$Inventory.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Global.paused = false

func outline():
	if played == false:
		$Outline.play("outline")
		played = true
		$InteractButton.text = InputMap.action_get_events("interact")[0].as_text()
		$InteractButton.show()

func no_outline():
	$Outline.play("no_outline")
	played = false
	$InteractButton.hide()
