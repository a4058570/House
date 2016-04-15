//
//  ALLTextField.h
//  ALiuLian
//
//  Created by 张旭 on 15/7/9.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef enum
{
    ALLTextField_Int=0,    //0112233445
    ALLTextField_String,   //012dcaad24d
    ALLTextField_Int_Number,  //不能以0打头    123124
    ALLTextField_Int_Float_Number,  //不能以0打头   11.11 或者 0.11
}ALLTextFieldType;


@interface ALLTextField : UITextField

@property(nonatomic)ALLTextFieldType type;
//ALLTextField_Int    ALLTextField_Int_Number  限制整数部分的位数
@property(nonatomic)int intLength;
//如果是ALLTextField_Int_Float_Number 类型 限制小数点后面位数
@property(nonatomic)int floatLength;
@property(nonatomic)int stringLength;


/********显示下划线***********/
@property(nonatomic)BOOL enableUnderLine;


/**********自动调整************/
//需要自动上移的view 如果为空 默认移动 textField 的parentView
//注意 adjustView 不要指定为 使用autoLayout的view, 假如一个textfield 在scrollView上
//scrollView 通过autoLayout 添加在viewA 中，那么这时候指定viewA  不要指定scrollview
@property(nonatomic,weak)UIView *adjustView;
@property(nonatomic)BOOL enableSuperViewAdjustForKeyboard;
//输入框底部与 键盘顶部的 最小距离 小于此距离 进行调整  default 40
@property(nonatomic)CGFloat textFieldKeyboardVerticalSpace;



//textfield 右边 的x 按钮 点击 清除textField内容
@property(nonatomic)BOOL enableCleanBtn;


@end
