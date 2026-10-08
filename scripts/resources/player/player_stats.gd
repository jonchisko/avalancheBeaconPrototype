class_name PlayerStats extends Resource


signal stats_updated


@export var movement_stats: MovementStats
@export var stamina_stats: StaminaStats
@export var tool_stats: Dictionary


func init_stats() -> void:
	self.movement_stats.init_stats()
	self.stamina_stats.init_stats()
	for tool_stat in tool_stats.values():
		tool_stat.init_stats()

	self.stats_updated.emit()


func set_walk_speed_by_percent(percentage: float) -> void:
	self.movement_stats.walk_speed = clampf(
		self.movement_stats.walk_speed + self.movement_stats.base_walk_speed * percentage,
		self.movement_stats.base_walk_speed,
		self.movement_stats.max_walk_speed
	)

	self.stats_updated.emit()


func set_walk_speed_by_amount(amount: float) -> void:
	self.movement_stats.walk_speed = clampf(
		self.movement_stats.walk_speed + amount,
		self.movement_stats.base_walk_speed,
		self.movement_stats.max_walk_speed
	)

	self.stats_updated.emit()


func set_run_speed_by_percent(percentage: float) -> void:
	self.movement_stats.run_speed = clampf(
		self.movement_stats.run_speed + self.movement_stats.base_run_speed * percentage,
		self.movement_stats.base_run_speed,
		self.movement_stats.max_run_speed
	)

	self.stats_updated.emit()


func set_run_speed_by_amount(amount: float) -> void:
	self.movement_stats.run_speed = clampf(
		self.movement_stats.run_speed + amount,
		self.movement_stats.base_run_speed,
		self.movement_stats.max_run_speed
	)

	self.stats_updated.emit()


func set_jump_strength_by_percent(percentage: float) -> void:
	self.movement_stats.jump_strength = clampf(
		self.movement_stats.jump_strength + self.movement_stats.base_jump_strength * percentage,
		self.movement_stats.base_jump_strength,
		self.movement_stats.max_jump_strength
	)

	self.stats_updated.emit()


func set_jump_strength_by_amount(amount: float) -> void:
	self.movement_stats.jump_strength = clampf(
		self.movement_stats.jump_strength + amount,
		self.movement_stats.base_jump_strength,
		self.movement_stats.max_jump_strength
	)

	self.stats_updated.emit()


func set_walk_stamina_cost_by_percent(percentage: float) -> void:
	self.movement_stats.walk_stamina_cost = clampf(
		self.movement_stats.walk_stamina_cost - self.movement_stats.base_walk_stamina_cost * percentage,
		self.movement_stats.min_walk_stamina_cost,
		self.movement_stats.base_walk_stamina_cost
	)

	self.stats_updated.emit()


func set_walk_stamina_cost_by_amount(amount: float) -> void:
	self.movement_stats.walk_stamina_cost = clampf(
		self.movement_stats.walk_stamina_cost - amount,
		self.movement_stats.min_walk_stamina_cost,
		self.movement_stats.base_walk_stamina_cost
	)

	self.stats_updated.emit()


func set_run_stamina_cost_by_percent(percentage: float) -> void:
	self.movement_stats.run_stamina_cost = clampf(
		self.movement_stats.run_stamina_cost - self.movement_stats.base_run_stamina_cost * percentage,
		self.movement_stats.min_run_stamina_cost,
		self.movement_stats.base_run_stamina_cost
	)

	self.stats_updated.emit()


func set_run_stamina_cost_by_amount(amount: float) -> void:
	self.movement_stats.run_stamina_cost = clampf(
		self.movement_stats.run_stamina_cost - amount,
		self.movement_stats.min_run_stamina_cost,
		self.movement_stats.base_run_stamina_cost
	)

	self.stats_updated.emit()


func set_jump_stamina_cost_by_percent(percentage: float) -> void:
	self.movement_stats.jump_stamina_cost = clampf(
		self.movement_stats.jump_stamina_cost - self.movement_stats.base_jump_stamina_cost * percentage,
		self.movement_stats.min_jump_stamina_cost,
		self.movement_stats.base_jump_stamina_cost
	)

	self.stats_updated.emit()


func set_jump_stamina_cost_by_amount(amount: float) -> void:
	self.movement_stats.jump_stamina_cost = clampf(
		self.movement_stats.jump_stamina_cost - amount,
		self.movement_stats.min_jump_stamina_cost,
		self.movement_stats.base_jump_stamina_cost
	)

	self.stats_updated.emit(self.movement_stats)


func set_stamina_by_percent(percentage: float) -> void:
	self.stamina_stats.stamina = clampf(
		self.stamina_stats.stamina + self.stamina_stats.base_stamina * percentage,
		self.stamina_stats.base_stamina,
		self.stamina_stats.max_stamina
	)

	self.stats_updated.emit(self.movement_stats)


func set_stamina_by_amount(amount: float) -> void:
	self.stamina_stats.stamina = clampf(
		self.stamina_stats.stamina + amount,
		self.stamina_stats.base_stamina,
		self.stamina_stats.max_stamina
	)

	self.stats_updated.emit()


func set_stamina_regen_by_percent(percentage: float) -> void:
	self.stamina_stats.stamina_regen_speed = clampf(
		self.stamina_stats.stamina_regen_speed + self.stamina_stats.base_stamina_regen_speed * percentage,
		self.stamina_stats.base_stamina_regen_speed,
		self.stamina_stats.max_stamina_regen_speed
	)

	self.stats_updated.emit()


func set_stamina_regen_by_amount(amount: float) -> void:
	self.stamina_stats.stamina_regen_speed = clampf(
		self.stamina_stats.stamina_regen_speed + amount,
		self.stamina_stats.base_stamina_regen_speed,
		self.stamina_stats.max_stamina_regen_speed
	)

	self.stats_updated.emit()


func set_tool_speed_by_percent(percentage: float, tool_type: GlobalEnums.ToolType) -> void:
	var tool = self.tool_stats[tool_type] as ToolStats

	tool.speed = clampf(
		tool.speed + tool.base_speed * percentage,
		tool.base_speed,
		tool.max_speed
	)

	self.stats_updated.emit()


func set_tool_speed_by_amount(amount: float, tool_type: GlobalEnums.ToolType) -> void:
	var tool = self.tool_stats[tool_type] as ToolStats

	tool.speed = clampf(
		tool.speed + amount,
		tool.base_speed,
		tool.max_speed
	)

	self.stats_updated.emit()


func set_tool_stamina_cost_by_percent(percentage: float, tool_type: GlobalEnums.ToolType) -> void:
	var tool = self.tool_stats[tool_type] as ToolStats

	tool.stamina_cost = clampf(
		tool.stamina_cost - tool.base_stamina_cost* percentage,
		tool.min_stamina_cost,
		tool.base_stamina_cost
	)

	self.stats_updated.emit()


func set_tool_stamina_cost_by_amount(amount: float, tool_type: GlobalEnums.ToolType) -> void:
	var tool = self.tool_stats[tool_type] as ToolStats

	tool.stamina_cost = clampf(
		tool.stamina_cost - amount,
		tool.min_stamina_cost,
		tool.base_stamina_cost
	)

	self.stats_updated.emit()


func get_walk_speed() -> float:
	return self.movement_stats.walk_speed


func is_walk_speed_maxed() -> bool:
	return self.movement_stats.walk_speed >= self.movement_stats.max_walk_speed


func get_run_speed() -> float:
	return self.movement_stats.run_speed


func is_run_speed_maxed() -> bool:
	return self.movement_stats.run_speed >= self.movement_stats.max_run_speed


func get_jump_strength() -> float:
	return self.movement_stats.jump_strength


func is_jump_strength_maxed() -> bool:
	return self.movement_stats.jump_strength >= self.movement_stats.max_jump_strength


func get_walk_stamina_cost() -> float:
	return self.movement_stats.walk_stamina_cost


func is_walk_stamina_cost_maxed() -> bool:
	return self.movement_stats.walk_stamina_cost <= self.movement_stats.min_walk_stamina_cost


func get_run_stamina_cost() -> float:
	return self.movement_stats.run_stamina_cost


func is_run_stamina_cost_maxed() -> bool:
	return self.movement_stats.run_stamina_cost <= self.movement_stats.min_run_stamina_cost


func get_jump_stamina_cost() -> float:
	return self.movement_stats.jump_stamina_cost


func is_jump_stamina_cost_maxed() -> bool:
	return self.movement_stats.jump_stamina_cost <= self.movement_stats.min_jump_stamina_cost


func get_stamina() -> float:
	return self.stamina_stats.stamina


func is_stamina_maxed() -> bool:
	return self.stamina_stats.stamina >= self.stamina_stats.max_stamina


func get_stamina_regen_speed() -> float:
	return self.stamina_stats.stamina_regen_speed


func is_stamina_regen_speed_maxed() -> bool:
	return self.stamina_stats.stamina_regen_speed >= self.stamina_stats.max_stamina_regen_speed


func get_tool_speed(tool_type: GlobalEnums.ToolType) -> float:
	var tool = self.tool_stats[tool_type] as ToolStats
	return tool.speed


func is_tool_speed_maxed(tool_type: GlobalEnums.ToolType) -> bool:
	var tool = self.tool_stats[tool_type] as ToolStats
	return tool.speed >= tool.max_speed


func get_tool_stamina_cost(tool_type: GlobalEnums.ToolType) -> float:
	var tool = self.tool_stats[tool_type] as ToolStats
	return tool.stamina_cost


func is_tool_stamina_cost_maxed(tool_type: GlobalEnums.ToolType) -> bool:
	var tool = self.tool_stats[tool_type] as ToolStats
	return tool.stamina_cost <= tool.min_stamina_cost
