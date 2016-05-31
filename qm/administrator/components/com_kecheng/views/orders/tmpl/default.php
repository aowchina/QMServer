<?php
defined('_JEXEC') or die;
$canDo = KechengHelper::getActions();

include_once(JPATH_ROOT.'/Utils.php');
$mp = new Utils;
?>
<form action="<?php echo JRoute::_('index.php?option=com_kecheng&view=orders'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist" id="ruleList">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>
				<th width="10%">
					<?php echo JText::_('课程名称'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('预订者'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('预订者编号'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('预订者联系电话'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('预订数量'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('订单号'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('下单日期'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('支付状态'); ?>
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
				<td class="center"><?php echo JHtml::_('grid.id', $i, $item->id); ?></td>
				<td class="center"><?php echo $this->escape($item->cname); ?></td>
				<td class="center">
					<?php echo $mp->getStrFromByte($this->escape($item->uname)); ?>
				</td>
				<td class="center"><?php echo $this->escape($item->userid); ?></td>
				<td class="center"><?php echo $this->escape($item->utel); ?></td>
				<td class="center"><?php echo $this->escape($item->amount); ?></td>
				<td class="center"><?php echo $this->escape($item->orderid); ?></td>
				<td class="center"><?php echo date("Y-m-d H:i:s", $this->escape($item->create_time)); ?></td>
				<td class="center">
					<?php
					$status = $this->escape($item->status);
					if($status == 1){
						echo "已支付";
					}else{
						echo "待支付";
					}
					?>
				</td>
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
