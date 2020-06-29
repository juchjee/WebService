
var Slide;
(function() {
	//img, btn, arrow
	var SlideContents = function(obj,func) {
		var c_idx = 0;
		var p_idx = 0;
		var _imgWrap;
		var _imgList;
		var total;
		var _toggle;
		var _arrow;
		var _type;
		var _duration = 400;
		var _vertical;
		var _auto;
		var _speed = 5000;
		var rollTimeId = null;
		var _autoBool = false;
		var _end = 'loop';
		var _arrowNext;
		var _arrowPrev;
		var result = {
			wrap : obj.slideArea,
			next : obj.nextBtn,
			prev : obj.prevBtn,
			type : obj.type,
			duration : obj.duration,
			vertical : obj.vertical,
			end:obj.end,
			auto : obj.auto,
			speed : obj.speed,
			init : init,
			arrowControl:arrowControl,
			reset : reset,
			func : func
		};
		result.init();
		return result;

		function init() {

			_wrap = result.wrap;

			_type = result.type;
			if (result._duration) {
				_duration = result._duration;
			}
			_vertical = result.vertical;
			if (result.auto) {
				_autoBool = result.auto;
			}
			if (result.end) {
				_end = result.end;
			}
			if (result.speed) {
				_speed = result.speed;
			}
			_imgWrap = _wrap.find('ul');
			_imgList = _imgWrap.find('>li');
			total = _imgList.size();

			/* 141104 개발에서 추가 */
			/* 슬라이드 영역이나 내용이 1개 또는 없을경우 */
			if(total <= 1){

				/* 내용이 1개일경우 동그라미 삭제 */
				if(total == 1)
					_imgList.children("a.btn_rolling").remove();

				/* 내용이 1개또는 없을 경우 플레이|일시정지 영역 삭제 */
				//_imgWrap.siblings("span.btn").remove();
				//개발자에 따라서 내용이 0개일경우 ul 조차 생성하지 않을 경우가있습니다. 아래로 내용 변경합니다.
				_wrap.children("span.btn").remove();

				return;
			}
			/* // 141104 개발에서 추가 */

			if (_imgList.children().is('.panel')) {
				_img = _imgList.find('.panel');

			} else {
				_img = _imgList;
			}
			_btn = _imgList.find('.btn_rolling');
			_toggle = _wrap.find('>.btn .stop');

			_arrowNext = _wrap.find('.next');
			_arrowPrev = _wrap.find('.prev');

			// _btn =result.btn.find('>button');
			// _arrow = result.arrow;
			gallerySetting();
			addEvnet();

			if (_autoBool) {
				startTimer();
				_toggle.addClass('on');
				_toggle.removeClass('play');
				_toggle.addClass('stop');
				_toggle.text("정지");
			} else {
				_toggle.removeClass('stop');
				_toggle.addClass('play');
				_toggle.text("실행");
			}

		}

		function gallerySetting() {
			//_imgList.css('position', 'absolute');
			_wrap.css('overflow', 'hidden');
			_img.css('width', '100%');
			if (!_btn.eq(0).hasClass('on'))
				_btn.eq(0).addClass('on');

			if (_type != 'alpha') {
				if (!_vertical) {
					_img.css('left', '-100%');
					_img.eq(c_idx).css('left', 0);
				} else {

					//_img.css('border','1px solid red')
					_img.css('top', '-100%');
					_img.eq(c_idx).css('top', 0);
				}
			} else {
				_img.css('opacity', '0');
				_img.eq(c_idx).css('opacity', 1);
			}

		}

		function startTimer() {

			rollTimeId = setInterval(onStart, _speed);
		}

		function stopTimer() {
			clearInterval(rollTimeId);
			rollTimeId = null;
		}

		function onStart() {
			if(_end !=='loop'){
				if (c_idx == 0) {
					return ;
				}
			}
			if (_imgList.children().is('.panel')) {
				prev = _imgList.eq(c_idx).find('.panel');
			} else {
				prev = _imgList.eq(c_idx);
			}
			if (_type != 'alpha') {
				moveCont(prev, 0, '-100%');
			} else {
				alphaCont(prev, 1, 0);
			}
			c_idx++;
			if (c_idx == total) {
				c_idx = 0;
			}
			activePot(c_idx);
			if (_imgList.children().is('.panel')) {
				current = _imgList.eq(c_idx).find('.panel');

			} else {
				current = _imgList.eq(c_idx);
			}
			if (_type != 'alpha') {
				moveCont(current, '100%', 0);
			} else {
				alphaCont(current, 0, 1);
			}
			//p_idx = c_idx;

		}

		function addEvnet() {

			if (_arrowNext && _arrowPrev) {

				_arrowNext.on('click', function(e) {
					e.preventDefault();

					if(_end !=='loop'){
						if (c_idx == total-1) {
							return;
						}
					}
					if (_imgList.children().is('.panel')) {
						prev = _imgList.eq(c_idx).find('.panel');
					} else {
						prev = _imgList.eq(c_idx);
					}
					if (_type != 'alpha') {
						moveCont(prev, 0, '-100%');
					} else {
						alphaCont(prev, 1, 0);
					}
					c_idx++;
					if (c_idx == total) {
						c_idx = 0;
					}
					activePot(c_idx);
					if (_imgList.children().is('.panel')) {
						current = _imgList.eq(c_idx).find('.panel');
					} else {
						current = _imgList.eq(c_idx);
					}
					if (_type != 'alpha') {
						moveCont(current, '100%', 0);
					} else {
						alphaCont(current, 0, 1);
					}
					result.arrowControl()
					//p_idx = c_idx;
				});
				_arrowNext.on('mouseover', function(e) {
					stopTimer();
				});
				_arrowNext.on('mouseout', function(e) {
					if (_autoBool) {
						startTimer();
					}
				});
				_arrowPrev.on('click', function(e) {
					e.preventDefault();

					if(_end !=='loop'){
						if (c_idx == 0) {
							return ;
						}
					}
					if (_imgList.children().is('.panel')) {
						prev = _imgList.eq(c_idx).find('.panel');
					} else {
						prev = _imgList.eq(c_idx);
					}
					if (_type != 'alpha') {
						moveCont(prev, 0, "100%");
					} else {
						alphaCont(prev, 0, 1);
					}

					c_idx--;
					if (c_idx < 0) {
						c_idx = total - 1;
					}
					activePot(c_idx);
					if (_imgList.children().is('.panel')) {
						current = _imgList.eq(c_idx).find('.panel');
					} else {
						current = _imgList.eq(c_idx);
					}
					if (_type != 'alpha') {
						moveCont(current, "-100%", 0);
					} else {
						alphaCont(current, 1, 0);
					}
					result.arrowControl()
					//p_idx = c_idx;
				});

				_arrowPrev.on('mouseover', function(e) {
					stopTimer();
				});
				_arrowPrev.on('mouseout', function(e) {
					if (_autoBool) {
						startTimer();
					}
				});
			}

			btnEventSeting();
			function btnEventSeting() {
				_btn.on('click', function(e) {

					e.preventDefault();
					var parent_li = $(this).parent('li');
					var parent_idx = parent_li.index();

					if (parent_idx != p_idx) {
						activePot(parent_idx);
						prev = _imgList.eq(c_idx).find('.panel');

						if (_type != 'alpha') {
							moveCont(prev, 0, '-100%');
						} else {
							alphaCont(prev, 1, 0);
						}
						c_idx = parent_idx;
						current = _imgList.eq(c_idx).find('.panel');
						if (_type != 'alpha') {
							moveCont(current, '100%', 0);
						} else {
							alphaCont(current, 0, 1);
						}
						p_idx = parent_idx;
						result.arrowControl();
					}

				});
			}


			_btn.on('mouseover', function(e) {
				stopTimer();
			});
			_btn.on('mouseout', function(e) {
				if (_autoBool) {
					startTimer();
				}
			});

			_toggle.on('click', function(e) {
				e.preventDefault();
				if ($(this).hasClass('on')) {
					_autoBool = false;
					stopTimer();
					$(this).removeClass('on');
					_toggle.removeClass('stop');
					_toggle.addClass('play');
					_toggle.text("실행");
				} else {
					_autoBool = true;
					startTimer();
					$(this).addClass('on');
					_toggle.removeClass('play');
					_toggle.addClass('stop');
					_toggle.text("정지");

				}
			});

		}

		function activePot(parent_idx) {

			_imgList.find('.btn_rolling').removeClass('on');
			_imgList.eq(parent_idx).find('.btn_rolling').addClass('on');


		}

		function moveCont(tg, first, final) {
			if (!_vertical) {
				tg.css('left', first).stop().animate({
					left : final
				}, {
					duration : _duration,
					ease : 'easeOutCubic',
					complete : function() {
						p_idx = tg.parent().index();
					}
				});
			} else {

				tg.css('top', first).stop().animate({
					top : final
				}, {
					duration : _duration,
					ease : 'easeOutCubic',
					complete : function() {
						p_idx = tg.parent().index();
					}
				});
			}


		}

		function alphaCont(tg, first, final) {
			tg.css('opacity', first).stop().animate({
				opacity : final
			}, {
				duration : _duration,
				ease : 'easeOutCubic'
			});
		}
		function arrowControl(){
			//callfunc();
			if (_arrowNext && _arrowPrev) {
				if (c_idx == _imgList.size() - 1) {
					_arrowNext.removeClass('on');
					_arrowPrev.addClass('on');
				} else if (c_idx == 0) {
					_arrowNext.addClass('on');
					_arrowPrev.removeClass('on');
				} else {
					_arrowNext.addClass('on');
					_arrowPrev.addClass('on');

				}
			}
		}
		function reset() {
			c_idx = 0;
			p_idx = 0;
			activePot(c_idx);
			_imgList.find('.panel').css('left', '-100%');
			_imgList.eq(c_idx).find('.panel').css('left', 0);
		}
		function callfunc(){
			if (result.func)result.func(c_idx ,p_idx);
		}
	};
	Slide = SlideContents;
})(jQuery);