Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EE7C8C84
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJMRmg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjJMRmf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B188BB
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMBA-0004W0-7I; Fri, 13 Oct 2023 19:42:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-001Rgm-QX; Fri, 13 Oct 2023 19:42:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-00Fim0-Gy; Fri, 13 Oct 2023 19:42:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/11] pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:12 +0200
Message-ID: <20231013174204.1457085-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M1OPhPtPgoAx37eXWZT9LtnHNhORjb33xVhLBmafCEM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYF1qmutfQlK4DDVgCGR1CEW2d6QuFS6bUQUv g7TD5F6esaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBdQAKCRCPgPtYfRL+ Tgq/CAC76lraDjdItS0wz/z1GDQwa1HWy9hQUAGq5G50Qn4U9b3Tox8IW9B/pyZhyaZBq7XvyeZ SInXc3WV5kOsPKO79H8RSf7H8mjHSxHFMqdEZsqE7UFJ6Yrwz/v+kI+/N5973rqgv69LYCvVQCp AmNNZXEFKeY1j7rcMYDn2mYRPpfsM7/P15lfz8rZmLwQRO74nzFU0cjUuIpzxmCh+eX6YZY+IEo m3ro6fpAnzpkF+DrRKSaPwnTyW/s5lNQGuyLlb6D+wJbc0kcCLHH6DGDqe/8B4uKL464xRSwiua 8XoFalI6XjAZ2KsqI4QSUTkAQbJm1CWmG6R6d85xn07+qVOF
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

