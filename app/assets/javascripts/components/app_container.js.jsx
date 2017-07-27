var AppContainer = React.createClass({
  // mixins: [ReactPersistentState],
  getInitialState: function() {
      return { 
          current_user_object: [],
          current_user: [],
          influencers: []
       };
  },
  componentWillMount: function() {
    // console.log("Component is Mounting, but componentDidMount has access to props and state but not the DOM");
    // console.log(this.state);
    // console.log(this.props);
    this.setState({ current_user_object: this.props.current_user });
    this.props.getUserSerializer(this.props.current_user);    
  },
  getUserSerializer: function(current_user_object) {
        // current_user_object.preventDefault();

    var self = this;
    console.log(current_user_object);
    console.log('http://api.whippering.dev:3000/users/' + current_user_object.id);
    console.log(current_user_object.auth_token );
      $.ajax({
        url: 'http://api.whippering.dev:3000/users/' + current_user_object.id,
        method: 'GET',
        headers: { "Authorization": current_user_object.auth_token },
        dataType: 'json',
        // data: JSON.stringify(self.state),
        success: function(data) {
          // self.props.handleAdd(data);
          // console.log(self);
          // console.log(self.state);

          console.log('this is the data');
          console.log(data);
          // console.log(data);

          // self.setState({ current_user: data});
          // console.log(data);
        },
        error: function(xhr, status, error) {
          console.log(self)
          alert('Sorry, could not get user info: ', error);
        }
      })
     },
  // signUpUser: function() {
  //   // ReactDOM.unmountComponentAtNode(document.getElementById('user-sign-in'));
  //   ReactDOM.render(
  //     <UserSignUpForm handleAdd={this.handleAdd} backToUserSignIn={this.backToUserSignIn}/>, document.getElementById('user-sign-in')
  
  //   );

  // },

  // backToUserSignIn: function(){
  //   ReactDOM.render(
  //     <UserSignIn handleAdd={this.handleAdd} signUpUser={this.signUpUser}/>, document.getElementById('user-sign-in')
  
  //   );
  // },
  // handleAdd: function(user) {
  //   this.setState({ current_user: user, signedIn: true });
  //   ReactDOM.render(<CurrentUser data={this.state}/>, document.getElementById('user-sign-in'));
  //   // if (user.is_dev == true) {
  //   //   this.findInfluencers(user.auth_token);
  //   //   ReactDOM.render(<PitchesList auth_token={this.state.current_user.auth_token} pitches={this.state.current_user.pitches}/>, document.getElementById('pitches'));
  //   //   ReactDOM.render(<SubmissionsList submissions={this.state.current_user.submissions}/>, document.getElementById('submissions'));
  //   // } else {
  //   //   ReactDOM.render(<ReceivedSubmissionsList received_submissions={this.state.current_user.received_submissions}/>, document.getElementById('submissions'));

  //   // }
  // },

  // findInfluencers: function(auth_token) {
  //   // e.preventDefault();
  //   // console.log(this);
  //   var self = this;

  //   // auth_token = this.state.auth_token
  //   // console.log(auth_token);
  //   // console.log(self.state)
  //   $.ajax({
  //     url: 'http://api.whippering.dev:3000/users',
  //     method: 'GET',
  //     headers: { "Authorization": auth_token },
  //     // dataType: 'json',
  //     // data: JSON.stringify(self.state.current_user),
  //     success: function(data) {
  //       // console.log(data);
  //       self.setState({ influencers: data});
  //       self.displayInfluencers(data);
  //     },
  //     error: function(xhr, status, error) {
  //       alert('Sorry, only devs can see influencers: ', error);
  //     }
  //   })

  // },  

  // displayInfluencers: function(influencers) {
  //   // console.log({influencers});
  //   ReactDOM.render(<InfluencersList influencers={influencers}/>, document.getElementById('influencers'));
  // },
  // componentDidMount: function() {
  //   // console.log('component did mount and this is the state');
  //   // console.log(this.state)
  // },
  render: function() {
    // console.log(this.state.current_user_object);
    // console.log(this.props.current_user);
    // console.log(this.state);
    console.log(this.state.current_user_object.auth_token);
    // console.log(current_user);
    // console.log('component did render and this is the state');
    // console.log(this.state)
    // signedIn = this.state.current_user;
    // console.log(this.state.signedIn);
    // console.log("the variable")
    // console.log(signed_in == false);
    // var current_user = this.state.current_user;
    // if (this.state.current_user.length == 0) {
    // if (signedIn == false) {
      return(
        <div className="container">
          <div className="jumbotron">
            <h1>GAMEBITY</h1>
          </div>
          <div className="row">
            <div id="user-sign-in" className="col-md-12">
              <CurrentUser current_user={this.state.current_user}/>
             
              
            </div>

          </div>
          <div className="row">
            <div id="pitches" className="col-md-12">

            </div>

          </div>
          <div className="row">
            <div id="influencers" className="col-md-12">

            </div>

          </div>
          <div className="row">
            <div id="submissions" className="col-md-12">

            </div>

          </div>
        </div>
      )

  }



});











































// var AppContainer = React.createClass({
//   // mixins: [ReactPersistentState],
//   getInitialState: function() {
//       return { 
//           signedIn: false,
//           current_user: [],
//           influencers: []
//        };
//   },

//   signUpUser: function() {
//     // ReactDOM.unmountComponentAtNode(document.getElementById('user-sign-in'));
//     ReactDOM.render(
//       <UserSignUpForm handleAdd={this.handleAdd} backToUserSignIn={this.backToUserSignIn}/>, document.getElementById('user-sign-in')
  
//     );

//   },

//   backToUserSignIn: function(){
//     ReactDOM.render(
//       <UserSignIn handleAdd={this.handleAdd} signUpUser={this.signUpUser}/>, document.getElementById('user-sign-in')
  
//     );
//   },
//   handleAdd: function(user) {
//     this.setState({ current_user: user, signedIn: true });
//     ReactDOM.render(<CurrentUser data={this.state}/>, document.getElementById('user-sign-in'));
//     // if (user.is_dev == true) {
//     //   this.findInfluencers(user.auth_token);
//     //   ReactDOM.render(<PitchesList auth_token={this.state.current_user.auth_token} pitches={this.state.current_user.pitches}/>, document.getElementById('pitches'));
//     //   ReactDOM.render(<SubmissionsList submissions={this.state.current_user.submissions}/>, document.getElementById('submissions'));
//     // } else {
//     //   ReactDOM.render(<ReceivedSubmissionsList received_submissions={this.state.current_user.received_submissions}/>, document.getElementById('submissions'));

//     // }
//   },

//   findInfluencers: function(auth_token) {
//     // e.preventDefault();
//     // console.log(this);
//     var self = this;

//     // auth_token = this.state.auth_token
//     // console.log(auth_token);
//     // console.log(self.state)
//     $.ajax({
//       url: 'http://api.whippering.dev:3000/users',
//       method: 'GET',
//       headers: { "Authorization": auth_token },
//       // dataType: 'json',
//       // data: JSON.stringify(self.state.current_user),
//       success: function(data) {
//         // console.log(data);
//         self.setState({ influencers: data});
//         self.displayInfluencers(data);
//       },
//       error: function(xhr, status, error) {
//         alert('Sorry, only devs can see influencers: ', error);
//       }
//     })

//   },  

//   displayInfluencers: function(influencers) {
//     // console.log({influencers});
//     ReactDOM.render(<InfluencersList influencers={influencers}/>, document.getElementById('influencers'));
//   },
//   componentDidMount: function() {
//     // console.log('component did mount and this is the state');
//     // console.log(this.state)
//   },
//   render: function() {
//     console.log(this.props.sent_in_user)
//     // console.log('component did render and this is the state');
//     // console.log(this.state)
//     signedIn = this.state.signedIn;
//     // console.log(this.state.signedIn);
//     // console.log("the variable")
//     // console.log(signed_in == false);
//     // var current_user = this.state.current_user;
//     // if (this.state.current_user.length == 0) {
//     // if (signedIn == false) {
//       return(
//         <div className="container">
//           <div className="jumbotron">
//             <h1>PLEASE SIGN IN</h1>
//           </div>
//           <div className="row">
//             <div id="user-sign-in" className="col-md-12">

//               <UserSignIn handleAdd={this.handleAdd} signUpUser={this.signUpUser}/>
              
//             </div>

//           </div>
//           <div className="row">
//             <div id="pitches" className="col-md-12">

//             </div>

//           </div>
//           <div className="row">
//             <div id="influencers" className="col-md-12">

//             </div>

//           </div>
//           <div className="row">
//             <div id="submissions" className="col-md-12">

//             </div>

//           </div>
//         </div>
//       )

//   }



// });

