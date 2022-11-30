Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEBD63D935
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiK3PWH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiK3PWD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614B8138A
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-00009w-Qz; Wed, 30 Nov 2022 16:21:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Lda-Cq; Wed, 30 Nov 2022 16:21:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuK-001Vqi-81; Wed, 30 Nov 2022 16:21:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 03/11] drm/bridge: ti-sn65dsi86: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:40 +0100
Message-Id: <20221130152148.2769768-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Tgtxe/BUdvILgFtR8LySgRChmx3a2vIX4EDaNnWT4D4=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSS3l7zQ7Nnbbcl7OCle/0dc/hIrjrAHhmm/7SrO1fgW/1rH xhPSyWjMwsDIxSArpshSV6QlNkFizX+7kiXcMINYmUCmMHBxCsBE0s9wMMzxq9l9RjNzwe+EwrfJl+ f18e0N4520t3iq63yrN/xSR8Ndn0grBEeKLZusEzeP48y0i9X+01zO30nS7Z2xNU9KJ9KHvZTL2VxQ LP3M17LtzA01b6MSNh+vvM2ruPBBJsOPLW6sJ/wYTU8x5DNvVl+RXy8+fW3a3j+VVY7dPZ0Lmx6qz1 p3JdH18r4Ye2nj9ReWzfm/LZfP3fFE8aa6n/laC9pzf33Q/1WtICvnIv6jvGWBe9PejJSfHo+sq1n1 Ozak8Xtbixbf+/xwcmaw9b073wv7/my/urbGluXIHbXl+s623veat/gopvEd9L7F32RzmvPBirn+ms Gvag4cXpW5cqfGl9aKlf4tHZcUAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6826d2423ae9..9671071490d8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1512,19 +1512,19 @@ static int ti_sn_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = regmap_read(pdata->regmap, SN_PWM_EN_INV_REG, &pwm_en_inv);
 	if (ret)
-		return 0;
+		return ret;
 
 	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_SCALE_REG, &scale);
 	if (ret)
-		return 0;
+		return ret;
 
 	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_REG, &backlight);
 	if (ret)
-		return 0;
+		return ret;
 
 	ret = regmap_read(pdata->regmap, SN_PWM_PRE_DIV_REG, &pre_div);
 	if (ret)
-		return 0;
+		return ret;
 
 	state->enabled = FIELD_GET(SN_PWM_EN_MASK, pwm_en_inv);
 	if (FIELD_GET(SN_PWM_INV_MASK, pwm_en_inv))
-- 
2.38.1

