extends StaticBody3D
var played : bool = false

func interact():
	print("HELLO I AM A BOX")

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
