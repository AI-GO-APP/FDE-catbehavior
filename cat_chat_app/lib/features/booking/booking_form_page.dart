import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/routes.dart';

class BookingFormPage extends StatefulWidget {
  const BookingFormPage({super.key});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('填寫預約資料'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            // Final submit
            _showSuccessDialog(context);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          final isLast = _currentStep == 2;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isLast ? '確認送出並付款' : '下一步'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('上一步', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('選擇貓咪檔案', style: TextStyle(fontWeight: FontWeight.bold)),
            content: _buildCatSelection(),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('行為問題與需求描述', style: TextStyle(fontWeight: FontWeight.bold)),
            content: _buildIssueDescription(),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : _currentStep == 1 ? StepState.editing : StepState.indexed,
          ),
          Step(
            title: const Text('預約偏好與聲明', style: TextStyle(fontWeight: FontWeight.bold)),
            content: _buildPreferences(),
            isActive: _currentStep >= 2,
            state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          ),
        ],
      ),
    );
  }

  Widget _buildCatSelection() {
    return Column(
      children: [
        RadioListTile<int>(
          title: const Text('橘子 (公, 3歲, 已結紮)'),
          subtitle: const Text('晶片號碼: 90012345678'),
          value: 1,
          groupValue: 1,
          onChanged: (val) {},
          activeColor: Colors.orange,
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<int>(
          title: const Text('黑糖 (母, 2歲, 未結紮)'),
          subtitle: const Text('晶片號碼: 無'),
          value: 2,
          groupValue: 1,
          onChanged: (val) {},
          activeColor: Colors.orange,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('新增貓咪檔案'),
          style: OutlinedButton.styleFrom(foregroundColor: Colors.orange),
        )
      ],
    );
  }

  Widget _buildIssueDescription() {
    return Column(
      children: [
        const Text(
          '請盡可能詳細描述您遇到的問題，這有助於諮詢師在見面前掌握狀況。',
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 12),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: '例如：最近一週開始會在沙發上亂尿尿，而且只挑晚上...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
        const SizedBox(height: 16),
        const Text('近期生活環境是否有重大變動？', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(label: const Text('搬家'), onSelected: (v) {}, selected: false),
            FilterChip(label: const Text('新成員加入'), onSelected: (v) {}, selected: true, selectedColor: Colors.orange.shade100),
            FilterChip(label: const Text('作息改變'), onSelected: (v) {}, selected: false),
            FilterChip(label: const Text('更換貓砂/飼料'), onSelected: (v) {}, selected: false),
          ],
        )
      ],
    );
  }

  Widget _buildPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('服務方式', style: TextStyle(fontWeight: FontWeight.w600)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                title: const Text('線上視訊'),
                value: 1,
                groupValue: 1,
                onChanged: (val) {},
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.orange,
              ),
            ),
            Expanded(
              child: RadioListTile<int>(
                title: const Text('到府服務'),
                value: 2,
                groupValue: 1,
                onChanged: (val) {},
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('是否同意將匿名案例用於內部教學？', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('同意授權'),
          value: true,
          onChanged: (val) {},
          activeColor: Colors.orange,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('預約送出成功'),
        content: const Text('我們已收到您的預約與資料，稍後會發送確認信件至您的信箱。若為到府服務，請留意後續的地址確認訊息。'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // close dialog
              context.go(AppRoutes.home); // return to home
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
            child: const Text('回到首頁'),
          )
        ],
      ),
    );
  }
}
