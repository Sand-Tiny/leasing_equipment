/**
 * Created by Hope on 2014/12/28.
 */
(function ($) {
    $.fn.extendPagination = function (options) {
        var defaults = {
            //pageId:'',
            totalCount: '',
            showPage: '5',
            limit: '1',
            curr:1,
            callback: function () {
                return false;
            }
        };
        $.extend(defaults, options || {});
        if (defaults.totalCount == '') {
            //alert('总数不能为空!');
            $(this).empty();
            return false;
        } else if (Number(defaults.totalCount) <= 0) {
            //alert('总数要大于0!');
            $(this).empty();
            return false;
        }

        if (defaults.showPage == '') {
            defaults.showPage = '10';
        } else if (Number(defaults.showPage) <= 0)defaults.showPage = '10';
        if (defaults.limit == '') {
            defaults.limit = '5';
        } else if (Number(defaults.limit) <= 0)defaults.limit = '5';
        var totalCount = Number(defaults.totalCount), showPage = Number(defaults.showPage),
            limit = Number(defaults.limit), totalPage = Math.ceil(totalCount / limit),currpage=Number(defaults.curr);
        if(Number(defaults.curr)>totalPage){
            currpage=1
        }
        if (totalPage > 0) {
            var html = [];
            html.push(' <ul class="pagination">');
            html.push(' <li class="previous"><a href="javascript:;">&laquo;</a></li>');
            html.push('<li class="disableds shou hidden"><a href="#1">首页</a></li>');
            if(totalPage<=showPage){
                for(var i=1; i<=totalPage; i++){
                    if (i == currpage) html.push(' <li class="active"><a href="'+i+'">' + i + '</a></li>');
                    else html.push(' <li><a href="'+i+'">' + i + '</a></li>');
                }
            }else if(totalPage<=showPage || currpage<showPage){
                for(var i=1; i<=showPage; i++){
                    if (i == currpage) html.push(' <li class="active"><a href="'+i+'">' + i + '</a></li>');
                    else html.push(' <li><a href="'+i+'">' + i + '</a></li>');
                }
            }else if(currpage==showPage && totalPage>showPage){//小于defaults.showPage
                for(var i=2; i<showPage+2; i++){
                    if (i == currpage) html.push(' <li class="active"><a href="'+i+'">' + i + '</a></li>');
                    else html.push(' <li><a href="'+i+'">' + i + '</a></li>');

                }
            }else if(currpage==totalPage){
                for(var i=currpage-showPage+1; i<=totalPage; i++){
                    if (i == currpage) html.push(' <li class="active"><a href="'+i+'">' + i + '</a></li>');
                    else html.push(' <li><a href="'+i+'">' + i + '</a></li>');
                }
            }else if(totalPage-currpage<showPage){

                for(var i=currpage-(showPage-(totalPage-currpage))+1; i<=totalPage; i++){
                    if (i == currpage) html.push(' <li class="active"><a href="'+i+'">' + i + '</a></li>');
                    else html.push(' <li><a href="'+i+'">' + i + '</a></li>');
                }
            }else{
                for(var i=currpage-1; i<=currpage+(showPage-2); i++){
                    if (i == currpage) html.push(' <li class="active"><a href="'+i+'">' + i + '</a></li>');
                    else html.push(' <li><a href="'+i+'">' + i + '</a></li>');
                }
            }
            html.push('<li class="disableds wei hidden"><a href="#'+totalPage+'">尾页</a></li>');
            html.push('<li class="next"><a href="#">&raquo;</a></li></ul>');
            $(this).html(html.join(''));
            if (totalPage > showPage){
               $(this).find('ul.pagination li.next').prev().removeClass('hidden');
            if(currpage>=showPage)$('.shou').removeClass('hidden');
            if(totalPage-currpage>1)$('.wei').removeClass('hidden');
            if(currpage>showPage){
                if(totalPage-currpage<showPage-1)$('.wei').addClass('hidden');
            }else{
                if(totalPage-currpage<showPage-3)$('.wei').addClass('hidden');
            } 
            } 
            var pageObj = $(this).find('ul.pagination'), preObj = pageObj.find('li.previous'),
                currentObj = pageObj.find('li').not('.previous,.disableds,.next'),
                nextObj = pageObj.find('li.next');
            function loopPageElement(minPage, maxPage) {
                var tempObj = preObj.next();
                console.log(minPage+"=="+maxPage);
                for (var i = minPage; i <= maxPage; i++) {
                    if (minPage == 1 && (preObj.next().attr('class').indexOf('hidden')) < 0)
                        preObj.next().addClass('hidden');
                    else if (minPage > 1 && (preObj.next().attr('class').indexOf('hidden')) > 0)
                        preObj.next().removeClass('hidden');
                    if (maxPage == totalPage && (nextObj.prev().attr('class').indexOf('hidden')) < 0)
                        nextObj.prev().addClass('hidden');
                    else if (maxPage < totalPage && (nextObj.prev().attr('class').indexOf('hidden')) > 0)
                        nextObj.prev().removeClass('hidden');
                    var obj = tempObj.next().find('a');
                    if (!isNaN(obj.html()))obj.html(i);
                    tempObj = tempObj.next();
                }
            }

            function callBack(curr) {
                defaults.callback(curr, defaults.limit, totalCount);
            }

            currentObj.click(function (event) {
                event.preventDefault();
                var currPage = Number($(this).find('a').html()), activeObj = pageObj.find('li[class="active"]'),
                    activePage = Number(activeObj.find('a').html());
                if (currPage == activePage ) return false;
                if (totalPage > showPage) {
                    var maxPage = currPage, minPage = 1;
                    if (($(this).prev().attr('class'))
                        && ($(this).prev().attr('class').indexOf('disableds')) >= 0 && activePage>2 ) {
                        minPage = currPage - 1;
                        maxPage = minPage + showPage - 1;
                        loopPageElement(minPage, maxPage);
                    } else if (($(this).next().attr('class'))
                        && ($(this).next().attr('class').indexOf('disableds')) >= 0) {
                        if (totalPage - currPage >= 1) maxPage = currPage + 1;
                        else  maxPage = totalPage;
                        if (maxPage - showPage > 0) minPage = (maxPage - showPage) + 1;

                        loopPageElement(minPage, maxPage)
                    }
                }
                activeObj.removeClass('active');
                $.each(currentObj, function (index, thiz) {

                    if ($(thiz).find('a').html() == currPage) {
                        $(thiz).addClass('active');
                        callBack(currPage);
                    }
                });
            });
            preObj.click(function (event) {
                event.preventDefault();
                var activeObj = pageObj.find('li[class="active"]'), activePage = Number(activeObj.find('a').html());
                if (activePage <= 1) return false;
                if (totalPage > showPage) {
                    var maxPage = activePage, minPage = 1;
                    if ((activeObj.prev().prev().attr('class'))
                        && (activeObj.prev().prev().attr('class').indexOf('disableds')) >= 0) {
                        minPage = activePage - 1;
                        if (minPage > 1) minPage = minPage - 1;
                        maxPage = minPage + showPage - 1;
                        loopPageElement(minPage, maxPage);
                    }
                }
                $.each(currentObj, function (index, thiz) {
                    if ($(thiz).find('a').html() == (activePage - 1)) {
                        activeObj.removeClass('active');
                        $(thiz).addClass('active');
                        callBack(activePage - 1);
                    }
                });
            });
            nextObj.click(function (event) {
                event.preventDefault();
                var activeObj = pageObj.find('li[class="active"]'), activePage = Number(activeObj.find('a').html());

                if (activePage >= totalPage) return false;
                if (totalPage > showPage) {
                    var maxPage = activePage, minPage = 1;
                    if ((activeObj.next().next().attr('class'))
                        && (activeObj.next().next().attr('class').indexOf('disableds')) >= 0) {
                        maxPage = activePage + 2;
                        if (maxPage > totalPage) maxPage = totalPage;

                        minPage = maxPage - showPage + 1;
                        loopPageElement(minPage, maxPage);
                    }
                }
                $.each(currentObj, function (index, thiz) {
                    if ($(thiz).find('a').html() == (activePage + 1)) {
                        activeObj.removeClass('active');
                        $(thiz).addClass('active');
                        callBack(activePage + 1);
                    }
                });
            });
            $('.wei').click(function(){
                var _this=$(this)
                var activeObj = pageObj.find('li[class="active"]'), activePage = Number(activeObj.find('a').html());
                loopPageElement($(this).find('a').attr('href').substr(1)-defaults.showPage+1,$(this).find('a').attr('href').substr(1));
                $.each(currentObj, function (index, thiz) {
                    activeObj.removeClass('active');
                    $(".wei").prev().addClass('active');
                    callBack(Number(_this.find('a').attr('href').substr(1)));

                });
            })
            $('.shou').click(function(){
                var activeObj = pageObj.find('li[class="active"]'), activePage = Number(activeObj.find('a').html());
                loopPageElement(1,defaults.showPage);
                $.each(currentObj, function (index, thiz) {
                    activeObj.removeClass('active');
                    $(".shou").next().addClass('active');
                    callBack(1);

                });
            })

        }
    };
})(jQuery);