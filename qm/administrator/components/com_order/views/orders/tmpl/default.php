<?php

defined('_JEXEC') or die;
$canDo = OrderHelper::getActions();

include_once(JPATH_ROOT.'/Utils.php');
$mp = new Utils;

?>
<form action="<?php echo JRoute::_('index.php?option=com_order&view=orders'); ?>" method="post" name="adminForm" id="adminForm">
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
					<?php echo JText::_('订单号'); ?>
				</th>

				<th width="20%">
					<?php echo JText::_('下单者ID'); ?>
				</th>

				<th width="20%">
					<?php echo JText::_('下单者昵称'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('订单状态'); ?>
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
				<td class="center"><?php echo $this->escape($item->id); ?></td>
				<td class="center"><?php echo $this->escape($item->orderid); ?></td>
				<td class="center"><?php echo $this->escape($item->userid); ?></td>
				<td class="center"><?php echo $mp->getStrFromByte($item->uname); ?></td>

				<td class="center">
					<?php
					if($item->status == 1){
						echo JText::_("待支付");
					}elseif($item->status == 2){
						echo JText::_("已支付");
					}elseif($item->status == 3){
						echo JText::_("待评价");
					}else{
						echo JText::_("已结束");
					}
					?>
				</td>

				<td class="center"><?php echo date("Y-m-d h:i:s",$this->escape($item->intime)); ?></td>
				
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
