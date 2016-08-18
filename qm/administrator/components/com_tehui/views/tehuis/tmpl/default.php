<?php
defined('_JEXEC') or die;

$canDo = TehuiHelper::getActions();

?>
<form action="<?php echo JRoute::_('index.php?option=com_tehui&view=tehuis'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist" id="ruleList">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>
				<th width="1%">
					<?php echo JText::_('ID'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('名称'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('原价'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('特惠价'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('订金'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('所属类别'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('所属医院'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('所属项目'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('上架时间'); ?>
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
				<td class="center"><?php echo $this->escape($item->id); ?></td>
				<td class="center">
					<?php if($canDo->get('core.edit')){ ?>
					<a href="<?php echo JRoute::_('index.php?option=com_tehui&task=tehui.edit&id='.(int) $item->id); ?>">
					<?php echo $this->escape($item->name); ?></a>
					<?php }else{ ?><?php echo $this->escape($item->name); ?></a>
					<?php } ?>
				</td>
				<td class="center"><?php echo $this->escape($item->oldval); ?></td>
				<td class="center"><?php echo $this->escape($item->newval); ?></td>
				<td class="center"><?php echo $this->escape($item->dj); ?></td>
				<td class="center"><?php echo $this->escape($item->tname); ?></td>
				<td class="center"><?php echo $this->escape($item->hname); ?></td>
				<td class="center"><?php echo $this->escape($item->pname); ?></td>
				<td class="center"><?php echo date("Y-m-d H:i", $this->escape($item->intime)); ?></td>
				
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
