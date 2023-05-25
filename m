Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836DB7118D9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 May 2023 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjEYVNS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 May 2023 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEYVNR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 May 2023 17:13:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138E9E
        for <linux-pwm@vger.kernel.org>; Thu, 25 May 2023 14:13:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2IGp-0001YE-8d; Thu, 25 May 2023 23:13:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2IGo-002oIw-B4; Thu, 25 May 2023 23:13:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2IGn-007xix-Jc; Thu, 25 May 2023 23:13:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: pca9685: Switch i2c driver back to use .probe()
Date:   Thu, 25 May 2023 23:13:05 +0200
Message-Id: <20230525211305.736102-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=k2HjSWlgTVHSx7QPGNNw5p60tMGsBnOkdyUZoRWnNFE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkb89aodIZUoxqSIuqiD6LOhosx+poSWhtCnLMY 6LR8IW+LtyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG/PWgAKCRCPgPtYfRL+ Tk7LB/4umNB4ufwLbePnS8vv0xQn/k/sV8TxnV5dBI1jedfOoqeDdHFliQqIQgW3RFufrnbeEbJ VuPgkLWaqKNkPhSAegCJAXJwI4fbT4Ii8mGfILlmpp6jyIz20oklOcNZ9tFFeExkhUA+pAFfXiK Dm4arBoAEshioJPEbsMhV+714OZignBOdGOkPIvBHtN1o99mJYTkYzO2d9wNu/ENjNgAv3JAx/N Ngr77aDYY9iok2YfyRrG6JLnkAQRG9b6aaTnr2fZdRrzTYsR99zoZ/SsyMnh2Pzi7z7rcd5+5yk Pqv3n0KorE+yKqCxOkdQGC+85f58uho1X9WkJ4MU6wOPPJl7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 3ed5a48ca581..3038a68412a7 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -665,7 +665,7 @@ static struct i2c_driver pca9685_i2c_driver = {
 		.of_match_table = of_match_ptr(pca9685_dt_ids),
 		.pm = &pca9685_pwm_pm,
 	},
-	.probe_new = pca9685_pwm_probe,
+	.probe = pca9685_pwm_probe,
 	.remove = pca9685_pwm_remove,
 	.id_table = pca9685_id,
 };

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

