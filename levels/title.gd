extends Node3D



func _ready() -> void:
	$TitleUI/Intro.queue_free()
	#$TitleUI/Intro.play()


func _on_intro_finished() -> void:
	$TitleUI/Intro.queue_free()


func _title_button_hovered() -> void:
	$Hover.play()



func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/the_lab/the_lab.tscn")


func _on_options_pressed() -> void:
	$Options.show()
	$TitleUI.hide()
