extends Node2D

@onready var timed: Button = $Timed
@onready var zen: Button = $Zen

func _on_timed_pressed() -> void:
	Globals.mode = 0
	get_tree().change_scene_to_file("res://scenes/catfight.tscn")

func _on_zen_pressed() -> void:
	Globals.mode = 1
	get_tree().change_scene_to_file("res://scenes/catfight.tscn")
