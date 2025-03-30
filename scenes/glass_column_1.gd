extends Node2D

func _ready():
	randomize()
	assign_platform_states()

func assign_platform_states():
	var platforms = get_children()
	
	# Ensure we have exactly 2 platforms
	if platforms.size() != 2:
		push_error("Glass Column must have exactly 2 platforms")
		return
	
	# Randomly choose which platform is safe
	var safe_platform_index = randi() % 2
	
	for i in range(platforms.size()):
		# Make sure the platform has the new script and method
		if platforms[i].has_method("set_platform_state"):
			platforms[i].set_platform_state(i == safe_platform_index)
			print("Platform %s is %s" % [platforms[i].name, "safe" if i == safe_platform_index else "wrong"])
