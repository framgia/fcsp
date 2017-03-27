function view_image(dom_id) {
  $(dom_id).on('change', function () {
    if (typeof (FileReader) != "undefined") {
      var bar = $(this).next();
      var image_holder = bar;
      image_holder.empty();
      var reader = new FileReader();
      reader.onload = function (e) {
        $("<img />", {
          "src": e.target.result,
          "class": "thumb-image"
        }).appendTo(image_holder);
      }
      image_holder.show();
      reader.readAsDataURL($(this)[0].files[0]);
    } else {
      alert("This browser does not support FileReader.");
    }
  });
}

function view_team_introduction (dom_id_button, dom_id_team_introduction) {
  $(dom_id_button).click(function(){
    $(dom_id_team_introduction).toggle();
  });
}

$(document).ready(function() {
  view_image('#team_introduction_images_attributes_0_image_url');
  view_image('#team_introduction_images_attributes_1_image_url');

  var $form_new_team_introduction = $('.team_introduction');
  $('.team_introduction form').on('submit', function(e) {
    e.preventDefault();
    debugger
    var url_team_introduction = $('.new_team_introduction').attr('action');
    var class_name = $(this).attr('class');
    var x = $(this).parent().parent().attr('class');
    var parent_name = x.substr(4);
    var lastChar = parent_name.substr(parent_name.length - 1);
    var index = parseInt(lastChar);
    var parent_class = '.'+ parent_name;
    var tr = '.team_introduction_' + (index+1).toString();
    $.ajax({
      dataType: 'json',
      url: url_team_introduction,
      method: 'post',
      data: $(this).serialize(),
      success: function(data) {
        debugger
        if (index != 3) {
          $(parent_class).hide();
          $(tr).show();
        }
        else {
          $('.team_introduction').find('input[type="submit"]').attr('disabled', false);
        }
      },
      error: function(){
        alert(I18n.t('employer.team_introductions.not_found'));
      }
    })
    view_image('#team_introduction_images_attributes_0_image_url');
    view_image('#team_introduction_images_attributes_1_image_url');
  });

  view_team_introduction('.button_team_introduction_1', '.team_introduction_1');
  view_team_introduction('.button_team_introduction_2', '.team_introduction_2');
  view_team_introduction('.button_team_introduction_3', '.team_introduction_3');

});
