class Header extends React.Component {

  _handleTicketsClick(event) {
    event.preventDefault();

    this.props.setRoute("tickets");
  }

  _handleUsersClick(event) {
    event.preventDefault();

    this.props.setRoute("users");
  }

  render () {
    return (
      <nav className="navbar navbar-default navbar-fixed-top">
        <div className="container">
          <div className="navbar-header">
            <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="    navbar">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a id="logo" href="#">Tickets System</a>
          </div>
          <div id="navbar" className="collapse navbar-collapse">
            <ul className="nav navbar-nav pull-right">

              <li><a onClick={ this._handleTicketsClick.bind(this) }>Tickets</a></li>
              <li><a onClick={ this._handleUsersClick.bind(this) }>Users</a></li>

              {(() => {
                if (this.props.access_token) {
                  return <Logout
                    setAccessToken={ this.props.setAccessToken } />
                }
              })()}

            </ul>
          </div>
        </div>
      </nav>
    );
  }
}
