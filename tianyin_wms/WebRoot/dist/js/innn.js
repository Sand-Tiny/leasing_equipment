define(function(require, exports, module) {
	var jQuery = $ = require("jquery-1.8.2.min.js"),
		nr_common = require("../nr_common.js"),
		template = require("../nr_template.js");
	var oCommon = new nr_common;
	template.helper("subStr", function(str, begin, end) {
		var str = str + "";
		return str.substring(begin, end)
	});

	function repayInterest(a, r, m) {
		return a * r * Math.pow(1 + r, m) / (Math.pow(1 + r, m) - 1)
	}

	function clearNoNum(evt, obj) {
		if (evt.keyCode == 37 | evt.keyCode == 39) {
			return
		}
		obj.value = obj.value.replace(/[^\d.]/g, "");
		obj.value = obj.value.replace(/^\./g, "");
		obj.value = obj.value.replace(/\.{2,}/g, ".");
		obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".")
	}

	function modifyRate(form, dialog) {
		var loanId = form.find("#loanId").val();
		var rate = form.find("#modify-rate").val();
		$("#loan-" + loanId).find(".j-modify-rate").html(parseFloat(rate).toFixed(2));
		$("#loan-" + loanId).find(".j-dialog").removeClass("j-dialog").addClass("disabled j-reload-tip").data("tip", "今天已上调过利率");
		oCommon.initTip(".j-reload-tip");
		dialog.close()
	}

	function sureModify(form, dialog) {
		var loanId = form.find("#loanId").val();
		$("#audit-" + loanId).find(".j-audit-state").html("申请成功");
		dialog.close()
	}

	function uploadCallback(data, dialog) {
		$(".j-nav-headImg").attr("src", data.data);
		$(".j-top-headImg").attr("src", data.data);
		dialog.close()
	}

	function autoSureClose(dialog) {
		var url = $(".j-close-auto").data("href");
		$.ajax({
			url: url,
			success: function() {
				$(".j-close-auto").removeClass("j-close-auto").addClass("j-open-auto").html('<i class="nr-icon-autoClose"></i>').data("href", "/personal/autoBidInvest/set?effecTive=1");
				dialog.close()
			}
		})
	}

	function personal() {}
	personal.prototype = {
		initNav: function() {
			$(".j-nav-parent").click(function() {
				$(this).next().slideToggle("normal")
			});
			return this
		},
		initValidate: function(element, callback) {
			var that = this,
				$form = $(element);
			require.async(["../nr_validate", "../plug/md5", "../nr_notify", "../nr_ajaxForm"], function(validate, hex_md5, notify) {
				var $validate = new validate($form, {
					ignore: ".j-not-validate",
					temple: 2,
					submitHandler: function(form, event) {
						if (form.data("ajax")) {
							var origSubmitTxt = "";
							form.ajaxSubmit({
								beforeSubmit: function(data) {
									for (var i = 0; i < data.length; i++) {
										if (data[i].type == "password") {
											data[i].value = hex_md5(data[i].value)
										}
									}
									origSubmitTxt = form.find('input[type="submit"]').val();
									form.find('input[type="submit"]').prop("disabled", "disabled").addClass("disabled").val("提交中...")
								},
								success: function(data) {
									var rate = $form.find("#modify-rate").val();
									if (data.code == 1e3 || data.state == 501) {
										new notify({
											content: '<i class="nr-icon-outages"></i>' + data.message
										})
									} else if (data.state == 200) {
										new notify({
											content: '<i class="nr-icon-correct"></i>' + data.message
										});
										if (callback) {
											callback.call($validate, form, data)
										}
									} else if (data.state == 500) {
										$validate.showErrors(data.data)
									}
									form.find('input[type="submit"]').removeProp("disabled").removeClass("disabled").val(origSubmitTxt)
								},
								error: function() {
									new notify({
										content: '<i class="nr-icon-outages"></i>网络异常，请稍后重试！'
									});
									form.find('input[type="submit"]').removeProp("disabled").removeClass("disabled").val(origSubmitTxt)
								}
							})
						} else {
							if (callback) {
								callback.call($validate, form)
							}
							form[0].submit()
						}
					}
				})
			});
			return this
		},
		getAjaxData: function(element) {
			var tmplRepay = $(element).data("tmpl"),
				ajaxUrl = $(element).data("href"),
				tmplContent = "";
			var dialogLoading = $('<div class="nr-dialog-loading"><i class="nr-icon-loading"></i><span>系统加载中...</span></div>');
			if (ajaxUrl) {
				$.ajax({
					url: ajaxUrl,
					async: false,
					beforeSend: function() {
						dialogLoading.appendTo("body")
					},
					success: function(response) {
						if (response.state == 200) {
							tmplContent = template(tmplRepay, response.data)
						} else if (response.code == 1e3) {
							require.async(["../nr_notify"], function(notify) {
								new notify({
									content: '<i class="nr-icon-outages"></i>' + response.message
								})
							});
							return false
						} else {
							require.async(["../nr_notify"], function(notify) {
								new notify({
									content: '<i class="nr-icon-outages"></i>' + response.message
								})
							});
							return false
						}
						dialogLoading.remove()
					},
					error: function() {
						require.async(["../nr_notify"], function(notify) {
							new notify({
								content: '<i class="nr-icon-outages"></i> 网络异常，请稍后重试！'
							})
						})
					},
					complete: function() {
						dialogLoading.remove()
					}
				})
			} else {
				tmplContent = template(tmplRepay)
			}
			return tmplContent
		},
		initCommonDialog: function(element) {
			var $element = $(element),
				self = this;
			var tmplContent;
			require.async(["../nr_dialog.js"], function(dialog) {
				var options = {
					onShowBefore: function(element, options) {
						var clear = $(element).data("clear");
						options.btnClose = clear
					},
					content: function(element) {
						tmplContent = self.getAjaxData(element);
						return tmplContent
					},
					onShow: function() {
						var that = this;
						if ($(tmplContent).find(".j-ajax-form").length) {
							if ($(tmplContent).find(".j-ajax-form").data("callback")) {
								var callback = $(tmplContent).find(".j-ajax-form").data("callback");
								self.initValidate(".j-ajax-form", function(form, data) {
									eval(callback + "(form,oDialog)")
								})
							} else {
								self.initValidate(".j-ajax-form")
							}
						}
						if ($(tmplContent).find(".j-dialog-tip").length) {
							oCommon.initTip(".j-dialog-tip")
						}
						if ($(tmplContent).find(".j-repayInterest").length) {
							$(".j-repayInterest").bind("keydown", function(evt) {
								var key = [8, 37, 39, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 110, 190];
								if (evt.shiftKey) {
									return false
								}
								if ($.inArray(evt.which, key) < 0) {
									return false
								}
							});
							$(".j-repayInterest").bind("keyup keypress charcount", function(evt) {
								clearNoNum(evt, this);
								var rate = $(this).val() / 12 / 100,
									time = parseFloat($(this).data("time")),
									money = parseFloat($(this).data("money")) / 100;
								var mouthMoney = isNaN(parseFloat(repayInterest(money, rate, time).toFixed(2))) ? 0 : parseFloat(repayInterest(money, rate, time).toFixed(2));
								var allMoney = mouthMoney * time;
								$(".j-mouthMoney").html(mouthMoney.toFixed(2));
								$(".j-allMoney").html(allMoney.toFixed(2))
							})
						}
						if ($(tmplContent).find(".j-dialog-close").length) {
							$(".j-dialog-close").bind("click", function(e) {
								e.preventDefault();
								e.stopPropagation();
								that.close()
							})
						}
						if ($(tmplContent).find(".j-dialog-closeReload").length) {
							$(".j-dialog-closeReload").bind("click", function(e) {
								e.preventDefault();
								e.stopPropagation();
								location.reload();
								that.close()
							})
						}
						if ($(tmplContent).find(".j-dialog-reload").length) {
							$(".j-dialog-reload").bind("click", function(e) {
								oDialog.reload($(this), options)
							})
						}
					}
				};
				var oDialog = new dialog($element, options);
				if ($element.data("render")) {
					oDialog.renderDom(options, $element)
				}
			});
			return this
		},
		initAllPage: function(element) {
			require.async(["../nr_pagination.js", "../nr_template.js", "../nr_notify"], function(pagintion, template, notify) {
				var href = $(element).data("href");
				var $ajaxLoading = $('<div class="nr-loading-tip"><img src="/personal/dist/image/loading.gif" width="16" height="16"/>数据加载中...</div>');
				$.ajax({
					url: href,
					beforeSend: function() {
						$ajaxLoading.appendTo($(element).parents("li"))
					},
					success: function(response) {
						if (response.state == 200) {
							if (response.data) {
								new pagintion(element, {
									pageSize: 6,
									dataSource: response.data,
									position: function(el) {
										$(element).parents("li").find(".j-repay-detalis-page").html(el)
									},
									callback: function(data, pagination) {
										var list = {
											data: data
										};
										var contentStr = template("tmpl-repay-detailed", list);
										$(element).parents("li").find(".j-repay-detalis-data").html(contentStr);
										if ($(contentStr).find(".j-tip").length) {
											oCommon.initTip(".j-tip")
										}
									}
								});
								$(element).data("ajax", true)
							} else {
								new notify({
									content: "数据加载异常,请稍后在试！",
									overlay: false
								})
							}
						} else if (response.state == 500) {
							new notify({
								content: '<i class="nr-icon-outages"></i>' + response.message
							})
						} else if (response.code == 1e3) {
							new notify({
								content: '<i class="nr-icon-outages"></i>' + response.message
							})
						}
					},
					error: function() {
						$(element).toggleClass("nr-icon-details").toggleClass("nr-icon-detailUp");
						$(element).parents("li").toggleClass("active");
						new notify({
							content: '<i class="nr-icon-outages"></i> 网络异常，请稍后重试！'
						})
					},
					complete: function() {
						$ajaxLoading.remove()
					}
				})
			});
			return this
		},
		initRepayDetalis: function() {
			var that = this;
			$("body").delegate(".j-repay-detalis", "click", function() {
				$(this).toggleClass("nr-icon-details").toggleClass("nr-icon-detailUp");
				$(this).parents("li").toggleClass("active");
				if (!$(this).data("ajax")) {
					that.initAllPage($(this))
				}
			});
			return this
		},
		initAjaxPage: function(element) {
			$("body").delegate(".j-ajax-page a", "click", function(e) {
				var $parent = $(this).parents(".j-ajax-page");
				var href = $(this).data("href"),
					tmpl = $parent.data("tmpl"),
					content = $parent.data("content");
				var $content = $("#" + content);
				$.ajax({
					url: href,
					beforeSend: function() {
						var top = $content.offset().top;
						$("html, body").animate({
							scrollTop: top
						}, 400);
						var $ajaxLoading = $('<div class="nr-loading-tip"><img src="/personal/dist/image/loading.gif" width="16" height="16"/>数据加载中...</div>');
						$content.prepend($ajaxLoading)
					},
					success: function(response) {
						if (response.state == 200) {
							if (response.data) {
								var contentStr = template(tmpl, response);
								$content.hide();
								$content.html(contentStr).fadeIn();
								if ($(contentStr).find(".j-countDown").length) {
									oCommon.initCountDown(".j-countDown")
								}
								if ($(contentStr).find(".j-tip").length) {
									oCommon.initTip(".j-tip")
								}
							}
						} else if (response.state == 500) {
							new notify({
								content: '<i class="nr-icon-outages"></i>' + response.message
							})
						}
					},
					complete: function() {},
					error: function() {
						require.async(["../nr_notify"], function(notify) {
							new notify({
								content: '<i class="nr-icon-outages"></i> 网络异常，请稍后重试！'
							})
						})
					}
				});
				e.preventDefault()
			});
			return this
		},
		initAjaxTab: function(element) {
			var $element = $(element);
			var tmplNoData = '<div class="nr-noData"><i class="nr-icon-pig"></i><p>没有数据呃~</p></div>';
			var href = $element.find("a").data("href"),
				tmpl = $element.find("a").data("tmpl"),
				content = $element.find("a").data("content");
			var $content = $("#" + content);
			require.async(["../nr_notify"], function(notify) {
				if (!$element.data("ajax")) {
					$.ajax({
						url: href,
						beforeSend: function() {
							$content.html('<i class="nr-loading"></i>')
						},
						success: function(response) {
							if (response.code == 1e3) {
								new notify({
									content: '<i class="nr-icon-outages"></i>' + response.message
								})
							} else if (response.state == 200) {
								if (response.data) {
									var contentStr = template(tmpl, response);
									$content.html(contentStr);
									if ($(contentStr).find(".j-countDown").length) {
										oCommon.initCountDown(".j-countDown")
									}
									if ($(contentStr).find(".j-tip").length) {
										oCommon.initTip(".j-tip")
									}
								} else {
									$content.html(tmplNoData)
								}
								$element.data("ajax", true)
							} else if (response.state == 500) {
								new notify({
									content: '<i class="nr-icon-outages"></i>' + response.message
								})
							}
						},
						complete: function() {},
						error: function() {
							new notify({
								content: '<i class="nr-icon-outages"></i> 网络异常，请稍后重试！'
							})
						}
					})
				}
			})
		},
		initRecharge: function() {
			$(".j-recharge").bind("keydown", function(evt) {
				var key = [8, 37, 39, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 110, 190];
				if (evt.shiftKey) {
					return false
				}
				if ($.inArray(evt.which, key) < 0) {
					return false
				}
			});
			$(".j-recharge").bind("keyup charcount", function(evt) {
				var payRates = 0;
				clearNoNum(evt, this);
				if ($("input[name='payType']:checked").val() == 1) {
					payRates = .003
				} else {
					payRates = .002
				}
				var valMoney = parseFloat($(this).val()) || 0;
				var payMoney = valMoney * payRates;
				$(".j-payMoney").html(payMoney.toFixed(2));
				$(".j-realMoney").html(valMoney.toFixed(2))
			});
			$(".j-recharge").bind("blur", function(evt) {
				var realVal = $(this).val();
				if (realVal != "") {
					realVal = parseFloat(realVal);
					realVal = isNaN(realVal) ? 0 : realVal;
					if (realVal < 100 || realVal > 5e4) {
						$(".j-payMoney").html("0.00");
						$(".j-realMoney").html("0.00")
					}
					$(this).val(realVal.toFixed(2))
				}
			});
			$(".j-enterprise-recharge").bind("keyup charcount", function(evt) {
				var payMoney = 10;
				clearNoNum(evt, this);
				var valMoney = parseFloat($(this).val()) || 0;
				var realMoney = valMoney - payMoney;
				if (realMoney < 0) {
					realMoney = 0
				}
				$(".j-realMoney").html(realMoney.toFixed(2))
			});
			$(".j-enterprise-recharge").bind("blur", function(evt) {
				var realVal = $(this).val();
				var inputVal = parseFloat($(this).val());
				if (realVal != "") {
					realVal = parseFloat(realVal - 10);
					realVal = isNaN(realVal) ? 0 : realVal;
					if (realVal < 90 || realVal > 5e4) {
						$(".j-realMoney").html("0.00")
					}
					$(this).val(inputVal.toFixed(2))
				}
			});
			$("input[name='payType']").bind("click", function() {
				$(".j-recharge").trigger("keyup")
			});
			return this
		},
		initContentDialog: function(tmpl, callback) {
			require.async(["../nr_dialog.js"], function(dialog) {
				var tmplStr = template(tmpl);
				var dialog = new dialog({
					content: tmplStr,
					onShow: function() {
						var that = this;
						$(".j-dialog-close").bind("click", function(e) {
							e.preventDefault();
							e.stopPropagation();
							that.close()
						});
						$(".j-dialog-closeReload").bind("click", function(e) {
							e.preventDefault();
							e.stopPropagation();
							that.close();
							location.reload()
						});
						$(".j-dialog-sure").bind("click", function(e) {
							if (callback) {
								callback(dialog)
							}
							e.preventDefault();
							e.stopPropagation()
						})
					}
				})
			});
			return this
		},
		initUploadDialog: function(element) {
			var $element = $(element);
			var self = this;
			require.async(["../nr_dialog.js", "../nr_notify"], function(dialog, notify) {
				var tmplStr;
				var dialog = new dialog($element, {
					content: function(element) {
						var tmpl = $element.data("tmpl");
						tmplStr = template(tmpl);
						return tmplStr
					},
					btnClose: true,
					onShow: function() {
						var url = $(tmplStr).find(".j-ajaxUpload").data("src");
						var $form = $(tmplStr).find(".j-ajax-form");
						oCommon.initAjaxUpload(".j-ajaxUpload", {
							uploadUrl: url,
							ajaxStart: function() {
								var domSelect = this.$element.data("dom");
								$(tmplStr).find("." + domSelect).html("头像上传中...").addClass("disabled");
								this.$element.addClass("nr-hide");
								$form.find('input[type="submit"]').prop("disabled", "disabled").addClass("disabled")
							},
							success: function(data) {
								var domSelect = this.$element.data("dom");
								$(tmplStr).find("." + domSelect).html("选择需要上传的头像").removeClass("disabled");
								if (data.state == 200) {
									oCommon.imgReady(data.lookUpUrl, function() {
										$(tmplStr).find(".j-crop").html('<img style="visibility: hidden;" id="j-crop-img" class="crossOrigin" src="' + data.lookUpUrl + '" alt="头像">');
										oCommon.initCropper("#j-crop-img", {
											aspectRatio: 1 / 1,
											preview: ".j-crop-smallImg",
											zoomable: false,
											build: function() {
												$form.find('input[type="submit"]').removeProp("disabled").removeClass("disabled")
											},
											crop: function(coordinate) {
												var json = ['{"x":' + coordinate.x, '"y":' + coordinate.y, '"height":' + coordinate.height, '"width":' + coordinate.width + "}"].join();
												$(tmplStr).find("#j-fileUrl").val(data.key);
												$(tmplStr).find("#j-avatar-data").val(json)
											}
										})
									}, function() {
										console.log("图片加载失败")
									})
								} else {
									new notify({
										content: '<i class="nr-icon-outages"></i>' + data.message
									})
								}
							},
							error: function(data) {
								new notify({
									content: '<i class="nr-icon-outages"></i>图片上传异常，请稍后重试！'
								})
							},
							complete: function() {
								this.$element.removeClass("nr-hide")
							}
						});
						self.initValidate($form, function(form, data) {
							uploadCallback(data, dialog)
						})
					}
				})
			});
			return this
		},
		initWithDraw: function() {
			var that = this;
			$(".j-withdraw").bind("keydown", function(evt) {
				var key = [8, 37, 39, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 110, 190];
				if (evt.shiftKey) {
					return false
				}
				if ($.inArray(evt.which, key) < 0) {
					return false
				}
			});
			$(".j-withdraw").bind("keyup charcount", function(evt) {
				clearNoNum(evt, this);
				var isFree = $(this).data("free-num"),
					realMoney = 0,
					freeMoney = 0;
				if (isFree > 0) {
					realMoney = parseFloat($(this).val());
					freeMoney = 0
				} else if (isFree == 0 && parseFloat($(this).val()) >= 2) {
					realMoney = parseFloat($(this).val()) - 2;
					freeMoney = 2
				}
				realMoney = isNaN(realMoney) ? 0 : realMoney;
				$(".j-free-money").html(freeMoney.toFixed(2));
				$(".j-realMoney").html(realMoney.toFixed(2))
			});
			$(".j-withdraw").bind("blur", function(evt) {
				var realVal = parseFloat($(this).val()) || 0;
				realVal = isNaN(realVal) ? 0 : realVal;
				$(this).val(realVal.toFixed(2))
			});
			$(".j-unbind-bank").bind("click", function(e) {
				var url = $(this).data("href");
				that.initContentDialog("tmpl-unbind-bank", function(dialog) {
					require.async(["../nr_notify"], function(notify) {
						$.ajax({
							url: url,
							success: function(data) {
								if (data.state == 200) {
									new notify({
										content: '<i class="nr-icon-correct"></i>' + data.message
									})
								} else {
									new notify({
										content: '<i class="nr-icon-outages"></i>' + data.message
									})
								}
							},
							error: function() {
								new notify({
									content: '<i class="nr-icon-outages"></i>系统繁忙，请稍后重试！'
								})
							}
						});
						dialog.close()
					})
				});
				e.preventDefault()
			});
			return this
		},
		initMessage: function() {
			var that = this;
			$("body").delegate(".j-all-checked", "click", function() {
				var checkList = $(this).parents(".nr-tab-body").find("input[name='message']");
				for (var i = 0; i < checkList.length; i++) {
					if ($(this)[0].checked) {
						checkList[i].checked = "checked"
					} else {
						checkList[i].checked = ""
					}
				}
			});
			$("body").delegate(".j-set-read", "click", function(e) {
				var $element = $(this);
				var url = $(this).data("href");
				var checkList = $(this).parents(".nr-tab-body").find(".nr-noRead input[name='message']:checked");
				if (checkList.length == 0) {
					require.async("../nr_tip.js", function(tip) {
						var tip = new tip;
						tip.active_tiptip($element, "未选择任何信息", "top");
						setTimeout(function() {
							tip.deactive_tiptip(e)
						}, 1e3)
					})
				} else {
					var idArrays = new Array;
					for (var i = 0; i < checkList.length; i++) {
						idArrays.push(checkList[i].value)
					}
					$.ajax({
						url: url,
						data: {
							idArray: idArrays
						},
						success: function(data) {
							if (data.state == "200") {
								var countRead = checkList.length;
								for (var i = 0; i < checkList.length; i++) {
									$(".j-message-" + checkList[i].value).removeClass("nr-noRead").addClass("nr-read");
									checkList[i].checked = ""
								}
								$(".j-count-noRead").html(parseInt($(".j-count-noRead").html()) - countRead);
								$(".j-count-read").html(parseInt($(".j-count-read").html()) + countRead);
								$(".j-msgCount").html(parseInt($(".j-msgCount").html() - countRead));
								$(".j-all-checked")[0].checked = ""
							}
						}
					})
				}
			});
			$("body").delegate(".j-del-message", "click", function(e) {
				var $element = $(this);
				var url = $(this).data("href");
				var checkList = $(this).parents(".nr-tab-body").find("input[name='message']:checked");
				if (checkList.length == 0) {
					require.async("../nr_tip.js", function(tip) {
						var tip = new tip;
						tip.active_tiptip($element, "未选择任何信息", "top");
						setTimeout(function() {
							tip.deactive_tiptip(e)
						}, 1e3)
					})
				} else {
					var idArrays = new Array,
						readCount = 0,
						noReadCount = 0;
					for (var i = 0; i < checkList.length; i++) {
						if ($(checkList[i]).parents(".nr-noRead").length > 0) {
							noReadCount++
						} else {
							readCount++
						}
						idArrays.push(checkList[i].value)
					}
					that.initContentDialog("tmpl-del-tip", function(_dialog) {
						$.ajax({
							url: url,
							data: {
								idArray: idArrays
							},
							success: function(data) {
								if (data.state == "200") {
									var countRead = checkList.length;
									for (var i = 0; i < checkList.length; i++) {
										$(".j-message-" + checkList[i].value).fadeOut("slow", function() {
											$(this).remove()
										})
									}
									_dialog.close();
									$(".j-count-allRead").html(parseInt($(".j-count-allRead").html()) - countRead);
									$(".j-count-noRead").html(parseInt($(".j-count-noRead").html()) - noReadCount);
									$(".j-count-read").html(parseInt($(".j-count-read").html()) - readCount);
									$(".j-msgCount").html(parseInt($(".j-msgCount").html() - noReadCount));
									$(".j-all-checked")[0].checked = ""
								}
							}
						})
					})
				}
			});
			return this
		},
		initCommont: function() {
			$("#questions-all,#repay-all").delegate(".j-read-comment", "click", function() {
				var that = this,
					url = $(this).data("href");
				$.ajax({
					url: url,
					success: function(data) {
						if (data.state) {
							if ($(that).data("repay")) {
								var countReply = parseInt($(".j-count-repay").html());
								$(".j-count-repay").html(countReply - 1)
							} else {
								var countRead = parseInt($(".j-count-questions").html());
								$(".j-count-questions").html(countRead - 1)
							}
							$(".j-msgCount").html(parseInt($(".j-msgCount").html() - 1));
							$(that).parents("li").removeClass("nr-comment-noRead").addClass("nr-comment-read");
							$(that).remove()
						}
					}
				})
			}).delegate(".j-read-all", "click", function(e) {
				var that = this,
					url = $(this).data("href");
				$.ajax({
					url: url,
					success: function(data) {
						if (data.state) {
							if ($(that).data("repay")) {
								$(".j-count-repay").html(0)
							} else {
								$(".j-count-questions").html(0)
							}
							$(that).parents(".nr-comments-list").find("li").removeClass("nr-comment-noRead").addClass("nr-comment-read")
						}
					}
				})
			})
		},
		initAutoSet: function(form) {
			var $form = $(form);
			require.async(["../nr_validate", "../nr_dialog.js", "../nr_notify", "../nr_ajaxForm"], function(validate, dialog, notify) {
				var $validate = new validate($form, {
					ignore: ".j-not-validate",
					temple: 2,
					submitHandler: function(form, event) {
						var origSubmitTxt = "";
						if (form.data("ajax")) {
							form.ajaxSubmit({
								beforeSubmit: function() {
									origSubmitTxt = form.find('input[type="submit"]').val();
									form.find('input[type="submit"]').prop("disabled", "disabled").addClass("disabled").val("提交中...")
								},
								success: function(data) {
									if (data.code == 1e3 || data.state == 501) {
										new notify({
											content: '<i class="nr-icon-outages"></i>' + data.message
										})
									} else if (data.state == 200) {
										var oDialog = new dialog({
											content: function() {
												var data = {
													money: $form.find("#investAmtOnce").val(),
													time: $form.find("#maxDeadline").val(),
													rate: $form.find("#minRate").val() / 100,
													retainMoney: $form.find("#stockAmount").val()
												};
												var tmplContent = template("tmpl-autoSet", data);
												return tmplContent
											},
											onShow: function() {
												var that = this;
												$(".j-dialog-close").bind("click", function(e) {
													e.preventDefault();
													e.stopPropagation();
													that.close()
												});
												$(".j-dialog-sure").bind("click", function(e) {})
											}
										})
									} else if (data.state == 500) {
										$validate.showErrors(data.data)
									}
									form.find('input[type="submit"]').removeProp("disabled").removeClass("disabled").val(origSubmitTxt)
								},
								error: function() {
									new notify({
										content: '<i class="nr-icon-outages"></i>网络异常，请稍后重试！'
									});
									form.find('input[type="submit"]').removeProp("disabled").removeClass("disabled").val(origSubmitTxt)
								}
							})
						} else {
							var oDialog = new dialog({
								content: function() {
									var data = {
										money: $form.find("#investAmtOnce").val(),
										time: $form.find("#maxDeadline").val(),
										rate: $form.find("#minRate").val() / 100,
										retainMoney: $form.find("#stockAmount").val()
									};
									var tmplContent = template("tmpl-autoSet", data);
									return tmplContent
								},
								onShow: function() {
									var that = this;
									$(".j-dialog-close").bind("click", function(e) {
										e.preventDefault();
										e.stopPropagation();
										that.close()
									});
									$(".j-dialog-sure").bind("click", function(e) {
										form[0].submit();
										e.preventDefault();
										oDialog.close()
									})
								}
							})
						}
					}
				})
			});
			return this
		},
		initAuth: function() {},
		initAuto: function() {
			oCommon.initDialog(".j-close-auto", function(dialog) {
				autoSureClose(dialog)
			});
			$("body").delegate(".j-open-auto", "click", function() {
				var url = $(this).data("href");
				$.ajax({
					url: url,
					success: function(data) {
						$(".j-open-auto").removeClass("j-open-auto").addClass("j-close-auto").html('<i class="nr-icon-auto"></i>').data("href", "/personal/autoBidInvest/set?effecTive=0")
					}
				})
			})
		}
	};
	return personal
});