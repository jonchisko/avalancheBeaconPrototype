class_name ToolStats extends Resource


@export_group("Base Stats")
@export var tool_type: GlobalEnums.ToolType
@export var base_speed: float = 0.5
@export var max_speed: float = 2.0

@export var base_stamina_cost: float = 4.0
@export var min_stamina_cost: float = 2.0


var speed: float = self.base_speed
var stamina_cost = self.base_stamina_cost


func init_stats() -> void:
	self.speed = self.base_speed
	self.stamina_cost = self.base_stamina_cost
