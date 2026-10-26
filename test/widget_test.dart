import 'package:due_date_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the app landing screen with the Due Date branding', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Due Date'), findsWidgets);
    expect(find.textContaining('Small reminders'), findsWidgets);
  });
}
