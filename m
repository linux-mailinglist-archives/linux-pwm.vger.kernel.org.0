Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60422250A9
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgGSII2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSII2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C76C0619D2;
        Sun, 19 Jul 2020 01:08:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x9so17029131ljc.5;
        Sun, 19 Jul 2020 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDwomWBaZyGmgAqcrUivq0LeYUSJfOi4w7mumAORuIo=;
        b=qZbLaespDfNwaOoZYjfwSw6uv2x1yI8DDERHdue+PXEnXZi63Azp8gN/o6R4QC9uOx
         Wa9NRMfnp4AF+nYsndHsy0/Rf0v6v5bcZ+LsJesG+AUfxfAjBwK4UoGNhAdffeDlG4Dd
         zM18q1hxAF4FFLXJNrD0rGFlDztvCd/LczZhAb4HDXSmAyJzC4zqDMaqjn3BLZV+dFlG
         uQRjjiTydR9+lcFtGZXKGBYIGYCJrDPYszDiwe6M4EcQ1+JviCm8AHkpV9za14e4TDhj
         cP/PXZRls6E9RZedtoijUBWUc8qP41t/uqSHMAFcg3H5H3I4Wlms6FKQaesrgyQfLUnZ
         sk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hDwomWBaZyGmgAqcrUivq0LeYUSJfOi4w7mumAORuIo=;
        b=fWh9SksFqaK7y8MFEG9nhZtVfJ/PRGkZNv9s6GiiHBa7XfX3FB3Co2h+YltYcBbAt2
         cMfwY0106i0sjpkbv2psxMrRH4ciUW+4In5+02TV2BiLhzJ/leAoIyTH9dGtyeJDBXd1
         dTaisjdWE39aK3oOQfs70sUBLoof6u4BMaEE/wlOc8TSGZqrltDOejPGFriHK6YLNwGv
         FP1uSgUDF9fUMUoBT5or+dC7Hh68kQS2Nuu5RNDh1jq+IQSgXafq6kBAbGMzxzhn721K
         TCS8EYO+FAMOwkJqMfiflfauRqY9rzAwVWaDDHEBslTM6rGkkt1eu5Oc2lcMdsUSdBoA
         YT4Q==
X-Gm-Message-State: AOAM532cX5bUbg1OuVH7S5n7ICCZNcHLNoqAR54ukg5KAKZfwbo3DW/M
        omrL8zLxxPWdgnmWz7ZI6ac=
X-Google-Smtp-Source: ABdhPJxl8rnN+FIc4hwfdlTsc9yUhDElaMadQ4i8ACenfj10jhR5RM+e3Rdb5asOLrfsrLf1PxnkFw==
X-Received: by 2002:a2e:571c:: with SMTP id l28mr7549009ljb.432.1595146106225;
        Sun, 19 Jul 2020 01:08:26 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:25 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 16/19] backlight: jornada720_bl: introduce backlight_is_blank()
Date:   Sun, 19 Jul 2020 10:07:40 +0200
Message-Id: <20200719080743.8560-17-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use the backlight_is_blank() helper to simplify the code a bit.

The jornada720_bl driver distingush between backlight off
and brightness set to 0.

Thus this driver turn off backlight only when backlight_is_blank()
returns true.

v2:
  - Updated changelog (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/jornada720_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
index f0385f9cf9da..996f7ba3b373 100644
--- a/drivers/video/backlight/jornada720_bl.c
+++ b/drivers/video/backlight/jornada720_bl.c
@@ -54,7 +54,7 @@ static int jornada_bl_update_status(struct backlight_device *bd)
 	jornada_ssp_start();
 
 	/* If backlight is off then really turn it off */
-	if ((bd->props.power != FB_BLANK_UNBLANK) || (bd->props.fb_blank != FB_BLANK_UNBLANK)) {
+	if (backlight_is_blank(bd)) {
 		ret = jornada_ssp_byte(BRIGHTNESSOFF);
 		if (ret != TXDUMMY) {
 			dev_info(&bd->dev, "brightness off timeout\n");
-- 
2.25.1

