class_name WalkSpeed extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_walk_speed_maxed()


func upgrade() -> void:
	self.player_stats.set_walk_speed_by_percent(self.value)
