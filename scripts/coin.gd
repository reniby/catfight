extends Node2D

var max_y: int = 250
var max_x: int = 460
var rng = RandomNumberGenerator.new()

@onready var area: Area2D = $Area2D
@onready var sprite: AnimatedSprite2D
@onready var particles: CPUParticles2D = $AmbientParticles

@onready var coin_sprite: AnimatedSprite2D = $Sprites/CoinSprite
@onready var pickup_timer: Timer = $PickupTimer
@onready var pickup_behavior: Callable

@export_enum("Coin", "Speed") var pickup_type: String

func _ready() -> void:
	if pickup_type == "Coin":
		sprite = coin_sprite
		pickup_timer.wait_time = 1
		pickup_behavior = Callable(self, "coin_behavior")
	sprite.visible = true
	choose_location()

func _physics_process(_delta: float) -> void:
	var overlapping = false

	for body in area.get_overlapping_bodies():
		if body is CharacterBody2D:
			pickup_behavior.call(body.player)
			pickup_timer.start()

		sprite.visible = false
		
		particles.restart()
		particles.emitting = false
		particles.visible = false
		
		overlapping = true
		choose_location()


	if not overlapping and not pickup_timer.time_left:
		sprite.set_deferred("visible", true)
		particles.emitting = true
		particles.visible = true
		
		sprite.scale = Vector2(0,0)
		sprite.rotation = 0
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "rotation", 8*PI, 0.3)
		tween.set_parallel()
		tween.tween_property(sprite, "scale", Vector2(1,1), 0.3)
		
func choose_location():
	var x = rng.randf_range(-max_x / 2, max_x / 2)
	var y = rng.randf_range(-max_y / 2, max_y / 2)
	position = Vector2(x, y)

func coin_behavior(player):
	Globals.scores[player] += 1
