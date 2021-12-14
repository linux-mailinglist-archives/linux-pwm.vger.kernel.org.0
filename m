Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09AD474800
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Dec 2021 17:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhLNQ2D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Dec 2021 11:28:03 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:39133 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230258AbhLNQ2C (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Dec 2021 11:28:02 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 7FA4B440F50;
        Tue, 14 Dec 2021 18:27:59 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1639499279;
        bh=rHkMOwgOi3SGGouzSwXqrVTyx8BtcP7/HjaYwhPfaF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIY5J2w8YHz+T5gS07Uj0U96Ze1mnAiEsLgwaIKwrTrAHY4lZIlMpVfyz6B7RfSlY
         u1ulwkaJBlFm/fU85iZFT1tv0E7yWMQMuG5ffupWPute0RDAHbLAlx7Mlz2fylCWiG
         hN6vgRf5GoAN1cg3+epQiCfczm4k5a47DR9RdFdwzniI439+UYAClUkFivNzB2Ux07
         k72/fc1/4K2CrxlrUYsH0O17mAoCkQnswP4jr2B+7HoLQ55+OKFck90ye/WwHmJ52r
         qY9bLHQnaZRiVlCGKoy4M/Hzmpc+k4MHYfjGIQ+5Jwj6QlWjlI295or2YclO1YPvOz
         +5DVQRjb9Psfw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 3/3] arm64: dts: ipq6018: add pwm node
Date:   Tue, 14 Dec 2021 18:27:19 +0200
Message-Id: <6b48e8845c0df6060feb6eca8eba97a29b577b83.1639499239.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ab2a4c345844f66aa22a847e522b2f4ee0786d8b.1639499239.git.baruch@tkos.co.il>
References: <ab2a4c345844f66aa22a847e522b2f4ee0786d8b.1639499239.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

Describe the PWM block on IPQ6018.

The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
&pwm as child of &tcsr.

Add also ipq6018 specific compatible string.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
v9:

  Add 'ranges' property (Rob)

v8:

  Add size cell to 'reg' (Rob)

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
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 933b56103a46..6a22bb5f42f4 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -258,8 +258,21 @@ tcsr_mutex_regs: syscon@1905000 {
 		};
 
 		tcsr: syscon@1937000 {
-			compatible = "syscon";
+			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
 			reg = <0x0 0x01937000 0x0 0x21000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x01937000 0x21000>;
+
+			pwm: pwm@a010 {
+				compatible = "qcom,ipq6018-pwm";
+				reg = <0xa010 0x20>;
+				clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+				assigned-clock-rates = <100000000>;
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		blsp_dma: dma-controller@7884000 {
-- 
2.33.0

