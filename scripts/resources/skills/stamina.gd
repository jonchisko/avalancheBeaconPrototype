class_name Stamina extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_stamina_maxed()


func upgrade() -> void:
	self.player_stats.set_stamina_by_percent(self.value)
