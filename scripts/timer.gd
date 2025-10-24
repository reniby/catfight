extends Label

@onready var game_timer: Timer = $"../../GameTimer"

func _ready():
	if Globals.mode == 0:
		game_timer.start()

func _process(_delta: float) -> void:
	text = "%.2f" % game_timer.time_left if Globals.mode == 0 else str("")
