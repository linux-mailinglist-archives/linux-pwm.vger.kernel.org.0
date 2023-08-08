Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E4774AF3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjHHUiv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjHHUid (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:38:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3075840
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-0006ts-10; Tue, 08 Aug 2023 19:19:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-00223r-5R; Tue, 08 Aug 2023 19:19:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00BTB6-Hq; Tue, 08 Aug 2023 19:19:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 015/101] pwm: cros-ec: Change prototype of helper to prepare further changes
Date:   Tue,  8 Aug 2023 19:18:05 +0200
Message-Id: <20230808171931.944154-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Y3j4tNZ4BBLsQ8380LO53phorckXzTg91t5MfypHR1A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njBzM04VpWXXBQkQL3fWAysbVIXbvE7VHpVI 7DzTIy+TniJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4wQAKCRCPgPtYfRL+ TrtwB/4+Z7Yaz9Yu6awvUQ7UtuVemPXTOZieLY9K3aRR0gTKzPkU4mBxsfn3Py3yxXTV6tCfeva bxRjeGodK4dsNOisqASkxxuAsr/H7iNTwNfEwTgTShJbaQV/gwYNbz7cv0K1Mzf1gftjwmDcIsh WN98advGbTkWO0CDYyPc5UJmfm0oIpTLZ2qWAKnofJXAS6CIxp2K8GwB31RaVwVlECuionS5rDQ 5nHOld+KhB/SkNVkOp76K7aitRODRTw/u8CEi2gfWBl0AC4WTz5DFxJIdTKweE3F0yaCrX9YLmB SfHmz8nbbhvn6bblKiBU/1SJDfD7MAnEk2nVG2Luq5wc/So5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_chip allocation and registration is about to change. For that the number
of PWM devices must be known earlier in cros_ec_pwm_probe(). So make
cros_ec_pwm_get_duty() independant from struct cros_ec_pwm_device which is only
available later.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index e2a5e54face1..8a5925a624e6 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -93,9 +93,8 @@ static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
 	return cros_ec_cmd_xfer_status(ec, msg);
 }
 
-static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
+static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, bool use_pwm_type, u8 index)
 {
-	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		union {
@@ -115,7 +114,7 @@ static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
 	msg->insize = sizeof(*resp);
 	msg->outsize = sizeof(*params);
 
-	if (ec_pwm->use_pwm_type) {
+	if (use_pwm_type) {
 		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
 		if (ret)
 			return ret;
@@ -169,7 +168,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
+	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0)
 		return ret;
 
@@ -228,7 +227,7 @@ static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
 
 	/* The index field is only 8 bits */
 	for (i = 0; i <= U8_MAX; i++) {
-		ret = cros_ec_pwm_get_duty(ec_pwm, i);
+		ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, i);
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
-- 
2.40.1

