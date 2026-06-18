extends Node3D



func _ready() -> void:
	$TitleUI/Intro.play()


func _on_intro_finished() -> void:
	$TitleUI/Intro.queue_free()
