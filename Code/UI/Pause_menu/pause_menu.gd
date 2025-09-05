extends CanvasLayer

@onready var exit_confirmation := $Exit_confirmation

func _ready() -> void:
	exit_confirmation.visible = false

func _on_controls_pressed() -> void:
	var instance = load("res://Code/UI/Controls/controls.tscn").instantiate()
	add_child(instance)

func _on_main_menu_pressed() -> void:
	exit_confirmation.visible = true

func _on_no_pressed() -> void:
	exit_confirmation.visible = false

func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://Code/UI/Main_menu/main_menu.tscn")
