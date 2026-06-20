extends StaticBody3D
@export var type : String
var played : bool = false
var inventory_opened : bool = false
var opened : bool = false



func interact():
	match type:
		"scaryhead": 
			if Autoload.inventory.has("Eyes"):
				pass
			else:
				$Dialogue/Label.text = "It's missing something..."
				$Dialogue/Label.modulate = Color(1.0, 1.0, 1.0, 1.0)
				await get_tree().create_timer(2.0).timeout
				var tween = create_tween()
				tween.tween_property($Dialogue/Label, "modulate", Color(1.0, 1.0, 1.0, 0.0), 3)
		"container":
			if inventory_opened == true:
				$Inventory.show()
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				$Inventory.hide()
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				Autoload.paused = false
		"door":
			opened = !opened
			var tween = create_tween()
			if opened:
				tween.tween_property(self, "rotation_degrees", Vector3(0, 90, 0), 0.5)
			else:
				tween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0.5)

			


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
