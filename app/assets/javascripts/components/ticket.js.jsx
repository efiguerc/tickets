class Ticket extends React.Component {

  _handleShowTicket(event) {
    event.preventDefault();

    this.props.showTicket(this.props.id);
  }

  _handleDeleteTicket(event) {
    event.preventDefault();

    $.ajax({
      url: '/api/v1/tickets/' + this.props.id,
      dataType: 'json',
      method: 'DELETE',
      beforeSend: (xhr) => {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.setRequestHeader('Authorization', this.props.access_token);
      },
      success: (data) => {
        this.props.deleteTicket(this.props.id);
      },
      error: (xhr, ststus, err) => {
        e = {name: 'loadallReportNews', message: 'err: "' + err + '" Status: "'  + xhr.status + '" responseText:   ' + xhr.responseText};
        console.log(e);
      }
    });  
  }

  render () {
    return (
      <tr>
        <td>{ this.props.id }</td>
        <td>{ this.props.category }</td>
        <td><a onClick={ this._handleShowTicket.bind(this) }>{ this.props.title }</a></td>
        <td>{ this.props.status }</td>
        <td>{ this.props.priority }</td>
        <td>{ this.props.customer }</td>
        <td>{ this.props.created_at }</td>
        <td>{ this.props.updated_at}</td>
        <td>{ this.props.agent }</td>
        <td><a onClick={ this._handleDeleteTicket.bind(this) }>delete</a></td>
      </tr>
    );
  }
}
