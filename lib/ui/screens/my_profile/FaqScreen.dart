import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Add this import for RenderAbstractViewport

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../components/custom_app_bar/custom_app_bar.dart';

// FAQ data model
class FaqCategory {
  final String title;
  final IconData icon;
  final List<FaqItem> items;

  FaqCategory({
    required this.title,
    required this.icon,
    required this.items,
  });
}

class FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> with AutomaticKeepAliveClientMixin {
  final List<FaqCategory> _faqCategories = [];
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  // Keys for preserving expanded state across rebuilds
  final Map<String, GlobalKey> _itemKeys = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadFaqs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadFaqs() async {
    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _faqCategories.addAll(_generateFaqCategories());
      _isLoading = false;
    });

    // Create keys for each FAQ item
    for (int catIndex = 0; catIndex < _faqCategories.length; catIndex++) {
      for (int itemIndex = 0; itemIndex < _faqCategories[catIndex].items.length; itemIndex++) {
        _itemKeys['cat${catIndex}_item$itemIndex'] = GlobalKey();
      }
    }
  }

  List<FaqCategory> _generateFaqCategories() {
    return [
      FaqCategory(
        title: 'General Questions',
        icon: Icons.help,
        items: [
          FaqItem(
            question: 'What is CosmosPedia?',
            answer: 'CosmosPedia is an educational mobile app that offers curated, real-time space-related information. Explore NASA\'s Astronomy Picture of the Day, asteroid data, Mars rover images, and live space weather updates—all in one place.',
          ),
          FaqItem(
            question: 'Which platforms support CosmosPedia?',
            answer: 'CosmosPedia is available for download on both Android and iOS devices.',
          ),
          FaqItem(
            question: 'Is the app free to use?',
            answer: 'Absolutely! CosmosPedia is completely free to download and use.',
          ),
          FaqItem(
            question: 'Does CosmosPedia require an internet connection?',
            answer: 'Yes. Most features fetch live data from NASA and other APIs, so an active internet connection is required.',
          ),
        ],
      ),
      FaqCategory(
        title: 'Features & Navigation',
        icon: Icons.explore,
        items: [
          FaqItem(
            question: 'What features are available in CosmosPedia?',
            answer: 'CosmosPedia includes the following key modules:\n\n'
                '• Asteroid Tracker – Explore real-time data on near-Earth objects (NEOs).\n'
                '• Mars Rover Explorer – View captivating images captured by NASA\'s rovers.\n'
                '• Space Weather Dashboard – Monitor solar activity like flares and storms.\n'
                '• Astronomy Picture of the Day (APOD) – Enjoy NASA\'s featured space images.',
          ),
          FaqItem(
            question: 'How do I navigate between different sections of the app?',
            answer: 'Use the bottom navigation bar to quickly access:\n\n'
                '• Home – Latest space news and featured images\n'
                '• Mars Rover Explorer\n'
                '• Asteroid Tracker\n'
                '• Space Weather\n'
                '• Settings',
          ),
          FaqItem(
            question: 'Can I filter Mars rover photos by camera or date?',
            answer: 'Yes. Easily:\n\n'
                '• Browse images by selecting an Earth date from the calendar\n'
                '• Filter photos by camera type (e.g., Mastcam, Navcam)',
          ),
          FaqItem(
            question: 'How do I access detailed asteroid information?',
            answer: 'Tap on any asteroid to view:\n\n'
                '• Orbit diagrams\n'
                '• Size comparisons\n'
                '• Historical and upcoming close approaches',
          ),
        ],
      ),
      FaqCategory(
        title: 'Account & User Data',
        icon: Icons.account_circle,
        items: [
          FaqItem(
            question: 'Do I need an account to use the app?',
            answer: 'No account is required for general use. However, signing in allows you to save favorite images and maintain personalized preferences.',
          ),
          FaqItem(
            question: 'How do I create or sign in to an account?',
            answer: 'Go to the Sign In screen and enter your credentials. New users can tap "Don\'t have an account? Sign Up" to register.',
          ),
          FaqItem(
            question: 'Is my personal data secure?',
            answer: 'Yes. CosmosPedia uses Firebase Authentication to ensure secure sign-in and safe storage of your preferences.',
          ),
        ],
      ),
      FaqCategory(
        title: 'Troubleshooting',
        icon: Icons.build,
        items: [
          FaqItem(
            question: 'Why are images not loading properly?',
            answer: 'Make sure you have a stable internet connection. Try pull-to-refresh to reload the content.',
          ),
          FaqItem(
            question: 'The app crashes in a specific section—what should I do?',
            answer: 'Restart the application. Ensure you\'re using the latest version from the app store. Still having trouble? Reach out via the Help & Support section.',
          ),
          FaqItem(
            question: 'How can I report a bug or suggest a feature?',
            answer: 'Navigate to the Help & Support section from the app menu to submit your feedback or report an issue.',
          ),
        ],
      ),
      FaqCategory(
        title: 'Space Data & Sources',
        icon: Icons.public,
        items: [
          FaqItem(
            question: 'Where does CosmosPedia get its space data from?',
            answer: 'We integrate real-time data through various NASA public APIs, including:\n\n'
                '• Astronomy Picture of the Day (APOD)\n'
                '• Mars Rover Photos API\n'
                '• Near-Earth Object Web Service (NeoWs)\n'
                '• DONKI (Space Weather) API',
          ),
          FaqItem(
            question: 'How frequently is the content updated?',
            answer: '• APOD: Updated daily\n'
                '• Mars Rover Photos: New images appear as NASA publishes them\n'
                '• Asteroid & Space Weather Data: Pulled in real-time upon accessing those sections',
          ),
          FaqItem(
            question: 'Can I download images for offline viewing?',
            answer: 'Yes! Tap the download icon while previewing any image to save it directly to your device.',
          ),
        ],
      ),
      FaqCategory(
        title: 'Customization & Settings',
        icon: Icons.settings,
        items: [
          FaqItem(
            question: 'Can I change the app theme?',
            answer: 'Yes. CosmosPedia supports both light and dark themes, adapting automatically to your device\'s system settings.',
          ),
          FaqItem(
            question: 'Can I change the language of the app?',
            answer: 'Currently, CosmosPedia is available in English, with support for more languages planned in upcoming releases.',
          ),
          FaqItem(
            question: 'Can I customize the layout of the Home screen?',
            answer: 'Not at the moment, but we\'re exploring customization options for future updates.',
          ),
        ],
      ),
      FaqCategory(
        title: 'Upcoming Features & Roadmap',
        icon: Icons.update,
        items: [
          FaqItem(
            question: 'Will more rover data (e.g., Perseverance) be added?',
            answer: 'Yes! Future versions of CosmosPedia will include imagery and data from the Perseverance rover and additional missions.',
          ),
          FaqItem(
            question: 'Are there plans for a web or desktop version?',
            answer: 'A desktop or web-based version is not currently available, but may be developed based on user interest.',
          ),
          FaqItem(
            question: 'Will I receive notifications about asteroid flybys or events?',
            answer: 'Yes! A notification system for near-Earth object alerts and astronomical events is currently under development.',
          ),
        ],
      ),
      FaqCategory(
        title: 'Need Additional Help?',
        icon: Icons.support_agent,
        items: [
          FaqItem(
            question: 'How can I contact support?',
            answer: 'For further assistance, feedback, or support, feel free to reach out:\n\n'
                '• Email: support@cosmospedia.com\n'
                '• In-App: Navigate to Help & Support via the app\'s main menu',
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.3,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.transparentColor,
        appBar: customAppBar(
          scaffoldKey: scaffoldKey,
          context: context,
          titleWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: _isLoading
            ? Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const CircularProgressIndicator(
              color: Colors.purpleAccent,
              strokeWidth: 3,
            ),
          ),
        )
            : _buildFaqList(context),
      ),
    );
  }

  Widget _buildFaqList(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CosmosPedia FAQs',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF8E44AD), // Purple color like in screenshots
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Implement search functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            key: const PageStorageKey('faq_list'),
            controller: _scrollController,
            itemCount: _faqCategories.length,
            itemBuilder: (context, index) {
              final category = _faqCategories[index];
              return _buildFaqCategory(category, context, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFaqCategory(FaqCategory category, BuildContext context, int categoryIndex) {
    final theme = Theme.of(context);

    // Color mapping based on category - matching the screenshot styles
    Map<String, Color> categoryColorMap = {
      'General Questions': Colors.blue,
      'Features & Navigation': Colors.amber,
      'Account & User Data': Colors.blue,
      'Troubleshooting': Colors.orange,
      'Space Data & Sources': Colors.teal,
      'Customization & Settings': Colors.lightBlue,
      'Upcoming Features & Roadmap': Colors.deepPurple,
      'Need Additional Help?': const Color(0xFF8E44AD), // Purple like the support icons
    };

    // Default to purple if not found
    Color iconColor = categoryColorMap[category.title] ?? const Color(0xFF8E44AD);

    return RepaintBoundary(
      child: Card(
        key: ValueKey('category_$categoryIndex'),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4, // Reduced elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.transparent, // Transparent base
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3), // More translucent
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        category.icon,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        category.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Colors.white30, height: 1),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: category.items.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white30,
                    height: 1,
                  ),
                  itemBuilder: (context, itemIndex) {
                    final item = category.items[itemIndex];
                    final String keyId = 'cat${categoryIndex}_item$itemIndex';
                    return _buildFaqItem(
                      item,
                      context,
                      iconColor,
                      category,
                      categoryIndex,
                      itemIndex,
                      _itemKeys[keyId] ?? GlobalKey(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleFaqItem(FaqItem item, GlobalKey itemKey, int categoryIndex, int itemIndex) {
    final beforeScrollPosition = _scrollController.position.pixels;

    setState(() {
      // Close all other open items first
      for (var cat in _faqCategories) {
        for (var faq in cat.items) {
          if (faq != item && faq.isExpanded) {
            faq.isExpanded = false;
          }
        }
      }

      // Toggle the current item
      item.isExpanded = !item.isExpanded;
    });

    // Don't attempt to scroll if closing the item
    if (!item.isExpanded) return;

    // Wait for layout calculation to complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Restore previous scroll position first to prevent jumping
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(beforeScrollPosition);

        // Then smoothly scroll to the selected item - using Scrollable.ensureVisible
        final context = itemKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            alignment: 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  Widget _buildFaqItem(
      FaqItem item,
      BuildContext context,
      Color categoryColor,
      FaqCategory category,
      int categoryIndex,
      int itemIndex,
      GlobalKey itemKey,
      ) {
    final theme = Theme.of(context);

    return RepaintBoundary(
      key: itemKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              item.question,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: categoryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20,
              ),
            ),
            onTap: () => _toggleFaqItem(item, itemKey, categoryIndex, itemIndex),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: item.isExpanded
                ? Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05), // Very subtle background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: categoryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  item.answer,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}