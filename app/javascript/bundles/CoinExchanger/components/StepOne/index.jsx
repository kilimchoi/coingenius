import React, { Component } from 'react';
import { Form, FormGroup, Label, Input, InputGroup, InputGroupAddon } from 'reactstrap';
import axios from 'axios';

class StepOne extends Component {
  constructor(props) {
    super(props);

    this.state = {
      availableCoins: [],
      sendOptionState: "BTC",
      receiveOptionState: "ETH"
    };
    this.handleReceiveSelectChange = this.handleReceiveSelectChange.bind(this);
    this.handleSendSelectChange = this.handleSendSelectChange.bind(this);
  }

  changeDupCoinInSenderAndReceiver() {

  }

  handleReceiveSelectChange(e) {
    if (e.target.value == this.state.sendOptionState) {
      this.setState({sendOptionState: this.state.receiveOptionState})
      this.setState({receiveOptionState: e.target.value})
    } else {
      this.setState({receiveOptionState: e.target.value})
    }
    //if user selects the same coin, it should detect that and change. 
  }

  handleSendSelectChange(e) {
    if (e.target.value == this.state.receiveOptionState) {
      this.setState({receiveOptionState: this.state.sendOptionState})
      this.setState({sendOptionState: e.target.value})
    } else {
      this.setState({sendOptionState: e.target.value});
    }
    //if user selects the same coin, it should detect that and change. 
  }

  componentDidMount() {
    axios.get('https://shapeshift.io/getcoins')
      .then(res => {
        const availableCoins = Object.keys(res.data);
        this.setState( { availableCoins });
      });
  }

  render() {
    var symbolsList = this.state.availableCoins.map(function(symbol, i){
                        return <option key={i} value={symbol}>{symbol}</option>;
                      })
    return (
      <Form>
        <FormGroup>
          <Label for="sendValue">You send</Label>
          <InputGroup>
            <Input name="sendValue" type="number" />
            <InputGroupAddon>
              <select name="sendCurrency" value={this.state.sendOptionState} onChange={this.handleSendSelectChange}>
                { symbolsList }
              </select>
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
        <FormGroup>
          <Label for="receiveValue">You receive</Label>
          <InputGroup>
            <Input name="receiveValue" type="number" />
            <InputGroupAddon>
              <select name="receiveCurrency" value={this.state.receiveOptionState} onChange={this.handleReceiveSelectChange}>
                { symbolsList }
              </select>
            </InputGroupAddon>
          </InputGroup>
        </FormGroup>
      </Form>
    );
  }
}

export default StepOne;
