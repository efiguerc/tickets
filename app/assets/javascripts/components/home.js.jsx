class Home extends React.Component {

  _handleStartClick(event) {
    event.preventDefault();

    this.props.setRoute("tickets");
  }

  render () {
    return (
      <div className="row">
        <div className="center jumbotron img-responsive col-md-12 col-xs-12">
          <div className="col-md-2 col-md-offset-5">
            <img id="logo-big" className="img-responsive" alt="Tickets System" src="http://metricswatch.com/wp-content/uploads/2016/03/logo-100px.png" />
          </div>
          <div className="col-md-12">
            <h1>Welcome to Tickets System</h1>
            <h2>A place where you can ask for infraestructure support any time!</h2>
            <a className="btn btn-lg btn-primary" onClick={this._handleStartClick.bind(this)}>Let's Start</a>
          </div>
        </div>
      </div>
    );
  }
}
