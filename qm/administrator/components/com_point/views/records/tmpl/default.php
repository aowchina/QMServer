<?php
defined('_JEXEC') or die;

include_once(JPATH_ROOT.'/Utils.php');
$mp = new Utils;
?>
<form action="<?php echo JRoute::_('index.php?option=com_point&view=records'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>
				<th width="10%">
					<?php echo JText::_('用户序号'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('用户昵称'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('积分类型'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('订单号'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('订单金额'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('获取积分'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('状态'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('获取时间'); ?>
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
				<td class="center"><?php echo $this->escape($item->userid); ?></td>
				<td class="center"><?php echo $mp->getStrFromByte($item->uname); ?></td>
				<td class="center">
					<?php
					if($item->type == 1){
						echo "签到";
					}else{
						echo "消费";
					}
					?>
				</td>

				<td class="center">
					<?php
					if($item->type == 1){
						echo "无";
					}else{
						echo $this->escape($item->order_num);
					}
					?>
				</td>

				<td class="center">
					<?php
					if($item->type == 1){
						echo "0";
					}else{
						echo $this->escape($item->order_fee);
					}
					?>
				</td>
				<td class="center"><?php echo $this->escape($item->point); ?></td>
				<td class="center">
					<?php
					if($item->status == 1){
						echo "正常";
					}else{
						echo "扣除";
					}
					?>
				</td>
				<td class="center"><?php echo date("Y-m-d H:i:s", $this->escape($item->ctime)); ?></td>
				<td class="center"><?php echo date("Y-m-d H:i:s", $this->escape($item->intime)); ?></td>
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
