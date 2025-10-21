extends Line2D

@export var length = 80
@onready var body = $Area2D
@onready var shapes = []
@onready var distances = []
@onready var sum_of_distances = 0
var point = Vector2()
var prev = null
var active = true

func _ready():
	while get_point_count() > 0:
		remove_point(0)
	#if self.get_parent().player == 1:
		#body.collision_layer = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if get_parent().visible:
		if get_parent().velocity != Vector2(0,0):
			global_position = Vector2(0,0)
			global_rotation = 0
			
			
			
			point = get_parent().global_position/get_parent().scale
			add_point(point)
			if len(points) > 0:
				var shape = CollisionShape2D.new()
				$Area2D.add_child(shape)
				var segment = SegmentShape2D.new()
				segment.a = points[points.size()-2]
				segment.b = points[points.size()-1]
				shape.shape = segment
				shapes.append(shape)
				if len(points) > 1:
					var dist = points[-1].distance_to(points[-2])
					distances.append(dist)
					sum_of_distances += dist
		elif get_point_count() > 0:
			shapes.pop_at(0).queue_free()
			remove_point(0)
			if len(distances) > 0:
				sum_of_distances -= distances.pop_at(0)
		
		#while get_point_count() >= length:
			#shapes.pop_at(0).queue_free()
			#remove_point(0)
			#if len(distances) > 0:
				#sum_of_distances -= distances.pop_at(0)
		while sum_of_distances >= length or get_point_count() >= length:
			if len(shapes) > 0:
				shapes.pop_at(0).queue_free()
				remove_point(0)
				if len(distances) > 0:
					sum_of_distances -= distances.pop_at(0)


func get_line_length(points):
	var total_length = 0
	
	for i in range(0, len(points) - 1, 2):
		total_length += sqrt((points[i+1][0]-points[i][0])**2 + (points[i+1][1] - points[i][1])**2)
		
	return total_length

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and get_parent().player != body.player:
		print(body.player, "dead")
		body.death()
