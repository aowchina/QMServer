<?php
defined('_JEXEC') or die;

$canDo = CuserHelper::getActions();

include_once(JPATH_ROOT.'/Utils.php');
$mp = new Utils;

?>
<form action="<?php echo JRoute::_('index.php?option=com_cuser&view=cusers'); ?>" method="post" name="adminForm" id="adminForm">
	<table class="adminlist" id="ruleList">
		<thead>
			<tr>
				<th width="1%">
					<input type="checkbox" name="checkall-toggle" value="" title="<?php echo JText::_('JGLOBAL_CHECK_ALL'); ?>" onclick="Joomla.checkAll(this)"/>
				</th>
				<th width="1%">
					<?php echo JText::_('ID'); ?>
				</th>

				<th width="1%">
					<?php echo JText::_('用户号'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('昵称'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('手机号'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('出生日期'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('性别'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('状态'); ?>
				</th>

				<th width="10%">
					<?php echo JText::_('注册日期'); ?>
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
				<td class="center"><?php echo $this->escape($item->userid); ?></td>
				<td class="center">
					<?php if($canDo->get('core.edit')){ ?>
					<a href="<?php echo JRoute::_('index.php?option=com_cuser&task=cuser.edit&id='.(int) $item->id); ?>">
						<?php echo $mp->getStrFromByte($this->escape($item->username)); ?>
					</a>
					<?php }else{ echo $mp->getStrFromByte($this->escape($item->username)); } ?>
				</td>
				<td class="center">
					<?php if($item->tel){ ?>
					<?php echo $this->escape($item->tel); ?></a>
					<?php }else{ ?>
					<?php echo '暂未设定'; ?>
					<?php } ?>
				</td>
				<td class="center">
					<?php if($item->birthday){ ?>
					<?php echo $this->escape($item->birthday); ?></a>
					<?php }else{ ?>
					<?php echo '暂未设定'; ?>
					<?php } ?>
				</td>
				<td class="center">
					<?php
						switch($item->sex){
							case 0:
								echo "保密";
								break;
							case 1:
								echo "女";
								break;
							case 2:
								echo "男";
								break;
						}
					?>
				</td>
				<td class="center">
					<?php
						switch($item->block){
							case 0:
								echo "正常";
								break;
							case 1:
								echo "拉黑";
								break;
							default:
								echo "正常";
								break;
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
