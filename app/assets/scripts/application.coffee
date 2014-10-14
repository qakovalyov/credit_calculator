jQuery ($) ->
  bindCalculating()


bindCalculating = () ->
  $form = $('#calculator').find('form')
  $form.on 'submit', calculating

calculating = (event) ->
  $form = $(event.target)
  event.preventDefault()
  validateFormBeforeSend $form
  if isValidateForm()
    $.ajax
      type: 'POST'
      dataType: 'json'
      data: $(event.target).serializeArray()
      url: '/calc'
      error: (data) ->
        response = JSON.parse data.responseText
        validateFormAfterSend response, $form
      success: (data) ->
        createTable data, $form



validateFormBeforeSend = ($form) ->
  $.each $form.find('input'), (index, val)->
    if $(this).val() == ''
      $(this).closest('.form-group')
      .removeClass 'has-success'
      .toggleClass 'has-error', true
      .find('.help-block').html 'This field cannot be blank.'
    else
      $(this).closest('.form-group')
      .removeClass 'has-error'
      .toggleClass 'has-success', true
      .find('.help-block').html('')

validateFormAfterSend =  (response, $form) ->
  $.each response.errors, (key, val) ->
    $form.find('#'+ key).closest('.form-group')
      .addClass 'has-error'
      .find('.help-block').html(val)


isValidateForm = () ->
  !$('form').find('.form-group').hasClass('has-error')

createTable = (data, $form) ->
  console.log data
  html = ''
  $.each data, (index, val) ->
    month = index + 1
    html +="<tr>
              <td>#{month}</td>
              <td>#{val[0]}</td>
              <td>#{val[1]}</td>
              <td>#{val[2]}</td>
              <td>#{val[3]}</td>
            </tr>"
  $('.credit-table')
    .toggleClass 'hidden'
    .find('table tbody').html html
  $form.toggleClass 'hidden'

