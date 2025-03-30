extends Node2D

@onready var animation_player = $fire/fireanimation
@onready var animation_player1 = $fire2/fireanimation

@export var ae_scene: PackedScene  
@export var co_scene: PackedScene 
var spawn_positions = [
	Vector2(23, 273),
	Vector2(556, 573),
	Vector2(1111, 71),
	Vector2(659, 538),
	Vector2(373, 563)
]

func _ready():
	animation_player.play("fireani")
	animation_player1.play("fireani")
	add_to_group("level1")  

	spawn_random_objects()

func spawn_random_objects():

	if !ae_scene or !co_scene:
		print("ERROR: AE or CO scene is not assigned! Please assign them in the Inspector.")
		return
	randomize()

	spawn_positions.shuffle()
	
	var total_objects = randi_range(2, 5)
	
	var ae_count = randi_range(0, total_objects)
	var co_count = total_objects - ae_count
	
	print("AE=" + str(ae_count) + " CO= " + str(co_count))
	

	for i in range(ae_count):
		if i < spawn_positions.size():
			var ae_instance = ae_scene.instantiate()
			ae_instance.position = spawn_positions[i]
			add_child(ae_instance)
			print(" AE " + str(spawn_positions[i]))
	

	for i in range(co_count):
		var position_index = i + ae_count
		if position_index < spawn_positions.size():
			var co_instance = co_scene.instantiate()
			co_instance.position = spawn_positions[position_index]
			add_child(co_instance)
			print("cO" + str(spawn_positions[position_index]))


func randi_range(min_val, max_val):
	return min_val + randi() % (max_val - min_val + 1)
