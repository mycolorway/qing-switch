/**
 * qing-switch v0.0.1
 * http://mycolorway.github.io/qing-switch
 *
 * Copyright Mycolorway Design
 * Released under the MIT license
 * http://mycolorway.github.io/qing-switch/license.html
 *
 * Date: 2016-09-7
 */
;(function(root, factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('jquery'),require('qing-module'));
  } else {
    root.QingSwitch = factory(root.jQuery,root.QingModule);
  }
}(this, function ($,QingModule) {
var define, module, exports;
var b = require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"qing-switch":[function(require,module,exports){
var QingSwitch,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

QingSwitch = (function(superClass) {
  extend(QingSwitch, superClass);

  QingSwitch.opts = {
    el: null,
    cls: ""
  };

  function QingSwitch(opts) {
    this.toggleState = bind(this.toggleState, this);
    QingSwitch.__super__.constructor.apply(this, arguments);
    this.opts = $.extend({}, QingSwitch.opts, this.opts);
    this.el = $(this.opts.el);
    if (!(this.el.length > 0)) {
      throw new Error('QingSwitch: option el is required');
    }
    if (!$(this.opts.el).is(':checkbox')) {
      throw new Error("QingSwitch: el should be a checkbox");
    }
    this._render();
    this._bind();
    this.toggleState(this.el.is(':checked'));
  }

  QingSwitch.prototype._render = function() {
    this.wrapper = $("<div class=\"qing-switch\">\n  <div class=\"switch-toggle\"></div>\n</div>").data('qingSwitch', this).addClass(this.opts.cls).insertBefore(this.el).append(this.el);
    return this.el.hide().data('qingSwitch', this);
  };

  QingSwitch.prototype._bind = function() {
    this.wrapper.on('click', (function(_this) {
      return function() {
        return _this.el.click();
      };
    })(this));
    return this.el.on('change.qingSwitch', (function(_this) {
      return function() {
        return _this.toggleState(_this.el.is(':checked'));
      };
    })(this));
  };

  QingSwitch.prototype.toggleState = function(state) {
    if (state == null) {
      state = !this.el.is(':checked');
    }
    this.el.prop('checked', state);
    this.wrapper.toggleClass('checked', state);
    this.checked = state;
    return this.trigger('switch', [state]);
  };

  QingSwitch.prototype.destroy = function() {
    this.el.show().insertBefore(this.wrapper).removeData('qingSwitch').off('.qingSwitch');
    return this.wrapper.remove();
  };

  return QingSwitch;

})(QingModule);

module.exports = QingSwitch;

},{}]},{},[]);

return b('qing-switch');
}));
