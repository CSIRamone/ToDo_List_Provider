import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/todolist_default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme.extensions.dart';
import 'package:todo_list_provider/app/core/ui/todolisticon_icons.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widget/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;
  
  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    TodolistDefaultListenerNotifier(changeNotifier: widget._homeController).listener(
      context: context, 
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
       
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._homeController.loadTotalTasks();
      widget._homeController.findTasks(filter: TaskFilterEnum.today); 
  });
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    //Navigator.of(context).pushNamed('/tasks/create');
    //exemplo Navigator.of(context).push(MaterialPageRoute(
    //exemplo   builder: (_) => TasksModule().getPage('/tasks/create', context)));
    await Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInQuad,
        );
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.bottomRight,
          child: child,
          );
      },
      pageBuilder: (context, animation, secondaryAnimation) =>
          TasksModule().getPage('/tasks/create', context),
    ));
    widget._homeController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.primaryColor,
        ),
        backgroundColor: Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(Todolisticon.filter),
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                child: Text('Mostrar tarefas concluidas'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          _goToCreateTask(context);
        },
      ),
      backgroundColor: Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: constraints.maxWidth,
              ),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        HomeFilters(),
                        HomeWeekFilter(),
                        HomeTasks(),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
