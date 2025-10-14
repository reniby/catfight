extends TextEdit

func _process(delta: float) -> void:
	if Globals.winner == 0:
		text = "It's a tie! woo xD"
	else:
		text = "Player " + str(Globals.winner) + " Wins!"
	text += "\n P1: " + str(Globals.scores[0]) + " vs P2: " + str(Globals.scores[1])

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
