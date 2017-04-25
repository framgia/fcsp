$(document).ready(function(){
  $('.change-image').on('change', function(){
    read_url(this);
    $('.user-old-image').val('');
    $('.btn-submit-avatar').addClass('btn-create-avatar');
    $('.btn-submit-avatar').removeClass('btn-update-avatar');
    $('.btn-submit-cover').addClass('btn-create-cover');
    $('.btn-submit-cover').removeClass('btn-update-cover');
  });

  $('.album-image').hide();

  $('.album-for-user').on('click', function(){
    $('.album-image').show();
  });

  $('.user-image-img').on('click', function(){
    image_id = this.dataset.id;
    image_src = $('#user-image-' + image_id).attr('src');
    $('.img-upload').attr('src', image_src);
    $('.user-old-image').val(image_id);
    $('.change-image').val('');
    $('.btn-submit-avatar').addClass('btn-update-avatar');
    $('.btn-submit-avatar').removeClass('btn-create-avatar');
    $('.btn-submit-cover').addClass('btn-update-cover');
    $('.btn-submit-cover').removeClass('btn-create-cover');
  });

  $('#changeAvatarModal').on('click', '.btn-create-avatar', function(){
    $('#form-create-avatar').submit();
  });

  $('#changeAvatarModal').on('click', '.btn-update-avatar', function(){
    $('#form-update-avatar').submit();
  });

  $('#changeCoverModal').on('click', '.btn-create-cover', function(){
    $('#form-create-cover').submit();
  });

  $('#changeCoverModal').on('click', '.btn-update-cover', function(){
    $('#form-update-cover').submit();
  });

  $(document).on('click', '.custom-paginate a.page-link', function(e){
    e.preventDefault();

    var params = $(this).attr('href').split('?')[1];
    var tab = params.split('tab=')[1];

    $.ajax({
      dataType: 'html',
      url: $(this).attr('href'),
      method: 'get',
      success: function(data){
        $('#' + tab).html($(data).find('#' + tab));
      },
      error: function(){
        flash = I18n.t("education.users.page_not_found");
        $.growl.error({message: flash});
      }
    })
  })
});

function read_url(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('.img-upload').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}
