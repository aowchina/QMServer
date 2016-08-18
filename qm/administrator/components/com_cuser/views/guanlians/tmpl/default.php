<?php
defined('_JEXEC') or die;
$canDo = CuserHelper::getActions();

?>
<form action="<?php echo JRoute::_('index.php?option=com_cuser&view=guanlians'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>
				<th width="20%">
					<?php echo JText::_('用户号'); ?>
				</th>

				<th width="15%">
					<?php echo JText::_('第三方类型'); ?>
				</th>

				<th>
					<?php echo JText::_('第三方ID'); ?>
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
					<?php echo $this->escape($item->userid); ?>
				</td>
				<td class="center">
					<?php 
					switch($item->type){
						case 1:
							echo "微信";
							break;
						case 2:
							echo "新浪微博";
							break;
						case 3:
							echo "QQ";
							break;
					} 
					?>
				</td>
				<td class="center">
					<?php echo $this->escape($item->openid); ?></a>
				</td>
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
