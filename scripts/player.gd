extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

@onready var camera = $"../Camera2D"
@export var player: int
@export var color: String

var trail

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	trail = get_node("Trail")
	trail.default_color = color

func _physics_process(delta):
	check_intersections()

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

func check_intersections():
	for i in range(1, trail.points.size()):
		var a1 = trail.points[i - 1]
		var a2 = trail.points[i]
		
		for j in range(1, trail.points.size()):
			if abs(i - j) <= 3:
				continue
			
			var b1 = trail.points[j - 1]
			var b2 = trail.points[j]

			if Geometry2D.segment_intersects_segment(a1, a2, b1, b2) != null:
				check_betwixt(i-1,j)

func check_betwixt(start,end):
	#var polygon = Polygon2D.new()
	var shape = PackedVector2Array(trail.points.slice(min(start,end),max(start,end)+1))
	#polygon.set_polygon(shape)
	var p2 = $"../Player2"
	if Geometry2D.is_point_in_polygon(p2.global_position/p2.global_scale, shape):
		print("DEATH")
