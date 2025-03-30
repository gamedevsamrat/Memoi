extends Area2D

func _on_body_entered(body):
	if body.name == "player1":  # Make sure it's the player
		print("PowerUp collected by:", body.name)
		get_parent().queue_free()  # Remove PowerUp from the scene
