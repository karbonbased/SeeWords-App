$(document).ready ->
  # hide spinner
  $('.spinner').hide()
  # show spinner on AJAX start
  $(document).ajaxStart ->
    $('.spinner').show()
    return
  # hide spinner on AJAX stop
  $(document).ajaxStop ->
    $('.spinner').hide()
    return
  return
