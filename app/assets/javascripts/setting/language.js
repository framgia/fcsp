$(document).ready(function(){
  $('body').on('click', '.cancel', function(e){
    $(this).closest('.edit-user-language').toggle('slow');
    $(this).closest('.pull-right').find('.lang-button-delete').remove();
    $(this).closest('.user-language').find('.show-user-language').show();
    e.stopPropagation();
  });

  $('body').on('click', '.user-language', function(){
    $('.edit-user-language').hide();
    $('.show-user-language').show();
    $(this).find('.show-user-language').hide();
    $(this).find('.edit-user-language').show();
    if($(this).find('.btn-danger').hasClass('lang-button-delete')){
      return;
    } else {
      $(this).find('.edit-user-language .pull-right').append(
        '<button type="button" class="btn btn-sm btn-danger lang-button-delete">'+
          I18n.t("experience.delete")+'</button>'
      );
    };
  });

  $('body').on('mouseenter', '.user-language', function(){
    $(this).find('.button-edit').show();
  });

  $('body').on('mouseleave', '.user-language', function(){
    $(this).find('.button-edit').hide();
  });

  $('#create_language .save').on('click', function(e){
    e.preventDefault();
    var url = '/languages';
    var inputData = {
      language: {
        name: $(this).closest('.form-edit-profile').find('#language-name').val(),
        user_languages_attributes: [{
          level: $(this).closest('.form-edit-profile').find('#language-level :selected').text()
        }]
      }
    };

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      data: inputData,
    })
    .done(function(json){
      if(json.status == "success"){
        $('.current_language').html(json.html);
        $('#language-name').val('');
        $.growl.notice({message: I18n.t('setting.notice.update_success')});
      } else {
        $.growl.error({message: I18n.t('setting.notice.update_error')});
      };
    })
    .fail(function(){
      $.growl.error({message: I18n.t('setting.notice.update_error')});
    });
  });

  $('body').on('click', '.lang-button-delete', function(e){
    e.stopPropagation();
    var inputData = $(this).closest('.user-language').attr('id').match(/\d/g).join('');
    var url = '/user_languages/'+inputData;

    $.ajax({
      url: url,
      type: 'DELETE',
      dataType: 'json',
      data: {id: inputData},
    })
    .done(function(json){
      if(json.status == "success"){
        $('.current_language').html(json.html);
        $.growl.notice({message: I18n.t('setting.notice.delete_success')});
      } else {
        $.growl.error({message: I18n.t('setting.notice.delete_error')});
      };
    })
    .fail(function(){
      $.growl.error({message: I18n.t('setting.notice.delete_error')});
    });
  });
})
