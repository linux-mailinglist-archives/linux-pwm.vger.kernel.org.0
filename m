Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287301D6BF5
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgEQTCI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88BC061A0C;
        Sun, 17 May 2020 12:02:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o14so7545631ljp.4;
        Sun, 17 May 2020 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TTbU+Xfbr8sJK5FSRi+ZS9sNODpYRd7hPkrg71kTQk=;
        b=mem+bAKqNu0CayFuu/pOujHPTFzqrTSq19SXLt7V8VOxzrSSnmGVnzvwm33jjb29NN
         rCRvWoTNDt6Mc4ExvCRFs8YBnKDxtPmo21dTWmhXBOrmB5KZcC3AN434I/zf1Jj4FQc8
         s2w/M+NIfHqyRC21Mk/hMm1o2S6YKgsMLbdfy+vAGyoh05xFzWs1EShSQ4Xnk3GrIFgw
         3Jo8THhs/QNFkRKOCncxUFQEc/fKNyrJ9qfXqecoBheQ/d6D5HIhyqyjGXASreCrfZJV
         U9n62m+XxgGor13L0+fJ0zwqQRRMW5z4CexR81BO399CBpoXEdnjMrLSUQ/oKHJy1Csv
         KXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+TTbU+Xfbr8sJK5FSRi+ZS9sNODpYRd7hPkrg71kTQk=;
        b=LzBHdcX5XUlpbNKwM8v83xcxNlrmAvpA5Sh1h8gENrWaM6lpLnODCYE/tI6zqHQs8k
         JaB9/8qH2+I8bmQgGedebWhKyCZvip1xh26LzVjTIyk99duqD3ChePA6JqTntLNNrzJC
         R0qqTl1bLOwkzu7zE3o4ca050zSyoPe6RFgLN05enUzAKIj4vV7+nGk1RtFglMw0Rwh3
         w0Y1kGUIIPxTkFKuS8Qihsqbbq24HuER8yZViIZ4Torhwv2R9hbVdmxOWeWj4ccMov2K
         Keng+jBKP0au9HIZ+VV5+vnZmc4wu/BAVVCjDtiO1xPbOKWoFdLbDHUZcHFMT9ThByBj
         VCuw==
X-Gm-Message-State: AOAM530r7pIGc43yUbhPgqpYCjhEdEed1VXhJTnuHsS8RaFyZ4LJfHl2
        pJehO4iCd1ssy2GAmS2WYUY=
X-Google-Smtp-Source: ABdhPJw3X5XXPLmjACBeaAtO1reBVwPhG7KACDi04P8E5dwChHnTLGrWmlkDy8d6D3PZEDu1vHiLCA==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr8260961ljj.249.1589742125781;
        Sun, 17 May 2020 12:02:05 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:05 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 07/16] backlight: document inline functions in backlight.h
Date:   Sun, 17 May 2020 21:01:30 +0200
Message-Id: <20200517190139.740249-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for the inline functions in backlight.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index e2d72936bf05..98349a2984dc 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -283,6 +283,10 @@ struct backlight_device {
 	int use_count;
 };
 
+/**
+ * backlight_update_status - force an update of the backligt device status
+ * @bd: the backlight device
+ */
 static inline int backlight_update_status(struct backlight_device *bd)
 {
 	int ret = -ENOENT;
@@ -375,6 +379,18 @@ extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
+/**
+ * bl_get_data - access devdata
+ * @bl_dev: pointer to backlight device
+ *
+ * When a backlight device is registered the driver has the possibility
+ * to supply a void * devdata. bl_get_data() return a pointer to the
+ * devdata.
+ *
+ * RETURNS:
+ *
+ * pointer to devdata stored while registering the backlight device.
+ */
 static inline void * bl_get_data(struct backlight_device *bl_dev)
 {
 	return dev_get_drvdata(&bl_dev->dev);
-- 
2.25.1

