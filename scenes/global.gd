extends Node

var has_correct_answered: bool = false
var blocks_fallen: int = 0
var is_dropping_blocks: bool = false
var current_scene: String = "main"  # Track which scene we're in
var wrong_platforms: Array = []  # Stores wrong platforms (to be used in Level 4)

# Recipe tracking variables
var current_recipe: int = 0  # 0=R1, 1=R2, 2=R3, 3=R4, 4=R5
var recipe_completed: bool = false
var collected_fruits: Array = []  # Stores names of fruits collected for current recipe

# Define the required fruits for each recipe
var recipe_requirements = [
	["Milk", "Strawberry"],                             # R1
	["Banana", "Kiwi", "Milk"],                         # R2
	["Banana", "Milk"],                                 # R3
	["Blue Berry", "Strawberry", "Banana", "Milk"],     # R4
	["Banana", "Mango", "Milk"]                         # R5
]

# Reset wrong platforms at Level 2 start
func reset_wrong_platforms():
	wrong_platforms.clear()
	print("platforms res")

# Store wrong platforms at Level 2 completion
func store_wrong_platforms(new_wrong_platforms: Array):
	wrong_platforms = new_wrong_platforms.duplicate()
	print("plat store", wrong_platforms)

# Reset collected fruits for a new recipe
func reset_collected_fruits():
	collected_fruits.clear()
	recipe_completed = false
	print("Collected fruits reset for recipe ", current_recipe + 1)

# Check if collected fruit is needed for current recipe
func check_fruit_collected(fruit_name: String) -> bool:
	# If fruit is in requirements for current recipe and not already collected
	if recipe_requirements[current_recipe].has(fruit_name) and not collected_fruits.has(fruit_name):
		collected_fruits.append(fruit_name)
		print("Collected " + fruit_name + " for recipe " + str(current_recipe + 1))
		
		# Check if all required fruits are collected
		var all_collected = true
		for required_fruit in recipe_requirements[current_recipe]:
			if not collected_fruits.has(required_fruit):
				all_collected = false
				break
		
		if all_collected:
			recipe_completed = true
			print("Recipe " + str(current_recipe + 1) + " completed!")
			
			# Move to next recipe if not on the last one
			if current_recipe < recipe_requirements.size() - 1:
				current_recipe += 1
				reset_collected_fruits()
			
		return true
	
	# If fruit is not needed for this recipe
	if not recipe_requirements[current_recipe].has(fruit_name):
		print(fruit_name + " is not needed for current recipe")
	
	return false
