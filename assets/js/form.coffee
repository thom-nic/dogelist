define [
  "jquery"],
  ($) ->

    ###
    # Convert form fields to an object.  See
    # http://stackoverflow.com/questions/1184624/convert-form-data-to-js-object-with-jquery
    # for more complex variations
    ###
    $.fn.form2obj = ->
      o = {}
      a = @serializeArray()

      $.each a, ->
        if o[@name]?
          unless o[@name].push
            o[@name] = [o[@name]]
          o[@name].push @value || ''
        else
          o[@name] = @value || ''

      return o
