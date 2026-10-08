class_name MovementStats extends Resource


@export_group("Base Stats")
@export var base_walk_speed: float = 1.0
@export var base_walk_stamina_cost: float = 1.0
@export var max_walk_speed: float = 2.0
@export var min_walk_stamina_cost: float = 1.0

@export var base_run_speed: float = 2.0
@export var base_run_stamina_cost: float = 2.0
@export var max_run_speed: float = 4.0
@export var min_run_stamina_cost: float = 1.0

@export var base_jump_strength: float = 2.5
@export var base_jump_stamina_cost: float = 5.0
@export var max_jump_strength: float = 5.0
@export var min_jump_stamina_cost: float = 1.0


var walk_speed: float = self.base_walk_speed
var walk_stamina_cost: float = self.base_walk_stamina_cost

var run_speed: float = self.base_run_speed
var run_stamina_cost: float = self.base_run_stamina_cost

var jump_strength: float = self.base_jump_strength
var jump_stamina_cost: float = self.base_jump_stamina_cost


func init_stats() -> void:
	walk_speed = self.base_walk_speed
	walk_stamina_cost = self.base_walk_stamina_cost

	run_speed = self.base_run_speed
	run_stamina_cost = self.base_run_stamina_cost

	jump_strength = self.base_jump_strength
	jump_stamina_cost = self.base_jump_stamina_cost
