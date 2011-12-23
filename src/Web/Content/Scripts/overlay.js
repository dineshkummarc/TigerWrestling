function addOverlay() {
	//Configure overlay for each hyperlink with a rel="#overlay" attribute
	$("a[rel]").overlay({
		mask: {
			color: '#000',
			loadSpeed: 200,
			opacity: 0.5
		},
		onBeforeLoad: function () {
			//fix for ie6 and ie7, allows content in front of mask
			this.getOverlay().appendTo('body');
			//Grab wrapper element inside content
			var wrap = this.getOverlay().find(".externalContent");
			if (wrap) {
				//Load the page specified in the trigger
				wrap.load(this.getTrigger().attr("href"));
			}
		}
	});
}