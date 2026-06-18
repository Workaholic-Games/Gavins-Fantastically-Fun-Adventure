extends Node3D



func _ready() -> void:
	$TitleUI/Intro.queue_free()
	#$TitleUI/Intro.play()


func _on_intro_finished() -> void:
	$TitleUI/Intro.queue_free()


func _title_button_hovered() -> void:
	$Hover.play()
