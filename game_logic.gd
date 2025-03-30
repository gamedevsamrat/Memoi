extends Node

@export var backgrounds: Array[Texture]  # Assign R1, R2, etc., in Inspector
@export var required_fruits: Array[Dictionary]  # Required fruits per stage

var current_stage := 0
var collected_fruits := []

@onready var background := $"../Background"
@onready var fruit_container := $"../FruitContainer"
@onready var basket := $"../Basket"

func _ready():
	start_stage(0)

func start_stage(stage: int):
	current_stage = stage
	background.texture = backgrounds[stage]  # Change background
	collected_fruits.clear()

func _on_fruit_caught(fruit_name: String):
	if fruit_name in required_fruits[current_stage]:
		collected_fruits.append(fruit_name)
		if is_stage_complete():
			advance_stage()

func is_stage_complete() -> bool:
	return len(collected_fruits) == len(required_fruits[current_stage])

func advance_stage():
	if current_stage + 1 < backgrounds.size():
		start_stage(current_stage + 1)
	else:
		print("Game Completed!")  # You can transition to a win screen here

# Connect this function to the fruit `Area2D`'s `body_entered` signal
func _on_basket_body_entered(body):
	if body is Area2D:
		_on_fruit_caught(body.name)
		body.queue_free()  # Remove the fruit
