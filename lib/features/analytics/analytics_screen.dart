import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.analytics), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Period selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _PeriodChip(l10n.week, true),
              const SizedBox(width: AppSpacing.sm),
              _PeriodChip(l10n.month, false),
              const SizedBox(width: AppSpacing.sm),
              _PeriodChip(l10n.threeMonths, false),
              const SizedBox(width: AppSpacing.sm),
              _PeriodChip(l10n.sixMonths, false),
              const SizedBox(width: AppSpacing.sm),
              _PeriodChip(l10n.year, false),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Weight trend
          PremiumCard(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.trending_down, size: 20, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.weightTrend, style: AppTypography.titleLarge),
              ]),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(height: 180, child: CustomPaint(painter: _ChartPainter(AppColors.primary),
                size: Size.infinite, child: const SizedBox.expand())),
              const SizedBox(height: AppSpacing.md),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _StatPill('-3.5 kg', AppColors.success),
                _StatPill(l10n.onTrack, AppColors.primary),
              ]),
            ],
          )),
          const SizedBox(height: AppSpacing.md),
          // Calorie trend
          PremiumCard(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.local_fire_department, size: 20, color: AppColors.accent),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.calorieTrend, style: AppTypography.titleLarge),
              ]),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(height: 180, child: CustomPaint(painter: _ChartPainter(AppColors.accent),
                size: Size.infinite, child: const SizedBox.expand())),
              const SizedBox(height: AppSpacing.md),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _StatPill('Ø 1.850 kcal', AppColors.accent),
                _StatPill(l10n.balanced, AppColors.success),
              ]),
            ],
          )),
          const SizedBox(height: AppSpacing.md),
          // Habit completion
          PremiumCard(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.check_circle, size: 20, color: AppColors.success),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.habitCompletion, style: AppTypography.titleLarge),
              ]),
              const SizedBox(height: AppSpacing.lg),
              _BarChart(),
              const SizedBox(height: AppSpacing.md),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _StatPill('78%', AppColors.success),
                _StatPill(l10n.improving, AppColors.primary),
              ]),
            ],
          )),
          const SizedBox(height: AppSpacing.md),
          // Insights
          PremiumCard(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.lightbulb_outline, size: 20, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.smartInsights, style: AppTypography.titleLarge),
              ]),
              const SizedBox(height: AppSpacing.md),
              _InsightRow(l10n.insightConsistent, AppColors.success),
              _InsightRow(l10n.insightWater, AppColors.warning),
              _InsightRow(l10n.insightClose, AppColors.primary),
            ],
          )),
        ],
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _PeriodChip(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: selected ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Text(label, style: AppTypography.bodySmall.copyWith(
        color: selected ? Colors.white : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      )),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String text;
  final Color color;
  const _StatPill(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(text, style: AppTypography.caption.copyWith(color: color, fontWeight: FontWeight.w600)),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final String text;
  final Color color;
  const _InsightRow(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: AppTypography.bodySmall)),
      ]),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final Color color;
  _ChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final fill = Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
      colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.0)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))..style = PaintingStyle.fill;
    final pts = [0.3, 0.5, 0.35, 0.6, 0.45, 0.7, 0.55];
    final path = Path();
    final fillPath = Path();
    for (int i = 0; i < pts.length; i++) {
      final x = i * size.width / (pts.length - 1);
      final y = size.height - pts[i] * size.height;
      if (i == 0) { path.moveTo(x, y); fillPath.moveTo(x, y); }
      else { path.lineTo(x, y); fillPath.lineTo(x, y); }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fill);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final days = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
    final values = [0.8, 0.6, 1.0, 0.4, 0.8, 0.6, 0.8];
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(7, (i) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 28, height: 80, decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(6),
        ), alignment: Alignment.bottomCenter, child: FractionallySizedBox(
          heightFactor: values[i],
          child: Container(decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6),
          )),
        )),
        const SizedBox(height: 4),
        Text(days[i], style: AppTypography.caption.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
        )),
      ]);
    }));
  }
}