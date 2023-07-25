Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F2760CD0
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jul 2023 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGYITw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jul 2023 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGYITu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jul 2023 04:19:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A2E5C
        for <linux-pwm@vger.kernel.org>; Tue, 25 Jul 2023 01:19:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qODGm-0004NP-Fh; Tue, 25 Jul 2023 10:19:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qODGl-001xGP-I9; Tue, 25 Jul 2023 10:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qODGk-007cdZ-Mx; Tue, 25 Jul 2023 10:19:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Remove outdated documentation for pwmchip_remove()
Date:   Tue, 25 Jul 2023 10:19:45 +0200
Message-Id: <20230725081945.396310-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Zb/7B3aVaM6DjWfsHerO9OHvQIbHpoGohFBg6xDhrK8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkv4WgBjhpATKXBHvJ5kBQIhrrcYFEotv7uR5U8 16TxnOmA+yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZL+FoAAKCRCPgPtYfRL+ TsK7CACC2iQJRsyJeXgPteaKCfuUbRLNwZ7AEL4S5TEVrWA39YRaoohze8nr67dfuNLAMhHyUvv NpbecsWSs+1AXk0ejK84GIoW6ao0TXv3LmDmI9Kwv7DZ0wGFsXeR2guwivO3Ey2K0k2bQV6yO+a lqviydtUI3ZGxRjxaZhdPqyxQfTdDuXgOVE2eQj4Q887BaNNHM/q7AFXUoJwR+NX1Vcrgs6Wrxi psXcJJEQDKh+92omHbf73qE9qbwUMmEk5d671FewLKYIiQYantCE66VvD2LZS4620UPqRHgj2D+ Mxw8UnZWOs+8vi5LIwxWFu8Rx2GBcek09kR4+ytvI03F0BZA
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

pwmchip_remove() returns void since some time but the documentation still
mentions the situations where it used to return an error code. Just remove
this old and now wrong text.

Fixes: 8083f58d08fd ("pwm: Make pwmchip_remove() return void")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3639d84c492d..4887154f6c7e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -312,10 +312,7 @@ EXPORT_SYMBOL_GPL(pwmchip_add);
  * pwmchip_remove() - remove a PWM chip
  * @chip: the PWM chip to remove
  *
- * Removes a PWM chip. This function may return busy if the PWM chip provides
- * a PWM device that is still requested.
- *
- * Returns: 0 on success or a negative error code on failure.
+ * Removes a PWM chip.
  */
 void pwmchip_remove(struct pwm_chip *chip)
 {

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
prerequisite-patch-id: 9faadf66e8ea1bf1622bd303d59d90251d7dea05
-- 
2.39.2

