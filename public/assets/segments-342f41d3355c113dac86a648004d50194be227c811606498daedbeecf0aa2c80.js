$(document).ready(function(){$("#new_segment").on("ajax:success",function(e,s,n){window.location.reload(window.location.pathname+"?tab=segments")}).on("ajax:error",function(e,s,n){var o=JSON.parse(s.responseText).errors;$(".form-message-container").html(o)}),$(".remove-reference-from-segment").bind("ajax:complete",function(){$(this).closest(".reference-row").remove()}),$(".delete-segment").bind("ajax:complete",function(){$(this).closest(".segment-single").remove()}),$(".js-tag-control").on("click",function(e){e.preventDefault(),$(this).hasClass("js-active")||($(".js-tag-control").siblings(".js-active").removeClass("js-active"),$(this).addClass("js-active")),$("#js-bulk-add-references").is(":visible")?($("#js-bulk-add-references").hide(),$("#js-bulk-reference-group-section").css("display","block")):($("#js-bulk-add-references").show(),$("#js-bulk-reference-group-section").hide())})});