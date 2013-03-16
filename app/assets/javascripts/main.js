$(document).ready(function() {

  $("#search").autocomplete({
    source: '/main/autocomplete.js',
    minLength: 2, delay: 500,
    messages: {
        noResults: null,
        results: function() {}
    },
    focus: function(event, ui) {
      return false;
    },
  }).data("autocomplete")._renderItem = function(ul, item) {
    item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(this.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
    // https://forum.jquery.com/topic/using-html-in-autocomplete
    return $("<li></li>")
      .data("item.autocomplete", item)
      .append("<a href='/" + item.tipo + "/" + item.id + "'>" + item.label + "</a>").appendTo(ul);
  };
    
});
