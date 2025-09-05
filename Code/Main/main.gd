extends Node2D

@export var current_scene : Node

@onready var transition_animations := $TransitionAnimations

var pause_menu_instance = null
var player

func _ready() -> void:
	GlobalSignals.switch_area.connect(switch_area)
	transition_animations.play_fade_in()
	print_debug("waiting")
	await transition_animations.animation_finished
	current_scene.start_intro_cutscene()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		#No menu instance -> menu not in scene
		if !pause_menu_instance:
			pause_menu_instance = load("res://Code/UI/Pause_menu/pause_menu.tscn").instantiate()
			add_child(pause_menu_instance)
			if !player:
				player = get_tree().get_first_node_in_group("Player")
			GlobalSignals.player_can_move.emit(false)
		else:
			remove_child(pause_menu_instance)
			pause_menu_instance = null
			GlobalSignals.player_can_move.emit(true)

func switch_area(name, speed = 3.0):
	print_debug("called")
	print_debug(name)
	GlobalSignals.player_can_move.emit(false)
	if !transition_animations.is_screen_black:
		transition_animations.play_fade_out(speed)
		await transition_animations.animation_finished
	var instance = load("res://Code/Areas/"+name+"/"+name.to_lower()+"_day_"+str(GlobalVariables.current_day)+".tscn").instantiate()
	call_deferred("remove_child", current_scene)
	add_child(instance)
	current_scene = instance
	
	for child in current_scene.get_children():
		if child.is_in_group("Pickupable_item"):
			if !player:
				player = get_tree().get_first_node_in_group("Player")
			if player.inventory.items.has(child.item) || GlobalVariables.eye_is_fed || !GlobalVariables.mission_given:
				current_scene.call_deferred("remove_child", child)
	
	
	if !transition_animations.is_playing():
		transition_animations.play_fade_in(speed)
	else:
		await transition_animations.animation_finished
		transition_animations.play_fade_in(speed)
	await transition_animations.animation_finished
	GlobalSignals.player_can_move.emit(true)
