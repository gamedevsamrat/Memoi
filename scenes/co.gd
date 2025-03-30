extends Node2D

@onready var anim_player = $AnimationPlayer  # Reference to AnimationPlayer

func _ready():
	add_to_group("co_group")
	add_to_group("co_target")  # Add CO to the "co_target" group
	anim_player.play("coani")  # Play animation
