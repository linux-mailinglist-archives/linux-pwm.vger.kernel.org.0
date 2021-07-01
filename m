Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153D13B8ED2
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhGAIac (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhGAIaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 04:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72805C0617AD
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 01:28:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-0000nX-RG; Thu, 01 Jul 2021 10:27:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-00028Z-Fe; Thu, 01 Jul 2021 10:27:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thomas Hebb <tommyhebb@gmail.com>
Subject: [PATCH 4/5] pwm: berlin: Ensure configuring period and duty_cycle isn't wrongly skipped
Date:   Thu,  1 Jul 2021 10:27:54 +0200
Message-Id: <20210701082755.332593-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Qdgk3OBZM8tH1cpv/g8P21BUfhFuBAVOiKx/p6ABSx0=; m=ePx6+HNwm5+sTR8PflXTMpE+HnKfxbZVomh09Fjr0cw=; p=f6RQwPd0DYynFLypf6Xj6wm3oetkrutSDyogBHQb9HM=; g=995d77b860cf0aca6197bcaa5542bcbc114c1ed3
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdfGAACgkQwfwUeK3K7AlATgf/QHs aT4rLnHmZh+C1GeiJaLXBGDuwY0NB+r3dG9Ul5FrH5Z1bIhYEC+7NWnGJIpWGylSyqoNKgPjQauJI CwSNnU0f3VTT9rbX5pYbEKeOjkDENPenaeoHFsz0+xunaNMxTdUyOUhQSyR/efHzjhu31yrrLln5n 0Pbq8MStGy4TuVFkBN/jMYAN8HU+1IgM2bTP4A9E77S0sYacQnxTagiZvpd2Iy89DB91SGHscfrbh Qr2hx6orCF46s5K59kCnz2m4jnGYdz+YmAVuU1QT4fZFqJ/8emusaVDkhrYkuG/knXl3LIeGc6oPo ipu6h724UnNMRgY0ctW12kRI5CvCdvA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As the last call to berlin_pwm_apply() might have exited early if
state->enabled was false, the values for period and duty_cycle stored in
pwm->state might not have been written to hardware and it must be
ensured that they are configured before enabling the PWM.

Fixes: 30dffb42fcd4 ("pwm: berlin: Implement .apply() callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 5537b5f6dd5d..e157273fd2f7 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -190,12 +190,9 @@ static int berlin_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	if (state->period != pwm->state.period ||
-	    state->duty_cycle != pwm->state.duty_cycle) {
-		err = berlin_pwm_config(chip, pwm, state->duty_cycle, state->period);
-		if (err)
-			return err;
-	}
+	err = berlin_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
 
 	if (!enabled)
 		return berlin_pwm_enable(chip, pwm);
-- 
2.30.2

