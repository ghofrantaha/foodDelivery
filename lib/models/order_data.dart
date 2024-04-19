class Order {
  final String code;
  final String status;
  final double total;
  final DateTime orderTime;
  final String address;

  const Order({
    required this.code,
    required this.status,
    required this.total,
    required this.orderTime,
    required this.address,
  });
}

List<Order> orders = [
  Order(
    code: '#001',
    status: 'Pending',
    total: 1053.63,
    orderTime: DateTime(2022, 3, 4),
    address: '123 Main St New York',
  ),
  Order(
    code: '#002',
    status: 'Cancelled',
    total: 1463.25,
    orderTime: DateTime.now(),
    address: '152 Side St Los Angeles',
  ),
  Order(
    code: '#003',
    status: 'Delivered',
    total: 1899.65,
    orderTime: DateTime(2023, 9, 12),
    address: '333 Main St France Paris',
  ),
  Order(
    code: '#004',
    status: 'Shipped',
    total: 2885.65,
    orderTime: DateTime(2024, 5, 20),
    address: '123 Main St Egypt',
  ),
];
