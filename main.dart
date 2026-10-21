import 'package:flutter/material.dart';

void main() => runApp(const GlassChatApp());

class GlassChatApp extends StatelessWidget {
  const GlassChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLASS CHAT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF080D18),
        fontFamily: 'Segoe UI',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF68D9FF),
          brightness: Brightness.dark,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

const bg = Color(0xFF080D18);
const glass = Color(0xFF151F31);
const cyan = Color(0xFF68D9FF);

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selected = 0;
  final pages = const ['Overview', 'Messages', 'Gaming', 'Groups', 'Flags'];
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 760;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.8, -0.9),
            radius: 1.5,
            colors: [Color(0xFF183D58), bg, Color(0xFF101020)],
          ),
        ),
        child: SafeArea(
          child: Row(children: [
            if (wide) _sidebar(),
            Expanded(child: Column(children: [
              _topbar(wide),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('YOUR WORLD, CONNECTED',
                      style: TextStyle(color: cyan.withOpacity(.9), letterSpacing: 3, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Welcome back, Player',
                      style: TextStyle(fontSize: wide ? 32 : 26, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    const Text('Chat. Play. Build your community.', style: TextStyle(color: Colors.white60)),
                    const SizedBox(height: 22),
                    _heroCard(),
                    const SizedBox(height: 18),
                    LayoutBuilder(builder: (context, c) {
                      final count = c.maxWidth > 800 ? 4 : c.maxWidth > 500 ? 2 : 1;
                      final items = [
                        _stat('TOTAL PLAY TIME', '320 h', const Color(0xFF56D7FF), Icons.schedule_rounded),
                        _stat('PLAYER RANK', 'ELITE', const Color(0xFFFFC857), Icons.workspace_premium_rounded),
                        _stat('GROUP MEMBERS', '24', const Color(0xFFB69CFF), Icons.groups_rounded),
                        _stat('UNREAD MESSAGES', '3', const Color(0xFF63E6A6), Icons.mark_chat_unread_rounded),
                      ];
                      return GridView.count(
                        crossAxisCount: count, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: count == 1 ? 3.0 : 1.55,
                        children: items,
                      );
                    }),
                    const SizedBox(height: 24),
                    _sectionTitle('RANK & PLAY TIME COLORS', 'Progress unlocks new profile colors'),
                    const SizedBox(height: 12),
                    _tierRow('BEGINNER', '0–9 hours', const Color(0xFF9AA5B1), 'Starter'),
                    _tierRow('PLAYER', '10–49 hours', const Color(0xFF57C7FF), 'Active'),
                    _tierRow('ADVANCED', '50–199 hours', const Color(0xFF63E6A6), 'Skilled'),
                    _tierRow('EXPERT', '200–499 hours', const Color(0xFFB69CFF), 'Veteran'),
                    _tierRow('ELITE', '500+ hours', const Color(0xFFFFC857), 'Legend'),
                    const SizedBox(height: 24),
                    _sectionTitle('FEATURED GROUP FLAG', 'A symbol for your community'),
                    const SizedBox(height: 12),
                    _flagCard(),
                    const SizedBox(height: 20),
                    const Center(child: Text('UI CONCEPT • SAMPLE DATA • NOT CONNECTED TO A SERVER',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.2))),
                    const SizedBox(height: 12),
                  ]),
                ),
              ),
              if (!wide) _bottomNav(),
            ])),
          ]),
        ),
      ),
    );
  }

  Widget _sidebar() => Container(
    width: 218, margin: const EdgeInsets.all(14),
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    decoration: _glassDecoration(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.all(12), child: Row(children: [
        Icon(Icons.blur_on_rounded, color: cyan, size: 30), SizedBox(width: 8),
        Text('GLASS CHAT', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.4)),
      ])),
      const SizedBox(height: 24),
      ...List.generate(pages.length, (i) => _navItem(i)),
      const Spacer(),
      const ListTile(leading: Icon(Icons.shield_outlined, color: Colors.white54), title: Text('Privacy & Security', style: TextStyle(fontSize: 12, color: Colors.white70))),
      const Padding(padding: EdgeInsets.all(12), child: Text('PREVIEW 0.1', style: TextStyle(color: Colors.white30, fontSize: 10, letterSpacing: 2))),
    ]),
  );

  Widget _navItem(int i) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: () => setState(() => selected = i),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: selected == i ? cyan.withOpacity(.14) : Colors.transparent,
          border: selected == i ? Border.all(color: cyan.withOpacity(.28)) : null,
        ),
        child: Row(children: [
          Icon([Icons.grid_view_rounded, Icons.chat_bubble_outline_rounded, Icons.sports_esports_rounded, Icons.groups_2_outlined, Icons.flag_outlined][i],
            color: selected == i ? cyan : Colors.white60, size: 19),
          const SizedBox(width: 12),
          Text(pages[i], style: TextStyle(color: selected == i ? Colors.white : Colors.white70, fontWeight: selected == i ? FontWeight.w600 : FontWeight.normal)),
        ]),
      ),
    ),
  );

  Widget _topbar(bool wide) => Padding(
    padding: const EdgeInsets.fromLTRB(22, 16, 22, 8),
    child: Row(children: [
      if (!wide) const Icon(Icons.blur_on_rounded, color: cyan, size: 28),
      if (!wide) const SizedBox(width: 8),
      if (!wide) const Text('GLASS CHAT', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1)),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: _glassDecoration(),
        child: const Row(children: [Icon(Icons.circle, size: 8, color: Color(0xFF63E6A6)), SizedBox(width: 8), Text('Online', style: TextStyle(fontSize: 12))]),
      ),
      const SizedBox(width: 10),
      const CircleAvatar(backgroundColor: Color(0xFF29465D), child: Icon(Icons.person_outline_rounded, color: cyan)),
    ]),
  );

  Widget _heroCard() => Container(
    width: double.infinity, padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: cyan.withOpacity(.35)),
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [const Color(0xFF1B5B76).withOpacity(.65), const Color(0xFF182236).withOpacity(.88), const Color(0xFF251D45).withOpacity(.8)]),
      boxShadow: [BoxShadow(color: cyan.withOpacity(.08), blurRadius: 28, spreadRadius: 1)],
    ),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('THE NEXT LEVEL OF CONNECTION', style: TextStyle(color: cyan, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text('Your people.\\nYour games. Your space.', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, height: 1.2)),
        const SizedBox(height: 10),
        const Text('A glass-inspired home for your gaming community.', style: TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 16),
        FilledButton.icon(onPressed: () => setState(() => selected = 3),
          icon: const Icon(Icons.groups_rounded, size: 18), label: const Text('Explore groups'),
          style: FilledButton.styleFrom(backgroundColor: cyan, foregroundColor: bg)),
      ])),
      const SizedBox(width: 8),
      const Icon(Icons.hub_rounded, size: 78, color: Color(0x9978DFFF)),
    ]),
  );

  Widget _stat(String title, String value, Color color, IconData icon) => Container(
    padding: const EdgeInsets.all(16),
    decoration: _glassDecoration(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Icon(icon, color: color, size: 22), const SizedBox(height: 12),
      Text(value, style: TextStyle(color: color, fontSize: 23, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(title, style: const TextStyle(color: Colors.white54, fontSize: 9, letterSpacing: 1.1)),
    ]),
  );

  Widget _sectionTitle(String title, String subtitle) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2, fontSize: 13)),
    const SizedBox(height: 5),
    Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
  ]);

  Widget _tierRow(String rank, String hours, Color color, String label) => Container(
    margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: _glassDecoration(),
    child: Row(children: [
      Container(width: 8, height: 34, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: color.withOpacity(.4), blurRadius: 12)])),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(rank, style: TextStyle(color: color, fontWeight: FontWeight.w800, letterSpacing: 1.2, fontSize: 12)),
        const SizedBox(height: 3), Text(hours, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ])),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      const SizedBox(width: 6), Icon(Icons.chevron_right_rounded, color: color, size: 19),
    ]),
  );

  Widget _flagCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: _glassDecoration(),
    child: Row(children: [
      Container(
        width: 100, height: 68,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white24),
          gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Color(0xFF2A9D68), Colors.white, Color(0xFFCE4545)], stops: [0, .5, 1])),
        child: const Center(child: Icon(Icons.wb_sunny_rounded, size: 33, color: Color(0xFFB78326))),
      ),
      const SizedBox(width: 14),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('LION & SUN • SPECIAL', style: TextStyle(color: Color(0xFFFFC857), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
        SizedBox(height: 6), Text('Unlock with rank or verified play time', style: TextStyle(color: Colors.white70, fontSize: 12)),
        SizedBox(height: 5), Text('Illustrative preview', style: TextStyle(color: Colors.white38, fontSize: 10)),
      ])),
      const Icon(Icons.lock_outline_rounded, color: Color(0xFFFFC857)),
    ]),
  );

  Widget _bottomNav() => Container(
    margin: const EdgeInsets.fromLTRB(12, 0, 12, 12), padding: const EdgeInsets.symmetric(vertical: 7),
    decoration: _glassDecoration(),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(pages.length, (i) =>
      IconButton(onPressed: () => setState(() => selected = i),
        icon: Icon([Icons.grid_view_rounded, Icons.chat_bubble_outline_rounded, Icons.sports_esports_rounded, Icons.groups_2_outlined, Icons.flag_outlined][i],
          color: selected == i ? cyan : Colors.white54),
        tooltip: pages[i]))),
  );

  BoxDecoration _glassDecoration() => BoxDecoration(
    color: glass.withOpacity(.68),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Colors.white.withOpacity(.10)),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.12), blurRadius: 18, offset: const Offset(0, 7))],
  );
}
