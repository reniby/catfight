extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

@onready var camera = $"../Camera2D"
@export var player: int
@export var color: String

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var trail = get_node("Trail")
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

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if player == 1:
		if Input.is_action_just_pressed("jump_p1") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	if player == 2:
		if Input.is_action_just_pressed("jump_p2") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var direction = Input.get_axis("left_p2", "right_p2")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
