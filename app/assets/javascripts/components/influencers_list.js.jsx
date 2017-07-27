
var InfluencersList = React.createClass({
  render: function() {
    var influencers = [];
    this.props.influencers.forEach(function(influencer) {
      influencers.push(<Influencer influencer={influencer}
                         key={'influencer' + influencer.id}/>);
    }.bind(this));
    return(
      <table className="table table-striped">
        <thead>
          <tr>
            <th className="col-md-3">Id</th>
            <th className="col-md-2">Email</th>
            <th className="col-md-3">Created At</th>
            <th className="col-md-3">Updated At</th>
            <th className="col-md-4">Is Dev</th>
            <th className="col-md-4">Authorization Token</th>
            <th className="col-md-4">Picture URL</th>
            <th className="col-md-4">Medium Picture URL</th>
            <th className="col-md-4">Thumb Picture URL</th>
          </tr>
        </thead>
        <tbody>
          {influencers}
        </tbody>
      </table>
    )
  }
});