@Entry
@Component
struct Calculator {
  // 状态变量：显示文本、当前输入值、计算结果、运算符
  @State displayText: string = "0";
  @State currentValue: string = "";
  @State result: number = 0;
  @State operator: string = "";

  // 数字/小数点点击事件（显式声明返回值void）
  handleNumberClick(num: string): void {
    if (num === "." && this.currentValue.includes(".")) {
      return;
    }
    if (this.currentValue === "0" && num !== ".") {
      this.currentValue = num;
    } else {
      this.currentValue += num;
    }
    this.displayText = this.currentValue;
  }

  // 运算符点击事件（显式声明返回值void）
  handleOperatorClick(op: string): void {
    if (this.currentValue === "") return;
    if (this.operator === "") {
      this.result = parseFloat(this.currentValue);
    } else {
      this.calculateResult();
    }
    this.operator = op;
    this.currentValue = "";
    this.displayText = `${this.result} ${this.operator}`;
  }

  // 计算结果（显式声明返回值void）
  calculateResult(): void {
    const current = parseFloat(this.currentValue);
    if (isNaN(current)) return;

    switch (this.operator) {
      case "+":
        this.result += current;
        break;
      case "-":
        this.result -= current;
        break;
      case "×":
        this.result *= current;
        break;
      case "÷":
        this.result = current !== 0 ? this.result / current : 0;
        break;
      case "%":
        this.result = this.result * (current / 100);
        break;
    }
    this.result = parseFloat(this.result.toFixed(6));
    this.displayText = this.result.toString();
    this.currentValue = this.result.toString();
    this.operator = "";
  }

  // 清空所有状态（显式声明返回值void）
  handleClear(): void {
    this.displayText = "0";
    this.currentValue = "";
    this.result = 0;
    this.operator = "";
  }

  // 删除最后一位（显式声明返回值void）
  handleDelete(): void {
    if (this.currentValue.length > 0) {
      this.currentValue = this.currentValue.slice(0, -1);
      this.displayText = this.currentValue || "0";
    }
  }

  // 通用按钮样式封装（增加flexGrow参数控制宽度）
  @Builder buttonItem(text: string, bgColor: string, textColor: string, flexGrow: number = 1, onClick: () => void): void {
    Button(text)
      .onClick(onClick)
      .backgroundColor(bgColor)
      .fontColor(textColor)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .borderRadius(12)
      .flexGrow(flexGrow)
      .margin(4)
      .height("100%")
      .shadow({ radius: 2, color: "#00000020", offsetX: 1, offsetY: 1 });
  }

  build() {
    Column() {
      // 显示区域
      Text(this.displayText)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.End)
        .padding({ left: 20, right: 20, top: 20, bottom: 20 })
        .flexGrow(1)
        .width("100%")
        .backgroundColor("#f8f8f8")
        .borderRadius(16)
        .margin(10)
        .fontColor("#333333");

      // 按钮区域：纯Column+Row布局
      Column() {
        // 第一行：AC、←、%、÷
        Row() {
          this.buttonItem("AC", "#ff9500", "#ffffff", 1, (): void => { this.handleClear() });
          this.buttonItem("←", "#ff9500", "#ffffff", 1, (): void => { this.handleDelete() });
          this.buttonItem("%", "#ff9500", "#ffffff", 1, (): void => { this.handleOperatorClick("%") });
          this.buttonItem("÷", "#ff9500", "#ffffff", 1, (): void => { this.handleOperatorClick("÷") });
        }
        .width("100%")
        .height("16%")
        .margin(2);

        // 第二行：7、8、9、×
        Row() {
          this.buttonItem("7", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("7") });
          this.buttonItem("8", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("8") });
          this.buttonItem("9", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("9") });
          this.buttonItem("×", "#ff9500", "#ffffff", 1, (): void => { this.handleOperatorClick("×") });
        }
        .width("100%")
        .height("16%")
        .margin(2);

        // 第三行：4、5、6、-
        Row() {
          this.buttonItem("4", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("4") });
          this.buttonItem("5", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("5") });
          this.buttonItem("6", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("6") });
          this.buttonItem("-", "#ff9500", "#ffffff", 1, (): void => { this.handleOperatorClick("-") });
        }
        .width("100%")
        .height("16%")
        .margin(2);

        // 第四行：1、2、3、+
        Row() {
          this.buttonItem("1", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("1") });
          this.buttonItem("2", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("2") });
          this.buttonItem("3", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick("3") });
          this.buttonItem("+", "#ff9500", "#ffffff", 1, (): void => { this.handleOperatorClick("+") });
        }
        .width("100%")
        .height("16%")
        .margin(2);

        // 第五行：0、.、= （0按钮占两列宽度）
        Row() {
          // 0占2列，.和=各占1列
          this.buttonItem("0", "#4CAF50", "#ffffff", 2, (): void => { this.handleNumberClick("0") });
          this.buttonItem(".", "#4CAF50", "#ffffff", 1, (): void => { this.handleNumberClick(".") });
          this.buttonItem("=", "#d32f2f", "#ffffff", 1, (): void => { this.calculateResult() });
        }
        .width("100%")
        .height("16%")
        .margin(2);
      }
      .flexGrow(2)
      .width("100%")
      .padding(10);
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#ffffff");
  }
}