Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46F7D3E3E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJWRq6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJWRqz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581EC5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-0001Md-II; Mon, 23 Oct 2023 19:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-003lPo-1y; Mon, 23 Oct 2023 19:46:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0o-004VDG-Oo; Mon, 23 Oct 2023 19:46:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 07/11] pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:24 +0200
Message-ID: <20231023174616.2282067-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NXKwetwbNKCTUU7iLllj9JWy9eeeqz9I3IefFdtqnNI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrFwxUau3jiMz5B6DogpvMagSbvZP3YYUK5h/ 2O4slwOl2yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxcAAKCRCPgPtYfRL+ TvX9CACKKZrXzW7g5nuSkrqzy7somn1xIdsk7f2qtsPNZBUNU+S6cdXqiXnxEsM0TxWkq5mijYE jNhCCmiDbAnvMz6nc9Ywjn9hNQk64D2g/7EAqu88YW5fzaB9NlScdKxiooWixGvvqvqDYe/T627 H7848D1WwLSWbf/BtChsRInsePTRFkBFHh+bIVYEDc6HfqzIjIdHXhtu2CA2D5rHAKJZm1eDi+8 AEx8iiiyFgt5HosyrEOxJ1rkxvLavms0cKpH5ZGmDQ289GqqH2PNUvUQ8J90zhEZbrFW3EWKoPt 4lNUCktai4KBZsLaIpdDHrv77D+BJ8vBYozELu/E0Ty5Njod
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 568491ed6829..e6a8fa77aac7 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -620,7 +620,6 @@ static void pwm_samsung_remove(struct platform_device *pdev)
 	clk_disable_unprepare(our_chip->base_clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int pwm_samsung_resume(struct device *dev)
 {
 	struct samsung_pwm_chip *our_chip = dev_get_drvdata(dev);
@@ -653,14 +652,13 @@ static int pwm_samsung_resume(struct device *dev)
 
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
2.42.0

