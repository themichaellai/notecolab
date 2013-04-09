$(document).ready( ->
  $('.join').click( (e) ->
    e.preventDefault()
    link = $(this)
    $.post(link.attr('href'), (result) ->
      console.log link.parent()
      link.parent().text(result)
    )
  )
)
