import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class ReminderEvent {
  ReminderEvent({
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    required this.description,
  });

  final String title;
  final DateTime date;
  final String time;
  final String category;
  final String description;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  final List<ReminderEvent> _events = [
    ReminderEvent(
      title: 'Project Deadline',
      date: DateTime(2025, 10, 15),
      time: '10:00 AM',
      category: 'School',
      description: 'Finish the research report and submit it online. Good luck!',
    ),
    ReminderEvent(
      title: 'Study Time',
      date: DateTime(2025, 10, 17),
      time: '5:00 PM',
      category: 'School',
      description: 'Review notes and finish the chapter summary.',
    ),
    ReminderEvent(
      title: 'Family Dinner',
      date: DateTime(2025, 10, 18),
      time: '6:30 PM',
      category: 'Personal',
      description: 'Celebrate dinner at home with everyone.',
    ),
    ReminderEvent(
      title: 'Birthday',
      date: DateTime(2025, 10, 21),
      time: 'All Day',
      category: 'Personal',
      description: 'Celebrate with friends and family.',
    ),
  ];

  void _login() => setState(() => _isLoggedIn = true);
  void _addEvent(ReminderEvent event) => setState(() => _events.add(event));
  void _removeEvent(int index) => setState(() => _events.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Due Date',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F2FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A6AEF)),
      ),
      home: _isLoggedIn
          ? DueDateDashboard(
              events: _events,
              onAddEvent: _addEvent,
              onRemoveEvent: _removeEvent,
            )
          : LandingScreen(onLogin: _login),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFE8FF), Color(0xFFF5F0FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due Date',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 96,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5F52D1),
                        height: 0.9,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Small reminders,\nbig plans.',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF403B5F),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Wrap(
                      spacing: 16,
                      runSpacing: 14,
                      children: const [
                        _FeatureChip(icon: Icons.event, label: 'Track\nImportant Dates'),
                        _FeatureChip(icon: Icons.notifications_active, label: 'Get\nReminders'),
                        _FeatureChip(icon: Icons.check_circle_outline, label: 'Stay\nOrganized'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final phoneWidth = constraints.maxWidth > 900 ? 260.0 : 220.0;
                        return Wrap(
                          spacing: 18,
                          runSpacing: 18,
                          alignment: WrapAlignment.center,
                          children: [
                            PhoneMock(width: phoneWidth, height: 580, child: LoginMock(onLogin: onLogin)),
                            PhoneMock(width: phoneWidth + 30, height: 640, child: DashboardMock()),
                            PhoneMock(width: phoneWidth, height: 600, child: AddEventMock()),
                            PhoneMock(width: phoneWidth, height: 620, child: DetailMock()),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFB58AE8), width: 1.3),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF5F52D1), size: 26),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF413A63),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneMock extends StatelessWidget {
  const PhoneMock({super.key, required this.width, required this.height, required this.child});

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(42),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.14), blurRadius: 18, offset: const Offset(0, 18)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.55), width: 2),
            borderRadius: BorderRadius.circular(36),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB9B0FF), Color(0xFF9FE0FF)],
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 36,
                color: Colors.white.withValues(alpha: 0.08),
                child: Center(
                  child: Container(
                    width: 92,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginMock extends StatelessWidget {
  const LoginMock({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: const Color(0xFFB39DFF),
            ),
            child: const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 42),
          ),
          const SizedBox(height: 16),
          Text(
            'Due Date',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 42,
              color: const Color(0xFF5F52D1),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Small reminders,\nbig plans.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              color: const Color(0xFF7C6FD9),
            ),
          ),
          const SizedBox(height: 18),
          _TextInput(label: 'Email or Username', icon: Icons.person_outline),
          const SizedBox(height: 10),
          _TextInput(label: 'Password', icon: Icons.lock_outline, isPassword: true),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color(0xFF7D6AEF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF5F52D1))),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Expanded(child: Divider(color: Colors.white70)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('OR', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
              ),
              Expanded(child: Divider(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: const Color(0xFF5F52D1),
                side: const BorderSide(color: Color(0xFFB7A7FF)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({required this.label, required this.icon, this.isPassword = false});

  final String label;
  final IconData icon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Color(0xFFEDE9FF)),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class DashboardMock extends StatelessWidget {
  const DashboardMock({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Flexible(
                child: Text(
                  '9:41',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF4B3B8B), fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 6,
                children: const [
                  Icon(Icons.signal_cellular_4_bar_rounded, size: 16, color: Color(0xFF4B3B8B)),
                  Icon(Icons.wifi_rounded, size: 16, color: Color(0xFF4B3B8B)),
                  Icon(Icons.battery_5_bar_rounded, size: 16, color: Color(0xFF4B3B8B)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Good Morning,\nAmethyst',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.1, color: Color(0xFF4A3C7C)),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF7D5DB),
                ),
                child: const Icon(Icons.face_rounded, size: 22, color: Color(0xFF5B4577)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Color(0xFF7A6AD8)),
                SizedBox(width: 8),
                Text('Search events...', style: TextStyle(color: Color(0xFF766C99))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CategoryButton(icon: Icons.grid_view_rounded, label: 'All', active: true),
              _CategoryButton(icon: Icons.person_rounded, label: 'Personal'),
              _CategoryButton(icon: Icons.school_rounded, label: 'School'),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Upcoming', style: TextStyle(color: Color(0xFF4A3C7C), fontWeight: FontWeight.w700)),
              Text('View All', style: TextStyle(color: Color(0xFF7D6AEF), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          ...const [
            _MiniEventItem(day: '15', title: 'Project Deadline', category: 'School', time: '10:00 AM'),
            _MiniEventItem(day: '18', title: "Doctor's Appointment", category: 'Personal', time: '2:00 PM'),
            _MiniEventItem(day: '25', title: 'Family Dinner', category: 'Personal', time: '6:00 PM'),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _NavIcon(icon: Icons.home_rounded, active: true),
              _NavIcon(icon: Icons.calendar_month_rounded),
              _NavIcon(icon: Icons.sticky_note_2_rounded),
              _NavIcon(icon: Icons.person_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({required this.icon, required this.label, this.active = false});

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF7831E5) : const Color(0xFFEFE5FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: active ? Colors.white : const Color(0xFF5C4F9A)),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 10, color: active ? Colors.white : const Color(0xFF5C4F9A))),
        ],
      ),
    );
  }
}

class _MiniEventItem extends StatelessWidget {
  const _MiniEventItem({required this.day, required this.title, required this.category, required this.time});

  final String day;
  final String title;
  final String category;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFE6D7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(day, style: const TextStyle(color: Color(0xFF5F52D1), fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF403B5F)),
                ),
                const SizedBox(height: 3),
                Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF8D7FCB), fontSize: 11),
                ),
              ],
            ),
          ),
          Flexible(
            child: Text(
              time,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Color(0xFF6E648C)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon, this.active = false});

  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: active ? const Color(0xFF7F6CFF) : Colors.transparent,
      ),
      child: Icon(icon, color: active ? Colors.white : const Color(0xFF4A3C7C), size: 18),
    );
  }
}

class AddEventMock extends StatelessWidget {
  const AddEventMock({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF4E3E84)),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Add New Event',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF4E3E84)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _FormRow(label: 'Event Title'),
          const SizedBox(height: 10),
          _FormRow(label: 'Date'),
          const SizedBox(height: 10),
          _FormRow(label: 'Time'),
          const SizedBox(height: 10),
          _FormRow(label: 'Category'),
          const SizedBox(height: 10),
          _FormRow(label: 'Description'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7F6CFF),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormRow extends StatelessWidget {
  const _FormRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Color(0xFF5F52D1), fontWeight: FontWeight.w500)),
          ),
          const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF5F52D1)),
        ],
      ),
    );
  }
}

class DetailMock extends StatelessWidget {
  const DetailMock({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF4E3E84)),
              Spacer(),
              Icon(Icons.favorite_border_rounded, color: Color(0xFF7B65FF)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: const Color(0xFFB59AFF),
            ),
            child: const Icon(Icons.assignment_rounded, color: Colors.white, size: 42),
          ),
          const SizedBox(height: 18),
          const Text('Project Deadline', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF4E3E84))),
          const SizedBox(height: 6),
          const Text('Oct 15, 2025 • 10:00 AM', style: TextStyle(color: Color(0xFF6B5FA1))),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Finish the research report and submit it online. Good luck!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF4E3E84), fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7F6CFF),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(46),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(46),
                    side: const BorderSide(color: Color(0xFF7F6CFF)),
                    foregroundColor: const Color(0xFF7F6CFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DueDateDashboard extends StatefulWidget {
  const DueDateDashboard({
    super.key,
    required this.events,
    required this.onAddEvent,
    required this.onRemoveEvent,
  });

  final List<ReminderEvent> events;
  final ValueChanged<ReminderEvent> onAddEvent;
  final ValueChanged<int> onRemoveEvent;

  @override
  State<DueDateDashboard> createState() => _DueDateDashboardState();
}

class _DueDateDashboardState extends State<DueDateDashboard> {
  int _currentIndex = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'School';
  String _selectedTime = '10:00 AM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1FF),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _HomeTab(events: widget.events, onRemoveEvent: widget.onRemoveEvent),
            _CalendarTab(events: widget.events),
            const _NotesTab(),
            const _ProfileTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context),
        backgroundColor: const Color(0xFF7F6CFF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6E5BE8),
        unselectedItemColor: const Color(0xFF6A6A82),
        backgroundColor: Colors.white,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2_rounded), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add New Event', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF4E3E84))),
            const SizedBox(height: 18),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Event Title'),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2035),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Date'),
                child: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedTime,
              decoration: const InputDecoration(labelText: 'Time'),
              items: ['10:00 AM', '2:00 PM', '5:00 PM', '6:30 PM', 'All Day']
                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedTime = value ?? _selectedTime),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ['School', 'Personal', 'Work', 'Other']
                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedCategory = value ?? _selectedCategory),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  if (title.isEmpty) return;
                  widget.onAddEvent(
                    ReminderEvent(
                      title: title,
                      date: _selectedDate,
                      time: _selectedTime,
                      category: _selectedCategory,
                      description: _descriptionController.text.trim().isNotEmpty
                          ? _descriptionController.text.trim()
                          : 'No additional details.',
                    ),
                  );
                  _titleController.clear();
                  _descriptionController.clear();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: const Color(0xFF7F6CFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.events, required this.onRemoveEvent});

  final List<ReminderEvent> events;
  final ValueChanged<int> onRemoveEvent;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('9:41', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF4B3B8B))),
              Row(
                children: [
                  Icon(Icons.signal_cellular_4_bar_rounded, size: 16, color: Color(0xFF4B3B8B)),
                  SizedBox(width: 6),
                  Icon(Icons.wifi_rounded, size: 16, color: Color(0xFF4B3B8B)),
                  SizedBox(width: 6),
                  Icon(Icons.battery_5_bar_rounded, size: 16, color: Color(0xFF4B3B8B)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Good Morning,\nAmethyst',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.1, color: Color(0xFF413A63)),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5D9DF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_rounded, color: Color(0xFF5B4577)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Color(0xFF7A6AD8)),
                SizedBox(width: 8),
                Text('Search events...', style: TextStyle(color: Color(0xFF716A8B))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CategoryButton(icon: Icons.grid_view_rounded, label: 'All', active: true),
              _CategoryButton(icon: Icons.person_rounded, label: 'Personal'),
              _CategoryButton(icon: Icons.school_rounded, label: 'School'),
              _CategoryButton(icon: Icons.work_rounded, label: 'Work'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF413A63))),
              Text('View All', style: TextStyle(color: Color(0xFF7F6CFF), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6D7FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(event.date.day.toString(), style: const TextStyle(color: Color(0xFF5D4BA7), fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF403B5F))),
                        const SizedBox(height: 3),
                        Text(event.category, style: const TextStyle(color: Color(0xFF8B7EC8), fontSize: 12)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(event.time, style: const TextStyle(fontSize: 11, color: Color(0xFF6E648C))),
                      IconButton(
                        onPressed: () => onRemoveEvent(index),
                        icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF7F6CFF)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CalendarTab extends StatelessWidget {
  const _CalendarTab({required this.events});

  final List<ReminderEvent> events;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    final days = List.generate(lastDay.day, (index) => index + 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('October 2025', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF4B3B8B))),
          const SizedBox(height: 18),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) => Center(child: Text(day, style: const TextStyle(color: Color(0xFF6D648C), fontWeight: FontWeight.w600)))),
              ...List.generate(firstDay.weekday % 7, (_) => const SizedBox()),
              ...days.map((day) {
                final active = day == 15;
                final hasEvent = events.any((event) => event.date.day == day);
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFF7F6CFF) : (hasEvent ? const Color(0xFFE9E2FF) : Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('$day', style: TextStyle(color: active ? Colors.white : const Color(0xFF4F3E85), fontWeight: FontWeight.w700)),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Events on Oct 15', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF4B3B8B))),
          ),
          const SizedBox(height: 12),
          ...events.take(3).map((event) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7D6FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(event.date.day.toString(), style: const TextStyle(color: Color(0xFF5F52D1), fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.title, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF413A63))),
                          const SizedBox(height: 3),
                          Text('${event.time} • ${event.category}', style: const TextStyle(color: Color(0xFF7F6CFF), fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _NotesTab extends StatelessWidget {
  const _NotesTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notes are ready for future updates.', style: TextStyle(fontSize: 18, color: Color(0xFF433A66), fontWeight: FontWeight.w600)),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile coming soon.', style: TextStyle(fontSize: 18, color: Color(0xFF433A66), fontWeight: FontWeight.w600)),
    );
  }
}
