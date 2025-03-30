extends Node

class_name StageManager

signal stage_completed
signal game_over
signal game_won

# Define the stages and required fruits
var stages = [
	{
		"image": "res://assets/backgrounds/x.png",
		"required_fruits": ["Fruit1", "Fruit3"],
		"stage_name": "Stage 1"
	},
	{
		"image": "res://assets/backgrounds/y.png",
		"required_fruits": ["Fruit2", "Fruit5"],
		"stage_name": "Stage 2"
	},
	{
		"image": "res://assets/backgrounds/z.png",
		"required_fruits": ["Fruit1", "Fruit4", "Fruit5"],
		"stage_name": "Stage 3"
	},
	{
		"image": "res://assets/backgrounds/w.png",
		"required_fruits": ["Fruit2", "Fruit3"],
		"stage_name": "Stage 4"
	},
	{
		"image": "res://assets/backgrounds/v.png",
		"required_fruits": ["Fruit1", "Fruit2", "Fruit3", "Fruit4", "Fruit5"],
		"stage_name": "Stage 5"
	}
]

var current_stage = 0
var caught_fruits = []
var background_node: Sprite2D

func _ready():
	# Get background node
	background_node = get_node("../Background")
	
	# Start the first stage
	start_stage(current_stage)

func start_stage(stage_index):
	if stage_index >= stages.size():
		print("Game completed! You won!")
		emit_signal("game_won")
		return
		
	current_stage = stage_index
	caught_fruits.clear()
	
	# Set the background image for this stage
	var texture = load(stages[current_stage].image)
	if texture and background_node:
		background_node.texture = texture
	
	print("Starting " + stages[current_stage].stage_name)
	print("Catch these fruits: " + str(stages[current_stage].required_fruits))

func handle_fruit_caught(fruit_name):
	# Only count the fruit if it's required for this stage
	if fruit_name in stages[current_stage].required_fruits and not fruit_name in caught_fruits:
		caught_fruits.append(fruit_name)
		print("Caught " + fruit_name + "!")
		
		# Check if all required fruits are caught
		if has_caught_all_required_fruits():
			complete_stage()
	elif not fruit_name in stages[current_stage].required_fruits:
		print("This fruit isn't needed for this stage!")

func has_caught_all_required_fruits():
	var required = stages[current_stage].required_fruits
	for fruit in required:
		if not fruit in caught_fruits:
			return false
	return true

func complete_stage():
	print(stages[current_stage].stage_name + " completed!")
	emit_signal("stage_completed")
	
	# Move to the next stage
	start_stage(current_stage + 1)

func handle_bomb_collision():
	print("Game Over! You hit a bomb!")
	emit_signal("game_over")
