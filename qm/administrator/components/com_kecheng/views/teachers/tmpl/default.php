<?php
defined('_JEXEC') or die;
$canDo = KechengHelper::getActions();

?>
<form action="<?php echo JRoute::_('index.php?option=com_kecheng&view=teachers'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist" id="ruleList">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>

				<th width="10%">
					<?php echo JText::_('姓名'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('任课'); ?>
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
						<a href="<?php echo JRoute::_('index.php?option=com_kecheng&task=teacher.edit&id='.(int) $item->id); ?>">
						<?php echo $this->escape($item->name); ?></a>
					<?php }else{ ?><?php echo $this->escape($item->name); ?></a>
					<?php } ?>
				</td>
				<td class="center"><?php echo $this->escape($item->cname); ?></td>
				<td class="center"><?php echo $this->escape($item->id); ?></td>
			</tr>
		<?php endforeach; ?>
		</tbody>
	</table>
	<div>
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="boxchecked" value="0" />
		<?php echo JHtml::_('form.token'); ?>
	</div>
</form>
