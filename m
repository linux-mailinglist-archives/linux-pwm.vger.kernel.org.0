Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF6463D1E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Nov 2021 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbhK3RsG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 12:48:06 -0500
Received: from bzq-84-110-109-230.cablep.bezeqint.net ([84.110.109.230]:41412
        "EHLO mx.tkos.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239176AbhK3RsG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 12:48:06 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 12:48:02 EST
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 31C45440EF5;
        Tue, 30 Nov 2021 19:38:05 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1638293885;
        bh=pmHAI62PJcgonrZzzSospKoaD7olCeJWuUO2kcIBOCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBpcX/wseBX5giUf5oR4HHIvYTF3LOCRQQtpJqwTlDnkRtkcwg9/5KfrA15MOQX9y
         To7LwzQKYl1YZhYa1KB46NwAPEuwEX3UzAWhWtitaPUD1IdBAeF8lC70GVdjwo33X2
         ETqoklBGJsasNcswo0Y2BzKKPpZq7MTDsmd+JbCQ0FuBEnNWZxu+LBLm3YpNTNn+WQ
         YxRmTx8AmdpsE1lBsdBPg6hmzA1pVvYnLVnGIvOFGL1eyTUHqbTNhGzmlM5nRXqzOf
         xiWRJH8s2hhf/fxjlbozMYPL+jivjCyGVJ9tM2eMGEaHX/gMuMHxPf/AKFmdveSs6V
         IfUsySyWzyHDw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 3/3] arm64: dts: ipq6018: add pwm node
Date:   Tue, 30 Nov 2021 19:37:30 +0200
Message-Id: <9e233bf613d05f32c36ca19d60854e017cb35e47.1638293850.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
References: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
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

