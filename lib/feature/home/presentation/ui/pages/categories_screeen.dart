import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';
import 'package:marketi/feature/home/presentation/mangement/cubit/home_cubit.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/category_item.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/custom_searsh.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/loading_widget.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/user_image.dart';


class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt<HomeRepo>())..getCategories(),
      child: Scaffold(
        appBar: AppBar(
          leading: ArrowBack(),
          title: const Text('Categories'),
          actions: [UserImage()],
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSearch(controller: controller),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("All Categories", style: AppStyle.title)],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final homeCubit = context.read<HomeCubit>();
                    if (state is HomeLoading) {
                      return LoadingWidget();
                    } else if (state is HomeFailure) {
                      return Center(child: Text(state.errorMessage, style: AppStyle.body));
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final category = homeCubit.categories[index];
                        return CategoryItem(
                          imagePath: category.image,
                          name: category.name,
                        );
                      },
                      itemCount: homeCubit.categories.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
