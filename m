Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B509EA1105
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Aug 2019 07:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfH2Fkd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Aug 2019 01:40:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59871 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbfH2Fkd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Aug 2019 01:40:33 -0400
X-UUID: bae4c73712cc4b8a8875781821352950-20190829
X-UUID: bae4c73712cc4b8a8875781821352950-20190829
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1630195273; Thu, 29 Aug 2019 13:40:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 13:40:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 13:40:31 +0800
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
Subject: [PATCH v6 01/11] pwm: mediatek: add a property "num-pwms"
Date:   Thu, 29 Aug 2019 13:39:10 +0800
Message-ID: <1567057160-552-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567057160-552-1-git-send-email-sam.shih@mediatek.com>
References: <1567057160-552-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This adds a property "num-pwms" to avoid having an endless
list of compatibles with no differences for the same driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since v6:
Add a Reviewed-by tag

Changes since v5:
Check num-pwms value is no more than MTK_CLK_MAX - 2 (MAIN + TOP)

Changes since v4:
Follow reviewer's comments:
Move the changes of droping the check for of_device_get_match_data returning non-NULL to next patch


---
 drivers/pwm/pwm-mediatek.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674ce995f..e214f4f57107 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -55,7 +55,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 };
 
 struct mtk_pwm_platform_data {
-	unsigned int num_pwms;
+	unsigned int fallback_npwms;
 	bool pwm45_fixup;
 	bool has_clks;
 };
@@ -227,9 +227,10 @@ static const struct pwm_ops mtk_pwm_ops = {
 static int mtk_pwm_probe(struct platform_device *pdev)
 {
 	const struct mtk_pwm_platform_data *data;
+	struct device_node *np = pdev->dev.of_node;
 	struct mtk_pwm_chip *pc;
 	struct resource *res;
-	unsigned int i;
+	unsigned int i, npwms;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -246,7 +247,26 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
+	ret = of_property_read_u32(np, "num-pwms", &npwms);
+	if (ret < 0) {
+		/* It's deprecated, we should specify num_pwms via DT now. */
+		if (pc->soc->fallback_npwms) {
+			npwms = pc->soc->fallback_npwms;
+			dev_warn(&pdev->dev, "DT is outdated, please update it\n");
+		} else {
+			dev_err(&pdev->dev, "failed to get number of PWMs\n");
+			return ret;
+		}
+	}
+
+	/* MAIN + TOP + NPWM < MTK_CLK_MAX */
+	if ((npwms + 2) > MTK_CLK_MAX) {
+		dev_warn(&pdev->dev, "number of PWMs is larger than %d\n",
+			 MTK_CLK_MAX - 2);
+		npwms = MTK_CLK_MAX - 2;
+	}
+
+	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
@@ -260,7 +280,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = data->num_pwms;
+	pc->chip.npwm = npwms;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
@@ -279,25 +299,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
-	.num_pwms = 8,
+	.fallback_npwms = 8,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
-	.num_pwms = 6,
+	.fallback_npwms = 6,
 	.pwm45_fixup = false,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
-	.num_pwms = 5,
+	.fallback_npwms = 5,
 	.pwm45_fixup = true,
 	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7628_pwm_data = {
-	.num_pwms = 4,
+	.fallback_npwms = 4,
 	.pwm45_fixup = true,
 	.has_clks = false,
 };
-- 
2.17.1

