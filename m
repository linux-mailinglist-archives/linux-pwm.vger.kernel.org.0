Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0898C23
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2019 09:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfHVHCp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Aug 2019 03:02:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21167 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730048AbfHVHCo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Aug 2019 03:02:44 -0400
X-UUID: 8b5b994b19934c8fb6ec44cf27186598-20190822
X-UUID: 8b5b994b19934c8fb6ec44cf27186598-20190822
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1661304108; Thu, 22 Aug 2019 15:02:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 15:02:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 15:02:35 +0800
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
Subject: [PATCH v5 12/13] pwm: mediatek: remove a property "has-clock"
Date:   Thu, 22 Aug 2019 14:58:42 +0800
Message-ID: <1566457123-20791-13-git-send-email-sam.shih@mediatek.com>
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

Due to we added clock-frequency property to fix
mt7628 pwm during configure from userspace.
We can alos use this property to determine whether
the complex clock tree exists in the SoC or not.
So we can safety remove has-clock property in the
driver specific data.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 290536a92a80..96f592595063 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -35,7 +35,6 @@
 struct pwm_mediatek_of_data {
 	unsigned int fallback_npwms;
 	bool pwm45_fixup;
-	bool has_clks;
 };
 
 /**
@@ -73,7 +72,7 @@ static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	int ret;
 
-	if (!pc->soc->has_clks)
+	if (pc->clk_freq)
 		return 0;
 
 	ret = clk_prepare_enable(pc->clk_top);
@@ -103,7 +102,7 @@ static void pwm_mediatek_clk_disable(struct pwm_chip *chip,
 {
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 
-	if (!pc->soc->has_clks)
+	if (pc->clk_freq)
 		return;
 
 	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
@@ -134,10 +133,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 resolution;
 	int ret;
 
-	if (pc->soc->has_clks)
-		clk_freq = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	else
+	if (pc->clk_freq)
 		clk_freq = pc->clk_freq;
+	else
+		clk_freq = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
 	if (ret < 0)
@@ -222,6 +221,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	struct pwm_mediatek_chip *pc;
 	struct resource *res;
 	unsigned int npwms;
+	unsigned int clk_freq;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -247,7 +247,8 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pc->soc->has_clks) {
+	ret = of_property_read_u32(np, "clock-frequency", &clk_freq);
+	if (ret < 0) {
 		int i;
 
 		pc->clk_pwms = devm_kcalloc(&pdev->dev, npwms,
@@ -280,13 +281,6 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
-		unsigned int clk_freq;
-
-		ret = of_property_read_u32(np, "clock-frequency", &clk_freq);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get clock_frequency\n");
-			return ret;
-		}
 		pc->clk_freq = clk_freq;
 	}
 
@@ -316,25 +310,21 @@ static int pwm_mediatek_remove(struct platform_device *pdev)
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.fallback_npwms = 8,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.fallback_npwms = 6,
 	.pwm45_fixup = false,
-	.has_clks = true,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.fallback_npwms = 5,
 	.pwm45_fixup = true,
-	.has_clks = true,
 };
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.fallback_npwms = 4,
 	.pwm45_fixup = true,
-	.has_clks = false,
 };
 
 static const struct of_device_id pwm_mediatek_of_match[] = {
-- 
2.17.1

