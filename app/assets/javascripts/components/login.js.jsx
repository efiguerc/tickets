class Login extends React.Component {

  _handleLogin(event) {
    event.preventDefault();

    let email = this._email;
    let password = this._password;

    $.ajax({
      url: '/api/v1/sessions',
      dataType: 'json',
      method: 'POST',
      beforeSend(xhr) {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
      },
      data: JSON.stringify({
        session: {
          email: email.value,
          password: password.value
        }
      }),
      success: (data) => {
        this.props.setAccessToken(data);
      },
      error: (xhr, ststus, err) => {
        e = {name: '_login', message: 'err: "' + err + '" Status: "'  + xhr.status + '" responseText:   ' + xhr.responseText};
        console.log(e);
      }
    });  
  }

  render () {
    return (
      <form onSubmit={ this._handleLogin.bind(this) }>
        <div className="form-group">
          <label htmlFor="exampleInputEmail1">Email address</label>
          <input type="email" className="form-control" id="exampleInputEmail1" placeholder="Email" ref={ (input) => this._email = input } />
        </div>
        <div className="form-group">
          <label htmlFor="exampleInputPassword1">Password</label>
          <input type="password" className="form-control" id="exampleInputPassword1" placeholder="Password" ref={ (input) => this._password = input } />
        </div>
        <button type="submit" className="btn btn-default">Login</button>
      </form>
    );
  }
}
