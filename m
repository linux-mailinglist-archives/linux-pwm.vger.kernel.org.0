Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6E63D932
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiK3PWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiK3PWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D37CA8E
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuN-0000BL-IK; Wed, 30 Nov 2022 16:21:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuM-001Le6-3J; Wed, 30 Nov 2022 16:21:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuM-001VrC-3f; Wed, 30 Nov 2022 16:21:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 11/11] pwm: Handle .get_state() failures
Date:   Wed, 30 Nov 2022 16:21:48 +0100
Message-Id: <20221130152148.2769768-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Dpsx2cpxcM/yovBGi8fx3Iex7d+WQSEYUOlIA2zpYhU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3UFl1zPf409UhK87JJpZodrjo1V4e//x4cwYusF bCxzWx+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d1BQAKCRDB/BR4rcrsCWgJCA CdtcY14YtkGlsfsaUTbc54MFOIeGRIx8fHJya9iieENUWdyIC9LxhZRXnrrKdMU1gPEnfrZGNNdAA1 LZV66vW6nLazFjF6e99AmA05IMay9c78THn4e7HN5G6k7K+2ipQ1CwkGjaboeH8lYk3URf2CFnTIXE mvKDJ1yVDKP8qilMfx+vfq3HrA7zTdINpjrgOXG2Zmy9RzB6jS1hkz63XPX8BjQnLIz6wjoe2ctfrd /YJ9LHSCazCfQrlupTYEHEXFskVddqz9NXteCUPzmLqCbzjACcqBZZpAKgjq/x41V+X7VHWltntO8y TSIGotw0IPWXkHeQsccO9osC52KaYI
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

This suppresses diagnosis for PWM_DEBUG routines and makes sure that
pwm->state isn't modified in pwm_device_request() if .get_state() fails.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 21e1553495ee..855c3885f94b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -108,8 +108,13 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	}
 
 	if (pwm->chip->ops->get_state) {
-		err = pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
-		trace_pwm_get(pwm, &pwm->state, err);
+		struct pwm_state state;
+
+		err = pwm->chip->ops->get_state(pwm->chip, pwm, &state);
+		trace_pwm_get(pwm, &state, err);
+
+		if (!err)
+			pwm->state = state;
 
 		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
@@ -459,6 +464,9 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	err = chip->ops->get_state(chip, pwm, &s1);
 	trace_pwm_get(pwm, &s1, err);
+	if (err)
+		/* If that failed there isn't much to debug */
+		return;
 
 	/*
 	 * The lowlevel driver either ignored .polarity (which is a bug) or as
@@ -523,6 +531,8 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	err = chip->ops->get_state(chip, pwm, last);
 	trace_pwm_get(pwm, last, err);
+	if (err)
+		return;
 
 	/* reapplication of the current state should give an exact match */
 	if (s1.enabled != last->enabled ||
-- 
2.38.1

