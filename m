Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881AF3F7241
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhHYJtX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Aug 2021 05:49:23 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43561 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239691AbhHYJtW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 25 Aug 2021 05:49:22 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 7E200440E83;
        Wed, 25 Aug 2021 12:48:28 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 4/4] arm64: dts: ipq6018: add pwm node
Date:   Wed, 25 Aug 2021 12:48:27 +0300
Message-Id: <80f5b40bfa3f644b5de41be65f771a0d7fb11d30.1629884907.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
References: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Describe the PWM block on IPQ6018.

The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
&pwm as child of &tcsr.

Add also ipq6018 specific compatible string.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v7:

  Use 'reg' instead of 'offset' (Rob)

  Add qcom,tcsr-ipq6018 (Rob)

  Drop clock-names (Bjorn)

v6:

  Make the PWM node child of TCSR (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for TCSR phandle instead of direct regs

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index ecadbee53554..6750a920cdb8 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -259,8 +259,20 @@ tcsr_mutex_regs: syscon@1905000 {
 		};
 
 		tcsr: syscon@1937000 {
-			compatible = "syscon";
+			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
 			reg = <0x0 0x01937000 0x0 0x21000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pwm: pwm@a010 {
+				compatible = "qcom,ipq6018-pwm";
+				reg = <0xa010>;
+				clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clock-rates = <100000000>;
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		blsp_dma: dma-controller@7884000 {
-- 
2.32.0

