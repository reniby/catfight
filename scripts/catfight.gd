extends Node2D

@export var coin_scene: PackedScene = preload("res://scenes/coin.tscn")
@onready var player_scores: Array[Label] = [$Labels/P1, $Labels/P2, $Labels/P3, $Labels/P4]

var player_scene: PackedScene = preload("res://scenes/player.tscn")
var title = "Reaper Madness :D"
var player_positions = [
	Vector2(-90, -30),
	Vector2(-30,-30),
	Vector2(30, -30),
	Vector2(90, -30)
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
	var winners = find_all_indices(Globals.scores, Globals.scores.max())

	if len(winners) ==  1:
		Globals.winner = winners[0] + 1
	else:
		Globals.winner = 0
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	
func find_all_indices(array_to_search: Array, target_element) -> Array:
	var indices: Array = []
	for i in range(array_to_search.size()):
		if array_to_search[i] == target_element:
			indices.append(i)
	return indices
