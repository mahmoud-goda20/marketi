import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/services/getit/get_it.dart';
import 'package:marketi/core/utils/app_style.dart';
import 'package:marketi/core/widgets/arrow_back.dart';
import 'package:marketi/feature/home/domain/repo/home_repo.dart';
import 'package:marketi/feature/home/presentation/mangement/cubit/home_cubit.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/custom_searsh.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/loading_widget.dart';
import 'package:marketi/feature/home/presentation/ui/widgets/user_image.dart';


class BrandsScreen extends StatelessWidget {
  BrandsScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt<HomeRepo>())..getBrands(),
      child: Scaffold(
        appBar: AppBar(
          leading: ArrowBack(),
          title: const Text('Brands'),
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
                children: [Text("All Brands", style: AppStyle.title)],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final homeCubit = context.read<HomeCubit>();
                    if (state is HomeLoading) {
                      return LoadingWidget();
                    } else if (state is HomeFailure) {
                      return Center(child: Text(state.errorMessage,
                          style: AppStyle.body));
                    }
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final brand = homeCubit.brands[index];
                        return Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppStyle.lightBlue700,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  brand.emoji,
                                  style: TextStyle(fontSize: 40),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  brand.name,
                                  style: AppStyle.title.copyWith(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: homeCubit.brands.length,
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
