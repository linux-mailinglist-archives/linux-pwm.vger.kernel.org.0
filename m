Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927C53B8ED0
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhGAIac (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhGAIaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 04:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B227C0617A8
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 01:28:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-0000nD-Fr; Thu, 01 Jul 2021 10:27:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-00028W-5I; Thu, 01 Jul 2021 10:27:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/5] pwm: tiecap: Ensure configuring period and duty_cycle isn't wrongly skipped
Date:   Thu,  1 Jul 2021 10:27:53 +0200
Message-Id: <20210701082755.332593-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ZOZxWRcdwNdXxQzp/M116gezOtreohLk2Jt3/3n7dr0=; m=vX123D05eesWZCmm6EkNBFcPwsHKkxjFjy3ksnSOQlg=; p=z1PYsqDNTAC01Nv7Cy6uuYuJqB4q5IlJQd+FxE8l1k4=; g=7f3d7b60ab3bf8f09f02d745541c7b5971199c20
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdfF0ACgkQwfwUeK3K7Ak5/wf+IGM JI+3CBT4m/GZosudn3C9zIRWGkpMCAmaM8c3XL9zUcqiFSuZvMtPhbUh9Jo14cHPe2euq9Yyt/w5g C2uX/jU221176NDfyOA9e2PlmgDVRj4LrQsmyUsvb0XXfbJrlfgZGLJ5BXdWrE7vAvTxcauRgdAxq pPI7a6pqqc2koZd9UKi9DP0z6xwjHXmt0xYEsM/tTTqm5lnXr015EeLOgMPpEM+thyzXUzF+EWVMd MCxxeD+otBuf8C1a0AHhyFnShw1onjiA1oIQ9jsfuiIz17MNUH2b2f6/u62zpCeKQiUAWZ+vrTsRd 5dcleg0m6ADcQuh7jV9ZI59q5TUbqUQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As the last call to ecap_pwm_apply() might have exited early if
state->enabled was false, the values for period and duty_cycle stored in
pwm->state might not have been written to hardware and it must be
ensured that they are configured before enabling the PWM.

Fixes: 0ca7acd84766 ("pwm: tiecap: Implement .apply() callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index dec3f1fb150c..35eb19a5a0d1 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -189,16 +189,13 @@ static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	if (state->period != pwm->state.period ||
-	    state->duty_cycle != pwm->state.duty_cycle) {
-		if (state->period > NSEC_PER_SEC)
-			return -ERANGE;
+	if (state->period > NSEC_PER_SEC)
+		return -ERANGE;
 
-		err = ecap_pwm_config(chip, pwm, state->duty_cycle,
-				      state->period, enabled);
-		if (err)
-			return err;
-	}
+	err = ecap_pwm_config(chip, pwm, state->duty_cycle,
+			      state->period, enabled);
+	if (err)
+		return err;
 
 	if (!enabled)
 		return ecap_pwm_enable(chip, pwm);
-- 
2.30.2

