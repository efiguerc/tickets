class Tickets extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      tickets: []
    };
  }

  componentDidMount() {
    var _this = this;
    $.ajax({
      url: '/api/v1/tickets',
      dataType: 'json',
      method: 'GET',
      beforeSend(xhr) {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
      },
      success(data) {
        _this.setState({tickets: data});
      },
      error(xhr, ststus, err) {
        e = {name: 'loadallReportNews', message: 'err: "' + err + '" Status: "'  + xhr.status + '" responseText:   ' + xhr.responseText};
      }
    });  
  }

  render () {
    return (
      <div>
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
                customer={ ticket["customer"]["email"] }
                created_at={ ticket["created_at"] }
                updated_at={ ticket["updated_at"] }
                agent={ ticket["agent"] && ticket["agent"]["email"] } />
            )}
          </tbody>
        </table>
      </div>
    );
  }
}
