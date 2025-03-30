extends Node2D

var button_type = null

func _on_start_pressed():
	button_type = "start"
	$Fade_transition.show() 
	$Fade_transition.get_node("FADE_TIMER").start()
	$Fade_transition.get_node("AnimationPlayer").play("fade_in")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout():
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
