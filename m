Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF47C8C81
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJMRmf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJMRmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D9CC
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMBA-0004VJ-AT; Fri, 13 Oct 2023 19:42:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-001Rgc-34; Fri, 13 Oct 2023 19:42:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB7-00Filj-Pq; Fri, 13 Oct 2023 19:42:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH v2 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:09 +0200
Message-ID: <20231013174204.1457085-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Cadu5NXFCOncNFFoTUYivaQKtHdgPAm3Eh2ECt9vZgo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYFxo+Nfx2xZvh7UOFo6S6BEfGaHfuMnC7VXc r85LzQgu3OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBcQAKCRCPgPtYfRL+ Tqu+CAC2cHhLOqojFiCU+BvQXQ2o9jDZB+rM/W8Sg/LgIOsE+jXV/fJhMfEs9RogDGvf8AKfRG4 fsOzVc5FY+WZBSlPIbEAhs/i5VKq7PuMlhiUpzSFH8fzaYIZ4qH6OFZLD5HKsDmvJgw2YzKDnFy g288srZlLSRK1T1HoVQcxvwFVjW8i5+J44yAjiy7ZHFxxAJ2xuUvrIvYZaHv4ZBP+uuVaTC8DRj oCxtnTvQAJo4o0K5NAfaxsFfIpxU1zFOxQ5OfUXpEP9k4pYoBsJgZ+h6Naz37i1S9KN4Ei4zZL/ NSH9rl1fZMLgA4X3P7SWUjToGX3BB/ir2DxP2ShLomS8wY3S
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index b723c2d4f485..0fdeb0b2dbf3 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -259,7 +259,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
@@ -275,17 +274,16 @@ static int brcmstb_pwm_resume(struct device *dev)
 
 	return clk_prepare_enable(p->clk);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
-			 brcmstb_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
+				brcmstb_pwm_resume);
 
 static struct platform_driver brcmstb_pwm_driver = {
 	.probe = brcmstb_pwm_probe,
 	.driver = {
 		.name = "pwm-brcmstb",
 		.of_match_table = brcmstb_pwm_of_match,
-		.pm = &brcmstb_pwm_pm_ops,
+		.pm = pm_ptr(&brcmstb_pwm_pm_ops),
 	},
 };
 module_platform_driver(brcmstb_pwm_driver);
-- 
2.42.0

