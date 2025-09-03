import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RewardUnlockScreen extends StatefulWidget {
  const RewardUnlockScreen({Key? key}) : super(key: key);

  @override
  State<RewardUnlockScreen> createState() => _RewardUnlockScreenState();
}

class _RewardUnlockScreenState extends State<RewardUnlockScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Mock credit card bill data
  final List<Map<String, dynamic>> mockBills = [
    {
      'amount': '\$1,245.67',
      'date': 'Due: Jan 15, 2025',
      'status': 'Pending',
      'cardType': 'Visa',
      'lastFour': '4521',
    },
    {
      'amount': '\$892.34',
      'date': 'Due: Jan 22, 2025',
      'status': 'Paid',
      'cardType': 'Mastercard',
      'lastFour': '8765',
    },
    {
      'amount': '\$567.89',
      'date': 'Due: Feb 5, 2025',
      'status': 'Overdue',
      'cardType': 'Amex',
      'lastFour': '3456',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation when screen loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Rewards'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                        Lottie.asset('assets/groovy.json'),
                          const SizedBox(height: 16),
                          const Text(
                            'You\'ve unlocked a \$10 reward!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Congratulations! Use it towards any bill payment.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrandSelectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Choose Brand to Apply Reward',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Credit card bills section
            const Text(
              'Your Bills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            

            ...mockBills.asMap().entries.map((entry) {
              final index = entry.key;
              final bill = entry.value;
              
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      (1 - _fadeAnimation.value) * 50 * (index + 1),
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Card icon
                            Container(
                              width: 48,
                              height: 32,
                              decoration: BoxDecoration(
                                color: _getCardColor(bill['cardType']),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            
                            const SizedBox(width: 16),
                            
                            // Bill details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${bill['cardType']} •••• ${bill['lastFour']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        bill['amount'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        bill['date'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(bill['status']),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          bill['status'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getCardColor(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return const Color(0xFF1A1F71);
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'amex':
        return const Color(0xFF006FCF);
      default:
        return Colors.grey[600]!;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Brand Selection Screen
class BrandSelectionScreen extends StatefulWidget {
  const BrandSelectionScreen({Key? key}) : super(key: key);

  @override
  State<BrandSelectionScreen> createState() => _BrandSelectionScreenState();
}

class _BrandSelectionScreenState extends State<BrandSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String? selectedBrand;

  // Mock brand data
  final List<Map<String, dynamic>> mockBrands = [
    {
      'name': 'Amazon',
      'logo': Icons.shopping_cart,
      'color': const Color(0xFFFF9900),
      'description': 'Shop millions of products',
      'discount': '5% cashback',
    },
    {
      'name': 'Netflix',
      'logo': Icons.movie,
      'color': const Color(0xFFE50914),
      'description': 'Stream movies and TV shows',
      'discount': '10% off subscription',
    },
    {
      'name': 'Starbucks',
      'logo': Icons.local_cafe,
      'color': const Color(0xFF00704A),
      'description': 'Coffee and beverages',
      'discount': '15% off drinks',
    },
    {
      'name': 'Target',
      'logo': Icons.store,
      'color': const Color(0xFFCC0000),
      'description': 'Everyday essentials',
      'discount': '8% cashback',
    },
    {
      'name': 'Uber',
      'logo': Icons.directions_car,
      'color': const Color(0xFF000000),
      'description': 'Rides and food delivery',
      'discount': '12% off rides',
    },
    {
      'name': 'Apple',
      'logo': Icons.phone_iphone,
      'color': const Color(0xFF007AFF),
      'description': 'Technology and services',
      'discount': '3% cashback',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Choose Brand'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Color(0xFF4CAF50),
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '\$10.00 Available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Select a brand to apply your reward',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          // Brand list
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: mockBrands.length,
                itemBuilder: (context, index) {
                  final brand = mockBrands[index];
                  final isSelected = selectedBrand == brand['name'];
                  
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected 
                            ? const Color(0xFF4CAF50) 
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          setState(() {
                            selectedBrand = brand['name'];
                          });
                          
                          // Show confirmation after selection
                          Future.delayed(const Duration(milliseconds: 300), () {
                            _showConfirmationDialog(brand);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // Brand icon
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: brand['color'] as Color,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  brand['logo'] as IconData,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              
                              const SizedBox(width: 16),
                              
                              // Brand details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      brand['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      brand['description'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (brand['color'] as Color).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        brand['discount'],
                                        style: TextStyle(
                                          color: brand['color'] as Color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Selection indicator
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF4CAF50),
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(Map<String, dynamic> brand) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.celebration,
                color: Color(0xFF4CAF50),
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Reward Applied!'),
            ],
          ),
          
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your \$10 reward has been applied to ${brand['name']}.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
                          Text(
                'Your message here', // Add the required text
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            
            TextButton(
              onPressed: () {
                
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text('Great!'),
            ),
          ],
        );
      },
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Reward App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto',
//       ),
//       home: const RewardUnlockScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }