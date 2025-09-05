extends CharacterBody2D

@export var speed = 13000
@export var stop_range = 100
@export var in_orig_pos = true

@onready var animation := $AnimatedSprite2D

var facing_forward = true
var sprite_scale
var player = null



func _ready() -> void:
	animation.play("idle_front")
	sprite_scale = animation.scale.x
	if GlobalVariables.dog_sacrificed:
		print_debug("sacrificed")
		queue_free()
	if !GlobalVariables.dog_following && !in_orig_pos:
		print_debug("not following or pos")
		queue_free()

func interact():
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/item_interactions/day_3.dialogue"), "interact_with_dog")

func _process(delta: float) -> void:
	if GlobalVariables.dog_sacrificed:
		queue_free()
		return
	if GlobalVariables.dog_following:
		if !player:
			player = get_tree().get_first_node_in_group("Player")
			return
		if player.position.y > position.y:
			facing_forward = true
		else:
			facing_forward = false
		if player.position.x < position.x:
			animation.scale.x = -sprite_scale
		else:
			animation.scale.x = sprite_scale
		if abs((player.position - position).length()) <= stop_range:
			if facing_forward:
				animation.play("idle_front")
			else:
				animation.play("idle_back")
			velocity.x = move_toward(velocity.x, 0, speed * delta)
			velocity.y = move_toward(velocity.y, 0, speed * delta)
		else:
			if facing_forward:
				animation.play("walk_front")
			else:
				animation.play("walk_back")
			velocity = (player.position - position).normalized() * speed * delta
		move_and_slide()
