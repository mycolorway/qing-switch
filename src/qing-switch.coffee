class QingSwitch extends QingModule

  @opts:
    el: null
    cls: ""

  constructor: (opts) ->
    super
    @opts = $.extend {}, QingSwitch.opts, @opts

    @el = $ @opts.el
    unless @el.length > 0
      throw new Error 'QingSwitch: option el is required'
    unless $(@opts.el).is(':checkbox')
      throw new Error "QingSwitch: el should be a checkbox"

    @_render()
    @_bind()

    @toggleState(@el.is(':checked'))

  _render: ->
    @wrapper = $("""
      <div class="qing-switch">
        <div class="switch-toggle"></div>
      </div>
    """)
      .data 'qingSwitch', @
      .addClass @opts.cls
      .insertBefore @el
      .append(@el)

    @el.hide()
      .data 'qingSwitch', @

  _bind: ->
    @wrapper.on 'click', =>
      @el.click()

    @el.on 'change.qingSwitch', =>
      @toggleState @el.is(':checked')

  toggleState: (state = !@el.is(':checked')) =>
    @el.prop 'checked', state
    @wrapper.toggleClass 'checked', state
    @checked = state
    @trigger 'switch', [state]

  destroy: ->
    @el.show()
      .insertBefore(@wrapper)
      .removeData 'qingSwitch'
      .off '.qingSwitch'
    @wrapper.remove()

module.exports = QingSwitch
