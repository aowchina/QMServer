<?php
defined('_JEXEC') or die;

$canDo = PointHelper::getActions();

?>
<form action="<?php echo JRoute::_('index.php?option=com_point&view=points'); ?>" method="post" name="adminForm" id="adminForm">
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
					<?php echo JText::_('签到积分换算率'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('消费积分换算率'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('1元需消耗积分'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('记录时间'); ?>
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
					<a href="<?php echo JRoute::_('index.php?option=com_point&task=point.edit&id='.(int) $item->id); ?>">
					<?php echo $this->escape($item->id); ?></a>
					<?php }else{ ?><?php echo $this->escape($item->name); ?></a>
					<?php } ?>
				</td>
				<td class="center"><?php echo $this->escape($item->qd_point); ?></td>
				<td class="center"><?php echo $this->escape($item->xf_point); ?></td>
				<td class="center">
					<?php
					$xh_point = $this->escape($item->xh_point);
					if($xh_point == 0){
						echo '暂未设置';
					}else{
						echo $xh_point;
					}
					?>
				</td>
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
