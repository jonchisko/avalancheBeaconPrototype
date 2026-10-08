class_name ProbeSpeed extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_tool_speed_maxed(GlobalEnums.ToolType.PROBE)


func upgrade() -> void:
	self.player_stats.set_tool_speed_by_percent(self.value, GlobalEnums.ToolType.PROBE)
