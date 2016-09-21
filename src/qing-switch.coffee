class QingSwitch extends QingModule

  @opts:
    el: null
    cls: ""

  constructor: (opts) ->
    super
    @opts = $.extend {}, QingSwitch.opts, @opts

    @el = $ @opts.el
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

    @disable() if @el.is(':disabled')

  _bind: ->
    @wrapper.on 'click.qingSwitch', =>
      @toggleState()
      false

    @wrapper.on 'keydown.qingSwitch', (e)=>
      return unless e.keyCode == 13 && !@wrapper.is('.disabled')
      @toggleState()

  toggleState: (state = !@el.is(':checked')) =>
    @el.prop 'checked', state
    @wrapper.toggleClass 'checked', state
    @checked = state
    @trigger 'switch', [state]

  disable: ->
    @el.attr 'disabled', true
    @wrapper.addClass 'disabled'
            .removeAttr 'tabindex'

  enable: ->
    @el.removeAttr 'disabled'
    @wrapper.removeClass 'disabled'
            .attr 'tabindex', '0'

  destroy: ->
    @el.show()
      .insertBefore(@wrapper)
      .removeData 'qingSwitch'
      .off '.qingSwitch'
    @wrapper.remove()

module.exports = QingSwitch
