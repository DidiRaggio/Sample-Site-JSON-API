var Submission = React.createClass({
  propTypes: {
    id: React.PropTypes.number,
    pitch_id: React.PropTypes.number,
    dev_id: React.PropTypes.number,
    influencer_id: React.PropTypes.number,
    dev_note: React.PropTypes.string,
    is_approved: React.PropTypes.bool,
    feedback: React.PropTypes.string,
  },
  render: function() {
    console.log(this.props.submission)
    var submission = this.props.submission;
    return(
      <tr>
        <td>{submission.id}</td>
        <td>{submission.pitch_id}</td>
        <td>{submission.dev_id}</td>
        <td>{submission.influencer_id}</td>
        <td>{submission.dev_note}</td>
        <td>{submission.is_approved}</td>
        <td>{submission.feedback}</td>
      </tr>
    )
  }
});
