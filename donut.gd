extends Node3D

@onready var _area: Area3D = $Area3D


func _ready() -> void:
	_area.area_entered.connect(_on_area_entered)


func _on_area_entered(_collided_area) -> void:
	queue_free()
