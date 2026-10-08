class_name MovementComponent extends Node


@export_category("Dependencies")
@export var input_component: InputComponent
@export var stamina_component: StaminaComponent
@export var body_to_move: CharacterBody3D


@export_category("Movement Component Vars")
## How floaty does the movement feel
@export var movement_speed_floatness_weight = 10.0
## How precise must the player be with jumping after leaving the ground. Higher number means less precise.
@export var jump_delay: float = 0.1
## How much is the player able to move in the air
@export var air_movement_weight: float = 0.3
## Under which speed is player considered idling?
@export var idle_speed: float = 1.0


@onready var _timer: Timer = $Timer


var _player_stats: PlayerStats

var _walk_speed: float
var _run_speed: float
var _jump_strength: float

var _walk_stamina_cost: float
var _run_stamina_cost: float
var _jump_stamina_cost: float

var _air_speed: float

var _timer_timedout: bool = false
var _is_jump_state: bool = false


func init_component(player_stats: PlayerStats) -> void:
	self._player_stats = player_stats
	self._update_current_values()
	self._timer.wait_time = self.jump_delay
	self._timer.timeout.connect(self._on_timeout)
	self._player_stats.stats_updated.connect(self._update_current_values)


func move() -> void:
	var movement_speed: float = 0.0

	var direction: Vector3 = self.input_component.get_movement_vector()
	direction = self.body_to_move.global_basis * direction.normalized()

	var delta_time: float = self.get_physics_process_delta_time()

	if self._is_on_floor():
		if self.input_component.is_jumping() && !self._is_jump_state && self.stamina_component.reduce_stamina(delta_time * self._jump_stamina_cost):
			self._is_jump_state = true
			self.body_to_move.velocity.y += self._jump_strength

		if self.input_component.is_running() && self.stamina_component.reduce_stamina(delta_time * self._run_stamina_cost):
			movement_speed = self._run_speed
		elif direction.length_squared() > 0 && self.stamina_component.reduce_stamina(delta_time * self._walk_stamina_cost):
			movement_speed = self._walk_speed
		else:
			movement_speed = 0.0
		self._air_speed = movement_speed
	else:
		self._air_speed = lerpf(self._air_speed, 0.0, self.air_movement_weight * delta_time)
		movement_speed = self._air_speed

	self.body_to_move.velocity.x = lerpf(self.body_to_move.velocity.x, direction.x * movement_speed, delta_time)
	self.body_to_move.velocity.z = lerpf(self.body_to_move.velocity.z, direction.z * movement_speed, delta_time)

	self.body_to_move.move_and_slide()


func is_idle() -> bool:
	return self.body_to_move.velocity.length_squared() < idle_speed


func _is_on_floor() -> bool:
	var on_floor: bool = self.body_to_move.is_on_floor()

	if on_floor:
		self._timer_timedout = false
		self._is_jump_state = false
		return on_floor
	else:
		if !self._timer_timedout && self._timer.is_stopped():
			self._timer.start()
			return true
		elif self._timer.time_left > 0.0:
			return true
		else:
			return false


func _update_current_values() -> void:
	self._walk_speed = self._player_stats.get_walk_speed()
	self._run_speed = self._player_stats.get_run_speed()
	self._jump_strength = self._player_stats.get_jump_strength()

	self._walk_stamina_cost = self._player_stats.get_walk_stamina_cost()
	self._run_stamina_cost = self._player_stats.get_run_stamina_cost()
	self._jump_stamina_cost = self._player_stats.get_jump_stamina_cost()


func _on_timeout() -> void:
	self._timer_timedout = true
