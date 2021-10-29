Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D941443FB1D
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJ2K66 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhJ2K66 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 06:58:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E20C061570
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 03:56:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPYg-0000kl-9J; Fri, 29 Oct 2021 12:56:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPYd-0005PB-4Y; Fri, 29 Oct 2021 12:56:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPYd-0002Q2-3T; Fri, 29 Oct 2021 12:56:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] pwm: img: Implement .apply() callback
Date:   Fri, 29 Oct 2021 12:56:17 +0200
Message-Id: <20211029105617.210178-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=W6dF7RZyvVaIfn3AMXQUv3qdOGuwqeXB8fHLxYMMvtI=; m=TzWDfn0QgyP4Qo0s0ELgUgvslQMmfgqYACV4fnO2KFo=; p=sr0kis/Z3+VqcivWjoj3JOsPSJ9sFZflxj25ZzF6/Xs=; g=e1395e015c7c9f89466c2b08606155c6d14d8df4
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF7004ACgkQwfwUeK3K7AljBwf/eGa ogavSsr9va2TR9ZnjxkYVH6xmSF6lQ7oIW3GJJMxePqPqL4si6J6k7pxeam8o9FN6YfqcaVfHQlsO PHKr7JV7QU3Q/mq0KJoD68Zsw0JEivVISCuovTDIJM+BpRKNyennVWhD8UkMfpi/ghebvh7itiCPG xfaQtanLO+SmqJaefGY6fCnCl3gF1slw4FmuiUVi9X6zINdLV8LZrw8Thss1QhErVuSWf7aHXwRxn 8HeSPt8HWDgNOgpQaMB8v9r6v1EiJe+Rqt24vgLZkJfaBdqxaigrU7X6jFN5Lz6irxX8VkqZ0qAib QHPxp9yPij/+AWvO7VlKV/K7yK/r/Ng==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply(). This just pushes down a slightly
optimized variant of how legacy drivers are handled in the core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index f97f82548293..1f3d6346ab86 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -184,10 +184,33 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pm_runtime_put_autosuspend(chip->dev);
 }
 
+static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			img_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = img_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = img_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops img_pwm_ops = {
-	.config = img_pwm_config,
-	.enable = img_pwm_enable,
-	.disable = img_pwm_disable,
+	.apply = img_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
-- 
2.30.2

