Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792788FC2E
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfHPHWu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 03:22:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4667 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727000AbfHPHWt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 03:22:49 -0400
X-UUID: 6b9b651a7a1d450f8164c1c3573eb264-20190816
X-UUID: 6b9b651a7a1d450f8164c1c3573eb264-20190816
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 359156654; Fri, 16 Aug 2019 15:22:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 16 Aug 2019 15:22:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 16 Aug 2019 15:22:45 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        sam shih <sam.shih@mediatek.com>
Subject: [PATCH v3 8/10] pwm: mediatek: add new property and fix mt7628 pwm
Date:   Fri, 16 Aug 2019 15:21:26 +0800
Message-ID: <1565940088-845-9-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

This fix mt7628 pwm during configure from userspace. The SoC
is legacy MIPS and has no complex clock tree. This patch add property
clock-frequency to the SoC specific data and legacy MIPS SoC need to
configure it in DT. This property is use for period calculation.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index d696df7a58fa..922a7543a2b1 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -53,6 +53,7 @@ struct pwm_mediatek_chip {
 	struct clk *clk_top;
 	struct clk *clk_main;
 	struct clk **clk_pwms;
+	unsigned int clk_freq;
 	const struct pwm_mediatek_of_data *soc;
 };
 
@@ -139,7 +140,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(clk));
+	if (pc->soc->has_clks)
+		do_div(resolution, clk_get_rate(clk));
+	else
+		do_div(resolution, pc->clk_freq);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
@@ -216,6 +220,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	struct pwm_mediatek_chip *pc;
 	struct resource *res;
 	unsigned int npwms;
+	unsigned int clk_freq;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -265,6 +270,14 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 			if (IS_ERR(pc->clk_pwms[i]))
 				return PTR_ERR(pc->clk_pwms[i]);
 		}
+	} else {
+		ret = of_property_read_u32(np, "clock-frequency",
+						&clk_freq);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get clk_freq\n");
+			return ret;
+		}
+		pc->clk_freq = clk_freq;
 	}
 
 	platform_set_drvdata(pdev, pc);
-- 
2.17.1

