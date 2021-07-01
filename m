Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978943B8ED1
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhGAIac (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhGAIaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 04:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF5C061756
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 01:28:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-0000nC-DT; Thu, 01 Jul 2021 10:27:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3B-00028T-Ua; Thu, 01 Jul 2021 10:27:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/5] pwm: spear: Ensure configuring period and duty_cycle isn't wrongly skipped
Date:   Thu,  1 Jul 2021 10:27:52 +0200
Message-Id: <20210701082755.332593-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=EqTLLDy0Le6CUjsTaxgk5Sb0aw20Wh2YQBPJfBtg0ys=; m=mCYl+K882oICNwHXLuGKxgYGCyyjMW9EEaYpYoM4biA=; p=lqmmipVVHsnF2W4AwdWMGdHMjh1LZE8LEWtlNd5Wobg=; g=89b79f1415783ff2959f3addf885a83a48cdb3e5
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdfFoACgkQwfwUeK3K7AnuyAf9FGx nPBS6+3gDOv/s+QmkJ6NcquGdnUq4KrkZui7KOfh4QIMYj6mRN7e4zT3yz+y0ILsvZTkpSdJQsClX dGALXfXiblLJEMTR0T8KbfIxEg9uMz/5uK66KQ7+jp6cvqakngNQzJInTwoKqp9Emp9+KDJbESDH5 Jgl3qrlZ/CPYNp2ELOnmFoZshyeLfMpNgD/RfPjLOD4Xpq+Wh6FjQ7eWQ9Jx2XDLcXOijO8K8L+Y2 xmcpx0ZXrT0E/AJpyUn/wbuUMZXVvglHJ7JranIiZYwRZbR8PMms3C4ui1s5cReHqbarVbEb0LPVR 4t47X+08zyiy4c4hL97o9YrO0h0QuxA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As the last call to spear_pwm_apply() might have exited early if
state->enabled was false, the values for period and duty_cycle stored in
pwm->state might not have been written to hardware and it must be
ensured that they are configured before enabling the PWM.

Fixes: 98761ce4b91b ("pwm: spear: Implement .apply() callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 48c31dac2f32..54c7990967dd 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -177,12 +177,9 @@ static int spear_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	if (state->period != pwm->state.period ||
-	    state->duty_cycle != pwm->state.duty_cycle) {
-		err = spear_pwm_config(chip, pwm, state->duty_cycle, state->period);
-		if (err)
-			return err;
-	}
+	err = spear_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
 
 	if (!pwm->state.enabled)
 		return spear_pwm_enable(chip, pwm);
-- 
2.30.2

