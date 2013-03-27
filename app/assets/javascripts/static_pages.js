$("#header .username").on("mouseenter mouseleave",function(event){
$this=$(this);
$(".username_dropdown").on("mouseenter mouseleave",function(event){
	console.log(5);
	if(event.type=="mouseenter"){$(this).addClass("active");}else{$(this).removeClass("active");$this.trigger("mouseleave");}
});
if(!$this.hasClass("active")){
$this.addClass("active");
var offset=$this.offset();
var dropdown=$(document.createElement('div'));
var option=$(document.createElement('a'));
$(document.body).append(dropdown);
dropdown.addClass("username_dropdown");
option.addClass("option");
option.text("post");
option.attr("href","/post");
dropdown.css({
	top:offset.top+34+'px',
	left:offset.left+10+'px'
});
$this.find(".icon-caret-down").removeClass("icon-caret-down").addClass("icon-caret-right");
dropdown.append(option);
}else{
	setTimeout(function(){
	var dropdown=$(".username_dropdown");
	if(!dropdown.hasClass("active")){
$this.removeClass("active");
$this.find(".icon-caret-right").removeClass("icon-caret-right").addClass("icon-caret-down");
dropdown.remove();
}
},500);
}
});
if($(".container_login.post").length>0){
var $this=$(".container_login.post");
$this.addClass("postit");
}
$(document).on("click",".icon-magic",function(){
	$this=$(".icon-magic");
	$(".minipost_form").show();
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
  			link_to_post.addClass("link_to_post");
  			link_to_post.text(response.url)
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

//signup form ajax helper tell the user if username and email have been used before