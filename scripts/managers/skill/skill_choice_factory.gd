class_name SkillChoiceFactory extends RefCounted


var _all_skills: Array[Skill]
var _number_of_skill_choices: int
var _max_skill_choice_size: int


func _init(skills: Array[Skill], number_of_skill_choices: int, max_skill_choice_size: int) -> void:
	self._all_skills = skills
	self._number_of_skill_choices = number_of_skill_choices
	self._max_skill_choice_size = max_skill_choice_size


func compute_all_skill_choices() -> Array[SkillChoice]:
	var skill_choices: Array[SkillChoice] = []
	for _i in range(self._number_of_skill_choices):
		skill_choices.push_back(self._compute_skill_choice())

	return skill_choices


func recompute_skill_choice() -> SkillChoice:
	return self._compute_skill_choice()


func _pick_a_skill(non_maxed_out_skills: Array[Skill], total_weight_sum: float) -> Skill:
	var random_value: float = randf() * total_weight_sum
	var upper_threshold: float = 0.0

	for skill in non_maxed_out_skills:
		upper_threshold += GlobalEnums.rarity_to_probability(skill.rarity)
		if upper_threshold >= random_value:
			return skill
	# Should never come to this, last skill in the loop will set threshold to total_weight_sum and random_value is never larger than it.
	return non_maxed_out_skills[non_maxed_out_skills.size() - 1]


func _compute_skill_choice() -> SkillChoice:
	var non_maxed_out_skills: Array[Skill] = self._all_skills\
		.filter(func(skill): return !skill.is_maxed_out())

	var total_weight_sum: float = non_maxed_out_skills\
		.map(func(skill): return GlobalEnums.rarity_to_probability(skill.rarity))\
		.reduce(func(acc, num): return acc + num, 0)

	var count_of_skills: int = self._max_skill_choice_size
	if non_maxed_out_skills.size() < count_of_skills:
		count_of_skills = non_maxed_out_skills.size()

	var skills_for_one_choice: Array[Skill] = []
	for _j in range(count_of_skills):
		skills_for_one_choice.push_back(self._pick_a_skill(non_maxed_out_skills, total_weight_sum))

	return SkillChoice.new(skills_for_one_choice, count_of_skills)
