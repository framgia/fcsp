$(document).ready(function() {
  checkbox = $('#auto_sync_checkbox');
  if(checkbox.val() == 'false'){
    checkbox.attr('checked', false);
  }
  else{
     checkbox.attr('checked', true);
  }

  $('#auto_sync').on('change.bootstrapSwitch', function(e) {
    $.ajax({
        method: 'POST',
        url: '/autosync',
        data: {
          'auto_sync_value': e.target.checked
        },
        dataType: 'json',
        success: function(data){
        }
    });
 });
});
