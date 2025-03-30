extends StaticBody2D

func _on_body_entered(body):
	if body.is_in_group("Player"):  # Ensure only player triggers the scene switch
		get_tree().change_scene_to_file("res://level4.tscn")
