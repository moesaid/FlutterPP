import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Clients/client_list_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildClientList extends StatelessWidget {
  final void Function(ClientModel)? onClientSelected;
  const BuildClientList({
    super.key,
    this.onClientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientListController>(
      init: ClientListController(),
      initState: (_) {},
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BuildLoadingOrEmptyLayout(
              isLoading: _.isLoading,
              isEmpty: _.clients.isEmpty,
              title: 'No Clients Found',
              child: ListView.separated(
                itemCount: _.clients.length,
                shrinkWrap: true,
                separatorBuilder: (_, __) {
                  return SizedBox(height: 1.sp);
                },
                itemBuilder: (__, int index) {
                  ClientModel item = _.clients[index];
                  return Card(
                    elevation: 0,
                    color: Get.theme.colorScheme.primaryContainer,
                    child: ListTile(
                      dense: true,
                      onTap: () => onClientSelected?.call(item),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.sp,
                        vertical: 1.sp,
                      ),
                      title: Text(
                        item.name ?? '',
                        style: Get.textTheme.titleSmall!,
                      ),
                      subtitle: Text(item.email ?? ''),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 4.sp,
                      ),
                      leading: CircleAvatar(
                        backgroundColor:
                            Get.theme.colorScheme.secondaryContainer,
                        foregroundImage: item.logo == null
                            ? null
                            : const NetworkImage(
                                'https://d33v4339jhl8k0.cloudfront.net/docs/assets/5c47e765042863543ccc1e58/images/5e56bcae2c7d3a7e9ae85836/file-eyETgxxf0V.png',
                              ),
                        child: item.logo == null
                            ? Text(item.name?[0] ?? '')
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
