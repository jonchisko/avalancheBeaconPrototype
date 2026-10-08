class_name RunStamina extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_run_stamina_cost_maxed()


func upgrade() -> void:
	self.player_stats.set_run_stamina_cost_by_percent(self.value)
