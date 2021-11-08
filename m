Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFCF44807C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 14:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhKHNtW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 08:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbhKHNtV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 08:49:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD019C061746
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 05:46:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yn-0004Uh-Kw; Mon, 08 Nov 2021 14:46:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4ym-00069I-Bv; Mon, 08 Nov 2021 14:46:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4ym-0002pY-Ar; Mon, 08 Nov 2021 14:46:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 4/4] pwm: meson: Drop always false check from .apply()
Date:   Mon,  8 Nov 2021 14:46:27 +0100
Message-Id: <20211108134628.120474-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=t6nqP68umcfgl2LMMZu5wgSXv5y7BP8Yq//bo4VIgNc=; m=jGsFlekQ+2yilMcwc32RAz5K+wnk4VawfE73mj0m3qI=; p=LtpYs78wmQ0R8LbrvctrXoYoGhL69XWeqyaBE8SxIKQ=; g=6e7fe3eec186f73a06b22fddee4682d34beb692b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGJKjEACgkQwfwUeK3K7AnGYgf+Imt 8va6K+BIAFvqfU0/lfExarhVnwqBGy4vN3UTLXOdGJiHvcNyNKQ7tiWxf36QX/OYE5sLFNUg14jRN 4NysbBguwGipT/92RLdXOiyz++lGogPl3OrgH39bkC5AiLo0YAhK6cjRk3nMLKn7aU0ypA67FNXzx hq8xl6Af+wIWC38CBtxY/RoYqGFZQuRDY21S4C10WXQzmmgqxPOw1ujAqIvkXxKCOexCV1eEWM7+e axAGEA2AzpvfsRJzpie/G3het+OeqO229bf+icyDAgd6MrS0yodTZc1kq5HTw1eIF/eJAvueBHPUZ y0yixS5fDaPAIAKwbqSW0c3r0VlN+3Q==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm core only calls the apply callback with a valid state pointer,
so don't repeat this check already done in the core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 908e314c7c00..57112f438c6d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -265,9 +265,6 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	int err = 0;
 
-	if (!state)
-		return -EINVAL;
-
 	if (!state->enabled) {
 		if (state->polarity == PWM_POLARITY_INVERSED) {
 			/*
-- 
2.30.2

