extends GridContainer
var item_icons : Dictionary = {
	"Sad Sun": load("res://sad_sun.png")
	}



func _ready() -> void:
	add_item("Sad Sun")
	add_item("Sad Sun")



func add_item(item_name : String):
	for slot in get_children():
		if slot.item_name.is_empty():
			slot.item_name = item_name
			slot.icon = item_icons[item_name]
			return


func description(item : String):
	$"../RichTextLabel".show()
	match item:
		"Sad Sun": $"../RichTextLabel".text = "very sad sun indeed"
