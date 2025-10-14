extends Node2D
@onready var player_1: CharacterBody2D = $Player
@onready var player_2: CharacterBody2D = $Player2

func _on_game_timer_timeout() -> void:
	Globals.scores[0] = player_1.score
	Globals.scores[1] = player_2.score
	if player_1.score > player_2.score:
		Globals.winner = 1
	elif player_1.score < player_2.score:
		Globals.winner = 2
	else:
		Globals.winner = 0
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
