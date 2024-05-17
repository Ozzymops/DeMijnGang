function eventsList() {
    var emList = document.getElementsByClassName('em-customlist');

    if (emList.length > 0) {
        // Add a <div> to the page with the class `em-customlist`  
        // TODO: Featured event on left-hand side, list of next five miscellaneous events on right-hand side
        var dateToday = new Date();
        let stringToday = dateToday.toLocaleDateString("local", {weekday:"long", month:"long", day:"numeric"});
            
        var dateFuture = new Date();
        dateFuture.setDate(dateToday.getDate() + 30);
        let stringFuture = dateFuture.toLocaleDateString("local", {weekday:"long", month:"long", day:"numeric"});
            
        let scope = `scope="${dateToday.toISOString().split('T')[0]},${dateFuture.toISOString().split('T')[0]}"`;
            
        emList[0].innerHTML = '[events_list $(scope)]<span><p class="event-list-entry-left">#_EVENTLINK</p><p class="event-list-entry-right">#_EVENTDATES, #_EVENTTIMES</p><p>#_EVENTEXCERPT</p></span>[/events_list]';
    }
}

window.onload = eventsList();