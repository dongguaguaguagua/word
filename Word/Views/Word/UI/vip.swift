import SwiftUI

struct VipTest: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 设置页面背景色
                Color(red: 39/255, green: 46/255, blue: 71/255).edgesIgnoringSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("付费会员卡")
                                .bold()
                                .padding(.bottom, 4)
                                .foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255))
                        }
                        // 填充中间空白区域，使文字上下靠边
                        Spacer()
                        HStack(alignment: .bottom) {
                            Text("3").bold().padding(.bottom, -4).font(.system(size: 24))
                            Text("天·9月27日到期").font(.system(size: 10))
                            // 空白区域填充，使文字居左
                            Spacer(minLength: 0)
                        }.foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255))
                    }
                    .padding()
                    .frame(height: 180)
                    // 会员卡背景色渐变
                    .background(RadialGradient(
                        gradient: Gradient(
                            colors: [
                                Color(red: 56/255, green: 81/255, blue: 116/255),
                                Color(red: 39/255, green: 46/255, blue: 71/255),
                                Color(red: 231/255, green: 200/255, blue: 153/255),
                                Color(red: 39/255, green: 46/255, blue: 71/255),
                            ]
                        ),
                        center: .center,
                        startRadius: 2,
                        endRadius: 650
                    )
                    )
                    // 圆角边框
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color(red: 231/255, green: 200/255, blue: 153/255), lineWidth: 1)

                    ).padding(.bottom, 10)
                    VStack {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "infinity")
                                    Text("付费会员卡").bold()
                                }.padding(.bottom, -5)
                                Divider().overlay(Color.gray)
                                Text("全场出版书畅读")
                                Text("全场有声书畅听")
                                Text("书架无上限")
                                Text("离线下载无上限")
                                Text("时长可兑换体验卡和书币")
                                Text("专属阅读背景和字体")
                            }
                            .padding()
                            .foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255))
                            Spacer()
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "infinity")
                                    Text("体验卡")
                                }.padding(.bottom, -5)
                                Divider().overlay(Color.gray)
                                Text("部分出版书畅读")
                                Text("仅可收盘 AI 朗读")
                                Text("书架 500 本上限")
                                Text("每月可下载 3 本")
                                Text("仅可兑换体验卡")
                                Text("-")
                            }
                            .padding()
                            .foregroundColor(Color.gray)
                        }.font(.system(size: 12))
                    }
                    .background(Color(red: 47/255, green: 54/255, blue: 77/255))
                    .cornerRadius(12)
                }.padding([.top, .leading, .trailing])
            }
            // 设置一个底部固定区域，然后自定义其内部子视图
            .safeAreaInset(edge: .bottom) {
                VStack {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("连续包月 19.00").bold().padding(.bottom, 6)
                                Text("19元/月-自动续费可随时取消").font(.system(size: 10))
                            }
                            Spacer()
                            Text("立即开通")
                                .font(.system(size: 14))
                                .bold()
                                .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                                .foregroundColor(Color(hex: "#6F5021"))
                                .background(Color(hex: "#EACEA6"))
                                .cornerRadius(16)
                        }.foregroundColor(Color(hex: "#6F5021"))
                    }
                    .padding()
                    // 背景线性渐变，从左到右
                    .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#E7C899"), Color(hex: "#F9E9CF")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                    .padding(.bottom, 10)
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("购买年卡").padding(.bottom, 1)
                                HStack {
                                    Text("228.00").font(.headline)
                                    Text("(19元/月)").font(.subheadline)
                                }
                            }.frame(maxWidth: .infinity).font(.system(size: 14)).foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255)).padding().background(Color(red: 52/255, green: 58/255, blue: 78/255)).cornerRadius(12)
                            HStack {
                                Image(systemName: "gift").font(.system(size: 20))
                                VStack(alignment: .leading) {
                                    Text("赠送年卡给好友").padding(.bottom, 1)
                                    VStack(alignment: .leading) {
                                        Text("228.00").font(.headline)
                                    }
                                }
                            }.frame(maxWidth: .infinity).font(.system(size: 14)).foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255)).padding().background(Color(red: 52/255, green: 58/255, blue: 78/255)).cornerRadius(12)
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text("购买季卡").padding(.bottom, 1)
                                HStack {
                                    Text("60.00").font(.headline)
                                    Text("(20元/月)").font(.subheadline)
                                }
                            }.frame(maxWidth: .infinity).font(.system(size: 14)).foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255)).padding().background(Color(red: 52/255, green: 58/255, blue: 78/255)).cornerRadius(12)
                            VStack(alignment: .leading) {
                                Text("购买月卡").padding(.bottom, 1)
                                VStack(alignment: .leading) {
                                    Text("30.00").font(.headline)
                                }
                            }.frame(maxWidth: .infinity).font(.system(size: 14)).foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255)).padding().background(Color(red: 52/255, green: 58/255, blue: 78/255)).cornerRadius(12)
                        }
                        Text("确认购买后，将向您的 iTunes 账户收款。购买连续包月项目，将自动续订，iTunes 账户会在到期前 24 小时内扣费。在此之前，您可以在系统[设置] -> [iTunes Store 与 App Store] -> [Apple ID] 里面进行退订。").font(.system(size: 10)).foregroundColor(Color.gray).padding(.top, 10)
                    }
                }
                .padding()
                .background(
                    Color(red: 41/255, green: 50/255, blue: 75/255)
                )
            }
            // 设置导航栏为行内模式
            .navigationBarTitleDisplayMode(.inline)
            // 自定义导航栏标题内容
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("会员卡").font(.headline).padding(.bottom, 2)
                        Text("已使用 517 天·累计节省 839.76 元").font(.system(size: 12))
                    }.foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255))
                }
            }
            // 自定义导航栏左右两边的按钮
            .navigationBarItems(
                leading: Button(action: {
                    // 点击按钮时的操作
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255))
                }), trailing: Button(action: {
                    // 点击按钮时的操作
                }, label: {
                    Text("明细")
                        .foregroundColor(Color(red: 231/255, green: 200/255, blue: 153/255))
                })
            )
        }
    }
}

struct VipTest_Previews: PreviewProvider {
    static var previews: some View {
        VipTest()
    }
}
