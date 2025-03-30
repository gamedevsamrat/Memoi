extends StaticBody2D

signal five_blocks_fallen 

@export var chain_scene: PackedScene
@onready var second_area = $SecondArea  
@onready var camera = get_parent().get_node_or_null("Camera2D")
@onready var mwall = $mwall  
@onready var mwall_timer = $MwallTimer  
@onready var chain_timer = $ChainTimer  

var logic_active = false  
var spacebar_count = 0  
var game_stopped = false  

var mwall_check_active = false  

var chain_y_position = 267 

var reset_count = 0 
var wall1_y_position = 412  
var wall2_y_position = 412  
var wall_step = 46  

func _ready():
	var first_chain = get_parent().get_node_or_null("chain")
	if first_chain:
		first_chain.add_to_group("chain")

	if mwall and mwall.has_signal("body_entered"):
		mwall.body_entered.connect(_on_mwall_body_entered)

	if mwall_timer:
		mwall_timer.timeout.connect(_on_mwall_timer_timeout)

	if chain_timer:
		chain_timer.timeout.connect(_on_chain_timer_timeout)

func _input(event):
	if game_stopped:
		return

	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		spacebar_count += 1
		start_mwall_timer()  

		if not logic_active:
			logic_active = true
			camera.zoom_in()

func start_mwall_timer():
	if mwall_timer:
		mwall_timer.stop()  
		mwall_check_active = true  
		mwall_timer.start(1.0)  

func _on_mwall_body_entered(body):
	if body is RigidBody2D:
		game_stopped = true
		camera.zoom_out_full()  
		await get_tree().create_timer(1.0).timeout 
		get_tree().paused = true 
		await get_tree().create_timer(1.0).timeout
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_mwall_timer_timeout():
	if game_stopped or not mwall_check_active:
		return

	mwall_check_active = false
	reset_chain()  
	
func _on_chain_timer_timeout():
	game_stopped = true
	get_tree().paused = true
	
func reset_chain():
	if game_stopped:
		return
		
	var existing_chains = get_tree().get_nodes_in_group("chain")
	for chain in existing_chains:
		if is_instance_valid(chain):  
			chain.queue_free()  

	await get_tree().process_frame  

	reset_count += 1 
	if reset_count == 5:
		print("Signal Emitted")
		five_blocks_fallen.emit()

	call_deferred("spawn_new_chain")
	move_walls_up()


func spawn_new_chain():
	var new_chain = chain_scene.instantiate()
	get_parent().add_child(new_chain)

	chain_y_position -= 39  

	new_chain.global_position = Vector2(581, chain_y_position)  
	new_chain.add_to_group("chain")  

	move_camera_up()


	if chain_timer:
		chain_timer.start(5.0)

func move_camera_up():
	if camera:
		camera.move_camera_up()

func move_walls_up():
	if mwall:
		var wall1 = mwall.get_node_or_null("Wall1")
		var wall2 = mwall.get_node_or_null("Wall2")

		if wall1:
			wall1_y_position = 412 - (reset_count * wall_step)
			wall1.global_position.y = wall1_y_position  

		if wall2:
			wall2_y_position = 412 - (reset_count * wall_step)
			wall2.global_position.y = wall2_y_position  
