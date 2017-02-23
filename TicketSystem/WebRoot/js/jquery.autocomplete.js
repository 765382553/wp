(function(a) {
	a.fn.extend({
		autocomplete : function(b, c) {
			var d = typeof b == "string";
			c = a.extend({}, a.Autocompleter.defaults, {
				url : d ? b : null,
				data : d ? null : b,
				delay : d ? a.Autocompleter.defaults.delay : 10,
				max : c && !c.scroll ? 10 : 150
			}, c);
			c.highlight = c.highlight || function(e) {
				return e
			};
			c.formatMatch = c.formatMatch || c.formatItem;
			return this.each(function() {
				new a.Autocompleter(this, c)
			})
		},
		result : function(b) {
			return this.bind("result", b)
		},
		search : function(b) {
			return this.trigger("search", [ b ])
		},
		flushCache : function() {
			return this.trigger("flushCache")
		},
		setOptions : function(b) {
			return this.trigger("setOptions", [ b ])
		},
		unautocomplete : function() {
			return this.trigger("unautocomplete")
		}
	});
	a.Autocompleter = function(l, g) {
		var c = {
			UP : 38,
			DOWN : 40,
			DEL : 46,
			TAB : 9,
			RETURN : 13,
			ESC : 27,
			COMMA : 188,
			PAGEUP : 33,
			PAGEDOWN : 34,
			BACKSPACE : 8
		};
		var b = a(l).attr("autocomplete", "off").addClass(g.inputClass);
		var j;
		var p = "";
		var m = a.Autocompleter.Cache(g);
		var e = 0;
		var u;
		var x = {
			mouseDownOnSelect : false
		};
		var r = a.Autocompleter.Select(g, l, d, x);
		var w;
		/*a.browser.opera && */a(l.form).bind("submit.autocomplete", function() {
			if (w) {
				w = false;
				return false
			}
		});
		b.bind(
				(a.browser/*.opera*/ ? "keypress" : "keydown") + ".autocomplete",
				function(y) {
					e = 1;
					u = y.keyCode;
					switch (y.keyCode) {
					case c.UP:
						y.preventDefault();
						if (r.visible()) {
							r.prev()
						} else {
							t(0, true)
						}
						break;
					case c.DOWN:
						y.preventDefault();
						if (r.visible()) {
							r.next()
						} else {
							t(0, true)
						}
						break;
					case c.PAGEUP:
						y.preventDefault();
						if (r.visible()) {
							r.pageUp()
						} else {
							t(0, true)
						}
						break;
					case c.PAGEDOWN:
						y.preventDefault();
						if (r.visible()) {
							r.pageDown()
						} else {
							t(0, true)
						}
						break;
					case g.multiple && a.trim(g.multipleSeparator) == ","
							&& c.COMMA:
					case c.TAB:
					case c.RETURN:
						if (d()) {
							y.preventDefault();
							w = true;
							return false
						}
						break;
					case c.ESC:
						r.hide();
						break;
					default:
						clearTimeout(j);
						j = setTimeout(t, g.delay);
						break
					}
				}).focus(function() {
			e++
		}).blur(function() {
			e = 0;
			if (!x.mouseDownOnSelect) {
				s()
			}
		}).click(function() {
			if (e++ > 1 && !r.visible()) {
				t(0, true)
			}
		}).bind("search", function() {
			var y = (arguments.length > 1) ? arguments[1] : null;
			function z(D, C) {
				var A;
				if (C && C.length) {
					for (var B = 0; B < C.length; B++) {
						if (C[B].result.toLowerCase() == D.toLowerCase()) {
							A = C[B];
							break
						}
					}
				}
				if (typeof y == "function") {
					y(A)
				} else {
					b.trigger("result", A && [ A.data, A.value ])
				}
			}
			a.each(h(b.val()), function(A, B) {
				f(B, z, z)
			})
		}).bind("flushCache", function() {
			m.flush()
		}).bind("setOptions", function() {
			a.extend(g, arguments[1]);
			if ("data" in arguments[1]) {
				m.populate()
			}
		}).bind("unautocomplete", function() {
			r.unbind();
			b.unbind();
			a(l.form).unbind(".autocomplete")
		});
		function d() {
			var B = r.selected();
			if (!B) {
				return false
			}
			var y = B.result;
			p = y;
			if (g.multiple) {
				var E = h(b.val());
				if (E.length > 1) {
					var A = g.multipleSeparator.length;
					var D = a(l).selection().start;
					var C, z = 0;
					a.each(E, function(F, G) {
						z += G.length;
						if (D <= z) {
							C = F;
							return false
						}
						z += A
					});
					E[C] = y;
					y = E.join(g.multipleSeparator)
				}
				y += g.multipleSeparator
			}
			b.val(y);
			v();
			b.trigger("result", [ B.data, B.value ]);
			return true
		}
		b.bind("input", function() {
			t(0, true)
		});
		function t(A, z) {
			if (u == c.DEL) {
				r.hide();
				return
			}
			var y = b.val();
			if (!z && y == p) {
				return
			}
			p = y;
			y = i(y);
			if (y.length >= g.minChars) {
				b.addClass(g.loadingClass);
				if (!g.matchCase) {
					y = y.toLowerCase()
				}
				f(y, k, v)
			} else {
				n();
				r.hide()
			}
		}
		function h(y) {
			if (!y) {
				return [ "" ]
			}
			if (!g.multiple) {
				return [ a.trim(y) ]
			}
			return a.map(y.split(g.multipleSeparator), function(z) {
				return a.trim(y).length ? a.trim(z) : null
			})
		}
		function i(y) {
			if (!g.multiple) {
				return y
			}
			var A = h(y);
			if (A.length == 1) {
				return A[0]
			}
			var z = a(l).selection().start;
			if (z == y.length) {
				A = h(y)
			} else {
				A = h(y.replace(y.substring(z), ""))
			}
			return A[A.length - 1]
		}
		function q(y, z) {
			if (g.autoFill && (i(b.val()).toLowerCase() == y.toLowerCase())
					&& u != c.BACKSPACE) {
				b.val(b.val() + z.substring(i(p).length));
				a(l).selection(p.length, p.length + z.length)
			}
		}
		function s() {
			clearTimeout(j);
			j = setTimeout(v, 200)
		}
		function v() {
			var y = r.visible();
			r.hide();
			clearTimeout(j);
			n();
			if (g.mustMatch) {
				b.search(function(z) {
					if (!z) {
						if (g.multiple) {
							var A = h(b.val()).slice(0, -1);
							b.val(A.join(g.multipleSeparator)
									+ (A.length ? g.multipleSeparator : ""))
						} else {
							b.val("");
							b.trigger("result", null)
						}
					}
				})
			}
		}
		function k(z, y) {
			if (y && y.length && e) {
				n();
				r.display(y, z);
				q(z, y[0].value);
				r.show()
			} else {
				v()
			}
		}
		function f(z, B, y) {
			if (!g.matchCase) {
				z = z.toLowerCase()
			}
			var A = m.load(z);
			if (A && A.length) {
				B(z, A)
			} else {
				if ((typeof g.url == "string") && (g.url.length > 0)) {
					var C = {
						timestamp : +new Date()
					};
					a.each(g.extraParams, function(D, E) {
						C[D] = typeof E == "function" ? E() : E
					});
					a.ajax({
						mode : "abort",
						port : "autocomplete" + l.name,
						dataType : g.dataType,
						url : g.url,
						data : a.extend({
							q : i(z),
							limit : g.max
						}, C),
						success : function(E) {
							var D = g.parse && g.parse(E) || o(E);
							m.add(z, D);
							B(z, D)
						}
					})
				} else {
					r.emptyList();
					y(z)
				}
			}
		}
		function o(B) {
			var y = [];
			var A = B.split("\n");
			for (var z = 0; z < A.length; z++) {
				var C = a.trim(A[z]);
				if (C) {
					C = C.split("|");
					y[y.length] = {
						data : C,
						value : C[0],
						result : g.formatResult && g.formatResult(C, C[0])
								|| C[0]
					}
				}
			}
			return y
		}
		function n() {
			b.removeClass(g.loadingClass)
		}
	};
	a.Autocompleter.defaults = {
		inputClass : "ac_input",
		resultsClass : "ac_results",
		loadingClass : "ac_loading",
		minChars : 1,
		delay : 400,
		matchCase : false,
		matchSubset : true,
		matchContains : false,
		cacheLength : 10,
		max : 100,
		mustMatch : false,
		extraParams : {},
		selectFirst : true,
		formatItem : function(b) {
			return b[0]
		},
		formatMatch : null,
		autoFill : false,
		width : 0,
		top : 0,
		multiple : false,
		multipleSeparator : ", ",
		highlight : function(c, b) {
			return c.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)("
					+ b.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1")
					+ ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>")
		},
		scroll : true,
		scrollHeight : 180
	};
	a.Autocompleter.Cache = function(c) {
		var f = {};
		var d = 0;
		function h(l, k) {
			if (!c.matchCase) {
				l = l.toLowerCase()
			}
			var j = l.indexOf(k);
			if (c.matchContains == "word") {
				j = l.toLowerCase().search("\\b" + k.toLowerCase())
			}
			if (j == -1) {
				return false
			}
			return j == 0 || c.matchContains
		}
		function g(j, i) {
			if (d > c.cacheLength) {
				b()
			}
			if (!f[j]) {
				d++
			}
			f[j] = i
		}
		function e() {
			if (!c.data) {
				return false
			}
			var k = {}, j = 0;
			if (!c.url) {
				c.cacheLength = 1
			}
			k[""] = [];
			for (var m = 0, l = c.data.length; m < l; m++) {
				var p = c.data[m];
				p = (typeof p == "string") ? [ p ] : p;
				var o = c.formatMatch(p, m + 1, c.data.length);
				if (o === false) {
					continue
				}
				var n = o.charAt(0).toLowerCase();
				if (!k[n]) {
					k[n] = []
				}
				var q = {
					value : o,
					data : p,
					result : c.formatResult && c.formatResult(p) || o
				};
				k[n].push(q);
				if (j++ < c.max) {
					k[""].push(q)
				}
			}
			a.each(k, function(r, s) {
				c.cacheLength++;
				g(r, s)
			})
		}
		setTimeout(e, 25);
		function b() {
			f = {};
			d = 0
		}
		return {
			flush : b,
			add : g,
			populate : e,
			load : function(n) {
				if (!c.cacheLength || !d) {
					return null
				}
				if (!c.url && c.matchContains) {
					var m = [];
					for ( var j in f) {
						if (j.length > 0) {
							var o = f[j];
							a.each(o, function(p, k) {
								if (h(k.value, n)) {
									m.push(k)
								}
							})
						}
					}
					return m
				} else {
					if (f[n]) {
						return f[n]
					} else {
						if (c.matchSubset) {
							for (var l = n.length - 1; l >= c.minChars; l--) {
								var o = f[n.substr(0, l)];
								if (o) {
									var m = [];
									a.each(o, function(p, k) {
										if (h(k.value, n)) {
											m[m.length] = k
										}
									});
									return m
								}
							}
						}
					}
				}
				return null
			}
		}
	};
	a.Autocompleter.Select = function(e, j, l, p) {
		var i = {
			ACTIVE : "ac_over"
		};
		var k, f = -1, r, m = "", s = true, c, o;
		function n() {
			if (!s) {
				return
			}
			c = a("<div/>").hide().addClass(e.resultsClass).css("position",
					"absolute").appendTo(document.body);
			o = a("<ul/>").appendTo(c).mouseover(function(t) {
				if (q(t).nodeName && q(t).nodeName.toUpperCase() == "LI") {
					f = a("li", o).removeClass(i.ACTIVE).index(q(t));
					a(q(t)).addClass(i.ACTIVE)
				}
			}).click(function(t) {
				a(q(t)).addClass(i.ACTIVE);
				l();
				j.focus();
				return false
			}).mousedown(function() {
				p.mouseDownOnSelect = true
			}).mouseup(function() {
				p.mouseDownOnSelect = false
			});
			if (e.width > 0) {
				c.css("width", e.width)
			}
			s = false
		}
		function q(u) {
			var t = u.target;
			while (t && t.tagName != "LI") {
				t = t.parentNode
			}
			if (!t) {
				return []
			}
			return t
		}
		function h(t) {
			k.slice(f, f + 1).removeClass(i.ACTIVE);
			g(t);
			var v = k.slice(f, f + 1).addClass(i.ACTIVE);
			if (e.scroll) {
				var u = 0;
				k.slice(0, f).each(function() {
					u += this.offsetHeight
				});
				if ((u + v[0].offsetHeight - o.scrollTop()) > o[0].clientHeight) {
					o.scrollTop(u + v[0].offsetHeight - o.innerHeight())
				} else {
					if (u < o.scrollTop()) {
						o.scrollTop(u)
					}
				}
			}
		}
		function g(t) {
			f += t;
			if (f < 0) {
				f = k.size() - 1
			} else {
				if (f >= k.size()) {
					f = 0
				}
			}
		}
		function b(t) {
			return e.max && e.max < t ? e.max : t
		}
		function d() {
			o.empty();
			var u = b(r.length);
			for (var v = 0; v < u; v++) {
				if (!r[v]) {
					continue
				}
				var w = e.formatItem(r[v].data, v + 1, u, r[v].value, m);
				if (w === false) {
					continue
				}
				var t = a("<li/>").html(e.highlight(w, m)).addClass(
						v % 2 == 0 ? "ac_even" : "ac_odd").appendTo(o)[0];
				a.data(t, "ac_data", r[v])
			}
			k = o.find("li");
			if (e.selectFirst) {
				k.slice(0, 1).addClass(i.ACTIVE);
				f = 0
			}
			if (a.fn.bgiframe) {
				o.bgiframe()
			}
		}
		return {
			display : function(u, t) {
				n();
				r = u;
				m = t;
				d()
			},
			next : function() {
				h(1)
			},
			prev : function() {
				h(-1)
			},
			pageUp : function() {
				if (f != 0 && f - 8 < 0) {
					h(-f)
				} else {
					h(-8)
				}
			},
			pageDown : function() {
				if (f != k.size() - 1 && f + 8 > k.size()) {
					h(k.size() - 1 - f)
				} else {
					h(8)
				}
			},
			hide : function() {
				c && c.hide();
				k && k.removeClass(i.ACTIVE);
				f = -1
			},
			visible : function() {
				return c && c.is(":visible")
			},
			current : function() {
				return this.visible()
						&& (k.filter("." + i.ACTIVE)[0] || e.selectFirst
								&& k[0])
			},
			show : function() {
				var v = a(j).offset();
				c
						.css(
								{
									width : typeof e.width == "string"
											|| e.width > 0 ? e.width : a(j)
											.width(),
									top : typeof e.top == "string" || e.top > 0 ? e.top
											: v.top + j.offsetHeight,
									left : v.left
											+ (typeof e.left != "undefined" ? parseInt(e.left)
													: 0)
								}).show();
				if (e.scroll) {
					o.scrollTop(0);
					o.css({
						maxHeight : e.scrollHeight,
						overflow : "auto"
					});
					if (a.browser/*.msie*/
							&& typeof document.body.style.maxHeight === "undefined") {
						var t = 0;
						k.each(function() {
							t += this.offsetHeight
						});
						var u = t > e.scrollHeight;
						o.css("height", u ? e.scrollHeight : t);
						if (!u) {
							k.width(o.width() - parseInt(k.css("padding-left"))
									- parseInt(k.css("padding-right")))
						}
					}
				}
			},
			selected : function() {
				var t = k && k.filter("." + i.ACTIVE).removeClass(i.ACTIVE);
				return t && t.length && a.data(t[0], "ac_data")
			},
			emptyList : function() {
				o && o.empty()
			},
			unbind : function() {
				c && c.remove()
			}
		}
	};
	a.fn.selection = function(i, b) {
		if (i !== undefined) {
			return this.each(function() {
				if (this.createTextRange) {
					var j = this.createTextRange();
					if (b === undefined || i == b) {
						j.move("character", i);
						j.select()
					} else {
						j.collapse(true);
						j.moveStart("character", i);
						j.moveEnd("character", b);
						j.select()
					}
				} else {
					if (this.setSelectionRange) {
						this.setSelectionRange(i, b)
					} else {
						if (this.selectionStart) {
							this.selectionStart = i;
							this.selectionEnd = b
						}
					}
				}
			})
		}
		var g = this[0];
		if (g.createTextRange) {
			var c = document.selection.createRange(), h = g.value, f = "<->", d = c.text.length;
			c.text = f;
			var e = g.value.indexOf(f);
			g.value = h;
			this.selection(e, e + d);
			return {
				start : e,
				end : e + d
			}
		} else {
			if (g.selectionStart !== undefined) {
				return {
					start : g.selectionStart,
					end : g.selectionEnd
				}
			}
		}
	}
})(jQuery);
