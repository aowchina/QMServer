<?php
defined('_JEXEC') or die;
$canDo = ProjectHelper::getActions();

?>
<form action="<?php echo JRoute::_('index.php?option=com_project&view=projects'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist" id="ruleList">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>
				<th width="10%">
					<?php echo JText::_('名称'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('所属类别'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('记录时间'); ?>
				</th>
				<th width="5%">
					<?php echo JText::_('ID'); ?>
				</th>
			</tr>
		</thead>

		<tfoot>
			<tr>
				<td colspan="15">
					<?php echo $this->pagination->getListFooter(); ?>
				</td>
			</tr>
		</tfoot>

		<tbody>
		<?php foreach($this->items as $i => $item) : ?>
			<tr class="row<?php echo $i % 2; ?>">
				<td class="center">
					<?php echo JHtml::_('grid.id', $i, $item->id); ?>
				</td>
				<td class="center">
					<?php if($canDo->get('core.edit')){ ?>
					<a href="<?php echo JRoute::_('index.php?option=com_project&task=project.edit&id='.(int) $item->id); ?>">
					<?php echo $this->escape($item->name); ?></a>
					<?php }else{ ?><?php echo $this->escape($item->name); ?></a>
					<?php } ?>
				</td>
				<td class="center"><?php echo $this->escape($item->ptname); ?></td>
				<td class="center"><?php echo date("Y-m-d H:i:s", $this->escape($item->intime)); ?></td>
				<td class="center"><?php echo $this->escape($item->id); ?></td>
			</tr>
		<?php endforeach; ?>
		</tbody>
	</table>

	<?php echo $this->loadTemplate('batch'); ?>

	<div>
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="boxchecked" value="0" />
		<?php echo JHtml::_('form.token'); ?>
	</div>
</form>
