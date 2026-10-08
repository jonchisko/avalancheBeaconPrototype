class_name JumpStamina extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_jump_stamina_cost_maxed()


func upgrade() -> void:
	self.player_stats.set_jump_stamina_cost_by_percent(self.value)
