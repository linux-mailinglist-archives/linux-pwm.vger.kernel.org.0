Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54B51C5F
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 22:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfFXUbf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 16:31:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42910 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbfFXUbY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 16:31:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so8157621pff.9
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cvCddzp/rQ9gLoVz2Ohmj6GbBYXrvNQEIWOBydlqbk=;
        b=RGTicdS+MgEOYEAHS+smvnz8GlVq6o2y1HVT5Balw5Aa4KWF33hdyuiXxr/N1xo7F+
         Cjtl6Fev/1MRaF2vXjK9cwelIWWrUlUxQlbN+bA/ht0z5aX334sPz3PdN4Abm+SWsTsG
         RpsNTk8Sl4N4t1+uRfbQo6YN+2AA71bqGKxso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cvCddzp/rQ9gLoVz2Ohmj6GbBYXrvNQEIWOBydlqbk=;
        b=tnxuLvzqX0IFbYV2VS4OnlG2XcAzRulJZiT1WeSsPqsGWb2sMPLVLs5JuxSnds3zbn
         lyQOTN1VXy4EeaJjgllCyVZDH44ZVesec+GG2T63Iqebb5GcViBIXrJkfVnDjmEYQYeO
         pLXJwmAE//A4HHdIFtVLP1VEKMih2gcbEWOpukg1EkKubdi4ko2e1/Hz19rmRh79tqWm
         lHCJR3e1+3xI/ZC8oH5uAbybU+wOUrgxzGUBZuS7D7ckzg3XkuiRGwaMfzETTQ+cLLnQ
         zUQuXDSqcas4KIgTDkVQPuzPOazwmHhuqcBeE2SzI7MGK3vSG7u/Lfnj34W8rEWvOyT5
         2lfA==
X-Gm-Message-State: APjAAAVmMQ7/BdxRjTJH8+ux3lX0uzA9akINFQK9nA2OzcwJVccwbnfM
        Sfur6WCt5JIgBgnZ3I+V6Zc7dQ==
X-Google-Smtp-Source: APXvYqztkGD2Zm1lhfUGrYuukC/zkqi/1wiD2UFCDCf7MnzGHMPiBOntzubbs4r7XKjVQ5JRS7vvPw==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr27137163pjc.10.1561408283171;
        Mon, 24 Jun 2019 13:31:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c98sm315435pje.1.2019.06.24.13.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:22 -0700 (PDT)
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
Subject: [PATCH v2 2/4] backlight: Expose brightness curve type through sysfs
Date:   Mon, 24 Jun 2019 13:31:11 -0700
Message-Id: <20190624203114.93277-3-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
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
'scale'. The value of the attribute may be a simple string like
'linear' or 'non-linear', or a composite string similar to
'compatible' strings of the device tree. A composite string consists
of different elements separated by commas, starting with the
most-detailed description and ending with the least-detailed one. An
example for a composite string is "cie-1931,perceptual,non-linear"
This brightness curve was generated with the CIE 1931 algorithm, it
is perceptually linear, but not actually linear in terms of the
emitted light. If userspace doesn't know about 'cie-1931' or
'perceptual' it should at least be able to interpret the 'non-linear'
part.

For devices that don't provide information about the scale of their
brightness curve the value of the 'scale' attribute is 'unknown'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- changed order of brightness scale enums, explicitly make 'unknown' zero
- minor update of commit message
- deleted excess blank line after 'backlight_scale_types'
- s/curves/curve/ in sysfs doc
---
 .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/video/backlight/backlight.c           | 21 ++++++++++++
 include/linux/backlight.h                     | 10 ++++++
 4 files changed, 64 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentation/ABI/testing/sysfs-class-backlight
new file mode 100644
index 000000000000..da1ce9e5c55a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-backlight
@@ -0,0 +1,32 @@
+What:		/sys/class/backlight/<backlight>/scale
+Date:		June 2019
+KernelVersion:	5.4
+Contact:	Daniel Thompson <daniel.thompson@linaro.org>
+Description:
+		Description of the scale of the brightness curve. The
+		description consists of one or more elements separated by
+		commas, from the most detailed to the least detailed
+		description.
+
+		Possible values are:
+
+		unknown
+		  The scale of the brightness curve is unknown.
+
+		linear
+		  The brightness changes linearly in terms of the emitted
+		  light, changes are perceived as non-linear by the human eye.
+
+		non-linear
+		  The brightness changes non-linearly in terms of the emitted
+		  light, changes might be perceived as linear by the human eye.
+
+		perceptual,non-linear
+		  The brightness changes non-linearly in terms of the emitted
+		  light, changes should be perceived as linear by the human eye.
+
+		cie-1931,perceptual,non-linear
+		  The brightness curve was calculated with the CIE 1931
+		  algorithm. Brightness changes non-linearly in terms of the
+		  emitted light, changes should be perceived as linear by the
+		  human eye.
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
index 1ef8b6fd62ac..86612ec42ed0 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -32,6 +32,14 @@ static const char *const backlight_types[] = {
 	[BACKLIGHT_FIRMWARE] = "firmware",
 };
 
+static const char *const backlight_scale_types[] = {
+	[BACKLIGHT_SCALE_UNKNOWN]	= "unknown",
+	[BACKLIGHT_SCALE_LINEAR]	= "linear",
+	[BACKLIGHT_SCALE_NON_LINEAR]	= "non-linear",
+	[BACKLIGHT_SCALE_PERCEPTUAL]	= "perceptual,non-linear",
+	[BACKLIGHT_SCALE_CIE1931]	= "cie-1931,perceptual,non-linear",
+};
+
 #if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
 			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
 /* This callback gets called when something important happens inside a
@@ -246,6 +254,18 @@ static ssize_t actual_brightness_show(struct device *dev,
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
@@ -292,6 +312,7 @@ static struct attribute *bl_device_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_actual_brightness.attr,
 	&dev_attr_max_brightness.attr,
+	&dev_attr_scale.attr,
 	&dev_attr_type.attr,
 	NULL,
 };
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 0b5897446dca..94d3559cd968 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -46,6 +46,14 @@ enum backlight_notification {
 	BACKLIGHT_UNREGISTERED,
 };
 
+enum backlight_scale {
+	BACKLIGHT_SCALE_UNKNOWN = 0,
+	BACKLIGHT_SCALE_LINEAR,
+	BACKLIGHT_SCALE_NON_LINEAR,	/* needed for backwards compatibility */
+	BACKLIGHT_SCALE_PERCEPTUAL,
+	BACKLIGHT_SCALE_CIE1931,
+};
+
 struct backlight_device;
 struct fb_info;
 
@@ -80,6 +88,8 @@ struct backlight_properties {
 	enum backlight_type type;
 	/* Flags used to signal drivers of state changes */
 	unsigned int state;
+	/* Type of the brightness scale (linear, non-linear, ...) */
+	enum backlight_scale scale;
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
-- 
2.22.0.410.gd8fdbe21b5-goog

