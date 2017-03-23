class Logout extends React.Component {

  _handleLogout(event) {
    event.preventDefault();

    this.props.setAccessToken(null);
  }

  render () {
    return (
      <li><a onClick={ this._handleLogout.bind(this) }>Logout</a></li>
    );
  }
}
