Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A076A9FC7
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCCSzf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjCCSzX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779FA149AC
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYc-0006WH-KJ; Fri, 03 Mar 2023 19:55:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYb-001cVh-5G; Fri, 03 Mar 2023 19:55:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001ul9-02; Fri, 03 Mar 2023 19:55:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 24/30] pwm: stm32: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:39 +0100
Message-Id: <20230303185445.2112695-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jmmiE3N34M+f9bnP1i3ZcXKc0KLwveoqbOciUOB61ao=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJWrCRVmtpts6fB4h58ukV4CnbNxk4KoXKBG rQtZQ0yup6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCVgAKCRDB/BR4rcrs CT+3B/0Z1tun5MtmoFj/1O0B0FihqbDTmjOyymVfU+DfA66JSWdMnqkG9ej3+lx6fM3Emy3T8ok HNfDto+b9idqnAEZzTDx031mKjn2ZahnLeBGuLVoQCa/ki5iEGHGaCRtTzDCnx25i3/grHTyzN0 IHZ2k8gdKsrKbKv6HW0xNcf6gt+zUngvNG4h6mxvOQ38V6asA9RR3hCdndZJ1fOI2p91III+A/R MzoA6+PdkyvCjHBmb9/eq1AsqLaWcFBI1/DYZH1sNRoSHdUYFVTXrpstPwMq2bVnyiL54/BDJr4 TFn9Nqlrm0+BW/K/EIUV32L608DB2qtJoFbjduJcbb/mT5T4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 21e4a34dfff3..a482f7e0e4ab 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -642,7 +642,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int stm32_pwm_remove(struct platform_device *pdev)
+static void stm32_pwm_remove(struct platform_device *pdev)
 {
 	struct stm32_pwm *priv = platform_get_drvdata(pdev);
 	unsigned int i;
@@ -651,8 +651,6 @@ static int stm32_pwm_remove(struct platform_device *pdev)
 		pwm_disable(&priv->chip.pwms[i]);
 
 	pwmchip_remove(&priv->chip);
-
-	return 0;
 }
 
 static int __maybe_unused stm32_pwm_suspend(struct device *dev)
@@ -699,7 +697,7 @@ MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);
 
 static struct platform_driver stm32_pwm_driver = {
 	.probe	= stm32_pwm_probe,
-	.remove	= stm32_pwm_remove,
+	.remove_new = stm32_pwm_remove,
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
-- 
2.39.1

