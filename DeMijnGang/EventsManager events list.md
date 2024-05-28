
```
<script>
    // Featured event
document.getElementById('featured-title').innerHTML = `[events_list category="featured" limit=1]#_EVENTLINK[/events_list]`
document.getElementById('featured-image').innerHTML = `[events_list category="featured" limit=1]{has_image}#_EVENTIMAGE{/has_image}[/events_list]`
document.getElementById('featured-excerpt').innerHTML = `[events_list category="featured" limit=1]#_EVENTEXCERPT[/events_list]`

    // List of events
    var today = new Date();
    var future = new Date();
    future.setDate(today.getDate() + 30);

    today = today.toISOString().split('T')[0];
    future = future.toISOString().split('T')[0];
    var scope = `scope="${today}, ${future}"`;

    document.getElementById('eventslist').innerHTML = `[events_list ${scope} limit=5]{no_category_featured}<div><h4>#_EVENTLINK</h4><p>#_EVENTDATES, #_EVENTTIMES</p><p>#_EVENTEXCERPT</p></div>{/no_category_featured}[/events_list]`;
</script>
```