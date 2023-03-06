extends Control

@onready var _counter: Label = $Control/Counter


func _process(_delta: float) -> void:
	var fps: String = str(Engine.get_frames_per_second())
	_counter.set_text("FPS " + fps)
