var LifecycleContainer = React.createClass({
	mount: function() {
		ReactDOM.render(
			<LifecycleComponent />, document.getElementById('renderHere')
		);
	},
	unmount: function() {
		ReactDOM.unmountComponentAtNode(document.getElementById('renderHere'));
	},
	render: function() {
		console.log("LyfecycleContainer Rendered");
		return(
			<div>
				<button onClick={this.mount}>Mount</button>
				<button onClick={this.unmount}>Unmount</button>
				<div id="renderHere"></div>
			</div>
		)
	}
});