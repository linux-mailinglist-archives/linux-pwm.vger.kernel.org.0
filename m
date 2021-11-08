Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBC44807D
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhKHNtV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 08:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhKHNtV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 08:49:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CBC061570
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 05:46:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yn-0004Ue-Kw; Mon, 08 Nov 2021 14:46:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yl-000699-Tp; Mon, 08 Nov 2021 14:46:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yl-0002ov-RJ; Mon, 08 Nov 2021 14:46:31 +0100
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
Subject: [PATCH 1/4] pwm: meson: Drop always false check from .request()
Date:   Mon,  8 Nov 2021 14:46:24 +0100
Message-Id: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=pFF+ThL4Urlu1TgeAT3wxZCnLMkalyqRs5xjfOsL+ZY=; m=nhk1f+7QpS0gg35JwXeZ3sqDXjYmbygGULsEVAtTKUQ=; p=u0Uw8z69fVb+Fwiw/oDyZ54AmbpstXAC/2Fa5ZfBsw0=; g=cf9f1f25cd7eecd9840378bff40eaedad4219019
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGJKiUACgkQwfwUeK3K7Alk1QgAk5M isgUA5ScsDyvJfOEg8PQFmdzrTFRAijf9kGuZbRH1b9EIAMnqNeFEFQJBwIvguQV4o6wOu2E+plZF AcLwTAXGe8WojGf+46Ka/fU2FzXCAqsHZuVbqjQGrcdVXkUGX+SYBqL+xlsaPPFSxhuC/wW+aNOSI MO2TnS5p5oMAe75ReJMSsdbGgkISZXtUABKqqpmKlcjmZu1ou2K3Tiyj5YPQy+YOYQsnHkl5gXL59 18ggvXAtY0bi7rm0jtG7m+OTYzvJcYxSqT8Lh5y80ADuaJBKTTFXMSn+hhMzRq3HNcttViWm2OrDP bA7N+Z0UDSSV+igFgkBi+IGazmOWSxw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In .request() pwm_get_chip_data() returns NULL always since commit
e926b12c611c ("pwm: Clear chip_data in pwm_put()"). (And if it didn't
returning 0 would be wrong because then .request() wouldn't reenable
the clk which the other driver code depends on.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3cf3bcf5ddfc..be3c806b57e4 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -120,16 +120,10 @@ static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
-	struct meson_pwm_channel *channel;
+	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct device *dev = chip->dev;
 	int err;
 
-	channel = pwm_get_chip_data(pwm);
-	if (channel)
-		return 0;
-
-	channel = &meson->channels[pwm->hwpwm];
-
 	if (channel->clk_parent) {
 		err = clk_set_parent(channel->clk, channel->clk_parent);
 		if (err < 0) {

base-commit: 6b75d88fa81b122cce37ebf17428a849ccd3d0f1
-- 
2.30.2

