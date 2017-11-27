$(document).ready(function(){
  $('body').on('click', '.edit-toggle', function(){
    $(this).closest('.col_full').find('.create-form').toggle('slow');
  });

  $('body').on('click', '.edit-form .cancel', function(){
    $(this).closest('.edit-form').find('#skill_id').val('');
    $(this).closest('.edit-form').toggle('slow');
    $(this).closest('.list-group-item').find('.show-form').show();
  });

  $('body').on('click', '.create-form .save', function(e){
    e.preventDefault();
    var form = $(this).closest('.new_skill');
    url = form.attr('action');
    name = form.find('#skill_name').val();
    years = form.find('#skill_skill_users_attributes__years').val();
    user_id = form.find('#skill_skill_users_attributes__user_id').val();
    var data = {skill: {name: name, skill_users_attributes: [{user_id: user_id, years: years}]}};
    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      data: data,
      success: function(result){
        if(result.status == "success"){
          $('.current-skills').html(result.html);
          form.find('input.short-form').val('');
          $.growl.notice({message: I18n.t('setting.notice.update_success')});
        } else {
          $.growl.notice({message: I18n.t('setting.notice.update_error')});
        }
      }
    });
  });

  $('body').on('click', '.edit-form .update', function(e){
    e.preventDefault();
    var form = $(this).closest('.edit_skill_user');
    url = form.attr('action');
    years = form.find('#years').val();
    id = form.attr('data-id');

    var data = {skill_users: {id: id, years: years}};
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
          $.growl.notice({message: I18n.t('setting.notice.update_error')});
        }
      }
    });
  });

  $('body').on('click', '.edit-form .delete-skill', function(e){
    e.preventDefault();
    button_delete = $(this);
    url = button_delete.attr('href');
    id = button_delete.attr('id');

    var data = {id: id};
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
          $.growl.notice({message: I18n.t('setting.notice.delete_error')});
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
    $(this).closest('.current-skills').find('.edit-form').hide();
    $(this).closest('.current-skills').find('.show-form').show();
    $(this).hide();
    $(this).next('.edit-form').show();
  });
});
