extends Node2D

func _ready():
	var platforms = get_children()
	if platforms.size() == 2:
		var wrong_platform = platforms[randi() % 2]  # Randomly pick one
		var collision = wrong_platform.get_node("CollisionShape2D")
		
		if collision:
			collision.set_deferred("disabled", true)  # Disable collision so player falls
			print("Wrong platform:", wrong_platform.name)
