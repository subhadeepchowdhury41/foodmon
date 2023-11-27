import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodmon/provider/cart_model.dart';
import 'package:foodmon/provider/cart_state.dart';
import 'package:foodmon/screens/search_screen.dart';
import 'package:foodmon/widgets/ui/filled_icon_button.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabItems.length, vsync: this);
    ref.read(cartProvider.notifier).initialize();
    super.initState();
  }

  final tabItems = ["Recommended", "Combos", "Regular Burgers", "Special"];
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(cartProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: list.isNotEmpty &&
              list.where((element) => element.quantity != 0).toList().isNotEmpty
          ? _getBottomSheet(list)
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.only(top: 15),
            height: size.height * 0.28,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/banner.jpg',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            FilledIconButton(
                                onPressed: () {},
                                icon: Icons.arrow_back_ios_new),
                          ],
                        ),
                        Row(
                          children: [
                            FilledIconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => SearchScreen()));
                                },
                                icon: Icons.search),
                            const SizedBox(
                              width: 20,
                            ),
                            FilledIconButton(
                                onPressed: () {}, icon: Icons.share),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amerika Foods',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'American, Fast Foods, Burgers',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {},
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  size: 23,
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(width: 30),
                        Row(
                          children: [
                            Icon(Icons.reviews_sharp, color: Colors.blueGrey),
                            SizedBox(
                              width: 10,
                            ),
                            Text('1k+ reviews',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16))
                          ],
                        ),
                        SizedBox(width: 30),
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, color: Colors.blue),
                            SizedBox(
                              width: 10,
                            ),
                            Text('5 mins',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.green,
            indicatorWeight: 12,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.green,
                ),
              ),
            ),
            tabs: List.generate(
              tabItems.length,
              (i) {
                return Text(
                  tabItems[i],
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                _tabController.length,
                (index) => ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (_, i) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/banner.jpg',
                                height: 120,
                                width: 120,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[i].itemName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'It is a long established fact that a reader will be distracted.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹ ${list[i].price}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              ref
                                                  .read(cartProvider.notifier)
                                                  .updateQuantity(list[i],
                                                      list[i].quantity - 1);
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: _getButtonDec(
                                                  green: list[i].quantity > 0),
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                                color: list[i].quantity > 0
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${list[i].quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              ref
                                                  .read(cartProvider.notifier)
                                                  .updateQuantity(list[i],
                                                      list[i].quantity + 1);
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: _getButtonDec(
                                                  green: list[i].quantity <
                                                      list[i].totolQuantity),
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                                color: list[i].quantity <
                                                        list[i].totolQuantity
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBottomSheet(List<CartItem> items) {
    double totalValue = 0;
    int len = 0;
    for (CartItem item in items) {
      if (item.quantity != 0) {
        totalValue += item.quantity * item.price;
        len++;
      }
    }

    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '${len} Item',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                    height: 16, child: VerticalDivider(color: Colors.grey)),
                Text(
                  '₹ ${totalValue}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'View Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  BoxDecoration _getButtonDec({required bool green}) {
    if (green == true) {
      return BoxDecoration(
        color: Colors.green.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green),
      );
    } else {
      return BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      );
    }
  }
}
