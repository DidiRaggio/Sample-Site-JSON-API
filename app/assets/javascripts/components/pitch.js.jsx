var Pitch = React.createClass({

  getInitialState: function() {
    return {
      edit: false
    }
  },
  propTypes: {
    id: React.PropTypes.number,
    body: React.PropTypes.string,
    video: React.PropTypes.string,
    expected_release_date: React.PropTypes.string,
    website: React.PropTypes.string,
  },
  handleToggle: function(e) {
    e.preventDefault();
    this.setState({ edit: !(this.state.edit) });
  },
  handleDelete: function(user_id, pitch_id, auth_token) {
        console.log('THIS IS IN THE DELETE METHOD');
        console.log(user_id);
        console.log(pitch_id);
        console.log(auth_token);
      $.ajax({
        url: 'http://api.whippering.dev:3000/users/' +  user_id + '/pitches/' + pitch_id,
        method: 'DELETE',
        headers: { "Authorization": auth_token },
        // dataType: 'json',
        // data: JSON.stringify(self.state),
        success: function() {
            console.log(auth_token);
          // self.props.handleAdd(data);
          // // console.log(self);
          // // console.log(self.state);
          // self.setState(self.getInitialState());
          // // console.log(data);
        },
        error: function(xhr, status, error) {
            // console.log(auth_token);
            // console.log('http://api.whippering.dev:3000/users/' +  user_id + '/pitches/' + pitch_id);
          alert('Sorry, the email or the password is incorrect: ', error);
        }
      })
 
  },
  // handleToggle: (e) ->
  //   e.preventDefault()
  //   @setState edit: !@state.edit
  // handleDelete: (e) ->
  //   e.preventDefault()
  //   $.ajax
  //     method: 'DELETE'
  //     url: "/lifts/#{ @props.lift.id }"
  //     dataType: 'JSON'
  //     success: () =>
  //       @props.handleDeleteLift @props.lift
  pitchRow: function(pitch, auth_token) {
    
    return(
      <tr>
        <td>{pitch.id}</td>
        <td>{pitch.title}</td>
        <td>{pitch.body}</td>
        <td>{pitch.video}</td>
        <td>{pitch.expected_release_date}</td>
        <td>{pitch.website}</td>
        <td>
            <button className='btn btn-primary' onClick={this.handleToggle}>Edit</button>
            <button className='btn btn-danger' onClick={this.handleDelete(pitch.user_id, pitch.id, auth_token)}>Delete</button>
        </td>
      </tr>
    )
  },
  pitchForm: function() {
        //     <form className="form-inline" onSubmit={this.handleAdd}>
        //   <div className="form-group">
        //     <input type="text"
        //            className="form-control"
        //            name="email"
        //            placeholder="Email"
        //            ref="email"
        //            value={this.state.email}
        //            onChange={this.handleChange} />
        //   </div>
        //   <div className="form-group">
        //     <input type="text"
        //            className="form-control"
        //            name="password"
        //            placeholder="Password"
        //            ref="password"
        //            value={this.state.password}
        //            onChange={this.handleChange} />
        //   </div>
        //   <button type="submit" className="btn btn-primary">Add</button>
        // </form>
  },
  render: function() {
    var pitch = this.props.pitch;
    var auth_token = this.props.auth_token
    console.log(auth_token);
    // console.log(pitch);
    // console.log(this.props.auth_token);
    // console.log('the pitch is editing');
    // console.log(this.state.edit == true);
    return(this.pitchRow(pitch, auth_token))
    
    // if (this.state.edit == true) {
    //     pitchRow();
    // } else {
    //     pitchForm();
    // }

  }
});
  // liftForm: ->
  //   React.DOM.tr null,
  //     React.DOM.td null,
  //       React.DOM.input
  //         className: 'form-control'
  //         type: 'date'
  //         defaultValue: @props.lift.date
  //         ref: 'date'
  //     React.DOM.td null,
  //       React.DOM.input
  //         className: 'form-control'
  //         type: 'text'
  //         defaultValue: @props.lift.liftname
  //         ref: 'liftname'
  //     React.DOM.td null,
  //       React.DOM.input
  //         className: 'form-control'
  //         type: 'number'
  //         defaultValue: @props.lift.weightlifted
  //         ref: 'weightlifted'
  //         onChange: @reCalculateOneRm
  //     React.DOM.td null,
  //       React.DOM.input
  //         className: 'form-control'
  //         type: 'number'
  //         min: '1'
  //         max: '10'
  //         defaultValue: @props.lift.repsperformed
  //         ref: 'repsperformed'
  //         onChange: @reCalculateOneRm
  //     React.DOM.td null,
  //       @state.onerm
  //     React.DOM.td null,
  //       React.DOM.button
  //         className: 'btn btn-primary'
  //         onClick: @toggleUnit
  //         'Metric = ' + @state.ismetric.toString()
  //     React.DOM.td null,
  //       React.DOM.button
  //         className: 'btn btn-primary'
  //         onClick: @handleEdit
  //         'Update'
  //       React.DOM.button
  //         className: 'btn btn-danger'
  //         onClick: @handleToggle
  //         'Cancel'
  // render: ->
  //   if @state.edit
  //     @liftForm()
  //   else
  //     @liftRow()