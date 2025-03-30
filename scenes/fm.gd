extends Node2D
@export var fruit_scenes = [
	preload("res://scenes/fruit1.tscn"),  
	preload("res://scenes/fruit2.tscn"),  
	preload("res://scenes/fruit3.tscn"),  
	preload("res://scenes/fruit4.tscn"),  
	preload("res://scenes/fruit5.tscn"),  
	preload("res://scenes/fruit6.tscn")   
]
@export var spawn_time_min = 1.0
@export var spawn_time_max = 3.0
@export var fruit_names = ["Banana", "Blue Berry", "Kiwi", "Mango", "Milk", "Strawberry"]
@onready var timer = $Timer
@onready var screen_width = get_viewport_rect().size.x

func _ready():
	randomize()  
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer.wait_time = randf_range(spawn_time_min, spawn_time_max)
	timer.start()

func _on_Timer_timeout():
	spawn_fruit()
	timer.wait_time = randf_range(spawn_time_min, spawn_time_max)
	timer.start()

func spawn_fruit():
	var fruit_index = randi() % fruit_scenes.size()
	var fruit_instance = fruit_scenes[fruit_index].instantiate()
	
	fruit_instance.name = fruit_names[fruit_index]
	
	var fruit_position = Vector2()
	fruit_position.x = randf_range(50, screen_width - 50)
	fruit_position.y = -50  
	fruit_instance.position = fruit_position
	
	
	add_child(fruit_instance)
