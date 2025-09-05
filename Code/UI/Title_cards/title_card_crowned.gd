extends CanvasLayer

@onready var animation := $AnimationPlayer

func _ready() -> void:
	animation.play("fade")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") && !animation.is_playing():
		get_tree().change_scene_to_file("res://Code/UI/Main_menu/main_menu.tscn")
