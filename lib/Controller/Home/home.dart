import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/Services/Helper/helper.dart';
import 'package:sample_app/Services/Routes/router.dart';
import 'package:sample_app/Services/Theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(name: 'HomeRoute')
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _orderIdController =
      TextEditingController(text: '');

  static const List<Map<String, String>> _countries = [
    {'code': 'MY', 'name': 'Malaysia', 'flag': '🇲🇾'},
    {'code': 'SG', 'name': 'Singapore', 'flag': '🇸🇬'},
    {'code': 'PH', 'name': 'Philippines', 'flag': '🇵🇭'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    super.dispose();
  }

  void _requireOrderId(VoidCallback action) {
    if (_orderIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Order ID is required!'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    action();
  }

  Future<void> _showCountryPicker(BuildContext context) async {
    String? selectedCountry = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Country',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8.0),
                for (final country in _countries)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      country['flag']!,
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    title: Text(country['name']!),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => Navigator.of(context).pop(country['code']),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedCountry != null) {
      debugPrint("logCountry home selectedCountry = " + selectedCountry);
      context.router.push(CartRoute(country: selectedCountry));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fiuu VT App-to-App Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter an order ID to check its status or void it, or start a new sale below.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _orderIdController,
                decoration: const InputDecoration(
                  labelText: 'Order ID',
                  prefixIcon: Icon(Icons.receipt_long_outlined),
                ),
              ),
              const SizedBox(height: 28.0),
              Text(
                'Actions',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12.0),
              _ActionTile(
                icon: Icons.shopping_cart_checkout_rounded,
                label: 'New Sale',
                description: 'Start a new payment for a selected country.',
                filled: true,
                onTap: () => _showCountryPicker(context),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: _ActionTile(
                      icon: Icons.undo_rounded,
                      label: 'Void',
                      onTap: () => _requireOrderId(onVoid),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: _ActionTile(
                      icon: Icons.fact_check_outlined,
                      label: 'Status',
                      onTap: () => _requireOrderId(onStatus),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onVoid() async {
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
        'merchantUrlScheme': 'merchantapp',
        'merchantHost': 'merchant.example.com',
        'opType': 'VOID',
        'orderId': _orderIdController.text,
      }),
    );
    try {
      debugPrint('logVoidStatus try launchUri = ' + launchUri.toString());
      await launch(launchUri.toString());
    } catch (e) {
      debugPrint('logVoidStatus Error: $e');
    }
  }

  Future<void> onStatus() async {
    final Uri launchUri = Uri(
      scheme: 'razervt',
      host: "merchant.razer.com",
      query: Helper.instance.encodeQueryParameters(<String, String>{
        'merchantUrlScheme': 'merchantapp',
        'merchantHost': 'merchant.example.com',
        'opType': 'STATUS',
        'orderId': _orderIdController.text,
      }),
    );
    try {
      debugPrint('logVoidStatus try launchUri = ' + launchUri.toString());
      await launch(launchUri.toString());
    } catch (e) {
      debugPrint('logVoidStatus Error: $e');
    }
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? description;
  final bool filled;
  final VoidCallback onTap;

  const _ActionTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.description,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color background =
        filled ? AppTheme.fiuuBlue : theme.colorScheme.surfaceContainerLow;
    final Color foreground =
        filled ? Colors.white : theme.colorScheme.onSurface;
    final Color iconBackground = filled
        ? Colors.white.withValues(alpha: 0.15)
        : theme.colorScheme.primary.withValues(alpha: 0.1);
    final Color iconColor =
        filled ? Colors.white : theme.colorScheme.primary;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(18.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            border: filled
                ? null
                : Border.all(
                    color: theme.colorScheme.outlineVariant
                        .withValues(alpha: 0.4)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: iconColor, size: 22.0),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 2.0),
                      Text(
                        description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: foreground.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: foreground.withValues(alpha: 0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
