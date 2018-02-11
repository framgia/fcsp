$(document).ready(function(){
  $('body').on('click', '.edit-form .cancel', function(){
    $(this).closest('.edit-form').find('#skill_id').val('');
    $(this).closest('.edit-form').toggle('slow');
    $(this).closest('.list-group-item').find('.show-form').show();
  });

  $('body').on('click', '.create-form .save', function(e){
    e.preventDefault();
    var form, url, name, years, user_id, data, skill_type, description;
    form = $(this).closest('.new_skill');
    url = form.attr('action');
    name = form.find('#skill_name').val();
    years = form.find('#skill_skill_users_attributes__years').val();
    skill_type = form.find('#skill_skill_type').val();
    description = form.find('#skill_skill_users_attributes__description').val();
    data = {skill: {name: name, skill_type: skill_type,
      skill_users_attributes: [{years: years, description: description}]}};

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      data: data,
      success: function(result){
        if(result.content.status == "success"){
          form.closest('.col_full').find('.current-skills').append(result.content.html);
          form.find('.input-field').val('');
          $.growl.notice({message: I18n.t('setting.notice.update_success')});
        } else {
          $.growl.error({message: I18n.t('setting.notice.update_error')});
        }
      }
    });
  });

  $('body').on('click', '.edit-form .update', function(e){
    e.preventDefault();
    var form, url, years, form_id, data;

    form = $(this).closest('.edit_skill_user');
    url = form.attr('action');
    years = form.find('#years').val();
    form_id = form.attr('data-id');
    name = form.find('#name').val();
    description = form.find('#skill_user_description').val();
    data = {skill_users: {name: name, skill_users_attributes: {id: form_id, years: years, description: description}}};

    $.ajax({
      url: url,
      type: 'PATCH',
      dataType: 'json',
      data: data,
      success: function(result){
        if(result.status == "success"){
          form.closest('.current-skills').html(result.html);
          $.growl.notice({message: I18n.t('setting.notice.update_success')});
        } else {
          $.growl.error({message: I18n.t('setting.notice.update_error')});
        }
      }
    });
  });

  $('body').on('click', '.edit-form .delete-skill', function(e){
    e.preventDefault();

    var button_delete, url, button_delete_id, data;

    button_delete = $(this);
    url = button_delete.attr('href');
    button_delete_id = button_delete.attr('id');
    data = {id: button_delete_id};

    $.ajax({
      url: url,
      type: 'DELETE',
      dataType: 'json',
      data: data,
      success: function(result){
        if(result.status == "success"){
          button_delete.closest('.current-skills').html(result.html);
          $.growl.notice({message: I18n.t('setting.notice.delete_success')});
        } else {
          $.growl.error({message: I18n.t('setting.notice.delete_error')});
        }
      }
    });
  });

  $('body').on('mouseenter', '.current-skills .list-group-item', function(){
    $(this).find('.button-edit').show();
  });

  $('body').on('mouseleave', '.current-skills .list-group-item', function(){
    $(this).find('.button-edit').hide();
  });

  $('body').on('click', '.current-skills .show-form', function(){
    var current_skill, edit_value;
    current_skill = $(this).closest('.current-skills');
    edit_value = current_skill.find('.edit_skill_user');
    for (var i = 0; i < edit_value.length; i++) {
      edit_value[i].reset();
    }
    current_skill.find('.edit-form').hide();
    current_skill.find('.show-form').show();
    $(this).hide();
    $(this).next('.edit-form').show();
  });
});
