## How to migrate from `expo-payments-stripe` to the new `@stripe/stripe-react-native` library

`expo-payments-stripe` is deprecated in favor of the `@stripe/stripe-react-native` library, and besides new features and better reliability, this module is supported in the managed workflow! To use it, make sure you download the newest version of Expo Go from the Play Store or App Store.

### Set up

Install the library by running the following command:

```shell
npx expo install @stripe/stripe-react-native
```

> If you're using the bare workflow, you'll also need to run `npx pod-install`.

### Initialization

In the old module, you were probably calling `setOptionsAsync` to setup & initialize. With `@stripe/stripe-react-native`, you'll instead use the `StripeProvider` component:

```
import { StripeProvider } from '@stripe/stripe-react-native';

function App() {
  return (
    <StripeProvider publishableKey="pk_test_e0Q6gnF9VeDke03pyammLdOD">
      // Your app code here
    </StripeProvider>
  );
}
```

### Payment with a card

Previously, you had to build your own forms for gathering user billing information. With `@stripe/stripe-react-native`, UI components are built into the library. Gather billing information with the `CardField` component:

```
function PaymentScreen() {
  const [card, setCard] = useState(null);
  // ...
  return (
    <View>
      <CardField
        postalCodeEnabled={true}
        placeholder={{
          number: '4242 4242 4242 4242',
        }}
        cardStyle={{
          backgroundColor: '#FFFFFF',
          textColor: '#000000',
        }}
        style={{
          width: '100%',
          height: 50,
          marginVertical: 30,
        }}
        onCardChange={(cardDetails) => {
          setCard(cardDetails);
        }}
        onFocus={(focusedField) => {
          console.log('focusField', focusedField);
        }}
      />
    </View>
  );
}
```

For more details and examples on accepting a payment with `@stripe/stripe-react-native`, please refer to [the documentation](https://stripe.com/docs/payments/accept-a-payment).

### Apple pay

Apple pay requires some prior setup- to setup your merchant identifier, please refer to [the documentation](https://stripe.com/docs/apple-pay?platform=react-native).

Once you have your merchant identifier, add:

```json
{
  expo: {
    ...
    "plugins": [
      [
        "@stripe/stripe-react-native",
        {
          "merchantIdentifier": string | string [],
          "enableGooglePay": boolean
        }
      ]
    ],
  }
}
```

to your `app.json` file, where `merchantIdentifier` is the Apple merchant ID obtained [here](https://stripe.com/docs/apple-pay?platform=react-native). Otherwise, Apple Pay will not work as expected. If you have multiple `merchantIdentifier`s, you can provide them all in an array. If you're in the bare workflow, you'll need to run `expo eject` or `expo prebuild` to apply the native project configuration.

Then, in the `StripeProvider` component, specify the same Apple Merchant ID:

```
<StripeProvider
  publishableKey="pk_test_e0Q6gnF9VeDke03pyammLdOD"
  merchantIdentifier="merchant.com.{{YOUR_APP_NAME}}"
  // ..
>
  <App>
</StripeProvider>
```

Replace `deviceSupportsApplePayAsync` with the new `useApplePay` hook:

```
  const { isApplePaySupported } = useApplePay();
```

Replace `paymentRequestWithApplePayAsync`, `completeApplePayRequestAsync`, and `cancelApplePayRequestAsync` with:

```
  const {
    presentApplePay,
    confirmApplePayPayment,
  } = useApplePay();
```

For more details and examples on accepting Apple Pay with `@stripe/stripe-react-native`, please refer to [the documentation](https://stripe.com/docs/apple-pay?platform=react-native).

### Google Pay

Configure Google Pay via `app.json` with:

```json
{
  expo: {
    ...
    "plugins": [
      [
        "@stripe/stripe-react-native",
        {
          "merchantIdentifier": string | string [],
          "enableGooglePay": boolean
        }
      ]
    ],
  }
}
```
