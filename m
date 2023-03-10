Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862166B52F2
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjCJVkR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 16:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCJVkP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 16:40:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6957F12EACB
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 13:40:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pakTE-0002mt-E2; Fri, 10 Mar 2023 22:40:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pakTD-003GHH-O5; Fri, 10 Mar 2023 22:40:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pakTC-003tYx-U0; Fri, 10 Mar 2023 22:40:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Munehisa Kamata <kamatam@amazon.com>,
        tobetter@gmail.com, kernel@pengutronix.de
Subject: [PATCH v2] pwm: Zero-initialize the pwm_state passed to driver's .get_state()
Date:   Fri, 10 Mar 2023 22:40:04 +0100
Message-Id: <20230310214004.2619480-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=robhHBmalGy+K95i0jCM0dQlZc3gTFupV/Uv93kq62o=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC6OvpgjLVfukMhemX+667CAToCLToNmk7bA7s l65RAdhEnqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAujrwAKCRDB/BR4rcrs CRvCB/4pldEFzboRpAGFD5Sa0giTISg7fT55wc+TuHBlzvOSrwnA/fcunE43pJLUpgxahm3+1EY utTi5CU2AjOuO8Kg/UXWi9xEya530FL7GU82X7RUNzuR/fZbO35UDLTCJHEJBH43SkSv/SeMGRU 4yGKM0Ka9EqsaZ2mCYkSD9ltKr60bkUZgjbnR21cyP1slFiI9ld7q/+R0tXeGLCSXSLsYhvPIxx LOPXdXmP7MRTPA+2BplOiJZGWjK0aN0IWJznNAdgU6moo3POE3GQ2p8xI3iRibZZHJ5c1dy9KtY BkRERErlrVY8K7atGjEYo2C7l1Fc0ErzbYcdth8UD4GU56wj
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

This is just to ensure that .usage_power is properly initialized and
doesn't contain random stack data. The other members of struct pwm_state
should get a value assigned in a successful call to .get_state(). So in
the absence of bugs in driver implementations, this is only a safe-guard
and no fix.

Reported-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I found a few more locations where .get_state() is called without
zero-initializing *state.

Best regards
Uwe

 drivers/pwm/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e01147f66e15..474725714a05 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -115,7 +115,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	}
 
 	if (pwm->chip->ops->get_state) {
-		struct pwm_state state;
+		/*
+		 * Zero-initialize state because most drivers are unaware of
+		 * .usage_power. The other members of state are supposed to be
+		 * set by lowlevel drivers. We still initialize the whole
+		 * structure for simplicity even though this might paper over
+		 * faulty implementations of .get_state().
+		 */
+		struct pwm_state state = { 0, };
 
 		err = pwm->chip->ops->get_state(pwm->chip, pwm, &state);
 		trace_pwm_get(pwm, &state, err);
@@ -448,7 +455,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 {
 	struct pwm_state *last = &pwm->last;
 	struct pwm_chip *chip = pwm->chip;
-	struct pwm_state s1, s2;
+	struct pwm_state s1 = { 0 }, s2 = { 0 };
 	int err;
 
 	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
@@ -530,6 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 		return;
 	}
 
+	*last = (struct pwm_state){ 0 };
 	err = chip->ops->get_state(chip, pwm, last);
 	trace_pwm_get(pwm, last, err);
 	if (err)

base-commit: cf70d01a62c712ee715df1f7892b58c77474bcfb
-- 
2.39.1

