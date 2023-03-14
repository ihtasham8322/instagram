function comments_show() {
    id = window.event.target.id
    var comments_area_div = document.getElementById("comments_area" + id);
    var edit_delete_div = document.getElementById("comments" + id);
    if (comments_area_div.style.display === "block" && edit_delete_div.style.display === "block") {
        comments_area_div.style.display = "none";
        edit_delete_div.style.display = "none";
    } else {
        comments_area_div.style.display = "block";
        edit_delete_div.style.display = "block";
    }
}