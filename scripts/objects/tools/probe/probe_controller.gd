class_name ProbeController extends Node


const ANIMATION_TIME: int = 900 # [ms]


signal probe_used(cool_down: float)
signal target_hit(at_depth: float)


var _stamina_component: StaminaComponent
var _stamina_cost: float
var _cooldown: int # in miliseconds

var _previous_time: int


func init_controler(stamina_component: StaminaComponent, stats: PlayerStats) -> void:
	self._stamina_component = stamina_component
	self._stamina_cost = stats.get_tool_stamina_cost(GlobalEnums.ToolType.PROBE)
	self._cooldown = int(1.0 / stats.get_tool_speed(GlobalEnums.ToolType.PROBE) * 1000.0)

	if self._cooldown < self.ANIMATION_TIME:
		push_error("ProbeController: CD shorter than ANIMATION TIME")


func use_tool() -> void:
	if self._previous_time + self._cooldown >= Time.get_ticks_msec():
		return

	if !self._stamina_component.reduce_stamina(self._stamina_cost):
		return

	self._previous_time = Time.get_ticks_msec()
	self.probe_used.emit(self._cooldown)


func _on_probe_detector_area_entered(area: Area3D) -> void:
	var target = area.get_parent()
	if target is Target:
		self.target_hit.emit(2.0) # TODO change to actual depth
