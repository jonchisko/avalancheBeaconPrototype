class_name ProbeStamina extends Skill


func is_maxed_out() -> bool:
	return self.player_stats.is_tool_stamina_cost_maxed(GlobalEnums.ToolType.PROBE)


func upgrade() -> void:
	self.player_stats.set_tool_stamina_cost_by_percent(self.value, GlobalEnums.ToolType.PROBE)
