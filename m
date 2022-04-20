Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA91D5087D9
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiDTMPs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 08:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352906AbiDTMPn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:15:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E993FDA3
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 05:12:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-00022J-QD; Wed, 20 Apr 2022 14:12:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CU-0049dM-BT; Wed, 20 Apr 2022 14:12:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CR-004TjV-MG; Wed, 20 Apr 2022 14:12:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 3/6] pwm: renesas-tpu: Implement .apply() callback
Date:   Wed, 20 Apr 2022 14:12:37 +0200
Message-Id: <20220420121240.67781-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; h=from:subject; bh=i/DbamAN54FzxHHPR0pW4sRTy4Kf59NwNWV7VxjTUzk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX/iqqLgSOGS/1b8wnJDCtNb5K7kfk2RHZAKdetgm jZL6NGqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/4qgAKCRDB/BR4rcrsCSt8CA CBKJNZsRWNBb50Hf8q2v34VKVP2PoD7toTYIPEZtjwvX7gKOiWjEMu2P7DzzY2Ja2hbq2xXnpvMzuQ xDpA0idlGWoOFch31tOGL3mYAgt7ci807ObP2zfYwlQC5hYQlJLeB7EQaMFJ5ukJw0a2ES6Rh7LSFB NzP33wf/NuhqU00c3gBLgMESKbPVRMA7DqSemR4L9JFqNiWyjtnFN0odxDlQ6UEc3D8Hbb4OTQ6/jm zR1l0Mjwj4fP3qKfIwmL65lGRfZcmTP9rOuzzYyEtRewOVQVUiPF7QCyvPvqET0VRJ3/pt4diEsxen HtkCHXftJCVMFUjTu9orTigxKCQuwv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().

As pwm->state might not be updated in tpu_pwm_apply() before calling
tpu_pwm_config(), an additional parameter is needed for tpu_pwm_config()
to not change the implemented logic.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 44 ++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 12376988c70e..bebae65a6ed7 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -242,7 +242,7 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *_pwm)
 }
 
 static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
-			  int duty_ns, int period_ns)
+			  int duty_ns, int period_ns, bool enabled)
 {
 	static const unsigned int prescalers[] = { 1, 4, 16, 64 };
 	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
@@ -293,7 +293,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 	pwm->duty = duty;
 
 	/* If the channel is disabled we're done. */
-	if (!pwm_is_enabled(_pwm))
+	if (!enabled)
 		return 0;
 
 	if (duty_only && pwm->timer_on) {
@@ -366,13 +366,45 @@ static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *_pwm)
 	tpu_pwm_timer_stop(pwm);
 }
 
+static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			tpu_pwm_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = tpu_pwm_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			tpu_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = tpu_pwm_config(pwm->chip, pwm,
+			     state->duty_cycle, state->period, enabled);
+	if (err)
+		return err;
+
+	if (!enabled)
+		err = tpu_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops tpu_pwm_ops = {
 	.request = tpu_pwm_request,
 	.free = tpu_pwm_free,
-	.config = tpu_pwm_config,
-	.set_polarity = tpu_pwm_set_polarity,
-	.enable = tpu_pwm_enable,
-	.disable = tpu_pwm_disable,
+	.apply = tpu_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.35.1

