enum PlanType { standard, premium }

class PremiumPlanModel {
  final PlanType type;
  final String title;
  final String price;
  final String? badge; // e.g. "POPULAR"
  final String subtitle;
  final List<String> features;
  final String trialText;

  const PremiumPlanModel({
    required this.type,
    required this.title,
    required this.price,
    this.badge,
    required this.subtitle,
    required this.features,
    required this.trialText,
  });

  static const PremiumPlanModel standard = PremiumPlanModel(
    type: PlanType.standard,
    title: 'Standard',
    price: '£5.29',
    subtitle: 'Everything you need to build great habits',
    features: [
      'Unlimited habits',
      'Advanced rhythm analytics',
      'Custom habit colours & icons',
      'Weekly review reports',
      'Daily reminders',
    ],
    trialText: '7-day free trial · Cancel anytime',
  );

  static const PremiumPlanModel premium = PremiumPlanModel(
    type: PlanType.premium,
    title: 'Premium',
    price: '£14.99',
    badge: 'POPULAR',
    subtitle: 'Habits + real coaching to accelerate your growth',
    features: [
      'Everything in Standard',
      'Live coach chat access',
      'Optional 15-min weekly coaching call',
      'Personalised coaching insights',
      'Priority coach response',
    ],
    trialText: '7-day free trial · Cancel anytime',
  );

  static const List<PremiumPlanModel> all = [standard, premium];
}