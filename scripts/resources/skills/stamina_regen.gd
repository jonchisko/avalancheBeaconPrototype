class_name StaminaRegen extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_stamina_regen_speed_maxed()


func upgrade() -> void:
	self.player_stats.set_stamina_regen_by_percent(self.value)
