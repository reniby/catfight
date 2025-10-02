extends Label
@onready var player: CharacterBody2D = $"../Player"
@onready var player_2: CharacterBody2D = $"../Player2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Player 1: " + str(player.score) + "\n" + "Player 2: " + str(player_2.score)
