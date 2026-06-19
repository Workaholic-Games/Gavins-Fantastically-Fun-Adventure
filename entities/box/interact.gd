extends StaticBody3D
@export var type : String
var played : bool = false
var inventory_opened : bool = false


func interact():
	match type:
		
		"scaryhead": 
			if Autoload.inventory.has("Eyes"):
				pass
			else:
				$Dialogue/Label.text = "It's missing something..."
		"container":
			if inventory_opened == true:
				$Inventory.show()
			else:
				$Inventory.hide()
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				Autoload.paused = false


func outline():
	if played == false:
		if is_in_group("Interactable"):
			$Outline.play("outline")
			played = true
			$InteractButton.text = InputMap.action_get_events("interact")[0].as_text()
			$InteractButton.show()

func no_outline():
	$Outline.play("no_outline")
	played = false
	$InteractButton.hide()
