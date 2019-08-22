Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C818198BF3
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2019 09:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfHVHAp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Aug 2019 03:00:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24426 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728605AbfHVHAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Aug 2019 03:00:45 -0400
X-UUID: 17eb2086c4e3493798a5996dce96b8e8-20190822
X-UUID: 17eb2086c4e3493798a5996dce96b8e8-20190822
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1696701101; Thu, 22 Aug 2019 15:00:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 15:00:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 15:00:34 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v5 03/13] pwm: mediatek: add a property "clock-frequency"
Date:   Thu, 22 Aug 2019 14:58:33 +0800
Message-ID: <1566457123-20791-4-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This fix mt7628 pwm during configure from userspace. The SoC
is legacy MIPS and has no complex clock tree. This patch add property
clock-frequency to the SoC specific data and legacy MIPS SoC need to
configure it in DT. This property is use for period calculation.

We will improve this fix by droping has-clks attribute and using
clock-frequency to do the same thing in a new patch.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
Changes since v5:
1. Follow reviewer's comments
Make the changes of fix mt7628 pwm as a single patch

Changes since v4:
- Follow reviewers's comments
1. use pc->soc->has_clks to check clocks exist or not.
2. Add error message when probe() unable to get clks
- Fixes bug when SoC is old mips which has no complex clock tree.
if clocks not exist, use the new property from DT to apply period caculation;
otherwise, use clk_get_rate to get clock frequency and apply period caculation.

Change-Id: Ibbe6d7a4f80b30f60725bcbeca1d02ce7834d28c
---
 drivers/pwm/pwm-mediatek.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ebd62629e3fe..1f18bff4800c 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -65,11 +65,13 @@ struct mtk_pwm_platform_data {
  * @chip: linux PWM chip representation
  * @regs: base address of PWM chip
  * @clks: list of clocks
+ * @clk_freq: the fix clock frequency of legacy MIPS SoC
  */
 struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	unsigned int clk_freq;
 	const struct mtk_pwm_platform_data *soc;
 };
 
@@ -141,19 +143,27 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
-	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
+	unsigned int clk_freq;
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
 	u64 resolution;
 	int ret;
 
+	if (pc->soc->has_clks) {
+		struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
+
+		clk_freq = clk_get_rate(clk);
+	} else {
+		clk_freq = pc->clk_freq;
+	}
+
 	ret = mtk_pwm_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(clk));
+	do_div(resolution, clk_freq);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
@@ -262,13 +272,26 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 		npwms = MTK_CLK_MAX - 2;
 	}
 
-	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
-		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
-		if (IS_ERR(pc->clks[i])) {
-			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
-			return PTR_ERR(pc->clks[i]);
+	if (pc->soc->has_clks) {
+		for (i = 0; i < npwms + 2 ; i++) {
+			pc->clks[i] = devm_clk_get(&pdev->dev,
+						  mtk_pwm_clk_name[i]);
+			if (IS_ERR(pc->clks[i])) {
+				dev_err(&pdev->dev, "clock: %s fail: %ld\n",
+					mtk_pwm_clk_name[i],
+					PTR_ERR(pc->clks[i]));
+				return PTR_ERR(pc->clks[i]);
+			}
+		}
+	} else {
+		unsigned int clk_freq;
+
+		ret = of_property_read_u32(np, "clock-frequency", &clk_freq);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get clock_frequency\n");
+			return ret;
 		}
+		pc->clk_freq = clk_freq;
 	}
 
 	platform_set_drvdata(pdev, pc);
-- 
2.17.1

