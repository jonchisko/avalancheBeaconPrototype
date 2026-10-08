class_name StaminaStats extends Resource


@export_group("Base Stats")
@export var base_stamina: float = 20.0
@export var max_stamina: float = 50.0
@export var base_stamina_regen_speed: float = 2.0
@export var max_stamina_regen_speed: float = 4.0


var stamina: float = self.base_stamina
var stamina_regen_speed: float = self.base_stamina_regen_speed


func init_stats() -> void:
	stamina = self.base_stamina
	stamina_regen_speed = self.base_stamina_regen_speed
