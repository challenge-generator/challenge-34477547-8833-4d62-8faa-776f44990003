import 'package:flutter/material.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/balance.dart';

class BalanceCard extends StatelessWidget {
  final Balance balance;
  final VoidCallback? onRefresh;
  final bool showDetails;

  const BalanceCard({
    super.key,
    required this.balance,
    this.onRefresh,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = balance.currentBalance >= 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isPositive
                ? [Colors.green.shade700, Colors.green.shade400]
                : [Colors.red.shade700, Colors.red.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saldo Actual',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (onRefresh != null)
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: onRefresh,
                      tooltip: 'Actualizar saldo',
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_formatCurrency(balance.currency)} ${balance.currentBalance.toStringAsFixed(2)}',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showDetails) ..._buildDetailsSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDetailsSection(ThemeData theme) {
    return [
      const SizedBox(height: 16),
      const Divider(color: Colors.white24),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _buildMetricTile(
              theme,
              'Ingresos',
              '+${_formatCurrency(balance.currency)} ${balance.income.toStringAsFixed(2)}',
              Icons.arrow_upward,
              Colors.green.shade100,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMetricTile(
              theme,
              'Gastos',
              '-${_formatCurrency(balance.currency)} ${balance.expenses.toStringAsFixed(2)}',
              Icons.arrow_downward,
              Colors.red.shade100,
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildMetricTile(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
    Color iconBackground,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: Colors.black87),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(Currency currency) {
    switch (currency) {
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      case Currency.jpy:
        return '¥';
    }
  }

  static Widget fromBalance(Balance balance, {VoidCallback? onRefresh}) {
    return BalanceCard(
      balance: balance,
      onRefresh: onRefresh,
    );
  }
}

class BalanceCardSkeleton extends StatelessWidget {
  const BalanceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class BalanceCardError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const BalanceCardError({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar el saldo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class BalanceCardEmpty extends StatelessWidget {
  final VoidCallback? onAddAccount;

  const BalanceCardEmpty({super.key, this.onAddAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Sin cuenta configurada',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Agrega una cuenta para comenzar a gestionar tus finanzas',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onAddAccount != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onAddAccount,
                icon: const Icon(Icons.add),
                label: const Text('Agregar Cuenta'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}