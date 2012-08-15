(function() {
  var $,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  var loadingImgCount = 0;
  $ = jQuery;

  $.fn.extend({
    s3ImageProxy: function(options) {
      var Proxy, load_image, log, proxy, settings, timestamp;
      Proxy = (function() {

        function _Class(options) {
          this.on_message = __bind(this.on_message, this);          
          window.addEventListener('message', this.on_message, false);
          this.load(options.url);
        }

        _Class.prototype.load = function(url) {
          console.log("loading iframe:" + url);
          var loader;
          this.remote_domain = url.match(/https:\/\/[^/]+/)[0];
          loader = document.createElement('iframe');
          loader.setAttribute('style', 'display:none');
          loader.src = "" + url + "?stamp=" + (this.timestamp());
          return document.body.appendChild(loader);
        };

        _Class.prototype.is_loaded = function() {
          return !!this.end_point;
        };

        _Class.prototype.on_message = function(event) {
          console.log("on message fired");
          var message;
          if (event.origin !== this.remote_domain) return;
          message = JSON.parse(event.data);
          switch (message.action) {
            case 'init':
              return this.end_point = event.source;
            default:
              
              toTrigger = $.grep(outfit_canvas.side.items,function(item){return item.img.id === message.id });
              console.log(toTrigger[0].img);
              return $(toTrigger[0].img).trigger("imageData", message.bits);
          }
        };

        _Class.prototype.send = function(message) {
          var _this = this;
          console.log("before send is called");
          if (this.is_loaded()) {
            return this.end_point.postMessage(JSON.stringify(message), this.remote_domain);
          } else {
            return window.setTimeout((function() {
              return _this.send(message);
            }), 200);
          }
        };

        _Class.prototype.timestamp = function() {
          return "img"+(Math.random() + "").substr(-10);
        };

        return _Class;

      })();
      load_image = function(img) {
        console.log("loading image");
        console.log(proxy);
        var i, path;
        path = img.attr('data-path');
        i = 0;
        remote = settings["s3remote"].replace('https','http');
        while (remote.charAt(i) === img.attr("src").charAt(i)) {
          i++;
        }
        return proxy.send({
          action: 'load',
          path: img.attr("src").substring(i),
          id: img.attr('id')
        });
      };
      timestamp = function() {
        return "img"+(Math.random() + "").substr(-10);
      };
      settings = {
        s3remote: "https://s3.amazonaws.com/sdjdevelopment/",
        proxyFile: "proxy_dev.html",
        debug: false
      };
      settings = $.extend(settings, options);
      proxy = new Proxy({
        url: settings["s3remote"] + settings["proxyFile"],
        application: this
      });
      log = function(msg) {
        if (settings.debug) {
          return typeof console !== "undefined" && console !== null ? console.log(msg) : void 0;
        }
      };
      return  this.each(function() {
        console.log("in return...");
        loadingImgCount++;
        time = timestamp;
        $(this).attr('id', time);
        $(this).bind("imageData", function(evt, bits) {
          loadingImgCount--;
          console.log(loadingImgCount);
          console.log("adding bits:" + bits)
          $(this).attr('src', bits);
          return $(this).unbind("imageData");
        });
        return load_image($(this));
      });
    }
  });
 
 var checkImageLoadingTimeout = function() {
  if (loadingImgCount > 0) {
      return window.setTimeout((function() {
        console.log("At the end: " + loadingImgCount);
        checkImageLoadingTimeout();
      }), 2000);
    }
  else
    console.log("done!");
    $(outfit_canvas).trigger('loadSideLoaded');
 }
 
window.setTimeout((function() {checkImageLoadingTimeout()}), 1000);
 
}).call(this);
