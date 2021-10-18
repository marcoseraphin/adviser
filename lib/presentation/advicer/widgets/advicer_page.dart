import 'package:adviser/application/advicer/advicer_bloc.dart';
import 'package:adviser/presentation/advicer/widgets/advice_field.dart';
import 'package:adviser/presentation/advicer/widgets/custom_button.dart';
import 'package:adviser/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Advicer", style: themeData.textTheme.headline1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                  child: Center(
                      child: BlocBuilder<AdvicerBloc, AdvicerState>(
                          bloc: BlocProvider.of<AdvicerBloc>(context),
                          //..add(AdviceRequestedEvent()), // fire initial event
                          builder: (context, adviceState) {
                            if (adviceState is AdvicerInitial) {
                              return Text(
                                "Your advice is waiting for you.",
                                style: themeData.textTheme.headline1,
                                textAlign: TextAlign.center,
                              );
                            } else if (adviceState is AdvicerStateLoading) {
                              return CircularProgressIndicator(
                                  color: themeData.colorScheme.secondary);
                            } else if (adviceState is AdvicerStateLoaded) {
                              return AdviceField(
                                advice: adviceState.advice,
                              );
                            } else if (adviceState is AdvicerStateError) {
                              return ErrorMessage(
                                message: adviceState.message,
                              );
                            }

                            return const Placeholder();
                          }))),
              const SizedBox(
                height: 200,
                child: Center(child: CustomButton()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
