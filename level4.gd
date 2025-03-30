extends Node2D

var correct_cards_clicked = 0  # Track correct card clicks
const TOTAL_CORRECT_CARDS = 4  # Since 4 columns, 4 correct cards exist

func _ready():
	assign_wrong_cards()

func assign_wrong_cards():
	for column in get_children():
		for card in column.get_children():
			var texture_button = card.get_node("TextureButton")
			if card.name in Global.wrong_platforms:
				# Mark as wrong card
				texture_button.texture_normal = load("res://wrong_card.png")  
				texture_button.pressed.connect(func(): on_card_clicked(false))
			else:
				# Mark as correct card
				texture_button.texture_normal = load("res://correct_card.png")  
				texture_button.pressed.connect(func(): on_card_clicked(true))

func on_card_clicked(is_correct):
	if is_correct:
		print("✅ Correct card clicked!")
		correct_cards_clicked += 1
	else:
		print("💣 Wrong card clicked!")

	# Check if all correct cards are clicked
	if correct_cards_clicked == TOTAL_CORRECT_CARDS:
		Global.reset_wrong_platforms()  # Reset wrong platforms after completing level
		print("🎉 All correct cards clicked! Data reset.")
