Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31766A9FAD
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCCSzU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCCSzQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8ED1EFFE
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-0006Ga-2T; Fri, 03 Mar 2023 19:55:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-001cU6-3l; Fri, 03 Mar 2023 19:55:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001uk9-TM; Fri, 03 Mar 2023 19:54:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>
Cc:     kernel@pengutronix.de, Guenter Roeck <groeck@chromium.org>,
        linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: [PATCH 09/30] pwm: cros-ec: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:24 +0100
Message-Id: <20230303185445.2112695-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Lfg1K7r0S85QCgR0GcUGLORJ4TBzsm46zCEWzJD8ikg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkH/i10PAL7z6HOQawqHxTWdGni51iMf0poLu pwiLYMHvsaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB/wAKCRDB/BR4rcrs CV7yB/0QHfr9d4v28ysfNOtztChpnwv0TQ9erNSRLwqUuF2BGHOTVkgWAvNx68WKRV8zjQqe3Q4 93hPDq9OVYXaI953ojztueMfKc/RNHGySlooVk3CIFIL08TqXii4jUSTOSInbUnxgYDoCCHw41h /sWfn42kr4gi+BHBs5Z67Z9/RBINTwYcdNKnUwvfND26oCtxs4I74nSQVeqZ+Jwy6lU+nAVyHJQ 3/jgyODdIPTy3L7PHH3yLDVRlaOWnWPVHequfNz515FUnN4J2/eT7E1Ndq06omkEIB5D1XTTQwu OgbCW7XtbgTZ3VfJe/5ZxueRBbqD1+vc6I7mvk/PIWi74tnD
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
 drivers/pwm/pwm-cros-ec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 86df6702cb83..90afce212fb0 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -328,14 +328,12 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cros_ec_pwm_remove(struct platform_device *dev)
+static void cros_ec_pwm_remove(struct platform_device *dev)
 {
 	struct cros_ec_pwm_device *ec_pwm = platform_get_drvdata(dev);
 	struct pwm_chip *chip = &ec_pwm->chip;
 
 	pwmchip_remove(chip);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -349,7 +347,7 @@ MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
 
 static struct platform_driver cros_ec_pwm_driver = {
 	.probe = cros_ec_pwm_probe,
-	.remove = cros_ec_pwm_remove,
+	.remove_new = cros_ec_pwm_remove,
 	.driver = {
 		.name = "cros-ec-pwm",
 		.of_match_table = of_match_ptr(cros_ec_pwm_of_match),
-- 
2.39.1

