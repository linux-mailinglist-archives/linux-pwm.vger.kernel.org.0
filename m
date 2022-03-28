Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F244E8F0D
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Mar 2022 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiC1Hgc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Mar 2022 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiC1Hgb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Mar 2022 03:36:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC351E5B
        for <linux-pwm@vger.kernel.org>; Mon, 28 Mar 2022 00:34:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nYjtl-0007DX-56; Mon, 28 Mar 2022 09:34:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nYjth-003Xl3-6n; Mon, 28 Mar 2022 09:34:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nYjtj-00CJRY-2R; Mon, 28 Mar 2022 09:34:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: samsung: Implement .apply() callback
Date:   Mon, 28 Mar 2022 09:34:34 +0200
Message-Id: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669; h=from:subject; bh=Wma7z56MXzPlyi5tga+1Vs5Q9xdWnEc8Jt+b6Asx6K0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiQWUHyhz4Bzlmg9fLv9oeKShDA/jMDEOEWXnGgg1J jSKNTKuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYkFlBwAKCRDB/BR4rcrsCUJIB/ 9k7LJmLyyr4QRLxSYJvX/KNo+0aY7oWczwIBweEtgId4sWkWm2i9aDjGH9iHFGRB0+5nnd2+O1yski WGR8ypgNIBsj4z4Dl7j09wDWZV/dbf+YaAWEF3LS2MfpjLx35wfJjvWoOzAq4+PWlVCiY9wlg+vCzJ 3KUcvjviqrxVfn55ooUNMDHmGd89YzSf7a5efsn2hHOR26AI1+jD91dzX8014J5OmTpYS5FIxhutNl X9K9jzB8fbpPbL7dDyi69uMxEZ0s8AiDrB+I9g8wiuYPI7NYKfWDAbQ+zMOPTqiVSWlVMSfqKedMKa fizFxaBl3EnB1hHHRdN230/2TnPYEn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().

The size check for state->period is moved to .apply() to make sure that
the values of state->duty_cycle and state->period are passed to
pwm_samsung_config without change while they are discarded to int.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 54 ++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 0a4ff55fad04..9c5b4f515641 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -321,14 +321,6 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct samsung_pwm_channel *chan = pwm_get_chip_data(pwm);
 	u32 tin_ns = chan->tin_ns, tcnt, tcmp, oldtcmp;
 
-	/*
-	 * We currently avoid using 64bit arithmetic by using the
-	 * fact that anything faster than 1Hz is easily representable
-	 * by 32bits.
-	 */
-	if (period_ns > NSEC_PER_SEC)
-		return -ERANGE;
-
 	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
 	oldtcmp = readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
 
@@ -438,13 +430,51 @@ static int pwm_samsung_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
+static int pwm_samsung_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	int err, enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			pwm_samsung_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = pwm_samsung_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			pwm_samsung_disable(chip, pwm);
+
+		return 0;
+	}
+
+	/*
+	 * We currently avoid using 64bit arithmetic by using the
+	 * fact that anything faster than 1Hz is easily representable
+	 * by 32bits.
+	 */
+	if (state->period > NSEC_PER_SEC)
+		return -ERANGE;
+
+	err = pwm_samsung_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = pwm_samsung_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops pwm_samsung_ops = {
 	.request	= pwm_samsung_request,
 	.free		= pwm_samsung_free,
-	.enable		= pwm_samsung_enable,
-	.disable	= pwm_samsung_disable,
-	.config		= pwm_samsung_config,
-	.set_polarity	= pwm_samsung_set_polarity,
+	.apply		= pwm_samsung_apply,
 	.owner		= THIS_MODULE,
 };
 

base-commit: ed14d36498c8d15be098df4af9ca324f96e9de74
-- 
2.35.1

