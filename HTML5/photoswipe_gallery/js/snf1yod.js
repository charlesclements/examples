/*
 * For font license information, see the CSS file loaded by this JavaScript.
 */
if(!window.Typekit)window.Typekit={};window.Typekit.config={"a":"705598","c":[".tk-myriad-pro","\"myriad-pro\",sans-serif"],"dl":"AAAAdAAAAAqO8A8NNaFdV19FF0EADbJT","f":"//use.typekit.net/c/bc9a10/1w;myriad-pro,2,bzN:R:n4,bzP:R:n6/{format}{/extras*}","fi":[6851,6852],"fn":["myriad-pro",["n4","n6"]],"ht":"tk","js":"1.14.12","k":"//use.typekit.net/{id}.js","kt":"snf1yod","l":"typekit","p":"//p.typekit.net/p.gif?s=1&k=snf1yod&ht=tk&h={host}&f=6851.6852&a=705598&_={_}","ps":1,"w":"snf1yod"};
/*{"k":"1.14.12","auto_updating":true}*/
;(function(window,document,undefined){if(!document.querySelector){document.documentElement.className+=" wf-inactive";return;}function aa(a,b,c){return a.call.apply(a.bind,arguments)}function ba(a,b,c){if(!a)throw Error();if(2<arguments.length){var e=Array.prototype.slice.call(arguments,2);return function(){var c=Array.prototype.slice.call(arguments);Array.prototype.unshift.apply(c,e);return a.apply(b,c)}}return function(){return a.apply(b,arguments)}}function h(a,b,c){h=Function.prototype.bind&&-1!=Function.prototype.bind.toString().indexOf("native code")?aa:ba;return h.apply(null,arguments)}var k=Date.now||function(){return+new Date};function ca(){this.P=this.R=this.I=this.N=this.O=!0};function da(){var a=[{name:"font-family",value:n.c[q+1]}];this.g=[n.c[q]];this.b=a}function ea(a){for(var b=a.g.join(","),c=[],e=0;e<a.b.length;e++){var d=a.b[e];c.push(d.name+":"+d.value+";")}return b+"{"+c.join("")+"}"};function fa(a){this.b=a}fa.prototype.toString=function(){return encodeURIComponent(ga(this.b))};function ha(a,b){this.g=a;this.b=b}ha.prototype.toString=function(){for(var a=[],b=0;b<this.b.length;b++)for(var c=this.b[b],e=c.G(),c=c.G(this.g),d=0;d<e.length;d++){var f;a:{for(f=0;f<c.length;f++)if(e[d]===c[f]){f=!0;break a}f=!1}a.push(f?1:0)}a=a.join("");a=a.replace(/^0+/,"");b=[];for(e=a.length;0<e;e-=4)b.unshift(parseInt(a.slice(0>e-4?0:e-4,e),2).toString(16));return b.join("")};function ia(a,b){this.b=a;this.g=b}ia.prototype.G=function(){return this.g};function ja(a){this.b=a}function ka(a,b){return b};function la(){this.b=this.g=-1}la.prototype.start=function(){this.g=(new Date).getTime();this.b=-1};var t={V:"a",$:"d",U:"i",W:"j",T:"k",Z:"l",NONE:"x"};var u={};u.a=u.d=u.l=u.j=function(){return[]};u.i=function(a,b,c){return[new fa(a),new ha(b,c)]};u.k=function(a){return[new fa(a)]};function ma(a,b,c){return u[b](a,b,c)};var na={};
na.i=new ja(function(a,b,c){for(var e=0;e<b.length;e+=1){var d=b[e],f;f=d;f=a.replace(/(-1|-2)$/,"").slice(0,28)+"-"+f;c.push(new ia(f,[d]))}a={};for(d=0;d<b.length;d++)c=b[d],e=c.charAt(1),(a[e]||(a[e]=[])).push(c);c=[[4,3,2,1,5,6,7,8,9],[7,8,9,6,5,4,3,2,1]];e=[];for(d=0;d<c.length;d++){f=c[d];for(var g=0;g<f.length;g++){var l=f[g];if(a[l]){e=e.concat(a[l]);break}}}c=e;e={};a=[];for(d=0;d<c.length;d++)f=c[d],e[f]||(e[f]=!0,a.push(f));c=[];for(e=0;e<b.length;e++)for(d=b[e],f=0;f<a.length;f++)g=a[f],
g==d&&c.push(g);return c});function oa(a){this.b=a}oa.prototype.s=function(a,b){var c=a||{},e=this.b.replace(/\{\/?([^*}]*)(\*?)\}/g,function(a,b,e){return e&&c[b]?"/"+c[b].join("/"):c[b]||""});e.match(/^\/\//)&&(e=(b?"http:":"https:")+e);return e.replace(/\/*\?*($|\?)/,"$1")};function pa(a,b){for(var c=[],e=0;e<b.length;e++)c.push(b[e].toString());return{format:a,extras:c}};function qa(a){var b=new Image(1,1),c=!1;b.src=a;b.onload=function(){c=!0;b.onload=null};setTimeout(function(){c||(b.src="about:blank",b.onload=null)},3E3)};function w(a,b,c,e,d,f,g){this.b=a;this.B=b;this.F=c;this.D=e;this.v=d;this.o=f;this.M=g}w.prototype.getName=function(){return this.b};function x(a,b,c,e){this.b=null!=a?a:null;this.g=null!=b?b:null;this.h=null!=c?c:null;this.s=null!=e?e:null}var ra=/^([0-9]+)(?:[\._-]([0-9]+))?(?:[\._-]([0-9]+))?(?:[\._+-]?(.*))?$/;function y(a,b){return a.b>b.b||a.b===b.b&&a.g>b.g||a.b===b.b&&a.g===b.g&&a.h>b.h?1:a.b<b.b||a.b===b.b&&a.g<b.g||a.b===b.b&&a.g===b.g&&a.h<b.h?-1:0}function z(a,b){return-1===y(a,b)}function A(a,b){return 0===y(a,b)||1===y(a,b)}function sa(a,b){return 0===y(a,b)||-1===y(a,b)}function ta(a,b){return 0===y(a,b)}
x.prototype.toString=function(){return[this.b,this.g||"",this.h||"",this.s||""].join("")};function B(a){a=ra.exec(a);var b=null,c=null,e=null,d=null;a&&(null!==a[1]&&a[1]&&(b=parseInt(a[1],10)),null!==a[2]&&a[2]&&(c=parseInt(a[2],10)),null!==a[3]&&a[3]&&(e=parseInt(a[3],10)),null!==a[4]&&a[4]&&(/^[0-9]+$/.test(a[4])?d=parseInt(a[4],10):d=a[4]));return new x(b,c,e,d)};function ua(a){return"Safari"===a.getName()&&"AppleWebKit"===a.F||"Unknown"===a.getName()&&"AppleWebKit"===a.F&&("iPhone"===a.v||"iPad"===a.v||"iPod"===a.v)}function va(a){return"Chrome"===a.getName()&&A(a.B,new x(6))&&sa(a.B,new x(35))}function wa(a){return"Chrome"===a.getName()&&A(a.B,new x(36))}function xa(a){return"BuiltinBrowser"===a.getName()};function D(a){return"Windows"===a.v}function ya(a){return D(a)&&A(a.o,new x(6,1))}function E(a){return D(a)&&ta(a.o,new x(5,1))||D(a)&&ta(a.o,new x(5,2))||D(a)&&ta(a.o,new x(6,0))||ya(a)}function F(a){return"Macintosh"===a.v&&(A(a.o,new x(10,4))||null===a.o.b)}function za(a,b){return b.O&&("iPhone"===a.v||"iPod"===a.v)&&A(a.o,new x(4,2))&&z(a.o,new x(5))}function Aa(a,b){return b.O&&("iPhone"===a.v||"iPod"===a.v)&&A(a.o,new x(5))}
function Ba(a,b){return b.N&&"iPad"===a.v&&A(a.o,new x(4,2))&&z(a.o,new x(5))}function Ca(a,b){return b.N&&"iPad"===a.v&&A(a.o,new x(5))}function I(a,b){return b.I&&"Android"===a.v}function Da(a,b){return I(a,b)&&A(a.o,new x(2,2))&&z(a.o,new x(3,1))}function Ea(a,b){return I(a,b)&&A(a.o,new x(3,1))&&z(a.o,new x(4,1))}function J(a){return"Linux"===a.v||"Ubuntu"===a.v};var Fa={a:function(a,b){return"Safari"===a.getName()&&"AppleWebKit"===a.F&&A(a.D,new x(525,13))&&z(a.D,new x(534,50))&&(E(a)||F(a))||xa(a)&&(Da(a,b)||I(a,b)&&A(a.o,new x(4,1)))||b.I&&"Silk"===a.getName()&&z(a.B,new x(2))&&(Da(a,b)||F)||b.I&&"Silk"===a.getName()&&A(a.B,new x(2))&&I(a,b)&&A(a.o,new x(4,1))||ua(a)&&(Ba(a,b)||za(a,b))||va(a)&&(Ba(a,b)||za(a,b))||wa(a)&&(Ba(a,b)||za(a,b))||"AdobeAIR"===a.getName()&&A(a.B,new x(2,5))&&(D(a)&&null===a.o.b||J(a)||F(a))},d:function(a,b){return va(a)&&(E(a)||
J(a)||F(a)||I(a,b)||"CrOS"===a.v||"CrKey"===a.v||Ca(a,b)||Aa(a,b))||wa(a)&&(Ca(a,b)||Aa(a,b))||"Gecko"===a.F&&1===y(a.D,new x(1,9,1))&&sa(a.D,new x(38))&&(E(a)||J(a)||F(a)||I(a,b))||"Safari"===a.getName()&&"AppleWebKit"===a.F&&A(a.D,new x(534,50))&&(E(a)||F(a))||ua(a)&&(Ca(a,b)||Aa(a,b))||"Opera"===a.getName()&&A(a.B,new x(11,10))&&sa(a.B,new x(22))&&(E(a)||J(a)||F(a)||I(a,b))||"MSIE"===a.getName()&&9<=a.M&&(ya(a)||D(a)&&ta(a.o,new x(6,0)))||"Edge"===a.getName()&&ya(a)||"MSIE"===a.getName()&&b.R&&
"Windows Phone"===a.v&&A(a.o,new x(8))||xa(a)&&(b.P&&"BlackBerry"===a.v&&A(a.o,new x(10))||J(a))},j:function(a,b){return xa(a)&&Ea(a,b)||b.I&&"Silk"===a.getName()&&A(a.B,new x(2))&&(Ea(a,b)||J(a))},i:function(a){return"MSIE"===a.getName()&&A(a.B,new x(6,0))&&(void 0===a.M||9>a.M)&&E(a)},l:function(a,b){return wa(a)&&(E(a)||J(a)||F(a)||I(a,b)||"CrOS"===a.v||"CrKey"===a.v)||"Gecko"===a.F&&A(a.D,new x(39))&&(E(a)||J(a)||F(a)||I(a,b))||"Opera"===a.getName()&&A(a.B,new x(23))&&(E(a)||J(a)||F(a)||I(a,b))},
x:function(){return!1}};var Ga=new w("Unknown",new x,"Unknown",new x,"Unknown",new x,void 0);function K(a){var b=L(a.b,/(iPod|iPad|iPhone|Android|Windows Phone|BB\d{2}|BlackBerry)/,1);if(""!==b)return/BB\d{2}/.test(b)&&(b="BlackBerry"),b;a=L(a.b,/(Linux|Mac_PowerPC|Macintosh|Windows|CrOS|PlayStation|CrKey)/,1);return""!==a?("Mac_PowerPC"==a?a="Macintosh":"PlayStation"==a&&(a="Linux"),a):"Unknown"}
function M(a){var b=L(a.b,/(OS X|Windows NT|Android) ([^;)]+)/,2);if(b||(b=L(a.b,/Windows Phone( OS)? ([^;)]+)/,2))||(b=L(a.b,/(iPhone )?OS ([\d_]+)/,2)))return b;if(b=L(a.b,/(?:Linux|CrOS|CrKey) ([^;)]+)/,1))for(var b=b.split(/\s/),c=0;c<b.length;c+=1)if(/^[\d\._]+$/.test(b[c]))return b[c];return(a=L(a.b,/(BB\d{2}|BlackBerry).*?Version\/([^\s]*)/,2))?a:"Unknown"}
function Ha(){var a=N,b="Unknown",c=B(L(a.b,/Presto\/([\d\w\.]+)/,1)),e=B(M(a)),d=O(a.g);null!==c.b?b="Presto":(-1!=a.b.indexOf("Gecko")&&(b="Gecko"),c=B(L(a.b,/rv:([^\)]+)/,1)));if(-1!=a.b.indexOf("Opera Mini/")){var f=B(L(a.b,/Opera Mini\/([\d\.]+)/,1));return new w("OperaMini",f,b,c,K(a),e,d)}if(-1!=a.b.indexOf("Version/")&&(f=B(L(a.b,/Version\/([\d\.]+)/,1)),null!==f.b))return new w("Opera",f,b,c,K(a),e,d);f=B(L(a.b,/Opera[\/ ]([\d\.]+)/,1));return null!==f.b?new w("Opera",f,b,c,K(a),e,d):new w("Opera",
new x,b,c,K(a),e,d)}
function Ia(){var a=N,b=K(a),c=B(M(a)),e=B(L(a.b,/AppleWeb(?:K|k)it\/([\d\.\+]+)/,1)),d="Unknown",f=new x,f="Unknown";/OPR\/[\d.]+/.test(a.b)?d="Opera":-1!=a.b.indexOf("Chrome")||-1!=a.b.indexOf("CrMo")||-1!=a.b.indexOf("CriOS")?d="Chrome":/Silk\/\d/.test(a.b)?d="Silk":"BlackBerry"==b||"Android"==b?d="BuiltinBrowser":-1!=a.b.indexOf("PhantomJS")?d="PhantomJS":-1!=a.b.indexOf("Safari")?d="Safari":-1!=a.b.indexOf("AdobeAIR")?d="AdobeAIR":-1!=a.b.indexOf("PlayStation")&&(d="BuiltinBrowser");"BuiltinBrowser"==
d?f="Unknown":"Silk"==d?f=L(a.b,/Silk\/([\d\._]+)/,1):"Chrome"==d?f=L(a.b,/(Chrome|CrMo|CriOS)\/([\d\.]+)/,2):-1!=a.b.indexOf("Version/")?f=L(a.b,/Version\/([\d\.\w]+)/,1):"AdobeAIR"==d?f=L(a.b,/AdobeAIR\/([\d\.]+)/,1):"Opera"==d?f=L(a.b,/OPR\/([\d.]+)/,1):"PhantomJS"==d&&(f=L(a.b,/PhantomJS\/([\d.]+)/,1));f=B(f);return new w(d,f,"AppleWebKit",e,b,c,O(a.g))}function L(a,b,c){return(a=a.match(b))&&a[c]?a[c]:""}function O(a){if(a.documentMode)return a.documentMode};function Ja(a){this.b=a||"-"}Ja.prototype.s=function(a){for(var b=[],c=0;c<arguments.length;c++)b.push(arguments[c].replace(/[\W_]+/g,"").toLowerCase());return b.join(this.b)};var Ka=!!window.FontFace;function La(a,b,c,e){b=a.b.createElement(b);if(c)for(var d in c)c.hasOwnProperty(d)&&("style"==d?b.style.cssText=c[d]:b.setAttribute(d,c[d]));e&&b.appendChild(a.b.createTextNode(e));return b}function Ma(a,b,c){a=a.b.getElementsByTagName(b)[0];a||(a=document.documentElement);a.insertBefore(c,a.lastChild)}
function Na(a,b){a.b.body?b():a.b.addEventListener?a.b.addEventListener("DOMContentLoaded",b):a.b.attachEvent("onreadystatechange",function(){"interactive"!=a.b.readyState&&"complete"!=a.b.readyState||b()})}function Oa(a){a.parentNode&&a.parentNode.removeChild(a)}
function P(a,b,c){b=b||[];c=c||[];for(var e=a.className.split(/\s+/),d=0;d<b.length;d+=1){for(var f=!1,g=0;g<e.length;g+=1)if(b[d]===e[g]){f=!0;break}f||e.push(b[d])}b=[];for(d=0;d<e.length;d+=1){f=!1;for(g=0;g<c.length;g+=1)if(e[d]===c[g]){f=!0;break}f||b.push(e[d])}a.className=b.join(" ").replace(/\s+/g," ").replace(/^\s+|\s+$/,"")}function Pa(a,b){for(var c=a.className.split(/\s+/),e=0,d=c.length;e<d;e++)if(c[e]==b)return!0;return!1}
function Qa(a){if("string"===typeof a.m)return a.m;var b=a.g.location.protocol;"about:"==b&&(b=a.h.location.protocol);return"https:"==b?"https:":"http:"}function ga(a){return a.g.location.hostname||a.h.location.hostname}
function Ra(a,b,c,e){function d(){C&&p&&G&&(C(H),C=null)}function f(a){for(var c=0;c<m.length;c++)if(m[c].href&&-1!==m[c].href.indexOf(b)){a();return}setTimeout(function(){f(a)},0)}function g(a){for(var c=0;c<m.length;c++)if(m[c].href&&-1!==m[c].href.indexOf(b)&&m[c].media){var d=m[c].media;if("all"===d||d.mediaText&&"all"===d.mediaText){a();return}}setTimeout(function(){g(a)},0)}var l=La(a,"link",{rel:"stylesheet",href:b,media:e?"only x":"all"}),m=a.b.styleSheets,p=!1,G=!e,H=null,C=c||null;Ka?(l.onload=
function(){p=!0;d()},l.onerror=function(){p=!0;H=Error("Stylesheet failed to load");d()}):setTimeout(function(){p=!0;d()},0);Ma(a,"head",l);e&&f(function(){l.media="all";g(function(){G=!0;d()})})}
function Sa(a,b,c){var e=a.b.getElementsByTagName("head")[0];if(e){var d=La(a,"script",{src:b}),f=!1;d.onload=d.onreadystatechange=function(){f||this.readyState&&"loaded"!=this.readyState&&"complete"!=this.readyState||(f=!0,c&&c(null),d.onload=d.onreadystatechange=null,"HEAD"==d.parentNode.tagName&&e.removeChild(d))};e.appendChild(d);setTimeout(function(){f||(f=!0,c&&c(Error("Script load timeout")))},5E3)}};function Ta(a,b){this.b=a;this.h=a.g.document.documentElement;this.u=b;this.g=new Ja("-");this.w=!1!==b.events;this.m=!1!==b.classes}function Ua(a){if(a.m){var b=Pa(a.h,a.g.s("wf","active")),c=[],e=[a.g.s("wf","loading")];b||c.push(a.g.s("wf","inactive"));P(a.h,c,e)}Q(a,"inactive")}function Q(a,b,c){if(a.w&&a.u[b])if(c)a.u[b](c.getName(),R(c));else a.u[b]()};function S(a,b){this.h=a;this.g=4;this.b="n";var c=(b||"n4").match(/^([nio])([1-9])$/i);c&&(this.b=c[1],this.g=parseInt(c[2],10))}S.prototype.getName=function(){return this.h};function Va(a){return Wa(a)+" "+(a.g+"00")+" 300px "+Xa(a.h)}function Xa(a){var b=[];a=a.split(/,\s*/);for(var c=0;c<a.length;c++){var e=a[c].replace(/['"]/g,"");-1!=e.indexOf(" ")||/^\d/.test(e)?b.push("'"+e+"'"):b.push(e)}return b.join(",")}function R(a){return a.b+a.g}
function Wa(a){var b="normal";"o"===a.b?b="oblique":"i"===a.b&&(b="italic");return b};function Ya(a,b){this.b=a;this.m=b;this.h={};this.g={}}Ya.prototype.G=function(a){return a?(this.h[a]||this.m).slice(0):this.m.slice(0)};function Za(a,b,c){for(var e=[],d=a.b.split(",")[0].replace(/"|'/g,""),f=a.G(),g,l=[],m={},p=0;p<f.length;p++)g=f[p],0<g.length&&!m[g]&&(m[g]=!0,l.push(g));c=c.b?c.b(d,l,e):l;a.h[b]=c;a.g[b]=e}
function $a(a,b){for(var c=a.G(b),e=a.g[b]||[],d=[],f=0;f<c.length;f++)d.push(new S(a.b,c[f]));for(f=0;f<e.length;f++)if(c=e[f].b,c!==a.b)for(var g=e[f].G(),l=0;l<g.length;l++)d.push(new S(c,g[l]));return d};function ab(a,b){this.b=a;this.h=b;this.g=La(this.b,"span",{"aria-hidden":"true"},this.h)}function cb(a){Ma(a.b,"body",a.g)}function db(a){return"display:block;position:absolute;top:-9999px;left:-9999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;white-space:nowrap;font-family:"+Xa(a.h)+";"+("font-style:"+Wa(a)+";font-weight:"+(a.g+"00")+";")};function eb(a,b,c,e,d,f,g){this.H=a;this.L=b;this.b=c;this.g=e;this.C=g||"BESbswy";this.h={};this.S=d||3E3;this.J=f||null;this.A=this.w=this.u=this.m=null;this.m=new ab(this.b,this.C);this.u=new ab(this.b,this.C);this.w=new ab(this.b,this.C);this.A=new ab(this.b,this.C);a=new S(this.g.getName()+",serif",R(this.g));a=db(a);this.m.g.style.cssText=a;a=new S(this.g.getName()+",sans-serif",R(this.g));a=db(a);this.u.g.style.cssText=a;a=new S("serif",R(this.g));a=db(a);this.w.g.style.cssText=a;a=new S("sans-serif",
R(this.g));a=db(a);this.A.g.style.cssText=a;cb(this.m);cb(this.u);cb(this.w);cb(this.A)}var fb={Y:"serif",X:"sans-serif"},gb=null;function hb(){if(null===gb){var a=/AppleWebKit\/([0-9]+)(?:\.([0-9]+))/.exec(window.navigator.userAgent);gb=!!a&&(536>parseInt(a[1],10)||536===parseInt(a[1],10)&&11>=parseInt(a[2],10))}return gb}eb.prototype.start=function(){this.h.serif=this.w.g.offsetWidth;this.h["sans-serif"]=this.A.g.offsetWidth;this.K=k();ib(this)};
function jb(a,b,c){for(var e in fb)if(fb.hasOwnProperty(e)&&b===a.h[fb[e]]&&c===a.h[fb[e]])return!0;return!1}function ib(a){var b=a.m.g.offsetWidth,c=a.u.g.offsetWidth,e;(e=b===a.h.serif&&c===a.h["sans-serif"])||(e=hb()&&jb(a,b,c));e?k()-a.K>=a.S?hb()&&jb(a,b,c)&&(null===a.J||a.J.hasOwnProperty(a.g.getName()))?kb(a,a.H):kb(a,a.L):lb(a):kb(a,a.H)}function lb(a){setTimeout(h(function(){ib(this)},a),50)}
function kb(a,b){setTimeout(h(function(){Oa(this.m.g);Oa(this.u.g);Oa(this.w.g);Oa(this.A.g);b(this.g)},a),0)};function mb(a,b,c,e,d,f){this.m=a;this.w=b;this.g=e;this.b=c;this.h=d||3E3;this.u=f||void 0}mb.prototype.start=function(){var a=this.b.g.document,b=this,c=k(),e=new Promise(function(d,e){function l(){k()-c>=b.h?e():a.fonts.load(Va(b.g),b.u).then(function(a){1<=a.length?d():setTimeout(l,25)},function(){e()})}l()}),d=new Promise(function(a,c){setTimeout(c,b.h)});Promise.race([d,e]).then(function(){b.m(b.g)},function(){b.w(b.g)})};function nb(a,b,c){this.b=a;this.g=b;this.h=0;this.A=this.w=!1;this.C=c}var ob=null;nb.prototype.m=function(a){var b=this.g;b.m&&P(b.h,[b.g.s("wf",a.getName(),R(a).toString(),"active")],[b.g.s("wf",a.getName(),R(a).toString(),"loading"),b.g.s("wf",a.getName(),R(a).toString(),"inactive")]);Q(b,"fontactive",a);this.A=!0;pb(this)};
nb.prototype.u=function(a){var b=this.g;if(b.m){var c=Pa(b.h,b.g.s("wf",a.getName(),R(a).toString(),"active")),e=[],d=[b.g.s("wf",a.getName(),R(a).toString(),"loading")];c||e.push(b.g.s("wf",a.getName(),R(a).toString(),"inactive"));P(b.h,e,d)}Q(b,"fontinactive",a);pb(this)};function pb(a){0==--a.h&&a.w&&(a.A?(a=a.g,a.m&&P(a.h,[a.g.s("wf","active")],[a.g.s("wf","loading"),a.g.s("wf","inactive")]),Q(a,"active")):Ua(a.g))};function qb(a,b){this.m=a;this.b=b;this.g=[]}qb.prototype.h=function(a){this.g.push(a)};qb.prototype.load=function(a,b){var c=a,e=b||{};"string"==typeof c?c=[c]:c&&c.length||(e=c||{},c=[]);if(c.length)for(var d=this,f=c.length,g=0;g<c.length;g++)rb(this,c[g],function(){0===--f&&sb(d,e)});else sb(this,e)};function rb(a,b,c){b=a.m.s({id:encodeURIComponent(b)});Sa(a.b,b,c)}
function sb(a,b){if(0!==a.g.length){for(var c=new Ta(a.b,b),e=!1,d=0;d<a.g.length;d++)a.g[d].init(),e=e||a.g[d].supportsConfiguredBrowser();if(e)for(c.m&&P(c.h,[c.g.s("wf","loading")]),Q(c,"loading"),c=0;c<a.g.length;c++)e=a.g[c],e.supportsConfiguredBrowser()&&e.load(null,c==a.g.length-1,b);else Ua(c);a.g=[]}};function tb(){this.g=0;this.b=null}function ub(a){a.g++;return function(){a.g--;vb(a)}}function wb(a,b){a.b=b;vb(a)}function vb(a){0==a.g&&a.b&&(a.b(),a.b=null)};function xb(a,b){this.b=b||Array(Math.ceil(a/32));if(!b)for(var c=0;c<this.b.length;c++)this.b[c]=0};function T(a,b){return(a&65535)*b+(((a>>>16)*b&65535)<<16)};function yb(a,b,c){this.b=a;this.h=b;this.g=new xb(a,c)}var zb=[2449897292,4218179547,2675077685,1031960064,1478620578,1386343184,3194259988,2656050674,3012733295,2193273665];
function Ab(a,b){if("string"!==typeof b&&"number"!==typeof b)throw Error("Value should be a string or number.");for(var c="number"===typeof b,e=0;e<a.h;e++){var d=0;if(c)var d=zb[e]||0,f=b&4294967295,f=T(f,3432918353),f=f<<15|f>>>17,f=T(f,461845907),d=d^f,d=d<<13|d>>>19,d=T(d,5)+3864292196,d=d^4;else{for(var d=zb[e]||0,g=f=0,l=b.length%4,m=b.length-l,g=0;g<m;g+=4)f=(b.charCodeAt(g+0)&4294967295)<<0|(b.charCodeAt(g+1)&4294967295)<<8|(b.charCodeAt(g+2)&4294967295)<<16|(b.charCodeAt(g+3)&4294967295)<<
24,f=T(f,3432918353),f=f<<15|f>>>17,f=T(f,461845907),d^=f,d=d<<13|d>>>19,d=T(d,5)+3864292196;f=0;switch(l){case 3:f^=(b.charCodeAt(g+2)&4294967295)<<16;case 2:f^=(b.charCodeAt(g+1)&4294967295)<<8;case 1:f^=(b.charCodeAt(g+0)&4294967295)<<0,f=T(f,3432918353),f=f<<15|f>>>17,f=T(f,461845907),d^=f}d^=b.length}d^=d>>>16;d=T(d,2246822507);d^=d>>>13;d=T(d,3266489909);d^=d>>>16;d=(d>>>0)%a.b;f=a.g;if(Math.floor(d/32+1)>f.b.length)throw Error("Index is out of bounds.");g=Math.floor(d/32);if(!(f.b[g]&1<<d-
32*g))return!1}return!0};function Bb(){var a;a=Cb;if(window.atob)a=window.atob(a);else{a=a.replace(/=+$/,"");if(1==a.length%4)throw Error("'atob' failed: The string to be decoded is not correctly encoded.");for(var b=0,c,e,d=0,f="";e=a.charAt(d++);~e&&(c=b%4?64*c+e:e,b++%4)?f+=String.fromCharCode(255&c>>(-2*b&6)):0)e="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(e);a=f}c=[];for(b=0;b<a.length;b+=4)c.push(a.charCodeAt(b)<<24|a.charCodeAt(b+1)<<16|a.charCodeAt(b+2)<<8|a.charCodeAt(b+3)<<0);a=c.shift();
b=c.shift();this.b=new yb(a,b,c)}function Db(a,b){if(""===b)return!0;for(var c=b.split(".");0!==c.length;){var e=c.join("."),d="*."+e;if(Ab(a.b,e)||Ab(a.b,d)||Ab(a.b,encodeURIComponent(e))||Ab(a.b,encodeURIComponent(d)))return!0;c.shift()}return!1};function Eb(a){this.b=a;this.g="x";this.A=this.L=null;this.h=[];this.m=[];this.H=this.J=this.u=null;this.C=!1;this.w=null}Eb.prototype.supportsConfiguredBrowser=function(){return"x"!==this.g};Eb.prototype.init=function(){if(0<this.m.length){for(var a=[],b=0;b<this.m.length;b++)a.push(ea(this.m[b]));var b=this.b,a=a.join(""),c=La(this.b,"style");c.setAttribute("type","text/css");c.styleSheet?c.styleSheet.cssText=a:c.appendChild(document.createTextNode(a));Ma(b,"head",c)}};
Eb.prototype.load=function(a,b,c){function e(){}var d=this,f=c||{},g=f.contextPath||".",l=f.hostname||this.J;a=f.timeout;c=!!f.async;var m=!1!==f.events,p=null,G=new la,H=new la,C=new tb;f.active&&(e=f.active);f.active=function(){H.b=(new Date).getTime();if(d.K){var a=d.K,b=-1!==G.g&&-1!==G.b?G.b-G.g:-1,c=-1!==H.g&&-1!==H.b?H.b-H.g:-1,f=new oa("//p.typekit.net/p.gif?s={service}&k={token}&app={app}&ht={hosting}&h={host}&f={variations}&a={account}&sl={stylesheetLoadTime}&fl={fontLoadTime}&js={version}&_={_}"),
g=encodeURIComponent((window.__adobewebfontsappname__||a.app||"").toString().substr(0,20)),l=encodeURIComponent(ga(d.b)),r=[],m=[];window.Typekit.fonts||(window.Typekit.fonts=[]);for(var m=window.Typekit.fonts,p=0;p<a.b.length;p++){for(var v=!1,C=0;C<m.length;C++)if(a.b[p]===m[C]){v=!0;break}v||(r.push(a.b[p]),m.push(a.b[p]))}r.length&&qa(f.s({service:a.m,token:a.u,app:g,hosting:a.h,host:l,variations:r.join("."),account:a.g,stylesheetLoadTime:b,fontLoadTime:c,version:a.version,_:(+new Date).toString()}))}e()};
p=new Ta(this.b,f);if(null!==this.w&&(f=location.hostname,!Db(this.w,f))){console.error('Typekit: the domain "'+f+'" isn\'t in the list of allowed domains for kit "'+this.H+'".');Ua(p);return}if(this.g){for(var f=na[this.g]||new ja(ka),v=0;v<this.h.length;v++)Za(this.h[v],this.g,f);this.u&&(f=ma(this.b,this.g,this.h),f=pa(this.g,f),f.contextPath=g,l&&(f.hostname=l),g=this.u.s(f,this.C?"https:"!==Qa(this.b):!1),G.start(),Ra(this.b,g,ub(C),c));if(m){for(var X=[],bb={},r=new nb(this.b,p,a),v=0;v<this.h.length;v++)X=
X.concat($a(this.h[v],this.g));for(v=0;v<X.length;v++)bb[X[v].getName()]="BESbswy\ue000\ue001\ue002\ue003\ue004\ue005\ue006";wb(C,function(){G.b=(new Date).getTime();H.start();Na(d.b,function(){var a=X,c={},d=bb||{};if(0===a.length&&b)Ua(r.g);else{r.h+=a.length;b&&(r.w=b);var e,f=[];for(e=0;e<a.length;e++){var g=a[e],l=d[g.getName()],m=r.g,p=g;m.m&&P(m.h,[m.g.s("wf",p.getName(),R(p).toString(),"loading")]);Q(m,"fontloading",p);m=null;null===ob&&(ob=window.FontFace?(p=/Gecko.*Firefox\/(\d+)/.exec(window.navigator.userAgent))?
42<parseInt(p[1],10):!0:!1);ob?m=new mb(h(r.m,r),h(r.u,r),r.b,g,r.C,l):m=new eb(h(r.m,r),h(r.u,r),r.b,g,r.C,c,l);f.push(m)}for(e=0;e<f.length;e++)f[e].start()}})})}}};var Fb,N=new function(){var a=document;this.b=navigator.userAgent;this.g=a},Gb;
if(-1!=N.b.indexOf("MSIE")||-1!=N.b.indexOf("Trident/")){var U=N,Hb=K(U),Ib=B(M(U)),Jb=null,Kb=null,Lb=null,Mb=L(U.b,/Trident\/([\d\w\.]+)/,1),Nb=O(U.g),Jb=-1!=U.b.indexOf("MSIE")?B(L(U.b,/MSIE ([\d\w\.]+)/,1)):B(L(U.b,/rv:([\d\w\.]+)/,1));""!==Mb?(Kb="Trident",Lb=B(Mb)):(Kb="Unknown",Lb=new x);Gb=new w("MSIE",Jb,Kb,Lb,Hb,Ib,Nb)}else{var Ob;if(-1!=N.b.indexOf("Edge/")){var Pb=N,Qb=K(Pb),Rb=B(M(Pb)),Sb=B(L(Pb.b,/Edge\/([\d\w\.]+)/,1));Ob=new w("Edge",Sb,"Edge",Sb,Qb,Rb,O(Pb.g))}else{var Tb;if(-1!=
N.b.indexOf("Opera"))Tb=Ha();else{var Ub;if(/OPR\/[\d.]+/.test(N.b))Ub=Ia();else{var Vb;if(/AppleWeb(K|k)it/.test(N.b))Vb=Ia();else{var Wb;if(-1!=N.b.indexOf("Gecko")){var V=N,Xb="Unknown",Yb=new x,Zb=B(M(V));-1!=V.b.indexOf("Firefox")?(Xb="Firefox",Yb=B(L(V.b,/Firefox\/([\d\w\.]+)/,1))):-1!=V.b.indexOf("Mozilla")&&(Xb="Mozilla");var $b=B(L(V.b,/rv:([^\)]+)/,1));Wb=new w(Xb,Yb,"Gecko",$b,K(V),Zb,O(V.g))}else Wb=Ga;Vb=Wb}Ub=Vb}Tb=Ub}Ob=Tb}Gb=Ob}Fb=Gb;
var ac=new function(){var a=window;this.g=this.h=a;this.b=this.g.document};window.Typekit||(window.Typekit={});if(!window.Typekit.load){var bc=window.Typekit.config||{},cc=null;bc.k&&(cc=new oa(bc.k));var dc=new qb(cc,ac);window.Typekit.load=function(){dc.load.apply(dc,arguments)};window.Typekit.addKit=function(){dc.h.apply(dc,arguments)}}var ec,W,Y,n=window.Typekit.config||{};Y=new Eb(ac);
Y.K=new function(){var a=n.ht,b=n.fi,c=n.a,e=n.kt,d=n.js,f=n.l;this.m=n.ps;this.h=a;this.b=b||[];this.g=c||null;this.u=e||null;this.version=d||null;this.app=f||null};W=new ca;W.O=!n.si;W.N=!n.st;W.I=!n.sa;W.R=!n.sw;W.P=!n.sb;Y.A=W;if(n.dl){var Cb=n.dl;try{Y.w=new Bb}catch(a){}}n.kt&&(Y.H=n.kt);n.ds&&(Y.C=n.ds);n.f&&(ec=new oa(n.f),Y.u=ec);n.hn&&(Y.J=n.hn);var q;if(n.fn)for(q=0;q<n.fn.length;q+=2)Y.h.push(new Ya(n.fn[q],n.fn[q+1]));if(n.c)for(q=0;q<n.c.length;q+=2)Y.m.push(new da);Y.L=Fb;var fc;
a:{var gc=Y.L,hc=new ca,ic=Y.A||hc,jc;for(jc in t){var Z=t[jc];if(Fa[Z]&&Fa[Z](gc,ic)){fc=Z;break a}}for(jc in t)if(Z=t[jc],Fa[Z]&&Fa[Z](gc,hc)){fc="x";break a}fc="k"}Y.g=fc;window.Typekit.addKit(Y);if(window.WebFont)try{window.Typekit.load()}catch(a){};}(this,document));
