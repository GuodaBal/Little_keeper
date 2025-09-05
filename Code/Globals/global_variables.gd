extends Node

var given_item_types: Array[int]
var current_day = 1
var eye_is_fed = false
var mission_given = false
var lowering_gently = true

var has_visited_crater = false

var prologue_has_taken_robe = false
var prologue_has_taken_bucket = false
var prologue_peeked_at_hole = false
var prologue_tried_to_leave = false

var ending_choice = null

var dog_following = false
var dog_sacrificed = false

func set_to_default():
	var blank_array : Array[int]
	given_item_types = blank_array
	current_day = 1
	eye_is_fed = false
	mission_given = false
	lowering_gently = true

	has_visited_crater = false

	prologue_has_taken_robe = false
	prologue_has_taken_bucket = false
	prologue_peeked_at_hole = false
	prologue_tried_to_leave = false

	ending_choice = null

	dog_following = false
	dog_sacrificed = false
