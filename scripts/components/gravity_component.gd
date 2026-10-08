class_name GravityComponent extends Node


@export_category("Dependencies")
@export var body_to_affect: CharacterBody3D


@export_category("Gravity Component Vars")
@export var gravity_scale: float = 1.0


var _gravity_magnitude: float = 0.0


func _ready() -> void:
	self._gravity_magnitude = ProjectSettings.get_setting("physics/3d/default_gravity")


func add_gravity() -> void:
	if not self.body_to_affect.is_on_floor():
		self.body_to_affect.velocity.y -= self.gravity_scale * self._gravity_magnitude * self.get_physics_process_delta_time()
