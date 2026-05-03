import 'dart:convert';
import 'package:flutter/material.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final _searchController = TextEditingController();
  final _doctorFeeController = TextEditingController();
  final _medicineChargeController = TextEditingController();

  Map<String, dynamic>? _patientData;
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _doctorFeeController.addListener(_calculateTotal);
    _medicineChargeController.addListener(_calculateTotal);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _doctorFeeController.dispose();
    _medicineChargeController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    final docFee = double.tryParse(_doctorFeeController.text) ?? 0.0;
    final medFee = double.tryParse(_medicineChargeController.text) ?? 0.0;
    setState(() {
      _totalAmount = docFee + medFee;
    });
  }

  void _searchPatient() {
    final input = _searchController.text;
    try {
      final data = jsonDecode(input);
      setState(() {
        _patientData = data;
      });
    } catch (e) {
      // Fallback to mock data if it's just an ID instead of JSON
      if (input.isNotEmpty) {
        setState(() {
          _patientData = {
            'id': input,
            'name': 'John Doe (Mock)',
            'nic': '123456789V',
            'phone': '0771234567',
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Billing'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Patient Retrieval Section
            Text(
              'Retrieve Patient',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Scan QR or Enter ID',
                      prefixIcon: Icon(Icons.qr_code_scanner),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _searchPatient,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Patient Details Section
            if (_patientData != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Details',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Divider(),
                      _DetailRow(label: 'Name', value: _patientData!['name'] ?? 'N/A'),
                      _DetailRow(label: 'ID', value: _patientData!['id'] ?? 'N/A'),
                      _DetailRow(label: 'NIC', value: _patientData!['nic'] ?? 'N/A'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Charges Section
              Text(
                'Charges',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _doctorFeeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Doctor Fee (\$)',
                  prefixIcon: Icon(Icons.medical_services),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _medicineChargeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Medicine Charges (\$)',
                  prefixIcon: Icon(Icons.medication),
                ),
              ),
              const SizedBox(height: 24),

              // Total Calculation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$${_totalAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Proceed Button
              ElevatedButton(
                onPressed: _totalAmount > 0
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/payment',
                          arguments: {
                            'patientName': _patientData!['name'],
                            'doctorFee': double.tryParse(_doctorFeeController.text) ?? 0.0,
                            'medicineCharge': double.tryParse(_medicineChargeController.text) ?? 0.0,
                            'totalAmount': _totalAmount,
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Proceed to Payment'),
              ),
            ] else ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48.0),
                  child: Text(
                    'Search for a patient to start billing.',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              )
            ],
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
