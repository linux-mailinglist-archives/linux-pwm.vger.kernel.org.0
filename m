Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64511E9E9B
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFAGwq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFAGwp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE43C061A0E;
        Sun, 31 May 2020 23:52:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z18so6709181lji.12;
        Sun, 31 May 2020 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjiBPif2aC324+vDH5W7L3OnbFVYWltMaLDt/zt0WxE=;
        b=mtY7E35P7NMSOhp9i+6bfaqRO2BlrKF2/SCdxL4Wo+C/dxcNueZ/8rL6drsV5Qk4ms
         OBZHTwJMwRh3vvlu1nl9mBpequPzPsTggrEfpwP84EHz2HBpIB9avd6RWb23Qqp2sjkZ
         Pb04vSzZr1FEM/sZ8OBTs38Gh1DDOLFSM1Ujn+0t7oUMdCNm9bVm2M0EIeSGSnwt45KB
         6Y/glw6EfVkRqqZhnjpU+wNvUkQRAf/gun9TNPiJ1plRGvTPhUJ5Gd9V7gakd43XkzX4
         tNhtDSKq6ZvNVi01I14PkmXvUCoLKioBy7SAaHwC79131X0KVxC3qKFBFsgkuxrePiiE
         nX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NjiBPif2aC324+vDH5W7L3OnbFVYWltMaLDt/zt0WxE=;
        b=Vtkx1uzQTWZ1C2TgmC+7t/ZE3uNgipBa10QFfmojFh19+rNLtMafGMGIP5nZlawuxl
         AbZyBLjypDNA4HAbc4ukT1pufkYeR8HgdaANJwhS4SysgtOmZapGG7kh30iBmCdw3nBd
         +B57x2dv6D8we2T9M0rNQWaWVUXXhpWSz1D0TxywV4lSxygKJdZfzbkYbnRsBZ6qa/l1
         vIfpdrEE9OmvTp+d8NyE16n+6mwG3yEXD0+IKfVlS1/bOy3DF4yoQVIa+c8K5LJHlDxu
         DJCxa9V0xQh8HQ3XPlAek/yYApkU7L5m5EkhwvaSF5d+HngZsdra8Ai0Q37q0p1D9bSS
         jqyA==
X-Gm-Message-State: AOAM532xOYN+keFy9fH15XCkVVMhtU+ZhGmC0gxN746u/nMKPz3Pu+sl
        EydlrPTWBGxcfTcQt8c1r7k=
X-Google-Smtp-Source: ABdhPJy7GQRKVdKefzETWFNpD9tAcpKEGeCIQ2ORhC0pwxa34K7ayOx8SXEcMeR6aBbHrE77mAFjFQ==
X-Received: by 2002:a2e:8044:: with SMTP id p4mr10445457ljg.151.1590994362678;
        Sun, 31 May 2020 23:52:42 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:42 -0700 (PDT)
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
Subject: [PATCH v3 12/13] backlight: as3711_bl: introduce backlight_is_blank()
Date:   Mon,  1 Jun 2020 08:52:06 +0200
Message-Id: <20200601065207.492614-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Replaces the open-coded checks of the state, with the
backlight_is_blank() helper. This increases readability
of the code and aling the functionality across the drivers.

Futhermore drop the debug prints in update_status().
If we need debug printing then we can add it to the backlight core.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/video/backlight/as3711_bl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 33f0f0f2e8b3..cc5628beaffd 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -107,13 +107,7 @@ static int as3711_bl_update_status(struct backlight_device *bl)
 	int brightness = bl->props.brightness;
 	int ret = 0;
 
-	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
-		__func__, bl->props.brightness, bl->props.power,
-		bl->props.fb_blank, bl->props.state);
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+	if (backlight_is_blank(bl))
 		brightness = 0;
 
 	if (data->type == AS3711_BL_SU1) {
-- 
2.25.1

