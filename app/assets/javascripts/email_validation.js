$('#user_email').on('blur', function() {
  $(this).mailcheck({
    suggested: function(element, suggestion) {
      element.next(".email-suggestion").empty();
      element.next(".email-suggestion").append('Did you mean <a "#" class="suggested-email">' + suggestion.full + '</a> ?');
    },
    empty: function(element) {
      element.next(".email-suggestion").empty();
    }
  });
});

$(".email-suggestion").on('click', function() {
  $(this).prev("#user_email").val($(this).find('.suggested-email').text());
  $(this).empty();
});
