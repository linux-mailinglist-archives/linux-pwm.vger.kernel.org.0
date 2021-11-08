Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3575244807E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhKHNtW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 08:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbhKHNtV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 08:49:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B22C061714
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 05:46:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yn-0004Ug-Kw; Mon, 08 Nov 2021 14:46:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4ym-00069F-5t; Mon, 08 Nov 2021 14:46:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4ym-0002pL-4o; Mon, 08 Nov 2021 14:46:32 +0100
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
Subject: [PATCH 3/4] pwm: meson: Simplify duplicated per-channel tracking
Date:   Mon,  8 Nov 2021 14:46:26 +0100
Message-Id: <20211108134628.120474-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=rNZrjCvgYmAqlJ5riojVlnaxpCf4wtmwd9yLL/nP0PM=; m=5XgqPhF6+YixcIl9jZOqNtNzkP5opD+m/1BKa93KXaM=; p=wj2PEOpn/8zNM06wPsEr602+lpcO38hRz6y9qIvpvBg=; g=2eaf700f1bee0410d39a81c3eecddf3d6da7db05
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGJKi0ACgkQwfwUeK3K7An8igf+INv cesPBBF3ca/KVzDkShBEJWZ1BVxrlZYKESmYp1sHbfMBtt2rAqQdGULLf70AYEiyzwi+5I4wPPrKk 9MyOapg0LS6ioCsC1ItQENjdArGwEybcHlx3uUNLPXPFatVe940MWOGbTA0NoDZoI907tysjtfAA6 6Iz1n58FZTyedYOjeyoJFOTEYSpITgd08jtD+morYCqD1h8sg/3fDWDcq9VkgDfeHHdrxnPgTa5mk izu2biIvenHBJ5eW53m5gkeyPQkFDde7S38uc01IPj+yM5AtPNH/37J+9Lg+2gYT12WYJCi84D52B lHkM7e1T4OsKs9ZVhX6R3NX2sMk8YPw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver tracks per-channel data via struct pwm_device::chip_data and
struct meson_pwm::channels[]. The latter holds the actual data, the former
is only a pointer to the latter. So simplify by using struct
meson_pwm::channels[] consistently.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 1fbe54a2abfe..908e314c7c00 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -141,12 +141,13 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	return pwm_set_chip_data(pwm, channel);
+	return 0;
 }
 
 static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 
 	clk_disable_unprepare(channel->clk);
 }
@@ -154,7 +155,7 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
 
@@ -217,7 +218,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
 	u32 value;
@@ -260,8 +261,8 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	int err = 0;
 
 	if (!state)
-- 
2.30.2

