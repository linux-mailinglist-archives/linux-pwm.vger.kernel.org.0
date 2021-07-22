Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69B73D21DB
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhGVJas (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 05:30:48 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:39349 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhGVJar (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 05:30:47 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3EDA44407CE;
        Thu, 22 Jul 2021 13:01:28 +0300 (IDT)
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
Subject: [PATCH v6 1/4] arm64: dts: ipq6018: correct TCSR block area
Date:   Thu, 22 Jul 2021 13:01:07 +0300
Message-Id: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

According to Bjorn Andersson[1], &tcsr_q6 base is 0x01937000 with size
0x21000. Adjust qcom,halt-regs offsets (add 0xe000) to match the new
syscon base.

Also, rename to just &tcsr as Kathiravan T suggested.

[1] https://lore.kernel.org/r/YLgO0Aj1d4w9EcPv@yoga

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v6:

  Fix offset adjust (Kathiravan T)

  Rename &tcsr_q6 to &tcsr (Kathiravan T)

v5: New patch in this series
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 6ee7b99c21ec..6bb262757cd9 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -270,9 +270,9 @@ tcsr_mutex_regs: syscon@1905000 {
 			reg = <0x0 0x01905000 0x0 0x8000>;
 		};
 
-		tcsr_q6: syscon@1945000 {
+		tcsr: syscon@1937000 {
 			compatible = "syscon";
-			reg = <0x0 0x01945000 0x0 0xe000>;
+			reg = <0x0 0x01937000 0x0 0x21000>;
 		};
 
 		blsp_dma: dma-controller@7884000 {
@@ -615,7 +615,7 @@ q6v5_wcss: remoteproc@cd00000 {
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "prng";
 
-			qcom,halt-regs = <&tcsr_q6 0xa000 0xd000 0x0>;
+			qcom,halt-regs = <&tcsr 0x18000 0x1b000 0xe000>;
 
 			qcom,smem-states = <&wcss_smp2p_out 0>,
 					   <&wcss_smp2p_out 1>;
-- 
2.30.2

