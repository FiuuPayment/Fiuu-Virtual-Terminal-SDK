import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Services/Theme/app_theme.dart';

/// Visual info (label/icon/color) for a resolved transaction status.
class TransactionStatusInfo {
  final String label;
  final IconData icon;
  final Color color;
  final Color containerColor;

  const TransactionStatusInfo({
    required this.label,
    required this.icon,
    required this.color,
    required this.containerColor,
  });
}

/// Maps a raw status code/string to a friendly label + color.
/// Codes follow the Fiuu XDK convention: 00=Success, 11=Failed, 22=Pending.
TransactionStatusInfo resolveStatusInfo(String? rawStatus) {
  final status = (rawStatus ?? '').trim();
  switch (status) {
    case '00':
      return const TransactionStatusInfo(
        label: 'Successful',
        icon: Icons.check_circle_rounded,
        color: StatusColors.success,
        containerColor: StatusColors.successContainer,
      );
    case '11':
      return const TransactionStatusInfo(
        label: 'Failed',
        icon: Icons.cancel_rounded,
        color: StatusColors.failed,
        containerColor: StatusColors.failedContainer,
      );
    case '22':
      return const TransactionStatusInfo(
        label: 'Pending',
        icon: Icons.hourglass_top_rounded,
        color: StatusColors.pending,
        containerColor: StatusColors.pendingContainer,
      );
    case 'Communication Error':
      return const TransactionStatusInfo(
        label: 'Communication Error',
        icon: Icons.wifi_off_rounded,
        color: StatusColors.failed,
        containerColor: StatusColors.failedContainer,
      );
    default:
      return TransactionStatusInfo(
        label: status.isEmpty ? 'Result' : status,
        icon: Icons.info_rounded,
        color: Colors.blueGrey.shade700,
        containerColor: Colors.blueGrey.withValues(alpha: 0.12),
      );
  }
}

/// Friendly labels for common (case-insensitive) response keys.
/// Falls back to a humanized version of the raw key when unrecognized.
const Map<String, String> _knownLabels = {
  'orderid': 'Order ID',
  'status': 'Status',
  'amount': 'Amount',
  'currency': 'Currency',
  'channel': 'Channel',
  'optype': 'Operation',
  'errdesc': 'Error Description',
  'errorDesc': 'Error Description',
  'error': 'Error',
  'tid': 'Terminal ID',
  'mid': 'Merchant ID',
  'txid': 'Transaction ID',
  'transactionid': 'Transaction ID',
  'paytype': 'Pay Type',
  'appcode': 'Approval Code',
};

String humanizeKey(String key) {
  final known = _knownLabels[key.toLowerCase()];
  if (known != null) return known;

  final spaced = key
      .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}')
      .replaceAll('_', ' ');
  return spaced
      .split(' ')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

/// Renders a deeplink response payload as a status banner + detail list.
/// Used by result-style screens (Blank / CartDetail) so raw key-value
/// dumps read like a proper transaction outcome screen.
class TransactionSummaryView extends StatelessWidget {
  final Map<String, dynamic> data;
  final Widget? footer;

  const TransactionSummaryView(
      {Key? key, required this.data, this.footer})
      : super(key: key);

  String? _findValue(String targetKey) {
    for (final key in data.keys) {
      if (key.toLowerCase() == targetKey) return data[key]?.toString();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusInfo = resolveStatusInfo(_findValue('status'));

    final entries = data.entries
        .where((e) => e.value != null && e.value.toString().isNotEmpty)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _StatusBanner(info: statusInfo),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: entries.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No data received.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : Column(
                    children: [
                      for (int i = 0; i < entries.length; i++) ...[
                        _DetailRow(
                          label: humanizeKey(entries[i].key),
                          value: entries[i].value.toString(),
                        ),
                        if (i != entries.length - 1)
                          Divider(
                            indent: 16,
                            endIndent: 16,
                            height: 1,
                            color: theme.colorScheme.outlineVariant
                                .withValues(alpha: 0.4),
                          ),
                      ],
                    ],
                  ),
          ),
        ),
        if (footer != null) ...[
          const SizedBox(height: 20),
          footer!,
        ],
      ],
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final TransactionStatusInfo info;
  const _StatusBanner({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: info.containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(info.icon, size: 56, color: info.color),
          const SizedBox(height: 12),
          Text(
            info.label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: info.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label copied')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
