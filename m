Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1535506C
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbhDFJ7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 05:59:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40573 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239005AbhDFJ7C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 05:59:02 -0400
X-UUID: c3ac562d87c3435888adf25ecc4e7cb7-20210406
X-UUID: c3ac562d87c3435888adf25ecc4e7cb7-20210406
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 273694520; Tue, 06 Apr 2021 17:58:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 17:58:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 17:58:51 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v3,PATCH 2/3] pwm: mtk_disp: convert the driver to atomic API
Date:   Tue, 6 Apr 2021 17:57:41 +0800
Message-ID: <1617703062-4251-3-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Switch the driver to atomic API apply().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 114 +++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 21416a8b6b47..502228adf718 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -20,6 +20,7 @@
 #define PWM_CLKDIV_SHIFT	16
 #define PWM_CLKDIV_MAX		0x3ff
 #define PWM_CLKDIV_MASK		(PWM_CLKDIV_MAX << PWM_CLKDIV_SHIFT)
+#define PWM_POLARITY	BIT(2)
 
 #define PWM_PERIOD_BIT_WIDTH	12
 #define PWM_PERIOD_MASK		((1 << PWM_PERIOD_BIT_WIDTH) - 1)
@@ -47,6 +48,7 @@ struct mtk_disp_pwm {
 	struct clk *clk_main;
 	struct clk *clk_mm;
 	void __iomem *base;
+	bool enabled;
 };
 
 static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
@@ -66,11 +68,11 @@ static void mtk_disp_pwm_update_bits(struct mtk_disp_pwm *mdp, u32 offset,
 	writel(value, address);
 }
 
-static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       int duty_ns, int period_ns)
+static int mtk_disp_pwm_enable(struct pwm_chip *chip,
+			       const struct pwm_state *state)
 {
 	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
-	u32 clk_div, period, high_width, value;
+	u32 clk_div, period, high_width, value, polarity;
 	u64 div, rate;
 	int err;
 
@@ -84,33 +86,47 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * period = (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
 	 * high_width = (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1))
 	 */
+	if (!mdp->enabled) {
+		err = clk_prepare_enable(mdp->clk_main);
+		if (err < 0) {
+			dev_err(chip->dev, "Can't enable mdp->clk_main: %d\n",
+				err);
+			return err;
+		}
+		err = clk_prepare_enable(mdp->clk_mm);
+		if (err < 0) {
+			dev_err(chip->dev, "Can't enable mdp->clk_mm: %d\n",
+				err);
+			clk_disable_unprepare(mdp->clk_main);
+			return err;
+		}
+	}
 	rate = clk_get_rate(mdp->clk_main);
-	clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >>
+	clk_div = div_u64(rate * state->period, NSEC_PER_SEC) >>
 			  PWM_PERIOD_BIT_WIDTH;
-	if (clk_div > PWM_CLKDIV_MAX)
+	if (clk_div > PWM_CLKDIV_MAX) {
+		dev_err(chip->dev, "clock rate is too high: rate = %d Hz\n",
+			rate);
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
 		return -EINVAL;
-
+	}
 	div = NSEC_PER_SEC * (clk_div + 1);
-	period = div64_u64(rate * period_ns, div);
+	period = div64_u64(rate * state->period, div);
 	if (period > 0)
 		period--;
 
-	high_width = div64_u64(rate * duty_ns, div);
+	high_width = div64_u64(rate * state->duty_cycle, div);
 	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
-
-	err = clk_enable(mdp->clk_main);
-	if (err < 0)
-		return err;
-
-	err = clk_enable(mdp->clk_mm);
-	if (err < 0) {
-		clk_disable(mdp->clk_main);
-		return err;
-	}
+	polarity = 0;
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		polarity = PWM_POLARITY;
 
 	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
 				 PWM_CLKDIV_MASK,
 				 clk_div << PWM_CLKDIV_SHIFT);
+	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
+				 PWM_POLARITY, polarity);
 	mtk_disp_pwm_update_bits(mdp, mdp->data->con1,
 				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
 				 value);
@@ -122,50 +138,49 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
 					 mdp->data->commit_mask,
 					 0x0);
+	} else {
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
+					 mdp->data->con0_sel,
+					 mdp->data->con0_sel);
 	}
 
-	clk_disable(mdp->clk_mm);
-	clk_disable(mdp->clk_main);
-
+	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
+				 mdp->data->enable_mask);
+	mdp->enabled = true;
 	return 0;
 }
 
-static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int mtk_disp_pwm_disable(struct pwm_chip *chip,
+				const struct pwm_state *state)
 {
 	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
-	int err;
-
-	err = clk_enable(mdp->clk_main);
-	if (err < 0)
-		return err;
 
-	err = clk_enable(mdp->clk_mm);
-	if (err < 0) {
-		clk_disable(mdp->clk_main);
-		return err;
+	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
+				 0x0);
+	if (mdp->enabled) {
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
 	}
 
-	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
-				 mdp->data->enable_mask);
+	mdp->enabled = false;
 
 	return 0;
 }
 
-static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
 {
-	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
+	if (!state->enabled)
+		return mtk_disp_pwm_disable(chip, state);
 
-	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
-				 0x0);
-
-	clk_disable(mdp->clk_mm);
-	clk_disable(mdp->clk_main);
+	return mtk_disp_pwm_enable(chip, state);
 }
 
 static const struct pwm_ops mtk_disp_pwm_ops = {
-	.config = mtk_disp_pwm_config,
-	.enable = mtk_disp_pwm_enable,
-	.disable = mtk_disp_pwm_disable,
+	.apply = mtk_disp_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
@@ -205,19 +220,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mdp);
 
-	/*
-	 * For MT2701, disable double buffer before writing register
-	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
-	 */
-	if (!mdp->data->has_commit) {
-		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
-					 mdp->data->bls_debug_mask,
-					 mdp->data->bls_debug_mask);
-		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
-					 mdp->data->con0_sel,
-					 mdp->data->con0_sel);
-	}
-
 	return 0;
 }
 
-- 
2.18.0

