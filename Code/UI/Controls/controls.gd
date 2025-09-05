extends Control

func _ready() -> void:
	print_debug(get_parent())

func _on_button_pressed() -> void:
	if get_parent() == get_tree().root:
		get_tree().change_scene_to_file("res://Code/UI/Main_menu/main_menu.tscn")
	else:
		queue_free()
