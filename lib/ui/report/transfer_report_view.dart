import 'package:flutter/material.dart';
import 'package:tgp_flutter/entity/report_cell_item_type.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tgp_flutter/ui/report/base_report.dart';
import 'package:tgp_flutter/ui/report/report_cell_item.dart';
import 'package:tgp_flutter/ui/report/report_view_model.dart';

class TransferReportView extends StatefulWidget {
  final ReportViewModel vm;

  TransferReportView({
    required this.vm,
  });

  @override
  TransferReportViewState createState() => TransferReportViewState();
}

class TransferReportViewState extends BaseState<TransferReportView> {
  ScrollController _scrollController = ScrollController();
  var isLoading = false;
  RefreshController _refreshController = RefreshController();
  var pickerText1;
  var filterIndex = 0;
  ReportViewModel _vm = ReportViewModel();

  void initState() {
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getReport();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<ReportViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          _handleApiState();
          return BaseReport(
            reportHeaderList: ["trade_time", "transfer_from", "transfer_to", "amount"],
            getPickerBox: Container(),
            filterIndex: filterIndex,
            expandedHeight: 170,
            vm: _vm,
            getReport: (mIsLoadMore, mStatus) {
              _getReport(isLoadMore: mIsLoadMore);
            },
            setIndex: (value) {
              setState(() {
                filterIndex = value;
              });
            },
            scrollController: _scrollController,
            refreshController: _refreshController,
            list: _vm.transferReportList,
            displayItemList: _getList(),
            isUploadButton: false,
            url: _vm.brandLogoUrl,
          );
        });
  }

  List<Widget> _getList() => _vm.transferReportList == null
      ? []
      : List.generate(_vm.transferReportList!.length, (index) {
          return Container(
            child: ReportCellItem(
              list: [
                "",
                "",
                Format().dateTimeFormat(_vm.transferReportList![index].balanceTime),
                _vm.transferReportList![index].from,
                _vm.transferReportList![index].to,
                _vm.transferReportList![index].amount.toString(),
              ],
              type: _getReportItemType(index),
              isEndRecord: _vm.endRecord,
            ),
          );
        }).toList();

  _getReportItemType(int index) {
    if (_vm.transferReportList!.length == 1) {
      return ReportCellItemType.SINGLE;
    } else {
      if (index == 0) {
        return ReportCellItemType.TOP;
      } else if (index == _vm.transferReportList!.length - 1) {
        return ReportCellItemType.BOTTOM;
      } else {
        return ReportCellItemType.CENTER;
      }
    }
  }

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      _getReport(isLoadMore: true);
      setState(() {
        isLoading = true;
      });
    }
  }

  _getReport({bool isLoadMore = false}) async {
    await _vm.getTransferReport(isLoadMore: isLoadMore);
  }

  _handleApiState() {
    handleApiState(_vm.getTransferReportApiState, isAutoHideLoading: false, onSuccess: () {});
  }
}
