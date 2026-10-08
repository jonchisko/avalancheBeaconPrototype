class_name LookAroundComponent extends Node


@export_category("Dependencies")

@export var camera: Camera3D
@export var body: CharacterBody3D


@export_category("LookAround Component Vars")

@export var max_vertical_range: float = 50.0

@export var vertical_sensitivity: float = 0.1
@export var horizontal_sensitivity: float = 0.1

@export var head_bob_amplitude: float = 0.1
@export var head_bob_speed: float = 0.1

@export var fov_change: float = 0.1


var _original_fov: float = 0.0
var _original_camera_offset: Vector3 = Vector3.ZERO
var _head_bob_x: float = 0.0


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self._original_fov = self.camera.fov
	self._original_camera_offset = self.camera.position
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	var velocity_squared: float = self.body.velocity.length_squared()

	self._head_bob_x += velocity_squared * delta * float(self.body.is_on_floor())
	self.camera.position.y = self._original_camera_offset.y + self.head_bob_amplitude * sin(self._head_bob_x * self.head_bob_speed)
	self.camera.position.x = self._original_camera_offset.x + self.head_bob_amplitude * cos(self._head_bob_x * (self.head_bob_speed / 2.0))

	self.camera.fov = lerpf(self.camera.fov, self._original_fov - min(velocity_squared * self.fov_change, 20.0), delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed() && event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif event.keycode == KEY_I:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			return

	var mouse_motion = event as InputEventMouseMotion

	if mouse_motion == null:
		return

	self.body.rotate_y(-mouse_motion.screen_relative.x * self.horizontal_sensitivity * self.get_physics_process_delta_time())
	self.camera.rotate_x(-mouse_motion.screen_relative.y * self.vertical_sensitivity * self.get_physics_process_delta_time())

	self.camera.rotation_degrees.x = clampf(
		self.camera.rotation_degrees.x,
		-self.max_vertical_range,
		self.max_vertical_range
	)
