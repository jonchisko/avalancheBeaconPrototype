class_name WalkStamina extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_walk_stamina_cost_maxed()


func upgrade() -> void:
	self.player_stats.set_walk_stamina_cost_by_percent(self.value)
