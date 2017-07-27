var CurrentUser = React.createClass({
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

    
    // console.log('this is the currenuser comp');
    // console.log(this.state);
    var current_user = this.props.current_user;
    // console.log(current_user);
    // console.log('this is the currenuser comp with data');
    // console.log(state);
    // console.log(current_user.pitches);
    // console.log(current_user.submissions);
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
                <tr>
                    <td>{current_user.id}</td>
                    <td>{current_user.email}</td>
                    <td>{current_user.created_at}</td>
                    <td>{current_user.updated_at}</td>
                    <td>{current_user.is_dev}</td>
                    <td>{current_user.auth_token}</td>
                    <td>{current_user.picture}</td>
                    <td>{current_user.medium_picture}</td>
                    <td>{current_user.thumb_picture}</td>
                </tr>
            </tbody>
          </table>
        )
  }
});