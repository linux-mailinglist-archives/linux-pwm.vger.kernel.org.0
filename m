Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5423B522F
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Jun 2021 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhF0F0h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 27 Jun 2021 01:26:37 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:55859 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhF0F0g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 27 Jun 2021 01:26:36 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 9D88D440677;
        Sun, 27 Jun 2021 08:24:10 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] arm64: dts: ipq6018: add pwm node
Date:   Sun, 27 Jun 2021 08:24:06 +0300
Message-Id: <6babae66a20fca62e10b6abdd642773d2590b70e.1624771446.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
References: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Describe the PWM block on IPQ6018.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
Rob has not responded to Bjorn's questions[1] regarding registers area
description and the TCSR block. Leaving it the same as in v2 for now.

[1] https://lore.kernel.org/linux-arm-msm/YLgO0Aj1d4w9EcPv@yoga/

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 6ee7b99c21ec..bbc1ed960bb4 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -355,6 +355,15 @@ i2c_1: i2c@78b7000 { /* BLSP1 QUP2 */
 			status = "disabled";
 		};
 
+		pwm: pwm@1941010 {
+			#pwm-cells = <2>;
+			compatible = "qcom,ipq6018-pwm";
+			reg = <0x0 0x1941010 0x0 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		qpic_bam: dma-controller@7984000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x0 0x07984000 0x0 0x1a000>;
-- 
2.30.2

