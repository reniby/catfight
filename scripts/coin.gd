extends Node2D

var max_y = 594
var max_x = 1086
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	choose_location()

	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func choose_location():
	var x = rng.randf_range(-max_x / 2, max_x / 2)
	var y = rng.randf_range(-max_y / 2, max_y / 2)
	position = Vector2(x, y)

	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.score += 1
		choose_location()
