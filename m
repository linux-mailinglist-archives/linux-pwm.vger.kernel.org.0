Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0386E8D0F6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfHNKo0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 06:44:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13159 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbfHNKo0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 06:44:26 -0400
X-UUID: cbccea2db1c3422dae7e8f8159513437-20190814
X-UUID: cbccea2db1c3422dae7e8f8159513437-20190814
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1342211489; Wed, 14 Aug 2019 18:44:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 18:44:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 18:44:18 +0800
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
Subject: [PATCH v2 3/10] pwm: mediatek: use pwm_mediatek as common prefix
Date:   Wed, 14 Aug 2019 18:43:33 +0800
Message-ID: <8ea3dd6e62d6e05bfce052b509a2a31d865d51b4.1548313019.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Use pwm_mediatek as common prefix to match the filename.
No functional change intended.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 119 +++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 59 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 47585b6..d696df7 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Mediatek Pulse Width Modulator driver
+ * MediaTek Pulse Width Modulator driver
  *
  * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
  * Copyright (C) 2017 Zhi Mao <zhi.mao@mediatek.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/err.h>
@@ -35,41 +33,43 @@
 
 #define PWM_CLK_DIV_MAX		7
 
-struct mtk_pwm_platform_data {
+struct pwm_mediatek_of_data {
 	unsigned int fallback_npwms;
 	bool pwm45_fixup;
 	bool has_clks;
 };
 
 /**
- * struct mtk_pwm_chip - struct representing PWM chip
+ * struct pwm_mediatek_chip - struct representing PWM chip
  * @chip: linux PWM chip representation
  * @regs: base address of PWM chip
  * @clk_top: the top clock generator
  * @clk_main: the clock used by PWM core
  * @clk_pwms: the clock used by each PWM channel
  */
-struct mtk_pwm_chip {
+struct pwm_mediatek_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
 	struct clk **clk_pwms;
-	const struct mtk_pwm_platform_data *soc;
+	const struct pwm_mediatek_of_data *soc;
 };
 
-static const unsigned int mtk_pwm_reg_offset[] = {
+static const unsigned int pwm_mediatek_reg_offset[] = {
 	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
 };
 
-static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
+static inline struct pwm_mediatek_chip *
+to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mtk_pwm_chip, chip);
+	return container_of(chip, struct pwm_mediatek_chip, chip);
 }
 
-static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
+				   struct pwm_device *pwm)
 {
-	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	int ret;
 
 	if (!pc->soc->has_clks)
@@ -97,9 +97,10 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return ret;
 }
 
-static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void pwm_mediatek_clk_disable(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
 {
-	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 
 	if (!pc->soc->has_clks)
 		return;
@@ -109,30 +110,30 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(pc->clk_top);
 }
 
-static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
-				unsigned int offset)
+static inline u32 pwm_mediatek_readl(struct pwm_mediatek_chip *chip,
+				     unsigned int num, unsigned int offset)
 {
-	return readl(chip->regs + mtk_pwm_reg_offset[num] + offset);
+	return readl(chip->regs + pwm_mediatek_reg_offset[num] + offset);
 }
 
-static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
-				  unsigned int num, unsigned int offset,
-				  u32 value)
+static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
+				       unsigned int num, unsigned int offset,
+				       u32 value)
 {
-	writel(value, chip->regs + mtk_pwm_reg_offset[num] + offset);
+	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);
 }
 
-static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
+static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			       int duty_ns, int period_ns)
 {
-	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	struct clk *clk = pc->soc->has_clks ? pc->clk_pwms[pwm->hwpwm] : NULL;
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
 	u64 resolution;
 	int ret;
 
-	ret = mtk_pwm_clk_enable(chip, pwm);
+	ret = pwm_mediatek_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
@@ -149,7 +150,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		mtk_pwm_clk_disable(chip, pwm);
+		pwm_mediatek_clk_disable(chip, pwm);
 		dev_err(chip->dev, "period %d not supported\n", period_ns);
 		return -EINVAL;
 	}
@@ -164,22 +165,22 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
-	mtk_pwm_clk_disable(chip, pwm);
+	pwm_mediatek_clk_disable(chip, pwm);
 
 	return 0;
 }
 
-static int mtk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 value;
 	int ret;
 
-	ret = mtk_pwm_clk_enable(chip, pwm);
+	ret = pwm_mediatek_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
@@ -190,29 +191,29 @@ static int mtk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
-static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 value;
 
 	value = readl(pc->regs);
 	value &= ~BIT(pwm->hwpwm);
 	writel(value, pc->regs);
 
-	mtk_pwm_clk_disable(chip, pwm);
+	pwm_mediatek_clk_disable(chip, pwm);
 }
 
-static const struct pwm_ops mtk_pwm_ops = {
-	.config = mtk_pwm_config,
-	.enable = mtk_pwm_enable,
-	.disable = mtk_pwm_disable,
+static const struct pwm_ops pwm_mediatek_ops = {
+	.config = pwm_mediatek_config,
+	.enable = pwm_mediatek_enable,
+	.disable = pwm_mediatek_disable,
 	.owner = THIS_MODULE,
 };
 
-static int mtk_pwm_probe(struct platform_device *pdev)
+static int pwm_mediatek_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct mtk_pwm_chip *pc;
+	struct pwm_mediatek_chip *pc;
 	struct resource *res;
 	unsigned int npwms;
 	int ret;
@@ -269,7 +270,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pc);
 
 	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &mtk_pwm_ops;
+	pc->chip.ops = &pwm_mediatek_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = npwms;
 
@@ -282,55 +283,55 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_pwm_remove(struct platform_device *pdev)
+static int pwm_mediatek_remove(struct platform_device *pdev)
 {
-	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_mediatek_chip *pc = platform_get_drvdata(pdev);
 
 	return pwmchip_remove(&pc->chip);
 }
 
-static const struct mtk_pwm_platform_data mt2712_pwm_data = {
+static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.fallback_npwms = 8,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
-static const struct mtk_pwm_platform_data mt7622_pwm_data = {
+static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.fallback_npwms = 6,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
-static const struct mtk_pwm_platform_data mt7623_pwm_data = {
+static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.fallback_npwms = 5,
 	.pwm45_fixup = true,
 	.has_clks = true,
 };
 
-static const struct mtk_pwm_platform_data mt7628_pwm_data = {
+static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.fallback_npwms = 4,
 	.pwm45_fixup = true,
 	.has_clks = false,
 };
 
-static const struct of_device_id mtk_pwm_of_match[] = {
+static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
+MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);
 
-static struct platform_driver mtk_pwm_driver = {
+static struct platform_driver pwm_mediatek_driver = {
 	.driver = {
-		.name = "mtk-pwm",
-		.of_match_table = mtk_pwm_of_match,
+		.name = "pwm-mediatek",
+		.of_match_table = pwm_mediatek_of_match,
 	},
-	.probe = mtk_pwm_probe,
-	.remove = mtk_pwm_remove,
+	.probe = pwm_mediatek_probe,
+	.remove = pwm_mediatek_remove,
 };
-module_platform_driver(mtk_pwm_driver);
+module_platform_driver(pwm_mediatek_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

