import 'package:flutter_test/flutter_test.dart';

import 'package:moneywise/app/moneywise_app.dart';

void main() {
  testWidgets('renders MoneyWise splash screen', (tester) async {
    await tester.pumpWidget(const MoneyWiseApp(useFirebase: false));

    expect(find.text('MoneyWise Junior'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.text('Login'), findsNothing);
  });
}
