$("#header .username").on("mouseenter mouseleave",function(event){
$this=$(this);
$(".username_dropdown").on("mouseenter mouseleave",function(event){
	if(event.type=="mouseenter"){$(this).addClass("active");}else{$(this).removeClass("active");$this.trigger("mouseleave");}
});
if(!$this.hasClass("active")){
$this.addClass("active");
var offset=$this.offset();
var dropdown=$(".username_dropdown");
dropdown.show();
$(document.body).append(dropdown);
dropdown.addClass("username_dropdown");
dropdown.css({
	top:offset.top+35+'px',
	left:(offset.left-10)+'px'
});
$this.find(".icon-caret-down").removeClass("icon-caret-down").addClass("icon-caret-right");
}else{
	setTimeout(function(){
	var dropdown=$(".username_dropdown");
	if(!dropdown.hasClass("active")){
$this.removeClass("active");
$this.find(".icon-caret-right").removeClass("icon-caret-right").addClass("icon-caret-down");
dropdown.hide();
}
},500);
}
});
if($(".container_login.post").length>0){
var $this=$(".container_login.post");
$this.addClass("postit");
}
$(".home .icon-magic").click(function(){
	if($("#header .username").length<1){
		location.href="/signin";
		return false;
	}
	$this=$(this);
	if(!$this.hasClass("active")){
		$(".down_btn").addClass("disabled");
	$(".minipost_form").fadeIn(1000);
	var main_content=$(".main_content");
	$(".minipost").each(function(index,value){
		var val=$(value);
		val.animate({top:"+="+$(".minipost_form").height()+'px',opacity:'0.3'}, {duration: 1000,
	complete:  function() {
		var off=val.offset();
		if((main_content.offset().top+main_content.height())<(off.top+val.height())){
			val.hide();
		}
	}});

	});
	$this.addClass("active");
	}else{
	$(".minipost_form").fadeOut(1000);
	if(!$(".down_btn").data("lock")) $(".down_btn").removeClass("disabled");
	$(".down_btn").addClass("disabled");
	$(".minipost").animate({top:"-="+$(".minipost_form").height()+'px',opacity:'1'},1000);
	$(".main_content .wrapper>:nth-child(5)").show();
	$this.removeClass("active");
	}

});
$(document).on("click",".post .icon-magic",function(){//initially
$this=$(this);
$(".minipost_form").fadeIn(1000);
$this.addClass("active");
});

$(".postit").submit(function(event){
	event.preventDefault();
	$this=$(this);
	$.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/postit',

  		data: {title:$this.find("input[name='title']").val(),tags:$this.find("input[name='tags']").val()}}).done(function(response){
  		if(response.valid){
  			var main_content=$(".main_content");
  			var link_to_post=$(document.createElement('div'));
  			var link=$(document.createElement('i'));
  			link.addClass("icon-link");
  			link_to_post.addClass("link_to_post");
  			link_to_post.text(response.url);
  			$(document.body).append(link_to_post);
  			link_to_post.prepend(link);
			main_content.fadeIn(1000);
			$this.fadeTo(600,0.35);
			//push others
			$
		}else{
			//display errors to user
			var off=$this.offset();
			var error_box=$(document.createElement('div'));
			error_box.text("error");
			$(document.body).append(error_box);
			error_box.css({position:"absolute",top:off.top,top:off.left+200+'px'});
		}
  		});
	});
$('.postit-btn').click(function(){
    var form=$(".minipost_form");

    $.ajax({
        url: '/minipostit',  //server script to process data
        type: 'POST',
        dataType: "json",
        // Form data
        data: {name:form.find("input[name='name']").val(),content:form.find("textarea").val(),micropost_id:form.parent().attr('id')},
        //Options to tell JQuery not to process data or worry about content-type
    }).done(function(response){

    });
});
//inc
$(".main_content.home .likes").click(function(){
	var $this=$(this);
	var meds=$this.find(".count");
	if(!$this.hasClass("upped")){
            meds.text(parseInt(meds.text())+1);
            $this.addClass("upped");
    }else{
    $this.removeClass("upped");
	meds.text(parseInt(meds.text())-1);
	}
	 $.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/miniposts/inc',
  		data: {id:$this.parent().attr("id")},
  	});
});
$(document).on("mouseenter","[data-title]",function(e){	
	$this=$(this);
	if($this.is("img")){ return false;} //will refine for extra power
	var tooltip=$(document.createElement('div'));
	tooltip.attr('id','otooltip');
var offset = $this.offset();
var height = $this.height();
var width = $this.width();
if($this.parent().hasClass("container")){
var top = offset.top +height+10 +"px";
var left = offset.left -10+ "px";
$this.parent().hasClass("commentz")||$this.hasClass("commentz")?tooltip.addClass("purple"):tooltip.addClass("blue")
	tooltip.css({
        position: 'absolute',
        background: $this.parent().hasClass("commentz")||$this.hasClass("commentz")?'#9525a6':'#81DAF5',
        padding: '7px',
        zIndex: 999,
        width:'30px',
        height:'7px',
        display: 'block',
        left:  left,
        "font-size":"8px",
        "font-weight":"bold",
        "text-transform":"capitalize",
        "text-align":"center",
        top:top,
        color:'white'
    }).insertBefore(document.body);
}else{
var top = offset.top -height-17 +"px";
var left = offset.left - width+ "px";
	tooltip.css({
        position: 'absolute',
        background: 'black',
        border: '1px solid black',
        padding: '10px',
        zIndex: 999,
        width:'50px',
        height:'7px',
        display: 'block',
        left:  left,
        "font-size":"12px",
        "text-transform":"capitalize",
        "text-align":"center",
        top:top,
        color:'white'
    }).insertBefore(document.body);
}
   tooltip.html($this.attr('data-title'));

});
function is_signed_in(){
	if($("#header .username").length<1) return false;
return true;
}
$(".sign_in_please").on("click",function(){
	if($("#header .username").length<1){
		location.href="/signin";
		var alert=$(document.createElement('div'))
		alert.addClass("alert");
		alert.text("please sign in");
		$(document.body).append(alert);
		return false;
	}
});
//for options under production
$(document).on("mouseleave","[data-title]",function(event){
$('#otooltip').remove();
});
 $(".comments i").on("click",function(){
 	if(!$(this).parent().hasClass("active")){
 	var comment=$(document.createElement('div'));
 	var name=$(document.createElement('p'));
	var text=$(document.createElement('textarea'));
	comment.addClass("comment_text");
	comment.appendTo($(".comments_container"));
	comment.append(text);
	comment.prepend(name);
	$(this).parent().addClass("active");
	name.text($("#header .username").text());
	var comments=$("ol.comments li");
	comments.animate({top:"+=100"});
	comments.fadeTo(500,0.5);
	}else{
		$(".comment_text").remove();
		$(this).parent().removeClass("active");
		var comments=$("ol.comments li");
	comments.animate({top:"-=100"});
	comments.fadeTo(500,1);
	}
 });
 $(".like_counter i").on("click",function(){
	var $this=$(this);
	var count=$this.parent().children("p");
	if(!$this.parent().hasClass("upped")){
            count.text(parseInt(count.text())+1);
            $this.parent().addClass("upped");
    }else{
    $this.parent().removeClass("upped");
	count.text(parseInt(count.text())-1);
	}
	 $.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/microposts/inc',
  		data: {id:$(".main_content").attr("id")},
  	});
 });
 $(".subscribers i").on("click",function(){
	var $this=$(this);
	var count=$this.parent().children("p");
	if(!$this.parent().hasClass("upped")){
           count.text(parseInt(count.text())+1);
            $this.parent().addClass("upped");
    }else{
    $this.parent().removeClass("upped");
	count.text(parseInt(count.text())-1);
	}
	 $.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/microposts/subscribe',
  		data: {id:$(".main_content").attr("id")},
  	});
 });
 //on every page load calculate one's subscriptions
 if(is_signed_in()){
 	$.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/json/subscriptions'
  	}).done(function(response){
  		$(".username_dropdown .count").text(response.count);
  	});
 }
//signup form ajax helper tell the user if username and email have been used before
$("form[action='/signupup'] input").on('blur',function(){
	$this=$(this);
if($this.attr("name")=="name"){
	$(".wrong-info.name").remove();
var img=$(document.createElement('img'));
var div=$(document.createElement('div'));
img.attr("src","/assets/ajax-loader.gif");
img.appendTo(div);
img.width(25);img.height(25);
var offset=$this.offset();
div.appendTo($(document.body));
div.css({position:"absolute",left:offset.left+$this.outerWidth()+100+'px',top:offset.top+'px'});
setTimeout(function(){
$.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/no_other_users',
  		data: {name:$this.val()},}).done(function(response){
  			var span=$(document.createElement('span'));
  			span.appendTo(div);
  			 if (response.user){
  			 	img.attr("src","/assets/cross.png");
  			 	span.text("Name taken");
  			 }
  			 else{
  			 	 var pattern=/^[a-zA-Z0-9_]+$/;
  			 	if($this.val()=="" || $this.val()==" "){
  			 	img.attr("src","/assets/cross.png");
  			 	span.text("Name is blank");
  			 	}else if(!pattern.test($this.val())){
  			 	img.attr("src","/assets/cross.png");
  			 	span.text("Not a vaild name");
  			 	}else{
  			 	img.attr("src","/assets/check.png");
  			 	span.text("Name is okay");
  			 	}
  			 	div.addClass("wrong-info");
  			 	div.addClass($this.attr("name"));
  			 }
  		});
  		},1000);
}else if($this.attr("name")=="email"){
	$(".wrong-info.email").remove();
var img=$(document.createElement('img'));
var div=$(document.createElement('div'));
img.attr("src","/assets/ajax-loader.gif");
img.width(25);img.height(25);
img.appendTo(div);
var offset=$this.offset();
div.appendTo($(document.body));
div.css({position:"absolute",left:offset.left+$this.outerWidth()+100+'px',top:offset.top+'px'});
setTimeout(function(){
$.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/no_other_emails',
  		data: {email:$this.val()},}).done(function(response){
  			var span=$(document.createElement('span'));
  			span.appendTo(div);
  			if (response.email){
  			 	img.attr("src","/assets/cross.png");
  			 	span.text("Email is taken");
  			 }
  			 else{
  			 	var pattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/;
  			 	if($this.val()=="" || $this.val()==" "){
  			 	img.attr("src","/assets/cross.png");
  			 	span.text("Email is blank");
  			 	}else if(!pattern.test($this.val())){
  			 	img.attr("src","/assets/cross.png");
  			 	span.text("Not a valid email");
  			 	}else{
  			 	img.attr("src","/assets/check.png");
  			 	span.text("Email is okay");
  			 	}
  			 	div.addClass("wrong-info");
  			 	div.addClass($this.attr("name"));
  			 }
  		});},1000);
}
});
if($(".down_btn").hasClass("disabled")){
$(".down_btn").data("lock",true);
}
$("span.content p.show").on("click",function(){
$this=$(this);
var minipost=$this.parents(".minipost");
var offset=$(".minipost.true").offset();//topcomment
 minipost.data("minipost_position",minipost.parent().children().index(minipost));
$(".minipost").addClass("hidden");
minipost.removeClass("hidden");
$(".down_btn").addClass("disabled");
	if(minipost.hasClass("true") || minipost==$(".minipost").filter(function(value){!$(value).hasClass("hidden")})[0]){
		
	}else{
	 minipost.css({top:"0px",left:"0px"});
	}
	var old_content=minipost.children(".content").text();
	var hidden_content=minipost.find(".hidden_content");
	minipost.find("p.show").remove();
	minipost.children(".content").text(hidden_content.text());
 	minipost.find(".hidden_content").text(old_content);
 	var reply=$(document.createElement('i'));
 	var btn=$(document.createElement('div'));
 	btn.addClass("go_back");
 	btn.append(reply);
 	minipost.append(btn);
 	reply.addClass("icon-reply");
 	reply.addClass("icon-white");
});
var pshow=true;//global bool key to lock below event handler, so that it only executes once.
$(document).on("click","span.content p.show",function(){
	if(pshow){
$this=$(this);
pshow=false;
var minipost=$this.parents(".minipost");
var offset=$(".minipost.true").offset();//topcomment
 minipost.data("minipost_position",minipost.parent().children().index(minipost));
$(".minipost").addClass("hidden");
minipost.removeClass("hidden");
$(".down_btn").addClass("disabled");
	if(minipost.hasClass("true") || minipost==$(".minipost").filter(function(value){!$(value).hasClass("hidden")})[0]){
		//nothing goes
	}else{
	 minipost.css({top:"0px",left:"0px"});
	}
	var old_content=minipost.children(".content").text();
	var hidden_content=minipost.find(".hidden_content");
	minipost.find("p.show").remove();
	minipost.children(".content").text(hidden_content.text());
 	minipost.find(".hidden_content").text(old_content);
 	var reply=$(document.createElement('i'));
 	var btn=$(document.createElement('div'));
 	btn.addClass("go_back");
 	btn.append(reply);
 	minipost.append(btn);
 	reply.addClass("icon-reply");
 	reply.addClass("icon-white");
 }
 });
if($(".down_btn").length>0){
	$(".down_btn").data("index",0);
}
$(".down_btn").on("click",function(){
	$this=$(this);
	if($this.hasClass("disabled")){return false;}
	$this.data("index",$this.data("index")+5);
	if($this.data("index")>=5){
		$(".up_btn").removeClass("disabled");
	}
	var reached_end=false;
	$(".minipost").each(function(index,value){
		if(index>=$this.data("index") && index<$this.data("index")+5){
			$(value).removeClass("hidden");
			reached_end=true;
		}else{
			$(value).addClass("hidden");
			reached_end=false;
		}
	});
	if(reached_end){$this.addClass("disabled");}
});
$(".up_btn").on("click",function(){
	$this=$(this);
	$$this=$(".down_btn");//they are like counterparts
	if($this.hasClass("disabled")){return false;}
	$$this.data("index",$$this.data("index")-5);
	if($$this.data("index")<5){
		$this.addClass("disabled");
		$$this.removeClass("disabled");
	}
	$(".minipost").each(function(index,value){
		if(index>=$$this.data("index") && index<$$this.data("index")+5){
			$(value).removeClass("hidden");
		}else{
			$(value).addClass("hidden");
		}
	});
});
$(document).on("click",".go_back",function(){//make the page normal again
$this=$(this);
var minipost=$this.parent();
var $$this=$(".down_btn");
var pos=minipost.data("minipost_position");
var content=minipost.children(".content");
pshow=true;
if(!$$this.data("lock")) $$this.removeClass("disabled");
pos==0?minipost.prependTo($(".wrapper")):minipost.insertAfter($(".minipost")[pos-1]);
		var old_content=content.text();
		content.text(minipost.find(".hidden_content").text().substr(0,minipost.find(".hidden_content").text().length-3))
		minipost.find(".hidden_content").text(old_content);
		$(".minipost").each(function(index,value){
		if(index>=$$this.data("index") && index<$$this.data("index")+5){
			$(value).removeClass("hidden");
		}else{
			$(value).addClass("hidden");
		}
	});
		var show=$(document.createElement('p'));
		show.addClass("show");
		show.text("...");
		minipost.children(".content").append(show);
		minipost.removeAttr("style");
		minipost.children(".go_back").remove();
	
});
function constructComment(comment){
	var comment_wrapper=$(document.createElement('li'));
	var name=$(document.createElement('p'));
	var body=$(document.createElement('p'));
	var container=$(document.createElement('div'));
	var likes=$(document.createElement('span'));
	var commentz=$(document.createElement('span'));
	var timestamp=$(document.createElement('span'));
	comment_wrapper.addClass("comment_wrapper");
	name.addClass("name");
	name.text(comment.children("p").text());
	med_container.addClass("container");
	meds.addClass("likez");meds.text(1);
	commentz.addClass("commentz");
	commentz.text("0");
	timestamp.addClass("timestamp");timestamp.text("Posted 1 second ago");
	body.addClass("body");
	body.text(comment.find("textarea").val());
	comment_wrapper.append(body);
	comment_wrapper.append(name);
	comment_wrapper.append(container);
	container.append(name)
	container.append(likes);
	container.append(commentz);
	comment_wrapper.append(timestamp);
	comment_wrapper.prependTo($("ol.comments"));
	$(".comment_wrapper").fadeTo(500,1);
	$(".comments i").trigger("click");
}
var comment_text_key=true;
$(document).on("keypress",".comment_text textarea",function(e){
if(e.type=="keypress" && e.which==13){//also dont forget to replicate validations on the server side
	if(comment_text_key){
	var $this=$(this);
	if($this.val()=="" || $this.val().legnth<3){return false;}
//exit if the user submits 
		var id=$(".main_content").attr('id');
		$.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/create_a_comment',
  		data: {micropost_id:id,body:$this.val()},
  	}).done(function(response){
  		
	if(response.valid==true){//animate a DIY bounce effect
		constructComment($this.parent());
		comment_text_key=false;

	}
	else{//error
	var offset=$this.parent().offset();
	var error_msg=$(document.createElement('div'));
	$(document.body).append(error_msg);
	error_msg.addClass("error");
	error_msg.text("something went wrong");
	error_msg.fadeOut(1000);
	}

  	});
}else{comment_text_key=true;}
}
});
$(".commentz").on("click",function(){
if(!$(this).hasClass("active")){
 	var comment=$(document.createElement('div'));
 	var name=$(document.createElement('p'));
	var text=$(document.createElement('textarea'));
	var p=$(this).parent().parent();
	comment.addClass("comment_text");
	comment.appendTo($(document.body));
	comment.append(text);
	comment.prepend(name);
	$(".commentz").each(function(index,value){//shut off everythign else
		if($(value).hasClass("active") && $(value)!=$(this)){$(value).trigger("click");}
	});
	$(".comments i").parent().hasClass("active")?$(".comments i").trigger("click"):"nothing"
	comment.css({top:p.offset().top+20+'px',left:p.offset().left+p.width()+30+'px'});
	$(this).addClass("active");
	name.text($("#header .username").text());
	var comments=$("ol.comments li");
	}else{
		$(".comment_text").remove();
		$(this).removeClass("active");
		var comments=$("ol.comments li");
	}
});
$(document.body).on("keypress",function(e){
if(e.type=="keypress" && e.which==18){//also dont forget to replicate validations on the server side
console.log("hey");
}
});
$(".likez").on("click",function(){
	$this=$(this);
	var comment=$this.parent().parent();
	if(!$this.hasClass("upped")){
            $this.text(parseInt($this.text())+1);
            $this.addClass("upped");
    }else{
    $this.removeClass("upped");
	$this.text(parseInt($this.text())-1);
	}
$.ajax({
		type: "post",
		dataType: "json",
  		url: '/commands/comments/inc',
  		data: {id:comment.attr("id")},
  	}).done(function(response){
  	});
});
