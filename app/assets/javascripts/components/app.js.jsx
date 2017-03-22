class App extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      current_route: "home"
    };
  }

  _setRoute(route) {
    this.setState({current_route: route});
  }

  render () {
    return (
      <div>
        <Header />
        <div className="container">

          {(() => {
            switch (this.state.current_route) {
              case "home":    return <Home setRoute={ this._setRoute.bind(this) } />
              case "tickets": return <Tickets setRoute={ this._setRoute.bind(this) } />
            }
          })()}

          <Footer />
        </div>
      </div>
    );
  }
}
