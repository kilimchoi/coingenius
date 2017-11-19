import React, { Component } from 'react';
import { Container, Button, Form, FormGroup, Label, Input } from 'reactstrap';

class CoinExchanger extends Component {
  render() {
    return (
      <Container fluid>
        <h2 className="mt-5">Coin Exchange</h2>

        <Form>
          <FormGroup>
            <Label for="sendValue">You send</Label>
            <Input name="sendValue" id="sendValue"/>
          </FormGroup>
          <FormGroup>
            <Label for="receiveValue">You receive</Label>
            <Input name="receiveValue" id="receiveValue"/>
          </FormGroup>
          <Button>Next</Button>
        </Form>
      </Container>
    );
  }
}

export default CoinExchanger;
