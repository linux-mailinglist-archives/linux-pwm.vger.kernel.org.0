Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF7BE038
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2019 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407795AbfIYOeS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Sep 2019 10:34:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27474 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730776AbfIYOeS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Sep 2019 10:34:18 -0400
X-UUID: 54d7c87adfc54a77a44725cbf882a3da-20190925
X-UUID: 54d7c87adfc54a77a44725cbf882a3da-20190925
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1746951140; Wed, 25 Sep 2019 22:34:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Sep 2019 22:34:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Sep 2019 22:34:08 +0800
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
Subject: [PATCH v10 04/12] pwm: mediatek: allocate the clks array dynamically
Date:   Wed, 25 Sep 2019 22:32:29 +0800
Message-ID: <1569421957-20765-5-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: AFED4E5A2A903EDD3636F111E0AE1B7B83DAF81B9CFC59CF040D2E1EF93091A62000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of using fixed size of arrays, allocate the memory for them
based on the information we get from the DT.

Also remove the check for num_pwms, due to dynamically allocate pwm
should not cause array index out of bound.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since v10:
- Remove unuse clk_freq description

Changes since v8:
- Fix warning and build-error

Changes since v6:
- Add a Reviewed-by tag

Changes since v5:
- Follow reviewers's comments
Make the changes of allocate the clks array dynamically as a single patch

Changes since v4:
- Follow reviewers's comments
1. use pc->soc->has_clks to check clocks exist or not.
2. Add error message when probe() unable to get clks
- Fixes bug when SoC is old mips which has no complex clock tree.
if clocks not exist, use the new property from DT to apply period caculation;
otherwise, use clk_get_rate to get clock frequency and apply period caculation.

---
 drivers/pwm/pwm-mediatek.c | 84 +++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 07e843aeddb1..dcc85d07156f 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -35,25 +35,6 @@
 
 #define PWM_CLK_DIV_MAX		7
 
-enum {
-	MTK_CLK_MAIN = 0,
-	MTK_CLK_TOP,
-	MTK_CLK_PWM1,
-	MTK_CLK_PWM2,
-	MTK_CLK_PWM3,
-	MTK_CLK_PWM4,
-	MTK_CLK_PWM5,
-	MTK_CLK_PWM6,
-	MTK_CLK_PWM7,
-	MTK_CLK_PWM8,
-	MTK_CLK_MAX,
-};
-
-static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
-	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6", "pwm7",
-	"pwm8"
-};
-
 struct mtk_pwm_platform_data {
 	unsigned int fallback_npwms;
 	bool pwm45_fixup;
@@ -63,12 +44,16 @@ struct mtk_pwm_platform_data {
  * struct mtk_pwm_chip - struct representing PWM chip
  * @chip: linux PWM chip representation
  * @regs: base address of PWM chip
- * @clks: list of clocks
+ * @clk_top: the top clock generator
+ * @clk_main: the clock used by PWM core
+ * @clk_pwms: the clock used by each PWM channel
  */
 struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
-	struct clk *clks[MTK_CLK_MAX];
+	struct clk *clk_top;
+	struct clk *clk_main;
+	struct clk **clk_pwms;
 	const struct mtk_pwm_platform_data *soc;
 };
 
@@ -86,24 +71,24 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	int ret;
 
-	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
+	ret = clk_prepare_enable(pc->clk_top);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(pc->clks[MTK_CLK_MAIN]);
+	ret = clk_prepare_enable(pc->clk_main);
 	if (ret < 0)
 		goto disable_clk_top;
 
-	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	ret = clk_prepare_enable(pc->clk_pwms[pwm->hwpwm]);
 	if (ret < 0)
 		goto disable_clk_main;
 
 	return 0;
 
 disable_clk_main:
-	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
+	clk_disable_unprepare(pc->clk_main);
 disable_clk_top:
-	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+	clk_disable_unprepare(pc->clk_top);
 
 	return ret;
 }
@@ -112,9 +97,9 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 
-	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
-	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
-	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
+	clk_disable_unprepare(pc->clk_main);
+	clk_disable_unprepare(pc->clk_top);
 }
 
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
@@ -134,7 +119,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
-	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
+	struct clk *clk = pc->clk_pwms[pwm->hwpwm];
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
 	u64 resolution;
@@ -222,8 +207,9 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mtk_pwm_chip *pc;
 	struct resource *res;
-	unsigned int i, npwms;
+	unsigned int npwms;
 	int ret;
+	int i;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
@@ -248,21 +234,33 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* MAIN + TOP + NPWM < MTK_CLK_MAX */
-	if ((npwms + 2) > MTK_CLK_MAX) {
-		dev_warn(&pdev->dev, "number of PWMs is larger than %d\n",
-			 MTK_CLK_MAX - 2);
-		npwms = MTK_CLK_MAX - 2;
+	pc->clk_pwms = devm_kcalloc(&pdev->dev, npwms,
+				    sizeof(*pc->clk_pwms), GFP_KERNEL);
+	if (!pc->clk_pwms)
+		return -ENOMEM;
+
+	pc->clk_top = devm_clk_get(&pdev->dev, "top");
+	if (IS_ERR(pc->clk_top)) {
+		dev_err(&pdev->dev, "clock: top fail: %ld\n",
+			PTR_ERR(pc->clk_top));
+		return PTR_ERR(pc->clk_top);
+	}
+
+	pc->clk_main = devm_clk_get(&pdev->dev, "main");
+	if (IS_ERR(pc->clk_main)) {
+		dev_err(&pdev->dev, "clock: main fail: %ld\n",
+			PTR_ERR(pc->clk_main));
+		return PTR_ERR(pc->clk_main);
 	}
+	for (i = 0; i < npwms; i++) {
+		char name[8];
 
-	for (i = 0; i < npwms + 2 ; i++) {
-		pc->clks[i] = devm_clk_get(&pdev->dev,
-					  mtk_pwm_clk_name[i]);
-		if (IS_ERR(pc->clks[i])) {
+		snprintf(name, sizeof(name), "pwm%d", i + 1);
+		pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
+		if (IS_ERR(pc->clk_pwms[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				mtk_pwm_clk_name[i],
-				PTR_ERR(pc->clks[i]));
-			return PTR_ERR(pc->clks[i]);
+				name, PTR_ERR(pc->clk_pwms[i]));
+			return PTR_ERR(pc->clk_pwms[i]);
 		}
 	}
 
-- 
2.17.1

