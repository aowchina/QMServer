<?php

defined('_JEXEC') or die;

$pid = intval($this->item->pid);
$hid = intval($this->item->hid);

?>
<script language="javascript" type="text/javascript" src="/qm/administrator/components/com_hospital/views/hospital/tmpl/jquery-1.3.2.min.js"></script>
<script type="text/JavaScript">
	window.onload = function(){
		setList(1);
		setList2(2);
	}

	function setList(tag){
		$.ajax({
			url: "index.php?option=com_act&task=act.getList&tag="+tag,
			type: "GET", 
			dateType: "json",
         	success: function(data){
         		var obj = document.getElementById("jform_hid");
         		var obj_id = document.getElementById("ohid").value;
         		
		        var t_list = eval(data);
		        var t_index = -1;
		        for(var i = 0; i < t_list.length; i++){
		        	var c_obj = t_list[i];
		        	var varItem = new Option(c_obj.name, c_obj.id);
		        	if(obj_id == c_obj.id){
		        		t_index = i;
		        	}
					obj.options.add(varItem);
		        }
		        if(t_index >= 0){
		        	obj.options[t_index+1].selected='selected';
		        }
         	}
     	});
	}

	function setList2(tag){
		$.ajax({
			url: "index.php?option=com_act&task=act.getList&tag="+tag,
			type: "GET", 
			dateType: "json",
         	success: function(data){
         		var obj = document.getElementById("jform_pid");
         		var obj_id = document.getElementById("opid").value;
         		
		        var t_list = eval(data);
		        var t_index = -1;
		        for(var i = 0; i < t_list.length; i++){
		        	var c_obj = t_list[i];
		        	var varItem = new Option(c_obj.name, c_obj.id);
		        	if(obj_id == c_obj.id){
		        		t_index = i;
		        	}
					obj.options.add(varItem);
		        }
		        if(t_index >= 0){
		        	obj.options[t_index+1].selected='selected';
		        }
         	}
     	});
	}
</script>

<form action="<?php echo JRoute::_('index.php?option=com_act&layout=edit&id='.(int)$this->item->id); ?>" 
	method="post" name="adminForm" id="adminForm" class="form-validate">

	<div class="width-100">
		<fieldset class="adminform">
			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("id"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("id"); ?></div>
			</div>

			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("name"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("name"); ?></div>
			</div>

			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("fname"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("fname"); ?></div>
			</div>

			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("simg"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("simg"); ?></div>
			</div>

			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("bimg"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("bimg"); ?></div>
			</div>

			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("hid"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("hid"); ?></div>
			</div>

			<div class="control-group">
				<div class="control-label"><?php echo $this->form->getLabel("pid"); ?></div>
				<div class="controls"><?php echo $this->form->getInput("pid"); ?></div>
			</div>
			
			<?php echo '<input type="hidden" id="opid" value="'.$pid.'" />' ?>
			<?php echo '<input type="hidden" id="ohid" value="'.$hid.'" />' ?>
			<input type="hidden" name="task" value="" />
			<?php echo JHtml::_('form.token'); ?>
		</fieldset>
	</div>
</form>

