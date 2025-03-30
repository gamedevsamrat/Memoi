extends RigidBody2D

@onready var pin_joint = $PinJoint2D
@onready var initial_position = global_position
@onready var top_detector = $Area2D  
@onready var main_collision = $CollisionShape2D  
@onready var collision_area = $CollisionDetector  
var is_resetting = false  
signal block_landed  
signal collision_detected  

func _ready():
	stop_all_animations()
	call_deferred("move_area2d_out_of_rigidbody")  

	var platform = get_tree().get_first_node_in_group("platform")
	if platform:
		block_landed.connect(platform._on_block_landed)
		collision_detected.connect(platform._on_block_collision)  

	if collision_area:
		collision_area.body_entered.connect(_on_collision_shape_1_collided)

func _process(_delta):
	if global_position != initial_position:
		global_position = initial_position  

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		detach()

func detach():
	if pin_joint and is_instance_valid(pin_joint):
		pin_joint.queue_free()
		pin_joint = null
	stop_all_animations()
	sleeping = false
	freeze = false
	reparent(get_tree().current_scene)  

	if top_detector:
		top_detector.global_position = global_position  

func stop_all_animations():
	set_freeze_enabled(false)
	set_process(false)

func move_area2d_out_of_rigidbody():
	if top_detector:
		top_detector.reparent(get_tree().current_scene)  
		top_detector.global_position = global_position + Vector2(0, -50)  


func _on_collision_shape_1_collided(body: Node2D):
	if is_resetting:
		return  

	if body is RigidBody2D and body.has_node("CollisionShape2D"):
		print("Collision ")

		print("unknown collided ")
		is_resetting = true  
		collision_detected.emit()  

		await get_tree().process_frame  
		is_resetting = false  
