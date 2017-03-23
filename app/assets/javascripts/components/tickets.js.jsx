class Tickets extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      show_ticket: false,
      current_ticket: null
    };
  }

  _showTicket(ticket) {
    this.setState({ show_ticket: true, current_ticket: ticket });
  }

  render () {

    let body = null;

    if (this.state.show_ticket) {
      body = <TicketsShow
        access_token={ this.props.access_token }
        ticket={ this.state.current_ticket } />
    } else {
      body = <TicketsIndex
        access_token={ this.props.access_token }
        showTicket={ this._showTicket.bind(this) } />;
    }

    return (
      <div>
        { body }
      </div>
    );
  }
}
