<?php

defined('_JEXEC') or die;

?>
<script language="javascript" type="text/javascript" src="/qm/administrator/components/com_hospital/views/hospital/tmpl/jquery-1.3.2.min.js"></script>
<script type="text/JavaScript">
	window.onload = function(){
		var pid = document.getElementById("jform_pid").value;
		setCity(pid);
		document.getElementById("jform_pid").onchange = getCity;
	}

	function setCity(pid){
		$.ajax({
			url: "index.php?option=com_hospital&task=hospital.getCity&pid="+pid,
			type: "GET", 
			dateType: "json",
         	success: function(data){    
            	var citys = document.getElementById("jform_cid");
		        jQuery("option",citys).remove();

		        var t_list = eval(data);
		        for(var i = 0; i < t_list.length; i++){
		        	var c_obj = t_list[i];
		        	var varItem = new Option(c_obj.name, c_obj.id); 
					citys.options.add(varItem); 
		        }
         	}
     	});
	}

	function getCity(){
		var pid = document.getElementById("jform_pid").value;
		setCity(pid);
	}
</script>

<form action="<?php echo JRoute::_('index.php?option=com_hospital&layout=edit&id='.(int)$this->item->id); ?>" 
	method="post" name="adminForm" id="adminForm" class="form-validate">

	<div class="width-100">
		<fieldset class="adminform">
			<?php foreach($this->form->getFieldset('myfields') as $field) : ?>

			<div class="control-group">
				<div class="control-label"><?php echo $field->label; ?></div>
				<div class="controls"><?php echo $field->input; ?></div>
			</div>

			<?php endforeach; ?>

			<input type="hidden" name="task" value="" />
			<?php echo JHtml::_('form.token'); ?>
		</fieldset>
	</div>
</form>

