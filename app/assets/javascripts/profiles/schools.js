$(document).ready(function(){

  $('#new_school').on('click', 'input[name="commit"].save', function(e){
    e.preventDefault();

    var form, url, data, name, address, degree, graduation;
    form = $(this).closest('form#new_school');
    url = form.attr('action');
    name = form.find('#school_name').val();
    address = form.find('#school_user_schools_attributes__address').val();
    major = form.find('#school_user_schools_attributes__major').val();
    degree = form.find('#school_user_schools_attributes__degree').val();
    graduation = form.find('#school_user_schools_attributes__graduation').val();
    description = form.find('#school_user_schools_attributes__description').val();

    data = {school: {name: name,
      user_schools_attributes: [{address: address, major: major, degree: degree,
        graduation: graduation, description: description}]}};

    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      success: function(result){
        if(result.status == 'success'){
          $('.user-schools').append(result.html);
          $.growl.notice({message: I18n.t('setting.notice.update_success')});
        } else {
          $.growl.error({message: I18n.t('setting.notice.update_error')});
        }
      }
    });
  })
});
