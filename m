Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90D2A0F3F
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 21:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgJ3UNR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 16:13:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38714 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgJ3UNA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 16:13:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09UKCtsd105958;
        Fri, 30 Oct 2020 15:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604088775;
        bh=nWVRfmVC8p1aTgFeGwMeYBz7Vd7oRys8RCcXEhmnEG0=;
        h=From:To:CC:Subject:Date;
        b=ixHhZI2S2JENnML2Lsv40o0varPLvIaqC2mr+QJHx1UHVepdGsyS30n86sC8tE/3S
         2E8v7t27RN6FK4pKxgX0D8juf5hwq5E8TK/GsaZrHOLv0dCToOsQgjwtgpaUyRWoV0
         P53Vw69Y9kZVLGjKIw6YTHYWWzQSAuq0S07edaYQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09UKCtWx043603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 15:12:55 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 30
 Oct 2020 15:12:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 30 Oct 2020 15:12:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09UKCsNG018741;
        Fri, 30 Oct 2020 15:12:54 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-pwm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] pwm: tiehrpwm: handle deferred probe with dev_err_probe()
Date:   Fri, 30 Oct 2020 22:12:54 +0200
Message-ID: <20201030201254.24557-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The devm_clk_get() may return -EPROBE_DEFER which is not handled properly
by TI EHRPWM driver and causes unnecessary boot log messages.

Hence, add proper deferred probe handling with new dev_err_probe() API.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0846917ff2d2..14c8fdcfd607 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -437,10 +437,8 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "failed to get clock\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "Failed to get fck\n");
 
 	pc->clk_rate = clk_get_rate(clk);
 	if (!pc->clk_rate) {
@@ -462,10 +460,8 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	/* Acquire tbclk for Time Base EHRPWM submodule */
 	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
-	if (IS_ERR(pc->tbclk)) {
-		dev_err(&pdev->dev, "Failed to get tbclk\n");
-		return PTR_ERR(pc->tbclk);
-	}
+	if (IS_ERR(pc->tbclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->tbclk), "Failed to get tbclk\n");
 
 	ret = clk_prepare(pc->tbclk);
 	if (ret < 0) {
-- 
2.17.1

