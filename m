Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A774B603F
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 11:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfIRJa1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 05:30:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61054 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729307AbfIRJa1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Sep 2019 05:30:27 -0400
X-UUID: 64a1ee396e9a4f8489f6978099c2bcc4-20190918
X-UUID: 64a1ee396e9a4f8489f6978099c2bcc4-20190918
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 14601261; Wed, 18 Sep 2019 17:30:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Sep 2019 17:30:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Sep 2019 17:30:17 +0800
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
Subject: [PATCH v8 03/11] pwm: mediatek: remove a property "has-clks"
Date:   Wed, 18 Sep 2019 17:28:51 +0800
Message-ID: <1568798939-16038-4-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568798939-16038-1-git-send-email-sam.shih@mediatek.com>
References: <1568798939-16038-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

We can use fixed-clock to repair mt7628 pwm during configure from
userspace. The SoC is legacy MIPS and has no complex clock tree.
Due to we can get clock frequency for period calculation from DT
fixed-clock, so we can remove has-clock property, and directly
use devm_clk_get and clk_get_rate.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>

---
Changes since v6:
Based on fixed-clock in DT, we can remove has-clks property

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
---
 drivers/pwm/pwm-mediatek.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ebd62629e3fe..07e843aeddb1 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -57,7 +57,6 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 struct mtk_pwm_platform_data {
 	unsigned int fallback_npwms;
 	bool pwm45_fixup;
-	bool has_clks;
 };
 
 /**
@@ -87,9 +86,6 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	int ret;
 
-	if (!pc->soc->has_clks)
-		return 0;
-
 	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
 	if (ret < 0)
 		return ret;
@@ -116,9 +112,6 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 
-	if (!pc->soc->has_clks)
-		return;
-
 	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
 	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
 	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
@@ -262,11 +255,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 		npwms = MTK_CLK_MAX - 2;
 	}
 
-	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
-		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
+	for (i = 0; i < npwms + 2 ; i++) {
+		pc->clks[i] = devm_clk_get(&pdev->dev,
+					  mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
+				mtk_pwm_clk_name[i],
+				PTR_ERR(pc->clks[i]));
 			return PTR_ERR(pc->clks[i]);
 		}
 	}
@@ -297,25 +292,21 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.fallback_npwms = 8,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.fallback_npwms = 6,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.fallback_npwms = 5,
 	.pwm45_fixup = true,
-	.has_clks = true,
 };
 
 static const struct mtk_pwm_platform_data mt7628_pwm_data = {
 	.fallback_npwms = 4,
 	.pwm45_fixup = true,
-	.has_clks = false,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
-- 
2.17.1

