extends CharacterBody2D

var speed = 15000
@onready var interactable_detection = $ItemDetector
@onready var camera := $Camera2D

@export var inventory: Inventory

var can_interact = true

func _ready() -> void:
	GlobalSignals.feed_item.connect(give_feed_options)
	GlobalSignals.item_fed.connect(remove_item)
	GlobalSignals.player_camera_on.connect(set_camera_on)
	GlobalSignals.player_can_move.connect(set_can_interact)
	DialogueManager.dialogue_started.connect(func(_arg):
		set_can_interact(false)
	)
	DialogueManager.dialogue_ended.connect(func(_arg):
		set_can_interact(true)
	)

func _physics_process(delta: float) -> void:
	if !can_interact:
		return
	var wanted_velocity = Vector2(0, 0)
	if Input.is_action_pressed("left"):
		wanted_velocity.x = -1
	if Input.is_action_pressed("right"):
		wanted_velocity.x = 1
	if Input.is_action_pressed("down"):
		wanted_velocity.y = 1
	if Input.is_action_pressed("up"):
		wanted_velocity.y = -1
	if wanted_velocity.length() == 0:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		velocity.y = move_toward(velocity.y, 0, speed * delta)
	else:
		velocity = wanted_velocity.normalized() * speed * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if !can_interact:
		return
	if Input.is_action_just_pressed("interact"):
		for item in interactable_detection.get_overlapping_bodies():
			if item.is_in_group("Use_item_on"):
				var current_item
				if inventory.items[inventory.current_index]:
					current_item = inventory.items[inventory.current_index].item_name
					item.use_item(current_item)
				else:
					if item.is_in_group("Interactable_item"):
						item.interact()
				return
			if item.is_in_group("Interactable_item") || item.is_in_group("Character") || item.is_in_group("Eye"):
				item.interact()
				return
			if item.is_in_group("Pickupable_item"):
				item.ask_pick_up(self)
				return
	if Input.is_action_just_pressed("feed"):
		for item in interactable_detection.get_overlapping_bodies():
			if item.is_in_group("Eye"):
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
	can_interact = tf

func set_camera_on(tf):
	camera.enabled = tf

func give_feed_options():
	DialogueManager.show_dialogue_balloon(load("res://Resources/Dialogue/eye.dialogue"), "feed_options", [self])

func remove_item(inv_item):
	inventory.remove_item(inv_item)
	GlobalVariables.given_item_types.append(inv_item.category)
