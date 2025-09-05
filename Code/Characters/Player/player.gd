extends CharacterBody2D

var speed = 17000
@onready var interactable_detection = $ItemDetector
@onready var animation := $AnimatedSprite2D

@export var inventory: Inventory

var can_interact = true

var sprite_scale
var facing_forward = true
var robed_status = "plain"

func _ready() -> void:
	GlobalSignals.feed_item.connect(give_feed_options)
	GlobalSignals.item_fed.connect(remove_item)
	GlobalSignals.player_can_move.connect(set_can_interact)
	GlobalSignals.start_ending.connect(go_to_idle)
	GlobalSignals.put_robe_up.connect(put_robe_up)
	GlobalSignals.put_robe_on.connect(put_robe_on)
	#DialogueManager.dialogue_started.connect(func(_arg):
		#set_can_interact(false)
	#)
	#DialogueManager.dialogue_ended.connect(func(_arg):
		#set_can_interact(true)
	#)
	animation.play("idle_forward_plain")
	sprite_scale = animation.scale.x
	set_can_interact(false)

func _physics_process(delta: float) -> void:
	#print_debug(GlobalVariables.current_day)
	if !can_interact || get_tree().get_first_node_in_group("Dialogue") != null:
		return
	var wanted_velocity = Vector2(0, 0)
	if Input.is_action_pressed("left"):
		wanted_velocity.x = -1
		animation.scale.x = -sprite_scale
	if Input.is_action_pressed("right"):
		wanted_velocity.x = 1
		animation.scale.x = sprite_scale
	if Input.is_action_pressed("down"):
		wanted_velocity.y = 1
		facing_forward = true
	if Input.is_action_pressed("up"):
		wanted_velocity.y = -1
		facing_forward = false
	if wanted_velocity.length() == 0:
		if facing_forward:
			animation.play("idle_forward_"+robed_status)
		else:
			animation.play("idle_back_"+robed_status)
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		velocity.y = move_toward(velocity.y, 0, speed * delta)
	else:
		if facing_forward:
			animation.play("run_forward_"+robed_status)
		else:
			animation.play("run_back_"+robed_status)
		velocity = wanted_velocity.normalized() * speed * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if !can_interact || get_tree().get_first_node_in_group("Dialogue") != null:
		return
	if Input.is_action_just_pressed("interact"):
		for item in interactable_detection.get_overlapping_bodies():
			#if item.is_in_group("Use_item_on"):
				#var current_item
				#if inventory.items[inventory.current_index]:
					#current_item = inventory.items[inventory.current_index].item_name
					#item.use_item(current_item)
				#else:
					#if item.is_in_group("Interactable_item"):
						#item.interact()
				#return
			if item.is_in_group("Use_item_on"):
				if inventory.items[inventory.current_index]:
					var inv_item = inventory.items[inventory.current_index]
					item.feed(inv_item)
					return
			if item.is_in_group("Interactable_item") || item.is_in_group("Character") || item.is_in_group("Eye"):
				item.interact()
				return
			if item.is_in_group("Pickupable_item"):
				item.ask_pick_up(self)
				return
	if Input.is_action_just_pressed("feed"):
		for item in interactable_detection.get_overlapping_bodies():
			if item.is_in_group("Use_item_on"):
				if inventory.items[inventory.current_index]:
					var inv_item = inventory.items[inventory.current_index]
					item.feed(inv_item)
					return
				#else:
					#if item.is_in_group("Interactable_item"):
						#item.interact()
						#return
				#var inventory_item = item.Pick_up()
				#inventory.Add_item(inventory_item)
				#inventory_ui.Update_slots()
	#if Input.is_action_just_pressed("use_item"):
		#var current_item
		#if inventory.items[inventory.current_index]:
			#current_item = inventory.items[inventory.current_index].item_name
			#for item in interactable_detection.get_overlapping_bodies():
				#if item.is_in_group("Use_item_on"):
					#item.Use_item(current_item)

func set_can_interact(tf):
	print_debug(tf)
	can_interact = tf

func give_feed_options():
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/eye.dialogue"), "feed_options", [self])

func remove_item(inv_item):
	inventory.remove_item(inv_item)
	GlobalVariables.given_item_types.append(inv_item.category)

func go_to_idle():
	animation.play("idle_forward_"+robed_status)

func put_robe_up():
	animation.play("ending_robe")

func put_robe_on():
	print_debug("robed")
	robed_status = "robed"
	animation.play("idle_forward_"+robed_status)
