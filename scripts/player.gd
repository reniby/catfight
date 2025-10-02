extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

@export var player: int
@export var color: String
@onready var death_timer: Timer = $DeathTimer
@onready var i_timer: Timer = $ITimer
@onready var camera = $"../Camera2D"
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var score: int = 0

var trail

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var count = 0
func _ready():
	trail = get_node("Trail")
	trail.default_color = color

func _physics_process(delta):
	var left = camera.get_viewport_rect().size.x/2 * -1
	var right = camera.get_viewport_rect().size.x/2
	var top = camera.get_viewport_rect().size.y/2 * -1
	var bottom = camera.get_viewport_rect().size.y/2

	if position.y > bottom:
		position.y = top
	elif position.y < top:
		position.y = bottom
	if position.x > right + 10:
		position.x = left
	elif position.x < left - 10:
		position.x = right

	if player == 1:
		var y_direction = Input.get_axis("up_p1", "down_p1")
		var x_direction = Input.get_axis("left_p1", "right_p1")
		if y_direction:
			velocity.y = y_direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		if x_direction:
			velocity.x = x_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	if player == 2:
		var y_direction = Input.get_axis("up_p2", "down_p2")
		var x_direction = Input.get_axis("left_p2", "right_p2")
		if y_direction:
			velocity.y = y_direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		if x_direction:
			velocity.x = x_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func death():
	visible = false

	set_collision_layer_value(2, false)
	death_timer.start()
	trail.clear_points()
	for coll in trail.shapes:
		coll.queue_free()
		trail.shapes = []
	
func _on_death_timer_timeout() -> void:
	position.x = 0
	position.y = 0
	visible = true
	i_timer.start()
	var tween = get_tree().create_tween()

	tween.tween_property($Icon, "modulate:a", 0.4, 0.25)
	tween.tween_property($Icon, "modulate:a", 1, 0.25)
	tween.tween_property($Icon, "modulate:a", 0.4, 0.25)
	tween.tween_property($Icon, "modulate:a", 1, 0.25)
	tween.tween_property($Icon, "modulate:a", 0.4, 0.25)
	tween.tween_property($Icon, "modulate:a", 1, 0.25)
	tween.tween_property($Icon, "modulate:a", 0.4, 0.25)
	tween.tween_property($Icon, "modulate:a", 1, 0.25)

func _on_i_timer_timeout() -> void:
	set_collision_layer_value(2, true)
	
