Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35F6A9FB9
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjCCSz2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCCSzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6D1EBF4
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006Ny-Gs; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001cUq-Pl; Fri, 03 Mar 2023 19:55:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-001ukH-Bv; Fri, 03 Mar 2023 19:54:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 11/30] pwm: img: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:26 +0100
Message-Id: <20230303185445.2112695-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FMtcxFe304W5YzTIaOTjMd4FJwqApmPKC9sBedLTaFo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkIG501sz78j/RpkAkZ3YdmWUtbkLw8xNMNC4 XlV0Uyx1x2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCBgAKCRDB/BR4rcrs CekpCACLsQTOuKpGIPYzI5dmA3kNHuo49O/ImIPAXDufLjgIrRo/45idJTXsD3SwN+R2C5lt2s3 3j0XVktlVRamDSBlVJzH23QcRjlh/MnOFJGh/kU5IjF9Vyrzd191Kklw8DjnqprXqCdyxQeuh88 zpK8JFRbaGCbiMqLkhWLoctW5raBPb07tISe5tTv75w8DpzH0bOEnN87yoJhI2sV9ZN0ac7o4DW 9ptWw0xjw8Sx82ooF/cGmfz8qKOw820p0tFSLjqFCJ9Nke6jFhLFdNh8lfG4OO8rLp62keGpamo 87OSS5lx91INfq1N3xrztyz40vEQrjdiLNIjLGG6cbwTstTf
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
 drivers/pwm/pwm-img.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 89362afe3c91..326af85888e7 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -343,7 +343,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int img_pwm_remove(struct platform_device *pdev)
+static void img_pwm_remove(struct platform_device *pdev)
 {
 	struct img_pwm_chip *imgchip = platform_get_drvdata(pdev);
 
@@ -352,8 +352,6 @@ static int img_pwm_remove(struct platform_device *pdev)
 		img_pwm_runtime_suspend(&pdev->dev);
 
 	pwmchip_remove(&imgchip->chip);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -423,7 +421,7 @@ static struct platform_driver img_pwm_driver = {
 		.of_match_table = img_pwm_of_match,
 	},
 	.probe = img_pwm_probe,
-	.remove = img_pwm_remove,
+	.remove_new = img_pwm_remove,
 };
 module_platform_driver(img_pwm_driver);
 
-- 
2.39.1

