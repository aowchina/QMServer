<?php

defined('_JEXEC') or die;

// Create the copy/move options.
$options = array(
	JHtml::_('select.option', 'add', JText::_('添加到关联小组')),
	JHtml::_('select.option', 'del', JText::_('从关联小组中删除'))
);

$list = $this->groups;

?>
<fieldset class="batch">
	<legend><?php echo JText::_('批处理选定项目');?></legend>
	<label id="batch-choose-action-lbl" for="batch-choose-action"><?php echo JText::_('选择关联小组') ?></label>
	<fieldset id="batch-choose-action" class="combo">
		<select name="batch[group_id]" class="inputbox" id="batch-group-id">
			<option value=""><?php echo JText::_('JSELECT') ?></option>
			<?php
				foreach($list as $item){
					echo '<option value="'.$item->id.'">'.$item->name.'</option>';
				}
			?>

		</select>
		<?php echo JHtml::_('select.radiolist', $options, 'batch[group_action]', '', 'value', 'text', 'add') ?>
	</fieldset>

	<button type="submit" onclick="Joomla.submitbutton('project.batch');">
		<?php echo JText::_('JGLOBAL_BATCH_PROCESS'); ?>
	</button>
</fieldset>
