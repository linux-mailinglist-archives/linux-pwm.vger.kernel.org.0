Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5187D3E39
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjJWRq4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJWRqw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC65D7C
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-0001MD-II; Mon, 23 Oct 2023 19:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0n-003lPV-LP; Mon, 23 Oct 2023 19:46:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0n-004VCs-C8; Mon, 23 Oct 2023 19:46:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/11] pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:18 +0200
Message-ID: <20231023174616.2282067-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eW6nN6+bV7+WD6kPRjOmYaz5+mCZjTj5+Na0i6hMbwA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrFpzNhsr8PrLZqwAJXXyPOM0ReQOYSnT7ooJ IOsiCCIluaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxaQAKCRCPgPtYfRL+ TicdB/0VWd4p/FsB727VnlJnFF+kHC0UoF9wzBxKoUSEEyD+H/Et5zm6LstLvQl16a8tmhQUdlw gLgas5+DAAjleGnRjxXzpfMH08BOBsCXMYaGefkJzrMyzqeE8a81xAWAF7VIMBRC2zFsrIcznJh hX1pYnXWDdEvi1psSwgrnA/Cq0yOPmgBlIm3RQecX/6jL82aiLqAUFNDDwV7Em0M3E8zRiLQ0YA CJl4fFZt4n8PjRD7eJpuhz/hPGxvI7Nj4HPULaHxhKgp4mbx8cx7pB9cJsIR3tbzlHgE6wmcGUg X/btEIy1acAbYkxagli//Y7CMMsLSwEmGjSdgJVqoKt9quer
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
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 07920e034757..3f2c5031a3ba 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -180,7 +180,6 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 	.div1_clk_erratum = true,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
@@ -210,10 +209,9 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
 	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
 				     &state);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
-			 atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
+				atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
 
 static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 	{
@@ -297,7 +295,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
 	.driver = {
 		.name = "atmel-hlcdc-pwm",
 		.of_match_table = atmel_hlcdc_pwm_dt_ids,
-		.pm = &atmel_hlcdc_pwm_pm_ops,
+		.pm = pm_ptr(&atmel_hlcdc_pwm_pm_ops),
 	},
 	.probe = atmel_hlcdc_pwm_probe,
 	.remove_new = atmel_hlcdc_pwm_remove,
-- 
2.42.0

