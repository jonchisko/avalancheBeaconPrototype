class_name StaminaComponent extends Node


signal stamina_changed(current_stamina: float)


var _player_stats: PlayerStats

var _current_stamina: float
var _max_stamina: float
var _stamina_regen_speed: float


func init_component(player_stats: PlayerStats) -> void:
	self._player_stats = player_stats
	self._update_current_values()
	self._player_stats.stats_updated.connect(self._update_current_values)


## Reduces current stamina by given cost. Returns true if stamina was able to be reduced and false if there was not enough stamina
## to be taken.
func reduce_stamina(cost: float, partial_reduction_allowed: bool = false) -> bool:
	if !partial_reduction_allowed && self._current_stamina - cost < 0:
		return false

	self._current_stamina = max(self._current_stamina - cost, 0.0)
	self.stamina_changed.emit(self._current_stamina)
	return true


## Increases current stamina by given amount (capped at max stamina).
func increase_stamina(amount: float) -> void:
	self._current_stamina = min(self._current_stamina + amount, self._max_stamina)
	self.stamina_changed.emit(self._current_stamina)


## Increases stamina by regen speed (amount), if less than max stamina
func regenerate_stamina(delta: float) -> void:
	if self._current_stamina < self._max_stamina:
		self._current_stamina = clampf(self._current_stamina + self._stamina_regen_speed * delta, 0.0, self._max_stamina)
		self.stamina_changed.emit(self._current_stamina)


## CHange stamina regen speed by given amount, can go over the set max limit, but cannot be reduced below zero
func change_stamina_regen_speed(amount: float) -> void:
	self._stamina_regen_speed = max(self._stamina_regen_speed + amount, 0.0)


func _update_current_values() -> void:
	self._max_stamina = self._player_stats.get_stamina()
	self._stamina_regen_speed = self._player_stats.get_stamina_regen_speed()
	self._current_stamina = self._max_stamina
	self.stamina_changed.emit(self._current_stamina)
