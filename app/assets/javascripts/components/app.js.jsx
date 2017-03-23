class App extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      current_route: "tickets",
      access_token: null,
      role: null
    };
  }

  _setRoute(route) {
    this.setState({ current_route: route });
  }

  _setAccessToken(data) {
    if (data) {
      this.setState({ access_token: data.access_token, role: data.role });
    } else {
      this.setState({ access_token: null });
    }
  }

  render () {
    return (
      <div>
        <Header
          access_token={ this.state.access_token }
          setAccessToken={ this._setAccessToken.bind(this) }
          setRoute={ this._setRoute.bind(this) } />
        <div className="container">

          {(() => {
            if (!this.state.access_token) {
              return <Login
                setAccessToken={ this._setAccessToken.bind(this) } />
            } else {
              switch (this.state.current_route) {
                case "tickets": return <Tickets
                  access_token={ this.state.access_token }
                  setRoute={ this._setRoute.bind(this) } />
                case "users": return <Users
                  access_token={ this.state.access_token }
                  setRoute={ this._setRoute.bind(this) } />
                default: return <Home setRoute={ this._setRoute.bind(this) } />
              }
            }
          })()}

          <Footer />
        </div>
      </div>
    );
  }
}
