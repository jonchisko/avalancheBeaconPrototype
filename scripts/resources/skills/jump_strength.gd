class_name JumpStrength extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_jump_strength_maxed()


func upgrade() -> void:
	self.player_stats.set_jump_strength_by_percent(self.value)
