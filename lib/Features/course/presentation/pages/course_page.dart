// TODO Implement this library.import '../../../../Core/widgets/loading_widget.dart';
import '../../../../Core/widgets/loading_widget.dart';
import '../../../course/presentation/widgets/course_page/message_display_widget.dart';
import '../blocs/Courses/course_bloc.dart';
import '../widgets/course_page/course_list_widget.dart';
import 'course_add_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CoursesPage extends StatelessWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: Text('Courses'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state is LoadingCoursesState) {
            return LoadingWidget();
          } else if (state is LoadedCoursesState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: CourseListWidget(courses: state.courses));
          } else if (state is ErrorCoursesState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<CoursesBloc>(context).add(RefreshCourseEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => courseAddUpdatePage(
                  isUpdatecourse: false,
                )));
      },
      child: Icon(Icons.add),
    );
  }
}