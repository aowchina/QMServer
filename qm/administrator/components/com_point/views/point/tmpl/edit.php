<?php

defined('_JEXEC') or die;
?>
<form action="<?php echo JRoute::_('index.php?option=com_point&layout=edit&id='.(int)$this->item->id); ?>" 
	method="post" name="adminForm" id="adminForm" class="form-validate">

	<div class="width-100">
		<fieldset class="adminform">
			<?php foreach($this->form->getFieldset('myfields') as $field) : ?>

			<div class="control-group">
				<div class="control-label"><?php echo $field->label; ?></div>
				<div class="controls"><?php echo $field->input; ?></div>
			</div>

			<?php endforeach; ?>

			<input type="hidden" name="task" value="" />
			<?php echo JHtml::_('form.token'); ?>
		</fieldset>
	</div>
</form>

