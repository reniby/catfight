extends Node2D

var max_y: int = 594
var max_x: int = 1086
var rng = RandomNumberGenerator.new()
@onready var area: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var coin_timer: Timer = $CoinTimer

func _ready() -> void:
	choose_location()

func _physics_process(_delta: float) -> void:
	var overlapping = false

	for body in area.get_overlapping_bodies():
		hide()
		overlapping = true
		choose_location()
		if body is CharacterBody2D:
			Globals.scores[body.player] += 1
			coin_timer.start()

	if not overlapping and not coin_timer.time_left:
		call_deferred("show")
	
func choose_location():
	var x = rng.randf_range(-max_x / 2, max_x / 2)
	var y = rng.randf_range(-max_y / 2, max_y / 2)
	position = Vector2(x, y)
