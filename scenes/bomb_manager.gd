extends Node

# Reference to the stage manager
var stage_manager: StageManager

func _ready():
	# Get the StageManager reference
	stage_manager = get_node("../StageManager")
	
	# Connect bomb collision detection
	for child in get_children():
		if child.name == "Bomb" and child is Area2D:
			child.connect("area_entered", _on_bomb_collision)

func _on_bomb_collision(area):
	# Check if the player collided with a bomb
	if area.get_parent().name == "Player":
		stage_manager.handle_bomb_collision()
