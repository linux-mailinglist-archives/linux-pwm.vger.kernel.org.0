Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C555213F88
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGCSqb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgGCSqb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB7C061794;
        Fri,  3 Jul 2020 11:46:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so33478310lji.12;
        Fri, 03 Jul 2020 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuNmp2Y8twclxYeBZp9lqPlgdVdohaDn7/kP95qzQpY=;
        b=kK9IT2VP55hji7w3/BPDLgv5S1BIM2VNWRPFZIgGj+pAQViasT2BzK72Q2m6YUvVH8
         t/I6KFLwVacqpCFWKF+aCBrTNuHmcgP0/vAbplT6/Ggvkuf91DEHeaH64Pw1pV13ZeK1
         ZLPwGz4UG31u9GgK5ghjIGp8j3pBywRL9FKk1Xqu4zsvpIUf819HT3xjV/667+MQ752t
         JhaleG7ou2hlANhNQmSJmNrAHwNNkBhuREnz1Oc9OdKIqMffLZjCG3sA00bmd6JRQtyq
         z/wJG9+GIV3Zt7hWIui9V6yowJKpARl7old5SfFOeUZ3or/5MBU/6Imc2W6DIvvxwvxE
         fdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cuNmp2Y8twclxYeBZp9lqPlgdVdohaDn7/kP95qzQpY=;
        b=LWkYoqUgqPJ14TPyVorpN/b7EFvwoPHVulfNtvxAJ7sVfBewOk2O9fB47ERCVfwU94
         PxlS1xXEczvL2RKAzNSJihysXnvZX08KFZetO1fLzEkDAzbzT7/7OoJQf1aulzZsSzx6
         XKtvyektY/3rTzu9MKOtrHDqNFaGV6/43seqAuwoGkvSNiDdTDuu+h80UgvSkLmTn1Vv
         7Xnb2srjnpcYM2wo5FYBlgspu0AZnNZ41E42S5JnbdByGJSiiaIYlrYqd7mQ4peLWCiR
         2ei2q7nqNND0zjVIQUNWHaM5g6sHDcN17BHKWDzMPfU2RdJpCUxnmHFfESL4Yb0RDgjr
         +9vQ==
X-Gm-Message-State: AOAM532s2OufQNNIGPhfz0nvRlYmESC0LXyXtiGriASlCuMPUVEvMPcR
        oIHhsw4LzQSvnGgoqFGraJxo9q6XQbQ=
X-Google-Smtp-Source: ABdhPJyBGH29SvxYyw0NjjWdvgwbdFGb97e14xVHDWd3nm3sy4Dj+wDXJFZR2VJ9zNEY+qr7qlaf+g==
X-Received: by 2002:a2e:8092:: with SMTP id i18mr13181844ljg.265.1593801989670;
        Fri, 03 Jul 2020 11:46:29 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:29 -0700 (PDT)
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
Subject: [PATCH v4 13/20] backlight: as3711_bl: simplify update_status
Date:   Fri,  3 Jul 2020 20:45:39 +0200
Message-Id: <20200703184546.144664-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Replaces the open-coded checks of the state, with the
backlight_get_brightness() helper. This increases readability
of the code and align the functionality across the drivers.

Futhermore drop the debug prints in update_status().
If we need debug printing then we can add it to the backlight core.

v2:
  - Use backlight_get_brightness()

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/video/backlight/as3711_bl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 33f0f0f2e8b3..3b60019cdc2b 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -104,17 +104,10 @@ static int as3711_bl_update_status(struct backlight_device *bl)
 	struct as3711_bl_data *data = bl_get_data(bl);
 	struct as3711_bl_supply *supply = to_supply(data);
 	struct as3711 *as3711 = supply->as3711;
-	int brightness = bl->props.brightness;
+	int brightness;
 	int ret = 0;
 
-	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
-		__func__, bl->props.brightness, bl->props.power,
-		bl->props.fb_blank, bl->props.state);
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
+	brightness = backlight_get_brightness(bl);
 
 	if (data->type == AS3711_BL_SU1) {
 		ret = as3711_set_brightness_v(as3711, brightness,
-- 
2.25.1

