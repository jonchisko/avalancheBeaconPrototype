class_name SkillManager extends Node


signal chosen_skill(skill: Skill)
signal shop_opened
signal shop_closed


@export_category("Dependencies")
@export var skill_shop_ui: SkillShopUi

@export_category("Skill Manager Vars")
## All skills that the player can obtain.
@export var all_possible_skills: Array[Skill]
## Temporary, how many levels are there in a single session.
@export var number_of_levels: int
## Number of rerolls - we have to generate 'number_of_levels + rerolls' of different choices for the player.
@export var rerolls: int
## Number of skills to be chosen from
@export var max_number_of_skills_to_choose: int


var _current_rerolls: int
var _skill_choices: Array[SkillChoice]
var _skill_choice_factory: SkillChoiceFactory

var _current_skill_choice: SkillChoice
var _player_chosen_skills: Array[Skill]


func _ready() -> void:
	GlobalSignals.level_successfully_completed.connect(self._on_level_successfully_completed)
	self.skill_shop_ui.skill_selected.connect(self._on_skill_chosen_from_shop)

	self.skill_shop_ui.visible = false

	self._current_rerolls = self.rerolls
	self._skill_choice_factory = SkillChoiceFactory.new(self.all_possible_skills, self.number_of_levels + self.rerolls, self.max_number_of_skills_to_choose)
	self._skill_choices = self._skill_choice_factory.compute_all_skill_choices()

	self._current_skill_choice = null
	self._player_chosen_skills = []


func show_skills_shop() -> void:
	self.skill_shop_ui.visible = true
	self.shop_opened.emit()


func apply_skill_upgrades() -> void:
	for skill in self._player_chosen_skills:
		skill.upgrade()


func reroll_skills() -> void:
	if self._current_rerolls <= 0:
		return
	self._set_current_skill_choice()
	self._current_rerolls -= 1

	self.skill_shop_ui.clear_skill_choice()
	self.skill_shop_ui.set_skill_choice(self._current_skill_choice)


func _on_skill_chosen_from_shop(skill: Skill) -> void:
	self.skill_shop_ui.visible = false
	self._player_chosen_skills.push_back(skill)
	self.chosen_skill.emit(skill)
	self.shop_closed.emit()


func _on_level_successfully_completed() -> void:
	self._set_current_skill_choice()
	self.skill_shop_ui.clear_skill_choice()
	self.skill_shop_ui.set_skill_choice(self._current_skill_choice)


func _set_current_skill_choice() -> void:
	self._current_skill_choice = self._skill_choices.pop_back()
	if self._current_skill_choice.has_max_upgraded_skill():
		# We do not want to show a skill choice collection with max upgraded skill
		# UNLESS: such a combination is not possible anymore -> then show as many skills if possible
		self._current_skill_choice = self._skill_choice_factory.recompute_skill_choice()
