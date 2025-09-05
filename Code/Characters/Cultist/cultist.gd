extends CharacterBody2D

@export var char_name = ""
@export var facing_forward = true
@export var facing_left = true

@onready var animation := $AnimatedSprite2D

func _ready() -> void:
	if facing_forward:
		animation.play("forward")
	else:
		animation.play("back")
	if !facing_left:
		scale.x *= -1

func interact():
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/Cultists/cultist_lines.dialogue"), char_name)
