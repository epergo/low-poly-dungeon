class_name Player
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouseSensibility: float = 100.0
var mouse_relative_x: float = 0.0
var mouse_relative_y: float = 0.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _camera: Camera3D = $Head/Camera3D
@onready var _light: SpotLight3D = $Head/Flashlight
@onready var _collectablesArea: Area3D = $CollectablesArea

signal donut_collected


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_collectablesArea.area_entered.connect(_on_collectables_area_entered)


func _on_collectables_area_entered(_collided_area) -> void:
	emit_signal("donut_collected")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if Input.is_action_just_pressed("flashlight"):
		if _light.light_energy > 0.0:
			_light.light_energy = 0.0
		else:
			_light.light_energy = 1.5

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouseSensibility
		_camera.rotation.x -= event.relative.y / mouseSensibility
		_camera.rotation.x = clamp(_camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		_light.rotation = _camera.rotation
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)
