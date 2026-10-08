class_name RunSpeed extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_run_speed_maxed()


func upgrade() -> void:
	self.player_stats.set_run_speed_by_percent(self.value)
