extends Node2D

var max_y = 594
var max_x = 1086
var rng = RandomNumberGenerator.new()
@onready var area: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	choose_location()

func _physics_process(delta: float) -> void:
	var overlapping = false

	if len(area.get_overlapping_bodies()):
		overlapping = true
		choose_location()

	if not overlapping:
		call_deferred("show")
	
func choose_location():
	hide()
	var x = rng.randf_range(-max_x / 2, max_x / 2)
	var y = rng.randf_range(-max_y / 2, max_y / 2)
	position = Vector2(x, y)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.score += 1
