extends Node2D
#
#@onready var tail_part = $TailPart
#var tail_part_scene = preload("res://scenes/tail_part.tscn")
#
#var point
#var parts = []
## Called when the node enters the scene tree for the first time.
#func _ready():
#	parts.append(tail_part)
#
#	point = get_parent().global_position/get_parent().scale
#	point = point[0] - 50
#	for i in range(1,10):
#		var node = PinJoint2D.new()
#		var new_part = tail_part_scene.instantiate()
#		new_part.position.x = point
#		node.set_node_a(parts[-1].get_path())
#		node.set_node_b(new_part.get_path())
#		add_child(node)
#		add_child(new_part)
#		parts.append(new_part)
#		point = point - 50
#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
