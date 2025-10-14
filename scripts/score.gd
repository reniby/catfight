extends Label
@onready var player_1: CharacterBody2D = $"../../Player"
@onready var player_2: CharacterBody2D = $"../../Player2"
@onready var player_3: CharacterBody2D = $"../../Player3"

func _process(delta: float) -> void:
	text = "Player 1: " + str(player_1.score) + "\n" + "Player 2: " + str(player_2.score) + "\n" + "Player 3: " + str(player_3.score)
