extends Label

@onready var game_timer: Timer = $"../../GameTimer"

func _ready():
	if Globals.mode == 0:
		game_timer.start()

func _process(delta: float) -> void:
	text = str(game_timer.time_left) if Globals.mode == 0 else str("")
