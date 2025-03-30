extends Camera2D

@export var move_distance := 50.0  
@export var move_duration := 0.5   
@export var zoom_in_factor := Vector2(1.2, 1.2) 
@export var zoom_out_factor := Vector2(1.0, 1.0) 

var target_position: Vector2

func _ready():
	target_position = global_position
	print("Camerapos", global_position) 

func move_camera_up():
	print("move_camera_up()")

	if not is_inside_tree():
		print("Camera NOT inside")
		return

	if not get_tree():
		print("null!")
		return

	target_position.y -= move_distance
	move_duration = max(move_duration * 0.95, 0.2)

	print("new targ pos", target_position)

	var tween = get_tree().create_tween()
	if tween:
		print("Tween")
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "global_position", target_position, move_duration)
	else:
		print("no tween")

func zoom_in():
	print("zoom_in")
	var tween = get_tree().create_tween()
	if tween:
		print("zoom")
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "zoom", zoom_in_factor, 0.5)
	else:
		print("nhi zoom")

func zoom_out():
	print(".zoom")
	var tween = get_tree().create_tween()
	if tween:
		print("Tween out")
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "zoom", zoom_out_factor, 0.5)
	else:
		print("null")

func zoom_out_full():
	print("full zoom") 
	var tween = get_tree().create_tween()
	if tween:
		print("")
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "zoom", Vector2(0.5, 0.5), 1.0)
	else:
		print("nope")
