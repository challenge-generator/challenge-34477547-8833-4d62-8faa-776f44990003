import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(Transaction)? onTransactionTap;
  final ScrollController? scrollController;
  final bool isLoading;
  final String? emptyMessage;
  final VoidCallback? onLoadMore;
  final bool hasMoreData;

  const TransactionList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
    this.scrollController,
    this.isLoading = false,
    this.emptyMessage,
    this.onLoadMore,
    this.hasMoreData = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && transactions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (transactions.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (onLoadMore != null) {
          onLoadMore!();
        }
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: transactions.length + (hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= transactions.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _TransactionListItem(
            transaction: transactions[index],
            onTap: onTransactionTap != null
                ? () => onTransactionTap!(transactions[index])
                : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage ?? 'No hay transacciones',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Las transacciones que realices aparecerán aquí',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const _TransactionListItem({
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? Colors.green : Colors.red;
    final amountPrefix = isIncome ? '+' : '-';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildCategoryIcon(theme),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.description,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildCategoryChip(theme),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(transaction.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$amountPrefix\$${transaction.amount.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildStatusChip(theme),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(ThemeData theme) {
    IconData icon;
    Color color;

    switch (transaction.category.toLowerCase()) {
      case 'food':
      case 'comida':
        icon = Icons.restaurant;
        color = Colors.orange;
        break;
      case 'transport':
      case 'transporte':
        icon = Icons.directions_car;
        color = Colors.blue;
        break;
      case 'shopping':
      case 'compras':
        icon = Icons.shopping_bag;
        color = Colors.pink;
        break;
      case 'entertainment':
      case 'entretenimiento':
        icon = Icons.movie;
        color = Colors.purple;
        break;
      case 'bills':
      case 'facturas':
        icon = Icons.receipt;
        color = Colors.red;
        break;
      case 'salary':
      case 'sueldo':
      case 'income':
      case 'ingreso':
        icon = Icons.work;
        color = Colors.green;
        break;
      case 'transfer':
      case 'transferencia':
        icon = Icons.swap_horiz;
        color = Colors.teal;
        break;
      default:
        icon = Icons.attach_money;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildCategoryChip(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        transaction.category,
        style: theme.textTheme.labelSmall,
      ),
    );
  }

  Widget _buildStatusChip(ThemeData theme) {
    Color color;
    String label;

    switch (transaction.status) {
      case TransactionStatus.completed:
        color = Colors.green;
        label = 'Completado';
        break;
      case TransactionStatus.pending:
        color = Colors.orange;
        label = 'Pendiente';
        break;
      case TransactionStatus.failed:
        color = Colors.red;
        label = 'Fallido';
        break;
      case TransactionStatus.reversed:
        color = Colors.grey;
        label = 'Revertido';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Hoy';
    } else if (transactionDate == today.subtract(const Duration(days: 1))) {
      return 'Ayer';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class TransactionListSkeleton extends StatelessWidget {
  final int itemCount;

  const TransactionListSkeleton({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 150,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 100,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 16,
                      width: 60,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 50,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TransactionListError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const TransactionListError({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar transacciones',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
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