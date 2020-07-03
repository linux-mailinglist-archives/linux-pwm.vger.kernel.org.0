Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30492213F91
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgGCSqi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCSqh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA8C061794;
        Fri,  3 Jul 2020 11:46:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so19029534lfd.10;
        Fri, 03 Jul 2020 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZNZ91Ufx6ojfiiT+ZYBRZsahy67A4bJ2OQndrGkqvw=;
        b=IN60GzkumPnjdCCjAXLga3TkI9r+tMRO4r414D3XwPqkkmoMM8IG73aedwq6jOFFJ+
         i7v/VdzLHRcaZ7LPh1243jMCJi+2OJVLjsA274K/ukCLJCkpUZcxMo2guoC2vFIScnvO
         DlugE49fFCUtw8ZSysGlX8UGz07m+FEoCmLKEUmba1IDOzTymnRiUNAhph69R5P+yR5Y
         shmKTkktHAcpdRBmICeMMF+e/roC/9Zygvi762Zu68xJCJLIIOQdMhsv3EZPerg9E/El
         +f/nH0T6d9m9idHYJXLNi1qNL1tSacKpX/gOpuPzvkZUu2+/U916r+cl5wcl1dnATqpV
         4Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VZNZ91Ufx6ojfiiT+ZYBRZsahy67A4bJ2OQndrGkqvw=;
        b=HX4SOez0zLc/TCVkrA4QIPTdaS6pnevGX1qRW2DmAUuOpQUuVuIz0IygExjwoO0Nj9
         oUE0WZnxa9vYavfan7klEIU5c9VtozIEY4GS0km/vjULsAl3qpf8YTzg8BWdP8OSJwqX
         u03xW52/Gqhh0NQVHH6Cih3IdceKeHbha9WocJPdIKlx72y8kEmiD0EQrjr0LxW6bNox
         wCbsAWl0DhMiZoNsxfhBRcoJLapEZoOD0cL+BWZ2cy31qMiZ2cIbZRvf6F1YFa8Pzq9/
         FNZWfSAiVfS8zVBrMYrYDLLPQsWT0saKoOxRMRyaVhz9h74fkheI8OQxGKC4pBFSMNLn
         ++rQ==
X-Gm-Message-State: AOAM533bWDMHdT8aYhRWUE094KR73coWcP1qx6L7WgLHcr4PDwwZ6fZl
        FOLYgQlwnD1t6N4EdVIWKyI=
X-Google-Smtp-Source: ABdhPJyNvWX5NnnpSSlpfSVj4ZmLvfiZUcS46+w0anQr3yWLoRT6w2fGIF+x7Bzmy6J8QO/7sRO4Aw==
X-Received: by 2002:ac2:43dc:: with SMTP id u28mr22896333lfl.17.1593801995826;
        Fri, 03 Jul 2020 11:46:35 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:35 -0700 (PDT)
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
Subject: [PATCH v4 16/20] backlight: jornada720_bl: introduce backlight_is_blank()
Date:   Fri,  3 Jul 2020 20:45:42 +0200
Message-Id: <20200703184546.144664-17-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use the backlight_is_blank() helper to simplify the code a bit.
This add support for fb_blank as a side-effect.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
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

