$(document).ready(function(){
  $('body').on('click', '.cancel', function(e){
    $(this).closest('.form-edit-profile').toggle('show');
    $(this).closest('.edit-work-experience').toggle('slow');
    $(this).closest('.pull-right').find('.ex-button-delete').remove();
    $(this).closest('.work-experience').find('.show-work-experience').show();
    e.stopPropagation();
  });

  $('body').on('click', '.work-experience', function(){
    $('.edit-work-experience').hide();
    $('.show-work-experience').show();
    $(this).find('.show-work-experience').hide();
    $(this).find('.edit-work-experience').show();
    if($(this).find('.btn-danger').hasClass('ex-button-delete')){
      return;
    } else {
      $(this).find('.edit-work-experience .pull-right').append(
        '<button type="button" class="btn btn-sm btn-danger ex-button-delete">'+
          I18n.t("experience.delete")+'</button>'
      );
    };
  });

  $('body').on('mouseenter', '.work-experience', function(){
    $(this).find('.button-edit').show();
  });

  $('body').on('mouseleave', '.work-experience', function(){
    $(this).find('.button-edit').hide();
  });

  $('#create_experience .save').on('click', function(e){
    e.preventDefault();
    var url = '/work_experiences';
    var inputData = {};

    $('.experience-form').serializeArray().map(function(x){
      inputData[x.name.replace( /(^.*\[|\].*$)/g, '' )] = x.value;
    });
    inputData = {work_experience: inputData};

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json',
      data: inputData,
    })
    .done(function(json){
      if(json.status == "success"){
        $('.current-experience').html(json.html);
        $('.experience-form').val('');
        $.growl.notice({message: I18n.t('setting.notice.update_success')});
      } else {
        $.growl.error({message: I18n.t('setting.notice.update_error')});
      };
    })
    .fail(function(){
      $.growl.error({message: I18n.t('setting.notice.update_error')});
    });
  });

  $('body').on('click', '.ex-button-delete', function(e){
    e.stopPropagation();
    var inputData = $(this).closest('.work-experience').attr('id').match(/\d/g).join('');
    var url = '/work_experiences/'+inputData;

    $.ajax({
      url: url,
      type: 'DELETE',
      dataType: 'json',
      data: {id: inputData},
    })
    .done(function(json){
      if(json.status == "success"){
        $('.current-experience').html(json.html);
        $('.ex-button-group').css('display', 'block');
        $.growl.notice({message: I18n.t('setting.notice.delete_success')});
      } else {
        $.growl.error({message: I18n.t('setting.notice.delete_error')});
      };
    })
    .fail(function(){
      $.growl.error({message: I18n.t('setting.notice.delete_error')});
    });
  });
});
