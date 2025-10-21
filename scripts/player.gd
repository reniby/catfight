extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -800.0

@export var player: int
@onready var death_timer: Timer = $Timer/DeathTimer
@onready var i_timer: Timer = $Timer/ITimer
@onready var camera = $"../Camera2D"
@onready var score: int = 0
@onready var anim: AnimatedSprite2D = $Anim
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var dash_timer: Timer = $Timer/DashTimer
@onready var particles: CPUParticles2D = $CPUParticles2D

var trail
var x_facing = 0
var y_facing = 0
var can_dash = true
var character_skin = [{
	"color": "cyan",
	"anim": "blue_idle"
},
{
	"color": "pink",
	"anim": "pink_idle"
},
{
	"color": "black",
	"anim": "red_idle"
}]
var character_input = [{
	"up": "up_p1", 
	"down": "down_p1",
	"left": "left_p1",
	"right": "right_p1",
	"dash": "dash_p1"
},
{
	"up": "up_p2", 
	"down": "down_p2",
	"left": "left_p2",
	"right": "right_p2",
	"dash": "dash_p2"
},
{
	"up": "up_p3", 
	"down": "down_p3",
	"left": "left_p3",
	"right": "right_p3",
	"dash": "dash_p3"
}
]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var count = 0
func _ready():
	trail = get_node("Trail")
	anim.play(character_skin[player]["anim"])
	trail.default_color = character_skin[player]["color"]

func _physics_process(delta):
	var left = camera.get_viewport_rect().size.x/2 * -1
	var right = camera.get_viewport_rect().size.x/2
	var top = camera.get_viewport_rect().size.y/2 * -1
	var bottom = camera.get_viewport_rect().size.y/2

	player_controller(delta)

	move_and_slide()
	if get_last_slide_collision() != null and get_last_slide_collision().get_collider() is CharacterBody2D:
		var collision = get_last_slide_collision()
		velocity = Vector2(cos(get_angle_to(collision.get_position()) - 3*PI/4), sin(get_angle_to(collision.get_position()) - 3*PI/4)).normalized() * SPEED * 2

	particles.rotation = anim.rotation + PI/2
	if velocity.length() < 50:
		particles.emitting = false
	else:
		particles.emitting = true
			
	particles.initial_velocity_min = remap(velocity.length(),0, 1000,5,100)
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
	for i in range(4):
		tween.tween_property(anim, "modulate:a", 0.4, 0.25)
		tween.tween_property(anim, "modulate:a", 1, 0.25)

func _on_i_timer_timeout() -> void:
	set_collision_layer_value(2, true)

func player_controller(delta):
	var direction = Input.get_vector(character_input[player]["left"], character_input[player]["right"], character_input[player]["up"], character_input[player]["down"])
	if direction:
		velocity = velocity.lerp(direction * SPEED, 5*delta)
	else:
		velocity = velocity.lerp(Vector2(0,0), 5 * delta)
	if Input.is_action_just_pressed(character_input[player]["dash"]) and can_dash:
		velocity = Vector2(cos(anim.rotation - PI/2), sin(anim.rotation - PI/2)).normalized() * SPEED * 5 
		can_dash = false
		dash_timer.start()
		var tween = get_tree().create_tween()
		tween.tween_property(anim, "modulate", Color.RED, 0.5)
		tween.tween_property(anim, "modulate", Color.WHITE, 0.5)
		
	anim.rotation = lerp_angle(anim.rotation, atan2(velocity.x, -velocity.y), delta*10.0)
	collision_shape.rotation = lerp_angle(anim.rotation, atan2(velocity.x, -velocity.y), delta*10.0)
	

func _on_dash_timer_timeout() -> void:
	can_dash = true
