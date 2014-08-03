$(function(){
  var link = $('<a href="javascript:"></a>').addClass('link').text('Link');
  var brand = $('.brand').parent().append(link);
  var container = $('<div class="link-container"></div>');
  var url = 'http://ircbrowse.net/selection/haskell';
  var events;
  var val = $.cookie('selected-events');
  if (val) {
    events = JSON.parse(val);
    for (var i = 0; i < events.length; i++) {
      $('#id' + events[i]).parent().addClass('selected');
    }
  }
  else events = [];
  brand.append(container);
  var textarea;
  function update(){
    var newuri = url;
    if (!newuri.match(/\?/)) {
      newuri += "?";
    }
    if (!newuri.match(/\?$/)) {
      newuri += "&";
    }
    var eventStr = 'events=' + events.join(',');
    var titleStr = 'title=Conversation';
    if (events.length)
      textarea.text(newuri + [titleStr,eventStr].join('&'));
    else
      textarea.text('');
    $.cookie('selected-events',JSON.stringify(events));
  }
  link.click(function(){
    if (container.children().size() == 0) {
      textarea = $('<textarea></textarea>');
      container.append(textarea);
      container.append($('<p></p>').text('(Click messages to include in selection)'));
      $('.container-fluid').addClass('selecting');
      $('.selecting tr').click(function(){
        var tr = $(this);
        events = toggle(events,tr.children('td').first().attr('id').replace(/^id/,'')*1);
        tr.toggleClass('selected');
        update();
        return false;
      });
      update();
    } else {
      if (events.length) confirm("Discard selected events?");
      container.empty();
      $('.container-fluid').removeClass('selecting');
      $('.selecting tr').off('click');
      events = [];
      $('.selected').removeClass('selected');
      $.cookie('selected-events',null);
    }
  });
  if ($.cookie('selected-events'))
    link.click();
});

function toggle(old,e){
  var arr = [], removed = false;
  for (var i = 0, len = old.length; i < len; i++) {
    if (e === old[i]) {
      removed = true;
    } else {
      arr.push(old[i]);
    }
  }
  if (!removed)
    arr.push(e);
  return arr;
};

/*!
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2006, 2014 Klaus Hartl
 * Released under the MIT license
 */
(function (factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD
    define(['jquery'], factory);
  } else if (typeof exports === 'object') {
    // CommonJS
    factory(require('jquery'));
  } else {
    // Browser globals
    factory(jQuery);
  }
}(function ($) {

  var pluses = /\+/g;

  function encode(s) {
    return config.raw ? s : encodeURIComponent(s);
  }

  function decode(s) {
    return config.raw ? s : decodeURIComponent(s);
  }

  function stringifyCookieValue(value) {
    return encode(config.json ? JSON.stringify(value) : String(value));
  }

  function parseCookieValue(s) {
    if (s.indexOf('"') === 0) {
      // This is a quoted cookie as according to RFC2068, unescape...
      s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
    }

    try {
      // Replace server-side written pluses with spaces.
      // If we can't decode the cookie, ignore it, it's unusable.
      // If we can't parse the cookie, ignore it, it's unusable.
      s = decodeURIComponent(s.replace(pluses, ' '));
      return config.json ? JSON.parse(s) : s;
    } catch(e) {}
  }

  function read(s, converter) {
    var value = config.raw ? s : parseCookieValue(s);
    return $.isFunction(converter) ? converter(value) : value;
  }

  var config = $.cookie = function (key, value, options) {

    // Write

    if (arguments.length > 1 && !$.isFunction(value)) {
      options = $.extend({}, config.defaults, options);

      if (typeof options.expires === 'number') {
	var days = options.expires, t = options.expires = new Date();
	t.setTime(+t + days * 864e+5);
      }

      return (document.cookie = [
	encode(key), '=', stringifyCookieValue(value),
	options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
	options.path    ? '; path=' + options.path : '',
	options.domain  ? '; domain=' + options.domain : '',
	options.secure  ? '; secure' : ''
      ].join(''));
    }

    // Read

    var result = key ? undefined : {};

    // To prevent the for loop in the first place assign an empty array
    // in case there are no cookies at all. Also prevents odd result when
    // calling $.cookie().
    var cookies = document.cookie ? document.cookie.split('; ') : [];

    for (var i = 0, l = cookies.length; i < l; i++) {
      var parts = cookies[i].split('=');
      var name = decode(parts.shift());
      var cookie = parts.join('=');

      if (key && key === name) {
	// If second argument (value) is a function it's a converter...
	result = read(cookie, value);
	break;
      }

      // Prevent storing a cookie that we couldn't decode.
      if (!key && (cookie = read(cookie)) !== undefined) {
	result[name] = cookie;
      }
    }

    return result;
  };

  config.defaults = {};

  $.removeCookie = function (key, options) {
    if ($.cookie(key) === undefined) {
      return false;
    }

    // Must not alter options, thus extending a fresh object...
    $.cookie(key, '', $.extend({}, options, { expires: -1 }));
    return !$.cookie(key);
  };

}));