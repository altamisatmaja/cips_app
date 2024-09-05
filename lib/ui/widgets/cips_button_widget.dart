part of 'widget.dart';

class CipsButtonWidget extends StatelessWidget {
  final String textTitle;
  final VoidCallback onPressed;
  final bool isLight;
  const CipsButtonWidget(
      {super.key,
      required this.textTitle,
      required this.onPressed,
      this.isLight = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
          ),
          backgroundColor:
              isLight == false ? CIPSColor.primaryColor : Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          textTitle,
          style: isLight == false
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)
              : Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: CIPSColor.primaryColor),
        ),
      ),
    );
  }
}
