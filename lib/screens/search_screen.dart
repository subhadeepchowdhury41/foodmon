import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodmon/provider/cart_model.dart';
import 'package:foodmon/provider/cart_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      // print('chic: ${_textEditingController.text}');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: _buildSearchTextField(),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        // You can customize the app bar as needed
      ),
      body: (_textEditingController.text.isEmpty)
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Recommendation',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 0.0,
                    children: [
                      _buildChip('Burgers'),
                      _buildChip('Chicken'),
                      _buildChip('Fries'),
                      _buildChip('Beverages'),
                      _buildChip('Sides'),
                      _buildChip('Desserts'),
                    ],
                  ),
                ],
              ),
            )
          : Consumer(
              builder: (context, state, _) {
                List<CartItem> prov = state
                    .watch(cartProvider.notifier)
                    .searchList(_textEditingController.text);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${prov.length} Search Results ...',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: prov.length,
                          itemBuilder: (_, i) => Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Chicken Crunch Burger',
                                          style: TextStyle(
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
                                            const Text(
                                              '₹ 209',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.15),
                                                      // Colors.green.withOpacity(0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Text(
                                                  '0',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 32,
                                                    width: 32,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green
                                                          .withOpacity(0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 16,
                                                      color: Colors.green,
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
                      const SizedBox(height: 15),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildChip(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _textEditingController.text = label;
        });
      },
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        label: Text(
          label,
          style: const TextStyle(
              color: Colors.green, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.green.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            isDense: true,
            hintText: 'Search...',
            contentPadding: EdgeInsets.all(10.0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: Icon(
              Icons.mic,
              color: Colors.black,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }
}
