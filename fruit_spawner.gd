extends Node2D

@export var fruit_scenes: Array[PackedScene]  # Drag fruit scenes here

# Spawn area boundaries (Rectangle ABCD)
const SPAWN_MIN_X = 38
const SPAWN_MAX_X = 1147
const SPAWN_MIN_Y = 4
const SPAWN_MAX_Y = 70  # Fruits will spawn under this

func _ready():
	print("🚀 FruitSpawner is ready!")  
	$SpawnTimer.timeout.connect(_spawn_fruit)  # Connect Timer signal
	_spawn_fruit()  # Spawn one fruit for testing

func _spawn_fruit():
	if fruit_scenes.is_empty():
		print("⚠️ No fruit scenes assigned!")
		return

	var fruit = fruit_scenes[randi() % fruit_scenes.size()].instantiate()
	
	# Generate random position within ABCD area
	fruit.position = Vector2(randi_range(SPAWN_MIN_X, SPAWN_MAX_X), randi_range(SPAWN_MIN_Y, SPAWN_MAX_Y))

	get_parent().add_child(fruit)
	print("✅ Spawned fruit:", fruit.name, "at", fruit.position)  # Debug log
