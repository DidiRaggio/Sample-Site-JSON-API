var App =
  React.createClass({
    componentWillMount: function() {
      $.ajax({
        method: "GET",
        url: "http://api.whippering.dev:3000/sessions/is_signed_in"
      })
      .done(function(data){
        this.setState({ signedIn: data.signed_in });
      }.bind(this));
    },
    getInitialState: function() {
      return { signedIn: null };
    },
    render:function(){
      return <RouteHandler signedIn={this.state.signedIn}/>;
    }
});