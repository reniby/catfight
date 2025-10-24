extends Node2D
@onready var labels: Array[Label] = [$Label,$Label2,$Label3,$Label4]
@onready var press_play: Label = $PressPlay

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
},
{
	"up": "up_p4", 
	"down": "down_p4",
	"left": "left_p4",
	"right": "right_p4",
	"dash": "dash_p4"
}
]
var actions = ['left', 'right', 'up', 'down']

func _process(_delta: float) -> void:
	for player in range(4):
		for action in actions:
			if Input.is_action_just_pressed(character_input[player][action]):
				Globals.players[player] = !Globals.players[player]
				if Globals.players[player]:
					Globals.numPlayers += 1
				else:
					Globals.numPlayers -= 1
				

		if Globals.players[player]:
			labels[player].text = "Player %d Joined\nPress again to leave" % (player+1)
		else:
			labels[player].text = ""
	
	if Globals.numPlayers > 1:
		press_play.text = "Press directional input to join!\nPress space to play!"
		if Input.is_action_just_pressed("dash_p2"):
			get_tree().change_scene_to_file("res://scenes/catfight.tscn")
	else:
		press_play.text = "Press directional input to join!"
