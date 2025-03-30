extends Node2D

@onready var anim_player = $AnimationPlayer  # Reference to AnimationPlayer

func _ready():
	add_to_group("ae_group")
	anim_player.play("appleani")  # Play the animation in a loop
