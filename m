Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0521F63B93
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2019 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfGITAS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jul 2019 15:00:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44690 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfGITAQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jul 2019 15:00:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so9906566pgl.11
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2019 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T12A56st4U6xMjv9tNrkzq8tQL5jOdbBhnZMauX8Bws=;
        b=SI2rCAS72N9CLesCndW5GOG2uj6BrMPw1IuIl2eGt1duNnrycvb0HSTo7g2HFa1dw6
         jre8ouKqMScn+GMJN2aW8u5WpdLg/vvwtRO68eGyrvh+hIhbuIR2XNab2JOlmMjR9svO
         NzG03XiTXHzv8UWz60/01C2e7bjXzIlH5mj70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T12A56st4U6xMjv9tNrkzq8tQL5jOdbBhnZMauX8Bws=;
        b=VwVA2Zhw5WTse59fJ4Db5OySAwE5ulE7yzkCyo6PyMLzoD9utXhCga8y7uXmt1etqL
         JyOV/1g0V0BzCFjqL2udXeuAy8FTE85G7bsZhDH6FzFdrLWHDvOV2PdLa7/Cd0rzxCW8
         dhoCrWv7lvRLg6fZ6uwDbM8nGyLiB2dwZMaPPoa/OARLiKrEyU5Y6Tj7gW/zliT8rNdg
         39zs0t86WLIh1CuiSaluW7LIU8wd2Azw9zbWR/P0ppfzdHs/llgXFW4YQlZ1Q5mYx+GW
         5qwFZfjUptQNJwM+1bMK/s3o61q0Imh1aGN9I2HobSH99BXsFl+gH0EHkAaWzQf1BGut
         w81A==
X-Gm-Message-State: APjAAAVPnOi1PX2+zIZYurS0rNpmbeCTfZSMVQPOLkQHhToTV5RtDKyg
        THgxG7vwvbBnvfx/fHXqgozd9A==
X-Google-Smtp-Source: APXvYqyEa4ryD7UuELRziTCBGlJ9o4biH2jBafr0m0ioDSkfIt9v3ZzlZ12RUj4fyPMeD5pAkrk6Hw==
X-Received: by 2002:a63:7519:: with SMTP id q25mr439220pgc.13.1562698815766;
        Tue, 09 Jul 2019 12:00:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b15sm20363265pfi.141.2019.07.09.12.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:00:15 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Date:   Tue,  9 Jul 2019 12:00:05 -0700
Message-Id: <20190709190007.91260-3-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190709190007.91260-1-mka@chromium.org>
References: <20190709190007.91260-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Backlight brightness curves can have different shapes. The two main
types are linear and non-linear curves. The human eye doesn't
perceive linearly increasing/decreasing brightness as linear (see
also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
linearly to human eye"), hence many backlights use non-linear (often
logarithmic) brightness curves. The type of curve currently is opaque
to userspace, so userspace often uses more or less reliable heuristics
(like the number of brightness levels) to decide whether to treat a
backlight device as linear or non-linear.

Export the type of the brightness curve via the new sysfs attribute
'scale'. The value of the attribute can be 'linear', 'non-linear' or
'unknown'. For devices that don't provide information about the scale
of their brightness curve the value of the 'scale' attribute is 'unknown'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Feel free to suggest improvements in the documentation :)

Changes in v3:
- removed composite strings, only keep 'linear', 'non-linear' and
  'unknown'
- updated sysfs attribute documentation
- updated commit message

Changes in v2:
- changed order of brightness scale enums, explicitly make 'unknown' zero
- minor update of commit message
- deleted excess blank line after 'backlight_scale_types'
- s/curves/curve/ in sysfs doc
---
 .../ABI/testing/sysfs-class-backlight         | 26 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/video/backlight/backlight.c           | 19 ++++++++++++++
 include/linux/backlight.h                     |  8 ++++++
 4 files changed, 54 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentation/ABI/testing/sysfs-class-backlight
new file mode 100644
index 000000000000..3ab175a3f5cb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight
@@ -0,0 +1,26 @@
+What:		/sys/class/backlight/<backlight>/scale
+Date:		July 2019
+KernelVersion:	5.4
+Contact:	Daniel Thompson <daniel.thompson@linaro.org>
+Description:
+		Description of the scale of the brightness curve.
+
+		The human eye senses brightness approximately logarithmically,
+		hence linear changes in brightness are perceived as being
+		non-linear. To achieve a linear perception of brightness changes
+		controls like sliders need to apply a logarithmic mapping for
+		backlights with a linear brightness curve.
+
+		Possible values of the attribute are:
+
+		unknown
+		  The scale of the brightness curve is unknown.
+
+		linear
+		  The brightness changes linearly with each step. Brightness
+		  controls should apply a logarithmic mapping for a linear
+		  perception.
+
+		non-linear
+		  The brightness changes non-linearly with each step. Brightness
+		  controls should use a linear mapping for a linear perception.
diff --git a/MAINTAINERS b/MAINTAINERS
index d51e74340870..c46812510ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2858,6 +2858,7 @@ F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 F:	Documentation/devicetree/bindings/leds/backlight
 F:	Documentation/ABI/stable/sysfs-class-backlight
+F:	Documentation/ABI/testing/sysfs-class-backlight
 
 BATMAN ADVANCED
 M:	Marek Lindner <mareklindner@neomailbox.ch>
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 1ef8b6fd62ac..277abc76c83a 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -32,6 +32,12 @@ static const char *const backlight_types[] = {
 	[BACKLIGHT_FIRMWARE] = "firmware",
 };
 
+static const char *const backlight_scale_types[] = {
+	[BACKLIGHT_SCALE_UNKNOWN]	= "unknown",
+	[BACKLIGHT_SCALE_LINEAR]	= "linear",
+	[BACKLIGHT_SCALE_NON_LINEAR]	= "non-linear",
+};
+
 #if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
 			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
 /* This callback gets called when something important happens inside a
@@ -246,6 +252,18 @@ static ssize_t actual_brightness_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(actual_brightness);
 
+static ssize_t scale_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct backlight_device *bd = to_backlight_device(dev);
+
+	if (WARN_ON(bd->props.scale > BACKLIGHT_SCALE_NON_LINEAR))
+		return sprintf(buf, "unknown\n");
+
+	return sprintf(buf, "%s\n", backlight_scale_types[bd->props.scale]);
+}
+static DEVICE_ATTR_RO(scale);
+
 static struct class *backlight_class;
 
 #ifdef CONFIG_PM_SLEEP
@@ -292,6 +310,7 @@ static struct attribute *bl_device_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_actual_brightness.attr,
 	&dev_attr_max_brightness.attr,
+	&dev_attr_scale.attr,
 	&dev_attr_type.attr,
 	NULL,
 };
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 0b5897446dca..c7d6b2e8c3b5 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -46,6 +46,12 @@ enum backlight_notification {
 	BACKLIGHT_UNREGISTERED,
 };
 
+enum backlight_scale {
+	BACKLIGHT_SCALE_UNKNOWN = 0,
+	BACKLIGHT_SCALE_LINEAR,
+	BACKLIGHT_SCALE_NON_LINEAR,
+};
+
 struct backlight_device;
 struct fb_info;
 
@@ -80,6 +86,8 @@ struct backlight_properties {
 	enum backlight_type type;
 	/* Flags used to signal drivers of state changes */
 	unsigned int state;
+	/* Type of the brightness scale (linear, non-linear, ...) */
+	enum backlight_scale scale;
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
-- 
2.22.0.410.gd8fdbe21b5-goog

