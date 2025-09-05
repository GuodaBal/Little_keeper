extends CharacterBody2D

@export var speed = 14000
@export var stop_range = 300

var player = null

func _process(delta: float) -> void:
	if !player:
		player = get_tree().get_first_node_in_group("Player")
		return
	if abs((player.position - position).length()) <= stop_range:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		velocity.y = move_toward(velocity.y, 0, speed * delta)
	else:
		velocity = (player.position - position).normalized() * speed * delta
	move_and_slide()
