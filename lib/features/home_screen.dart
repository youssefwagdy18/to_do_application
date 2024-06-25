import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/features/setting_tab/setting_tab.dart';
import 'package:todo_app/features/task_list_tab/add_task_bottom_sheet.dart';
import 'package:todo_app/features/task_list_tab/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    AuthProviders authProviders = Provider.of<AuthProviders>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Row(
          children: [
            Text(AppLocalizations.of(context)!.to_do_list,
              style: MyTheme.lightMode.textTheme.titleLarge,
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.02,),
            Text("{${authProviders.currentUser?.firstName??''}}",
              style: MyTheme.lightMode.textTheme.titleLarge,)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          padding: const EdgeInsets.all(10),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int currentIndex) {
              selectedIndex = currentIndex;
              setState(() {});
            },
            items:  [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list), label: AppLocalizations.of(context)!.task_List),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings), label:AppLocalizations.of(context)!.settings),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          color: MyTheme.lightWhiteColor,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ?  const TaskListTab() :  const SettingTab(),
    );
  }

  void showTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const AddTaskBottomSheet());
  }
}
