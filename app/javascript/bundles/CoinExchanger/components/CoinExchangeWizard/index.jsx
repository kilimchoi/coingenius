import React, { Component } from 'react';
import { Button, Container } from 'reactstrap';
import { Wizard, Step, Steps, Navigation } from 'react-albus';
import StepOne from '_bundles/CoinExchanger/components/StepOne';
import StepTwo from '_bundles/CoinExchanger/components/StepTwo';
import StepThree from '_bundles/CoinExchanger/components/StepThree';

class CoinExchanger extends Component {
  render() {
    return (
      <Container fluid>
        <h2 className="mt-5">Coin Exchange</h2>
        <Wizard>
          <Steps>
            <Step path="stepOne">
              <StepOne />
              <Navigation
                render={({ next }) => (
                  <Button className="pull-right" size="lg" onClick={next}>
                    Next
                  </Button>
                )}
              />
            </Step>
            <Step path="stepTwo">
              <StepTwo />
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
              <StepThree />
            </Step>
          </Steps>
        </Wizard>
      </Container>
    );
  }
}

export default CoinExchanger;
