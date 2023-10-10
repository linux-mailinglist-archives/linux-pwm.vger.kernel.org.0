Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D537BF4CD
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442584AbjJJHvd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442603AbjJJHv3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD599F
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WS-000879-DV; Tue, 10 Oct 2023 09:51:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-000bj5-Nu; Tue, 10 Oct 2023 09:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00Cvmw-EV; Tue, 10 Oct 2023 09:51:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 07/11] pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:08 +0200
Message-Id: <20231010075112.755178-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tdDsVaIQTBAFmDdZwZMSBACIYYvrBNNMW6Ee1DHfp08=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlRVppSXmwwz+3dzfLohPFdivnHpxXfiFspG87/w6ar1X vd/eCC3k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJREaz//eXvDM3o9O6Y47l tOd2ZyLyo6oPROfGha4zXXzoA2tPCtvy7RenL/N1V3PVe9+qt0Ah1OpZ1bSdU5t67m07v+ouh6X w+j+nzgiqnGrgditTKtuaX6YbIl2Yf/ThQsWj8t9DYwQZgrRuJNhvS/ZYXPrzc7ir/B5hzYsrMp h3nN4Z1B2i7JglvfRBv5NZyIsvUlZv+6skT3Q3J1clxc4PMemJmWZb38x09YVhmrPjMr0CCbP2J +GVvWKKfG9/SUlxsHrHfzo28y3bbLst1ZOkhfReWyoxdhenqcdOTTHNvuhbkZRpm5jEqCFcM7Mu /8yCGWeKFzO2ZTU9e71IdUGU7eJ91zNzfCXmRZ5UuQ0A
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index e8828f57ab15..041e2f9476ff 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -630,7 +630,6 @@ static void pwm_samsung_remove(struct platform_device *pdev)
 	clk_disable_unprepare(chip->base_clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int pwm_samsung_resume(struct device *dev)
 {
 	struct samsung_pwm_chip *our_chip = dev_get_drvdata(dev);
@@ -663,14 +662,13 @@ static int pwm_samsung_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(pwm_samsung_pm_ops, NULL, pwm_samsung_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pwm_samsung_pm_ops, NULL, pwm_samsung_resume);
 
 static struct platform_driver pwm_samsung_driver = {
 	.driver		= {
 		.name	= "samsung-pwm",
-		.pm	= &pwm_samsung_pm_ops,
+		.pm	= pm_ptr(&pwm_samsung_pm_ops),
 		.of_match_table = of_match_ptr(samsung_pwm_matches),
 	},
 	.probe		= pwm_samsung_probe,
-- 
2.40.1

