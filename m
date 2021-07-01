Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABB53B8ECE
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhGAIaa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhGAIaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 04:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CBC0617A8
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 01:28:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-0000nB-Da; Thu, 01 Jul 2021 10:27:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3B-00028P-Na; Thu, 01 Jul 2021 10:27:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Baolin Wang <baolin.wang@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 1/5] pwm: sprd: Ensure configuring period and duty_cycle isn't wrongly skipped
Date:   Thu,  1 Jul 2021 10:27:51 +0200
Message-Id: <20210701082755.332593-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=F+MIQpP/2e28GXz4s3vQMHCyGNRHm9EPmWQWLWHI5Ig=; m=ZsJK1/kkQj7E5ET+EJXTFAAIQnZI7n3pdIjoFbNqiEU=; p=jha8HbRLpjTsr9zHkBgDEUIaFu4ZDf48yiEWrF89bgU=; g=7ca01afa070d3d61074c45b51ee5c4e5ad6b5304
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdfFYACgkQwfwUeK3K7Ams+Af/ejU 5qLeM91tfr3nVm/fK/2wiMAJl/sA3lZsqZ+cjnWG57IjkqAJKtTP1oMAOUro2sRWF3T4m+krdS60q ql2BymwDZ5eiYd7HKWGMl6SPjx6TvRkEcEYI08AComr4M/XtAEsE9Wdf7IrhbY2JhpXrZwveOEli6 ZqR5dGYP1P/y+BMxsfTAp4K2L9ZXLtM/tEwiDVubX3u06NayJzkoljnYfnCWwDb3IXoWFu1k3BXFU tNz0IW5zS1GyelT7WxHludoUtC/Gkx8CTyiXwTu/35V8boHgIhtEHCzHmD6maSWJsf5oiM2qb9V4t MYR8CSX2WKd21RwkZWztWz6e1dIzM5w==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As the last call to sprd_pwm_apply() might have exited early if
state->enabled was false, the values for period and duty_cycle stored in
pwm->state might not have been written to hardware and it must be
ensured that they are configured before enabling the PWM.

Fixes: 8aae4b02e8a6 ("pwm: sprd: Add Spreadtrum PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index f2a85e8dd941..7004f55bbf11 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -183,13 +183,10 @@ static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			}
 		}
 
-		if (state->period != cstate->period ||
-		    state->duty_cycle != cstate->duty_cycle) {
-			ret = sprd_pwm_config(spc, pwm, state->duty_cycle,
-					      state->period);
-			if (ret)
-				return ret;
-		}
+		ret = sprd_pwm_config(spc, pwm, state->duty_cycle,
+				      state->period);
+		if (ret)
+			return ret;
 
 		sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
 	} else if (cstate->enabled) {
-- 
2.30.2

