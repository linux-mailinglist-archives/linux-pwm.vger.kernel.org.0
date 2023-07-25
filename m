Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD7760CA8
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jul 2023 10:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGYIKL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jul 2023 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGYIKK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jul 2023 04:10:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143A5A4
        for <linux-pwm@vger.kernel.org>; Tue, 25 Jul 2023 01:10:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOD7P-0003Iy-Gl; Tue, 25 Jul 2023 10:10:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOD7O-001xEL-Id; Tue, 25 Jul 2023 10:10:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOD7N-007caW-OJ; Tue, 25 Jul 2023 10:10:05 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kenrel@pengutronix.de
Subject: [PATCH] pwm: Fix order of freeing resources in pwmchip_remove()
Date:   Tue, 25 Jul 2023 10:10:04 +0200
Message-Id: <20230725081004.395798-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XZF4CB9uydFthMqqjD/sch8sJbmIEREzyCkFcl1Q8LI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkv4Nbcc+oVE9NkIJv+jVlXQu1Jngiku59g3scy NfgIu9tUtiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZL+DWwAKCRCPgPtYfRL+ Tmk/CACNLG32kYcbyPjdz5m6MKhZ13W/k+JjofFlY+On22IT08LRvl0tyS7IwY6OP/h2Cyle7uG 6baBnSDeKY70GFwmMvGOrtgaDOa7nkQRr3HqqwDcps7xhRan7/EsC3aHzTEy1OGYvaLRvkUsk1r eEuqOet9xJC8J0BQtT/xA2ekCHf1s4mlAazHhXgp++YC0sOb9UomG8GI+fRFHqBA6L6nzMtTMFa QK41+4MEkmF//OuS+ihy1XJqFa3Asq9bSg6Yu3HfngoCzOmaoKx7GcaMurQyBx7SmcyazyRv41u xcYwq0WYQ5xaVXdBzzymv/0Uq7HnvFTNq1ch55j864rf8xSL
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

pwmchip_add() calls of_pwmchip_add() only after adding the chip to
pwm_chips and releasing pwm_lock. So the proper order in
pwmchip_remove() is to call of_pwmchip_remove() before taking the mutex
and removing the chip from pwm_chips. This way pwmchip_remove() releases
the resources in reverse order compared to pwmchip_add() requesting
them.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't spot a real problem that is fixed here, so this is only for the
sake of consistency.

Best regards
Uwe

 drivers/pwm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9..3639d84c492d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -321,13 +321,13 @@ void pwmchip_remove(struct pwm_chip *chip)
 {
 	pwmchip_sysfs_unexport(chip);
 
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
 	mutex_lock(&pwm_lock);
 
 	list_del_init(&chip->list);
 
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
-
 	free_pwms(chip);
 
 	mutex_unlock(&pwm_lock);
-- 
2.39.2

