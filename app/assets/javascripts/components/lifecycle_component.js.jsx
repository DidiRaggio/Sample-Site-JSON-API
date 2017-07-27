var LifecycleComponent = React.createClass({
	//1 CALLED ONCE
	//BEFORE COMPONENT IS RENDERED
	getDefaultProps: function() {
		console.log("Getting our default properties");	
	},
	//2 CALLED ONCE
	// BEFORE COMPONENT IS RENDERED
	getInitialState: function() {
		console.log("Getting our initial state");
		return{
			count: 0
		};
	},
	//3 CALLED ONCE
	//BEFORE COMPONENT IS RENDERED
	componentWillMount: function() {
		console.log("Component is Mounting, but componentDidMount has access to props and state but not the DOM");
		console.log(this.state);
		console.log(this.props);		
	},
	//OUR CUSTOM METHOD, NOT PART OF LIFECYCLE
	increment: function() {
		this.setState({
			count: this.state.count + 1
		});
		console.log(this.state)
	},
	componentDidMount: function() {
		console.log("component has rendered");
		console.log("componentDidMount has access to the dom, the state, the props");
		console.log(this.state);
		console.log(this.props);
		console.log(ReactDOM.findDOMNode(this));
		this.interval = setInterval(this.increment, 1000);
	},
	componentWillUnmount: function() {
		clearInterval(this.interval);
		console.log("component Unmounted!");

	},
	//4 RENDER
	// HAPPENS WHENEVER OUR COMPONENT CHANGES
	render: function() {
		console.log('Componend is rendered');
		return(
			<button onClick={this.increment}>{this.state.count}</button>
		);
	}

});
