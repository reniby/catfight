extends Line2D

@export var length = 750
var point = Vector2()
var prev = null
var active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		global_position = Vector2(0,0)
		global_rotation = 0
		
		point = get_parent().global_position/get_parent().scale
		add_point(point)
		add_point(point-Vector2(0.1,0.1))
		add_point(point-Vector2(0.2,0.2))
	else:
		remove_point(0)

	while get_point_count() > length:
		remove_point(0)
	
	if get_point_count() == 0:
		queue_free()
	
