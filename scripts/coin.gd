extends Node2D

var max_y = 594
var max_x = 1086
var rng = RandomNumberGenerator.new()
@onready var area: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var coin_timer: Timer = $CoinTimer

func _ready() -> void:
	choose_location()

func _physics_process(delta: float) -> void:
	var overlapping = false

	for body in area.get_overlapping_bodies():
		hide()
		overlapping = true
		choose_location()
		if "Player" in body.name:
			coin_timer.start()

	if not overlapping and not coin_timer.time_left:
		call_deferred("show")
	
func choose_location():
	var x = rng.randf_range(-max_x / 2, max_x / 2)
	var y = rng.randf_range(-max_y / 2, max_y / 2)
	position = Vector2(x, y)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.score += 1
