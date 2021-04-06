Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5735506A
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhDFJ7B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 05:59:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46122 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235467AbhDFJ7B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 05:59:01 -0400
X-UUID: d7872b6fb6554129a22c0cc13b11a373-20210406
X-UUID: d7872b6fb6554129a22c0cc13b11a373-20210406
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1840545353; Tue, 06 Apr 2021 17:58:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 17:58:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 17:58:49 +0800
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
Subject: [v3,PATCH 1/3] pwm: mtk_disp: clear the clock operations
Date:   Tue, 6 Apr 2021 17:57:40 +0800
Message-ID: <1617703062-4251-2-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove the clk_prepare from mtk_disp_pwm_probe.
Remove the clk_unprepare from mtk_disp_pwm_remove.

After using atomic API and get_state() function which are implemented in PATCH [2/3], [3/3],
clk_prepare/clk_unprepare are useless in probe/remove function.
So we remove clk_prepare/clk_unprepare in probe/remove fuinction.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 87c6b4bc5d43..21416a8b6b47 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -192,14 +192,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mdp->clk_mm))
 		return PTR_ERR(mdp->clk_mm);
 
-	ret = clk_prepare(mdp->clk_main);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare(mdp->clk_mm);
-	if (ret < 0)
-		goto disable_clk_main;
-
 	mdp->chip.dev = &pdev->dev;
 	mdp->chip.ops = &mtk_disp_pwm_ops;
 	mdp->chip.base = -1;
@@ -208,7 +200,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&mdp->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto disable_clk_mm;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, mdp);
@@ -227,24 +219,13 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-disable_clk_mm:
-	clk_unprepare(mdp->clk_mm);
-disable_clk_main:
-	clk_unprepare(mdp->clk_main);
-	return ret;
 }
 
 static int mtk_disp_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pwmchip_remove(&mdp->chip);
-	clk_unprepare(mdp->clk_mm);
-	clk_unprepare(mdp->clk_main);
 
-	return ret;
+	return pwmchip_remove(&mdp->chip);
 }
 
 static const struct mtk_pwm_data mt2701_pwm_data = {
-- 
2.18.0

