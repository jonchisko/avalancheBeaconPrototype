extends Control


@export var skill_manager: SkillManager
@export var player_stats: PlayerStats

#@onready var chosen_skills_ui:
#@onready var player_stats_ui:

@onready var _skill_container_ui: VBoxContainer = %PickedSkillsContainer
@onready var _reroll_label_ui: Label = %ReRollLabel
@onready var _max_levels_label_ui: Label = %MaxLevels
@onready var _levels_label_ui: Label = %Levels

@onready var _stats_walk_base_ui: Label = %WalkSpeedBaseLabel
@onready var _stats_walk_ui: Label = %WalkSpeedLabel
@onready var _stats_run_base_ui: Label = %RunSpeedBaseLabel
@onready var _stats_run_ui: Label = %RunSpeedLabel
@onready var _stats_jump_base_ui: Label = %JumpStrengthBaseLabel
@onready var _stats_jump_ui: Label = %JumpStrengthLabel
@onready var _stats_shovel_base_ui: Label = %ShovelSpeedBaseLabel
@onready var _stats_shovel_ui: Label = %ShovelSpeedLabel


var _skill_element_test_ui: PackedScene = preload("res://tests/scenes/skill_shop/skill_element_test.tscn")


var _rerolls: int = 0
var _max_levels: int = 0
var _levels_done: int = 0
var _skills: Dictionary


func _ready() -> void:
	self.player_stats.init_stats()

	self._rerolls = self.skill_manager.rerolls
	self._max_levels = self.skill_manager.number_of_levels

	self._reroll_label_ui.text = str(self._rerolls)
	self._max_levels_label_ui.text = str(self._max_levels)

	self.skill_manager.chosen_skill.connect(self._on_skill_chosen)

	self._stats_walk_base_ui.text = str(self.player_stats.get_walk_speed())
	self._stats_run_base_ui.text = str(self.player_stats.get_run_speed())
	self._stats_jump_base_ui.text = str(self.player_stats.get_jump_strength())
	self._stats_shovel_base_ui.text = str(self.player_stats.get_tool_speed(GlobalEnums.ToolType.SHOVEL))

	self._stats_walk_ui.text = str(self.player_stats.get_walk_speed())
	self._stats_run_ui.text = str(self.player_stats.get_run_speed())
	self._stats_jump_ui.text = str(self.player_stats.get_jump_strength())
	self._stats_shovel_ui.text = str(self.player_stats.get_tool_speed(GlobalEnums.ToolType.SHOVEL))



func _on_skill_chosen(skill: Skill) -> void:
	if self._skills.has(skill.skill_name + str(skill.rarity)):
		self._skills[skill.skill_name + str(skill.rarity)] += 1
	else:
		self._skills[skill.skill_name + str(skill.rarity)] = 1

	for child in self._skill_container_ui.get_children():
		child.queue_free()

	for skill_key in self._skills.keys():
		var instantiated: SkillElementTest = self._skill_element_test_ui.instantiate()
		self._skill_container_ui.add_child(instantiated)
		instantiated.init_data(skill_key, self._skills[skill_key])


func _on_re_roll_button_pressed() -> void:
	if self._rerolls <= 0:
		return
	self.skill_manager.reroll_skills()
	self._rerolls -= 1
	self._reroll_label_ui.text = str(self._rerolls)


func _on_open_shop_button_pressed() -> void:
	self.skill_manager.show_skills_shop()


func _on_level_won_button_pressed() -> void:
	# To reset as they would be between the levels
	self.player_stats.init_stats()
	self.skill_manager.apply_skill_upgrades()

	print(self.skill_manager._player_chosen_skills)
	print("Stamina: ", self.player_stats.stamina_stats.stamina)
	print("Max stamina: ", self.player_stats.stamina_stats.max_stamina)
	print("Stamina regen: ", self.player_stats.stamina_stats.stamina_regen_speed)

	if self._levels_done == self._max_levels:
		return

	GlobalSignals.level_successfully_completed.emit()
	self._levels_done += 1
	self._levels_label_ui.text = str(self._levels_done)

	self._stats_walk_ui.text = str(self.player_stats.get_walk_speed())
	self._stats_run_ui.text = str(self.player_stats.get_run_speed())
	self._stats_jump_ui.text = str(self.player_stats.get_jump_strength())
	self._stats_shovel_ui.text = str(self.player_stats.get_tool_speed(GlobalEnums.ToolType.SHOVEL))


# Does not do anything -> next level is only present when we cannot show any skill. In the real game, for testing it`s useless.
func _on_next_level_button_pressed() -> void:
	pass # Replace with function body.
