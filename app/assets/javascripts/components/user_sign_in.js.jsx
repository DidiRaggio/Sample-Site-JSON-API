var UserSignIn = React.createClass({
  propTypes: {
    email: React.PropTypes.string,
    password: React.PropTypes.string

  },
  getInitialState: function() {
    return {
      email: '',
      password: ''


    }
  },
  handleAdd: function(e) {
    e.preventDefault();

    var self = this;
    console.log(JSON.stringify(self.state));
    if (this.validForm()) {
      $.ajax({
        url: 'http://api.whippering.dev:3000/sessions',
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        // dataType: 'json',
        data: JSON.stringify(self.state),
        success: function(data) {
          self.props.handleAdd(data);
          // console.log(self);
          // console.log(self.state);
          self.setState(self.getInitialState());
          // console.log(data);
        },
        error: function(xhr, status, error) {
          console.log(error);
          alert('Sorry, the email or the password is incorrect: ', error);
        }
      })
    } else {
      alert('Please fill all fields.');
    }
  },
  signUpUser: function(e) {
    e.preventDefault();
    var self = this;
    self.props.signUpUser();
  },
  validForm: function() {
    if (this.state.email && this.state.password) {
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
          <button type="submit" className="btn btn-primary">Add</button>
        </form>
        <button onClick={this.signUpUser}>SIGN UP!</button>
      </div>
    )
  }
});