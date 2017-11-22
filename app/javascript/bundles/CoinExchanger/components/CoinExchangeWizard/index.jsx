import React, { Component } from 'react';
import { Button, Container } from 'reactstrap';
import { Wizard, Step, Steps, Navigation } from 'react-albus';
import StepOne from '_bundles/CoinExchanger/components/StepOne';
import StepTwo from '_bundles/CoinExchanger/components/StepTwo';
import StepThree from '_bundles/CoinExchanger/components/StepThree';

const defaultCurrency = {
  id: 0,
  label: '',
  symbol: '',
  value: '',
};

class CoinExchanger extends Component {
  constructor(props) {
    super(props);

    this.state = {
      sendAmount: 0.0,
      sendCurrency: { ...defaultCurrency },
      sendAddress: '',
      receiveAmount: 0.0,
      receiveCurrency: { ...defaultCurrency },
      refundAddress: '',
    };
  }

  handleValueChange = (name, value) => {
    this.setState({
      [name]: value,
    });
  };

  render() {
    return (
      <Container fluid>
        <h2 className="mt-3 mb-3">Coin Exchange</h2>
        <Wizard>
          <Steps>
            <Step path="stepOne">
              <StepOne {...this.state} onValueChange={this.handleValueChange} />
              <Navigation
                render={({ next }) => (
                  <Button className="pull-right" size="lg" onClick={next}>
                    Next
                  </Button>
                )}
              />
            </Step>
            <Step path="stepTwo">
              <StepTwo {...this.state} />
              <Navigation
                render={({ next, previous }) => (
                  <div>
                    <div className="pull-right">
                      <Button size="lg" onClick={previous}>
                        Previous
                      </Button>{' '}
                      <Button size="lg" onClick={next}>
                        Next
                      </Button>
                    </div>
                  </div>
                )}
              />
            </Step>
            <Step path="stepThree">
              <StepThree {...this.state} />
            </Step>
          </Steps>
        </Wizard>
      </Container>
    );
  }
}

export default CoinExchanger;
