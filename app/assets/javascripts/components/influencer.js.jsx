var Influencer = React.createClass({
  propTypes: {
    id: React.PropTypes.number,
    email: React.PropTypes.string,
    created_at: React.PropTypes.string,
    updated_at: React.PropTypes.string,
    is_dev: React.PropTypes.bool,
    auth_token: React.PropTypes.string,
    picture: React.PropTypes.string,
    medium_picture: React.PropTypes.string,
    thumb_picture: React.PropTypes.string,
    submissions: React.PropTypes.array,
    received_submissions: React.PropTypes.array,
    pitches: React.PropTypes.array
  },
  render: function() {
    var influencer = this.props.influencer;
    return(
      <tr>
        <td>{influencer.id}</td>
        <td>{influencer.email}</td>
        <td>{influencer.created_at}</td>
        <td>{influencer.updated_at}</td>
        <td>{influencer.is_dev}</td>
        <td>{influencer.auth_token}</td>
        <td>{influencer.picture}</td>
        <td>{influencer.medium_picture}</td>
        <td>{influencer.thumb_picture}</td>
      </tr>
    )
  }
});


