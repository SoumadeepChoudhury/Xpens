import 'package:flutter/material.dart';
import 'package:xpens/components/favourite_component.dart';
import 'package:xpens/variables.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header Section
            Container(
                child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_2_outlined,
                  size: home_page_profile_icon_size,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good morning, Soumadeep!",
                      style: TextStyle(
                          fontSize: home_page_profile_text_size,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("Spend Wisely, Save Smartly.")
                  ],
                ),
              ],
            )),
            SizedBox(height: 20),
            //Balance Section
            Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Your Current Balance",
                            style: TextStyle(
                                fontSize: your_current_balance_text_size,
                                color: Colors.white70),
                          ),
                          Spacer(),
                          DropdownButton<String>(
                              value: "Savings",
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.white70,
                              ),
                              elevation: 16,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700),
                              underline: SizedBox.shrink(),
                              onChanged: (String? newValue) {},
                              items: [
                                DropdownMenuItem(
                                    value: "Savings", child: Text("Savings")),
                                DropdownMenuItem(
                                    value: "UPI Lite", child: Text("UPI Lite"))
                              ]),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_rupee_sharp,
                              size: balance_value_text_size,
                              color: Colors.deepPurple[300],
                            ),
                            Text(
                              "11,987.28",
                              style: TextStyle(
                                  fontSize: balance_value_text_size,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[300]),
                            ),
                          ]),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text("January 23, 2025"),
                        ],
                      )
                    ])),
            SizedBox(
              height: 20,
            ),
            //Favourite Categories Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Favourite Categories",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FavouriteCategory(
                          icon: Icons.fastfood,
                          label: "Food",
                        ),
                        FavouriteCategory(
                          icon: Icons.local_grocery_store,
                          label: "Grocery",
                        ),
                        FavouriteCategory(
                          icon: Icons.book,
                          label: "Education",
                        ),
                        FavouriteCategory(
                          icon: Icons.sports_tennis,
                          label: "Sports",
                        ),
                        FavouriteCategory(
                          icon: Icons.add,
                          label: "Add",
                          isAddButton: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
