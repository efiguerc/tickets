class TicketsIndex extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      tickets: [],
    };
  }

  componentWillMount() {
    this._fetchTickets();
  }

  _fetchTickets() {
    $.ajax({
      url: '/api/v1/tickets',
      dataType: 'json',
      method: 'GET',
      beforeSend: (xhr) => {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.setRequestHeader('Authorization', this.props.access_token);
      },
      success: (tickets) => {
        this.setState({ tickets });
      },
      error: (xhr, ststus, err) => {
        e = {name: 'loadallReportNews', message: 'err: "' + err + '" Status: "'  + xhr.status + '" responseText:   ' + xhr.responseText};
        console(e);
      }
    });  
  }

  componentDidMount() {
    this._timer = setInterval(
      () => this._fetchTickets(),
      5000
    );
  }

  componentWillUnmount() {
    clearInterval(this._timer);
  }

  _deleteTicket(id) {
    console.log(id);
  }

  _getIndex(value, arr, prop) {
      for(var i = 0; i < arr.length; i++) {
          if(arr[i][prop] === value) {
              return i;
          }
      }
      return -1;
  }

  _showTicket(id) {

    const ticketIndex = this._getIndex(id, this.state.tickets, 'id');

    this.props.showTicket(this.state.tickets[ticketIndex]);
  }

  render () {
    return (
      <div>
        <h1>Tickets <small>
          <a> New</a>
        </small></h1>

        <form>
          <div className="input-group col-md-offset-9 col-md-3 col-xs-12">
            <input id="search" name="search" type="search" />
          </div>
        </form>
        <br/>

        <table className="table table-striped">
          <thead>
          <tr>
            <th>Number</th>
            <th>Category</th>
            <th>Title</th>
            <th>Status</th>
            <th>Priority</th>
            <th>Customer</th>
            <th>Created</th>
            <th>Updated</th>
            <th>Agent</th>
            <th>#</th>
          </tr>
          </thead>
          <tbody>
            { this.state.tickets.map( ticket =>

              <Ticket
                key={ ticket["id"] }
                id={ ticket["id"] }
                category={ ticket["category"] }
                title={ ticket["title"] }
                status={ ticket["status"] }
                priority={ ticket["priority"] }
                customer={ ticket["customer"]["name"] }
                created_at={ ticket["created_at"] }
                updated_at={ ticket["updated_at"] }
                agent={ ticket["agent"] && ticket["agent"]["name"] }
                access_token={ this.props.access_token }
                showTicket={ this._showTicket.bind(this) }
                deleteTicket={ this._deleteTicket.bind(this) } />

            )}
          </tbody>
        </table>
      </div>
    );
  }
}
