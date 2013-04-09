$(document).ready( ->
  $('.leave').click( (e) ->
    e.preventDefault()
    if confirm('Are you sure?')
      link = $(this)
      $.post(link.attr('href'), (result) ->
        if result.success
          link.parent().parent().fadeOut()
        else
          console.log result.message

      )
  )
  return
)
