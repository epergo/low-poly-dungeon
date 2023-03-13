extends Node

@onready var _player: Player = $Player
@onready var _donuts_collected_counter: Control = $DonutsCounter

var _donuts_to_collect: int = 0
var _donuts_collected: int = 0


func _ready() -> void:
	_player.donut_collected.connect(_on_donut_collected)

	_donuts_to_collect = $Donuts.get_children().size()
	_donuts_collected_counter.update_counter(_donuts_collected, _donuts_to_collect)


func _on_donut_collected() -> void:
	_donuts_collected += 1
	_donuts_collected_counter.update_counter(_donuts_collected, _donuts_to_collect)
