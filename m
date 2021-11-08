Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6607A44807B
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 14:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhKHNtV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 08:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhKHNtV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 08:49:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF110C061764
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 05:46:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yn-0004Uf-Kw; Mon, 08 Nov 2021 14:46:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4ym-00069C-0m; Mon, 08 Nov 2021 14:46:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4yl-0002p8-W0; Mon, 08 Nov 2021 14:46:31 +0100
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
Subject: [PATCH 2/4] pwm: meson: Drop useless check for channel data being NULL
Date:   Mon,  8 Nov 2021 14:46:25 +0100
Message-Id: <20211108134628.120474-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=WYWbEo0mdLasyONjA5l0Q8GW6ag2v1wA0HYDo9/eUbo=; m=3MDjJzoRh63117QhB/RgLRb8f8aNIyaZ/jAm+bicXOk=; p=Hw1bqdubrn8I4UHF0kD52flQxDKafxUj3KVtG+rMoPQ=; g=d11fe241c518b8a375ef3cda3e0d354bfe0bc0b4
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGJKigACgkQwfwUeK3K7AmB0Qf/Y6E qXsMl91ssbdUh7Ztdip6h9FkWb4LZ0aFHtSo4M9fn9Y1pIZ7snFfXq4S+kqNISljAkLh4SfUehJA9 VAj3/IUVFdbf5RyZNEV8RvXH7/93DLQz13ZxoNKooHoNA/OuTAl1p5csZhaxeowUKD7A/pQsuZ/h/ nOEks7Js0kPMTl5Y56AzBbUvUm9QWmbZ2VDD5vVq3FeaF9lCiY4cqqUJ50k28OfTFYdyPuYX9uXYR vTGmc9CQu26voug2FKwPJej+Z0prDE7q850gf4JbUQEhArEVHl9HYoSqyEbbaINmg4eEFuZvJOF8/ jpCsUSFRU6bSFg2yu+llzki1lC4he8A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In meson_pwm_free() the function pwm_get_chip_data() always returns a
non-NULL pointer because it's only called when the request callback
succeeded and this callback calls pwm_set_chip_data() in this case.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index be3c806b57e4..1fbe54a2abfe 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -148,8 +148,7 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 
-	if (channel)
-		clk_disable_unprepare(channel->clk);
+	clk_disable_unprepare(channel->clk);
 }
 
 static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
-- 
2.30.2

