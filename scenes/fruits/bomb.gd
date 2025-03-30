extends Node2D

@export var fall_speed: float = 200  # Speed at which bomb falls

func _ready():
	# Ensure the Area2D is in the bomb group
	var area = $Area2D
	if area and not area.is_in_group("bomb"):
		area.add_to_group("bomb")
		print("Added", name, "to bomb group")

func _process(delta):
	# Make the bomb fall down
	position.y += fall_speed * delta
	
	# Remove if goes off screen
	if position.y > 800:  # Adjust based on your screen size
		queue_free()
