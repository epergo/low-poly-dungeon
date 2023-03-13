extends Control

@onready var _counter: Label = $Control/Counter


func update_counter(new_donuts_collected: int, max_donuts: int) -> void:
	_counter.set_text(str(new_donuts_collected) + " / " + str(max_donuts))
