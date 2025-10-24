extends Node2D

@export var coin_scene: PackedScene = preload("res://scenes/coin.tscn")
@onready var player_scores: Array[Label] = [$Labels/P1, $Labels/P2, $Labels/P3, $Labels/P4]

var player_scene: PackedScene = preload("res://scenes/player.tscn")
var title = "Reaper Madness :D"
var player_positions = [
	Vector2(-500, -250),
	Vector2(500,-250),
	Vector2(-500, 250),
	Vector2(500,250)
]

func _ready():
	for i in range(Globals.numPlayers-1):
		add_child(coin_scene.instantiate())
	for i in range(len(Globals.players)):
		if Globals.players[i]:
			var child = player_scene.instantiate()
			child.player = i
			add_child(child)
			child.global_position = player_positions[i]

func _process(_delta):
	DisplayServer.window_set_title(title + " | fps: " + str(Engine.get_frames_per_second()))
	for i in range(len(Globals.scores)):
		if Globals.players[i]:
			player_scores[i].text = str(Globals.scores[i])

func _on_game_timer_timeout() -> void:
	#Globals.scores[0] = player_1.score
	#Globals.scores[1] = player_2.score
	#if player_1.score > player_2.score:
		#Globals.winner = 1
	#elif player_1.score < player_2.score:
		#Globals.winner = 2
	#else:
		#Globals.winner = 0
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
