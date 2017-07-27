var UserSignUpForm = React.createClass({
  propTypes: {
    email: React.PropTypes.string,
    password: React.PropTypes.string,
    password_confirmation: React.PropTypes.string

  },
  getInitialState: function() {
    return {
      email: '',
      password: '',
      password_confirmation: ''


    }
  },
  handleAdd: function(e) {
    e.preventDefault();
    var self = this;
    // console.log( JSON.stringify({ user: self.state }));
    if (this.validForm()) {
      $.ajax({
        url: 'http://api.whippering.dev:3000/users',
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        // dataType: 'json',
        data: JSON.stringify({ user: self.state }),
        success: function(data) {
          self.props.handleAdd(data);
          self.setState(self.getInitialState());
        },
        error: function(xhr, status, error) {
          // console.log(this.state)
          alert('Sorry, the email or the password or password confirmation is incorrect: ', error);
        }
      })
    } else {
      alert('Please fill all fields.');
    }
  },
  backToUserSignIn: function(e) {
    e.preventDefault();
    var self = this;
    self.props.backToUserSignIn();
  },

  validForm: function() {
    if (this.state.email && this.state.password && this.state.password_confirmation) {
      return true;
    } else {
      return false;
    }
  },
  handleChange: function(e) {
    var input_name = e.target.name;
    var value = e.target.value;
    this.setState({ [input_name] : value });
  },
  render: function() {
    return(
      <div>
        <form className="form-inline" onSubmit={this.handleAdd}>
          <div className="form-group">
            <input type="text"
                   className="form-control"
                   name="email"
                   placeholder="Email"
                   ref="email"
                   value={this.state.email}
                   onChange={this.handleChange} />
          </div>
          <div className="form-group">
            <input type="text"
                   className="form-control"
                   name="password"
                   placeholder="Password"
                   ref="password"
                   value={this.state.password}
                   onChange={this.handleChange} />
          </div>
          <div className="form-group">
            <input type="text"
                   className="form-control"
                   name="password_confirmation"
                   placeholder="Password Confirmation"
                   ref="password_confirmation"
                   value={this.state.password_confirmation}
                   onChange={this.handleChange} />
          </div>
          <button type="submit" className="btn btn-primary">Add</button>
        </form>
        <button onClick={this.backToUserSignIn}>Already Signed Up?</button>
      </div>
    )
  }
});