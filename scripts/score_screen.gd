extends Label

func _process(delta: float) -> void:
	if Globals.winner == 0:
		text = "It's a tie! woo xD"
	else:
		text = "Player " + str(Globals.winner) + " Wins!"
	
	for i in range(len(Globals.players)):
		if Globals.players[i]:
			text += "\n P%d: " % (i+1) + str(Globals.scores[i])

func _on_button_pressed() -> void:
	Globals.resetGlobals()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
