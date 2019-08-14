Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5988D110
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 12:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHNKpT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 06:45:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53511 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727484AbfHNKpS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 06:45:18 -0400
X-UUID: d72f5f8f277a45a6b610e459151fc5ea-20190814
X-UUID: d72f5f8f277a45a6b610e459151fc5ea-20190814
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 2021076256; Wed, 14 Aug 2019 18:45:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 18:45:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 18:45:10 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        sam shih <sam.shih@mediatek.com>
Subject: [PATCH v2 10/10] arm: dts: mediatek: add mt7629 pwm support
Date:   Wed, 14 Aug 2019 18:43:40 +0800
Message-ID: <1565779497-23621-3-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 27BF008E58CB4D2053A06CEEFA952E5DF09D949F53CD1AA2DC22F59B95EF6DA62000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

This adds pwm support for MT7629.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 arch/arm/boot/dts/mt7629.dtsi | 14 ++++++++++++++
 drivers/pwm/pwm-mediatek.c    |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 9608bc2ccb3f..352df8d61788 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -241,6 +241,18 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@11006000 {
+			compatible = "mediatek,mt7629-pwm";
+			reg = <0 0x11006000 0 0x1000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				 <&pericfg CLK_PERI_PWM_PD>,
+				 <&pericfg CLK_PERI_PWM1_PD>;
+			clock-names = "top", "main", "pwm1";
+			num-pwms = <1>;
+			status = "disabled";
+		};
+
 		i2c: i2c@11007000 {
 			compatible = "mediatek,mt7629-i2c",
 				     "mediatek,mt2712-i2c";
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 922a7543a2b1..d2352ca7792e 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -327,11 +327,18 @@ static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.has_clks = false,
 };
 
+static const struct pwm_mediatek_of_data mt7629_pwm_data = {
+	.fallback_npwms = 1,
+	.pwm45_fixup = false,
+	.has_clks = true,
+};
+
 static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);
-- 
2.17.1

