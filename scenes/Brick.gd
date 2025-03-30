extends StaticBody2D

@export var max_hits: int = 1  # Default: 1 hit to break

var current_hits: int = 0

func _ready():
	# Special bricks (Brick3 & Brick4) need 2 hits
	if name in ["Brick3", "Brick4"]:
		max_hits = 2

func hit():
	current_hits += 1
	if current_hits >= max_hits:
		queue_free()  # Destroy the brick
