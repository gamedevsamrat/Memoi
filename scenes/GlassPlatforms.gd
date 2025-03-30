extends Node2D

var space_pressed = false

func _ready():
	Global.wrong_platforms.clear() 
	randomize()
	assign_wrong_platforms()

func assign_wrong_platforms():
	for column in get_children():
		if column.get_child_count() == 2:
			var platforms = column.get_children()
			var wrong_platform = platforms[randi() % 2]  
			var collision_shape = wrong_platform.get_node("CollisionShape2D")
			if collision_shape:
				collision_shape.set_deferred("disabled", true)

			Global.wrong_platforms.append(wrong_platform.name) 
			print(column.name + " Wrong p " + wrong_platform.name)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		space_pressed = true

func _process(delta):
	if space_pressed:
		check_column_collisions()

func check_column_collisions():
	for column in get_children():
		var active_collisions = 0
		for platform in column.get_children():
			if is_player_on_platform(platform): 
				active_collisions += 1


		if active_collisions > 1:
			print("Removing CS")
			remove_all_collisions()

func remove_all_collisions():
	for column in get_children():
		for platform in column.get_children():
			var collision_shape = platform.get_node("CollisionShape2D")
			if collision_shape:
				collision_shape.set_deferred("disabled", true)  
	
	print("DONE") 

func is_player_on_platform(platform):
	var area = platform.get_node_or_null("Area2D")
	if area:
		for body in area.get_overlapping_bodies():
			if body.is_in_group("Player"):
				return true
	return false

func transition_to_level4():
	get_tree().change_scene_to_file("res://scenes/level4.tscn")
