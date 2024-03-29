<?php

defined('_JEXEC') or die;
$canDo = OrderHelper::getActions();

include_once(JPATH_ROOT.'/Utils.php');
$mp = new Utils;
$orderStatus = array("1"=>"待支付","2"=>"已付定金","3"=>"待评价","5"=>"已付全款","6"=>"已传图","7"=>"待退尾款","8"=>"待退定金","9"=>"已退款","4"=>"已结束");

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

				<th width="10%">
					<?php echo JText::_('下单者ID'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('下单者昵称'); ?>
				</th>

				<th width="10%">
					<select name="filter_level" class="inputbox" onchange="this.form.submit()">
						<option value=""><?php echo JText::_('全部状态');?></option>
						<?php echo JHtml::_('select.options', $this->f_levels, 'value','text', $this->state->get('filter.level'));?>
					</select>
					
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
				<td class="center">
					<?php if($canDo->get('core.edit')){ ?>
					<a href="<?php echo JRoute::_('index.php?option=com_order&task=order.edit&id='.(int) $item->id); ?>">
					<?php echo $this->escape($item->orderid); ?></a>
					<?php }else{ ?><?php echo $this->escape($item->orderid); ?></a>
					<?php } ?>
				</td>
				<td class="center"><?php echo $this->escape($item->userid); ?></td>
				<td class="center"><?php echo $mp->getStrFromByte($item->uname); ?></td>

				<td class="center">
					<?php
					if($item->status == 1){
						echo JText::_("待支付");
					}
					elseif($item->status == 2){
						echo JText::_("已付定金");
					}
					elseif($item->status == 3){
						echo JText::_("待评价");
					}
					elseif($item->status == 5){
						echo JText::_("已付全款");
					}
					elseif($item->status == 6){
						echo JText::_("已上传图片");
					}
					elseif($item->status == 7){
						echo JText::_("待退尾款");
					}
					elseif($item->status == 8){
						echo JText::_("待退定金");
					}
					elseif($item->status == 9){
						echo JText::_("已退款");
					}
					else{
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
</form