import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_typography.dart';
import '../../config/theme/app_spacing.dart';
import '../../config/localization/app_localizations.dart';
import '../../core/widgets/app_widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgress), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Weight trend card
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.trending_down, size: 20, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Text(l10n.weightTrend, style: AppTypography.titleLarge),
                ]),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  height: 160,
                  child: CustomPaint(
                    painter: _SimpleLineChartPainter(
                      color: AppColors.primary,
                      points: [85, 84.2, 83.5, 83.8, 82.9, 82.1, 81.5],
                    ),
                    size: Size.infinite,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.weeklyAverage, style: AppTypography.caption.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    )),
                    Text('82.6 kg', style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.success, fontWeight: FontWeight.w600,
                    )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Stats grid
          Row(children: [
            Expanded(child: StatCard(title: l10n.bmi, value: '24.2', icon: Icons.speed, accentColor: AppColors.info)),
            Expanded(child: StatCard(title: l10n.bodyFat, value: '22%', icon: Icons.accessibility, accentColor: AppColors.accent)),
          ]),
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Expanded(child: StatCard(title: l10n.waist, value: '82 cm', icon: Icons.straighten, accentColor: AppColors.warning)),
            Expanded(child: StatCard(title: l10n.chest, value: '96 cm', icon: Icons.straighten, accentColor: AppColors.success)),
          ]),
          const SizedBox(height: AppSpacing.md),
          PremiumButton(label: l10n.viewAnalytics, isOutlined: true, icon: Icons.analytics_outlined,
            onPressed: () => context.push('/analytics')),
        ],
      ),
    );
  }
}

class _SimpleLineChartPainter extends CustomPainter {
  final Color color;
  final List<double> points;
  _SimpleLineChartPainter({required this.color, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final paint = Paint()..color = color..strokeWidth = 2.5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final fillPaint = Paint()..shader = LinearGradient(
      begin: Alignment.topCenter, end: Alignment.bottomCenter,
      colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.0)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    final min = points.reduce((a, b) => a < b ? a : b) - 1;
    final max = points.reduce((a, b) => a > b ? a : b) + 1;
    final range = max - min;
    final stepX = size.width / (points.length - 1);
    final path = Path();
    final fillPath = Path();
    for (int i = 0; i < points.length; i++) {
      final x = i * stepX;
      final y = size.height - ((points[i] - min) / range) * size.height;
      if (i == 0) { path.moveTo(x, y); fillPath.moveTo(x, y); }
      else { path.lineTo(x, y); fillPath.lineTo(x, y); }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
    // Draw dots
    for (int i = 0; i < points.length; i++) {
      final x = i * stepX;
      final y = size.height - ((points[i] - min) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}