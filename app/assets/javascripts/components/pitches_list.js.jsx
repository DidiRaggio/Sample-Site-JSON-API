
var PitchesList = React.createClass({

  
  // deleteLift: (lift) ->
  //   lifts = @state.lifts.slice()
  //   index = lifts.indexOf lift
  //   lifts.splice index, 1
  //   @replaceState lifts: lifts


  render: function() {
    var pitches = [];
    var auth_token = this.props.auth_token
    this.props.pitches.forEach(function(pitch) {
      pitches.push(<Pitch auth_token={auth_token} pitch={pitch}
                         key={'pitch' + pitch.id}/>);
    }.bind(this));
    return(
      <table className="table table-striped">
        <thead>
          <tr>
            <th className="col-md-3">Id</th>
            <th className="col-md-2">Title</th>
            <th className="col-md-3">Body</th>
            <th className="col-md-4">Video</th>
            <th className="col-md-3">Expected Release Date</th>
            <th className="col-md-2">Website</th>
            <th className="col-md-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {pitches}
        </tbody>
      </table>
    )
  }
});