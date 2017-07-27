
var SubmissionsList = React.createClass({
  render: function() {
    var submissions = [];
    this.props.submissions.forEach(function(submission) {
      submissions.push(<Submission submission={submission}
                         key={'submission' + submission.id}/>);
    }.bind(this));
    console.log(this.props.submissions)
    return(
      <table className="table table-striped">
        <thead>
          <tr>
            <th className="col-md-3">Id</th>
            <th className="col-md-2">Pitch Id</th>
            <th className="col-md-3">Developer</th>
            <th className="col-md-4">Influencer</th>
            <th className="col-md-3">Developer Note</th>
            <th className="col-md-2">Is Approved</th>
            <th className="col-md-2">Feedback</th>
          </tr>
        </thead>
        <tbody>
          {submissions}
        </tbody>
      </table>
    )
  }
});