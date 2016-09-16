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
    if (initialized = @el.data('qingSwitch'))
      return initialized

    @_render()
    @_bind()

    @toggleState(@el.is(':checked'))

  _render: ->
    @wrapper = $("""
      <div class="qing-switch" tabindex="0">
        <div class="switch-toggle"></div>
      </div>
    """)
      .data 'qingSwitch', @
      .addClass @opts.cls
      .insertBefore @el
      .append(@el)

    @el.hide()
      .data 'qingSwitch', @

    @disabled @el.is(':disabled')

  _bind: ->
    @wrapper.on 'click.qingSwitch', =>
      @el.click()

    @wrapper.on 'keydown.qingSwitch', (e)=>
      return unless e.keyCode == 13
      @toggleState()

    @el.on 'change.qingSwitch', =>
      @toggleState @el.is(':checked')

  toggleState: (state = !@el.is(':checked')) =>
    @el.prop 'checked', state
    @wrapper.toggleClass 'checked', state
    @checked = state
    @trigger 'switch', [state]

  disabled: (disabled = true) =>
    if disabled then @el.attr('disabled', true) else @el.removeAttr('disabled')
    @wrapper.toggleClass 'disabled', disabled

  destroy: ->
    @el.show()
      .insertBefore(@wrapper)
      .removeData 'qingSwitch'
      .off '.qingSwitch'
    @wrapper.remove()

module.exports = QingSwitch
