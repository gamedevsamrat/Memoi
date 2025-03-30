extends Node2D

func _ready():
	# Connect UI elements if needed
	var restart_button = $UI/RestartButton
	if restart_button:
		restart_button.pressed.connect(_on_restart_button_pressed)
	
	var game_over_panel = $UI/GameOverPanel
	if game_over_panel:
		game_over_panel.visible = false

func _on_player_bomb_hit():
	# Show game over UI
	var game_over_panel = $UI/GameOverPanel
	if game_over_panel:
		game_over_panel.visible = true
	
	# Pause the game
	get_tree().paused = true

func _on_restart_button_pressed():
	# Unpause and reload the current scene
	get_tree().paused = false
	get_tree().reload_current_scene()
