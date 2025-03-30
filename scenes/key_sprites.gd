extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var key_up = $KeyUp
@onready var key_down = $KeyDown
@onready var key_left = $KeyLeft
@onready var key_right = $KeyRight
@onready var key_space = $KeySpace

func _ready():
	show_all_keys()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		play_animation("key_up_pressed")
	if Input.is_action_just_pressed("ui_down"):
		play_animation("key_down_pressed")
	if Input.is_action_just_pressed("ui_left"):
		play_animation("key_left_pressed")
	if Input.is_action_just_pressed("ui_right"):
		play_animation("key_right_pressed")
	if Input.is_action_just_pressed("ui_accept"): 
		play_animation("key_space_pressed")

func show_all_keys():
	key_up.visible = true
	key_down.visible = true
	key_left.visible = true
	key_right.visible = true
	key_space.visible = true

func play_animation(anim_name: String):
	if animation_player.is_playing():
		animation_player.stop() 
	animation_player.play(anim_name) 
