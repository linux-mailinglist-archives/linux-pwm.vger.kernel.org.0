Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECE4AB7D9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiBGJkE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352862AbiBGJim (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 04:38:42 -0500
Received: from mx.tkos.co.il (guitar.tcltek.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4DC0401C0;
        Mon,  7 Feb 2022 01:38:40 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 4065A4409ED;
        Mon,  7 Feb 2022 11:30:38 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1644226238;
        bh=Kd4KB7a0IuAHNoAFfdMAc3/6q6mBt1QnffvQOUL1hCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLYQTmZwAI35PLILedReLiOLWqqwYeZ6PrJVwvNyh+0cqdyI1dspGQL7N5l9fpHgn
         NqFTwIASdoV6ghUVc9qN0yy4rAuyHCy890rchFaRczeZ4s1Ul3JLaHOMxDFXKCKNem
         BVuWd0jN70fuGsTGr255julMy5/yqE2ogy+kmgOwIA79f0MxMKvnUiY5oANiqDNSNr
         0oVNTNroptYTK3DV9+eEyLvWUJPAKs1vdx+WWRTp70uhe3V6fAwQdPSjjRLhxRnllP
         iwlbae/vnwN2tiiRl3HJulay8YOX4o7JYrBGoHYR6q7JLEcUGysscN1PUCGzNVk8uH
         Gf4Rzo0ut9VXg==
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
Subject: [PATCH 3/3] arm64: dts: ipq6018: add pwm node
Date:   Mon,  7 Feb 2022 11:30:45 +0200
Message-Id: <989c681a730f38b1a5f09dbb31552d9b974e400e.1644226245.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 66ec5615651d..a717fc17523d 100644
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
2.34.1

