extends Line2D

@export var length = 200
@onready var body = $Area2D
@onready var shapes = []
var point = Vector2()
var prev = null
var active = true

func _ready():
	remove_point(0)
	#if self.get_parent().player == 1:
		#body.collision_layer = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().velocity != Vector2(0,0):
		global_position = Vector2(0,0)
		global_rotation = 0
		
		point = get_parent().global_position/get_parent().scale
		add_point(point)
		if len(points) > 0:
			var shape = CollisionShape2D.new()
			$Area2D.add_child(shape)
			var segment = SegmentShape2D.new()
			segment.a = points[points.size()-1]
			segment.b = points[points.size()-2]
			shape.shape = segment
			shapes.append(shape)
	elif get_point_count() > 0:
		shapes.pop_at(0).queue_free()
		remove_point(0)

	while get_point_count() >= length:
		shapes.pop_at(0).queue_free()
		remove_point(0)

func _on_area_2d_body_entered(body: Node2D) -> void:
		if get_parent().player != body.player:
			print(get_parent().player, " inbody ", body.player)
