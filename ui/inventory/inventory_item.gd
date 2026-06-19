extends Button
class_name drag_drop_cell 
signal dragged(from: Vector2i, to: Vector2i)
@export var item_name : String
@export var inventory : Control
var grid_position : Vector2i



func _get_drag_data(_at_position: Vector2) -> Variant:
	if icon == null:
		return null
	
	var preview : TextureRect = TextureRect.new()
	var control : Control = Control.new()
	control.add_child(preview)
	preview.texture = icon
	preview.size = Vector2(64, 64)
	preview.global_position -= Vector2(32, 32)
	preview.self_modulate = Color(1.0, 1.0, 1.0, 0.784)
	preview.z_index = 10
	set_drag_preview(control)
	# $border.visible = false
	
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if not data is drag_drop_cell or data == self:
		return false
	
	#grab_focus()
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var temp : Texture2D = icon
	var temp_type : String = item_name
	
	icon = data.icon
	item_name = data.item_name
	emit_signal("visibility_changed")
	
	data.icon = temp
	data.item_name = temp_type
	data.emit_signal("visibility_changed")
	dragged.emit(data.grid_position, self.grid_position)


func _on_pressed() -> void:
	inventory.description(item_name)
