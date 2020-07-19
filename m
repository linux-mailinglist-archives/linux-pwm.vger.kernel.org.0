Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55069225086
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgGSIII (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C75C0619D2;
        Sun, 19 Jul 2020 01:08:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so17105713lji.2;
        Sun, 19 Jul 2020 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0SPsNNLLDKNzMQANE5E5Oyzv60rxxHp94XasELHeFk=;
        b=FAYHsxMfA7LSjuJ9SNKNKjT6muVZ086wH8lblSVm7uEVA5bk5/4XKprjx44PQ4ye9i
         CsDOprIILwui5Vv8gYUNzaF0SdJ7Xc0F+gCOL+DY9UQp3Jb1kMWB5QM1RivQJYzVJcRI
         I+bqt10R4kaJIfFsnJCWxjsVnflMHGid2KrBExd0MpMh+dD5+DzMgVi0mymN11+lp6J8
         Nkh9Tk6xxJUJJivwKb6+5muH1s6LftMsbS8fPcpCuyrWuLrSH3nludTS3jsbEqiCykcR
         eHCpr3fyaFDN5rA8xPhRMY6+Ek1yB7N6TuGuWPOK+31tbzlkGeX+xL+6Ozi7rctl5rMm
         x5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=O0SPsNNLLDKNzMQANE5E5Oyzv60rxxHp94XasELHeFk=;
        b=SI5ErwrK7d6FYwGsu5v4thU/b1onb+gnqx34p/iBmklLe+Lo55MgQm7x/U5Iqu8HR2
         T3tx4M7cPd/b7PjHsMdNpry2NmPyGdkm9J0wCY3xazc98PZhcpFGrVIvuroXzbilbC4T
         cWORhbOzQqePKKQmrtcMlROR8CilpK395wCYk0aZ60XmYfjJ27fImfYFic3qWVArt0Lt
         MxFHORtDv2egi9jSBuU6l0MbdjfOHj1wPxUOqRU9yDPzKoZ4UCgJgwNqrwgYAEOmXdOW
         ERew1plfwTJMwaJ1LMW0IGYfCdbFFzc1uP5YmotGgWpCDNTTFVOXE8EDWPrAynxe6B9U
         QO4A==
X-Gm-Message-State: AOAM531p6xej/8pNXK6b/kR6UmQgycO4ZMLpLtSCsN4IPyqWgoz07NQ0
        ix7tVp92BHMsSvJ6LtdV5GE=
X-Google-Smtp-Source: ABdhPJwrr27+mLQRzHwTEPcWxHY/5mguDpC10mIF1tbevGWDakKvIEcfc2iwgeOAYMGg04xNuXkK2A==
X-Received: by 2002:a05:651c:88:: with SMTP id 8mr7335618ljq.136.1595146085762;
        Sun, 19 Jul 2020 01:08:05 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:05 -0700 (PDT)
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
Subject: [PATCH v5 02/19] backlight: add backlight_is_blank()
Date:   Sun, 19 Jul 2020 10:07:26 +0200
Message-Id: <20200719080743.8560-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The backlight support has three properties that express the state:
- power
- state
- fb_blank

It is un-documented and easy to get wrong.
Add backlight_is_blank() helper to make it simpler
for drivers to get the check of the state correct.

A lot of drivers also includes checks for fb_blank.
This check is redundant when the state is checked
and thus not needed in this helper function.
But added anyway to avoid introducing subtle bugs
due to the creative use of fb_blank in some drivers.
Introducing this helper will for some drivers results in
added support for fb_blank. This will be a change in
functionality, which will improve the backlight driver.

Rolling out this helper to all relevant backlight drivers
will eliminate almost all accesses to fb_blank.

v5:
  - Improved changelog, added fb_blank to properties
    that express state (Daniel)

v4:
  - struct backlight_device * is now const

v3:
  - Clarified that the fb_blank support in
    backlight_is_blank() may result in functionality
    changes for the users (Emil)

v2:
  - Added fb_blank condition (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 56e4580d4f55..56e51ebab740 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -175,6 +175,25 @@ static inline void backlight_put(struct backlight_device *bd)
 		put_device(&bd->dev);
 }
 
+/**
+ * backlight_is_blank - Return true if display is expected to be blank
+ * @bd: the backlight device
+ *
+ * Display is expected to be blank if any of these is true::
+ *
+ *   1) if power in not UNBLANK
+ *   2) if fb_blank is not UNBLANK
+ *   3) if state indicate BLANK or SUSPENDED
+ *
+ * Returns true if display is expected to be blank, false otherwise.
+ */
+static inline bool backlight_is_blank(const struct backlight_device *bd)
+{
+	return bd->props.power != FB_BLANK_UNBLANK ||
+	       bd->props.fb_blank != FB_BLANK_UNBLANK ||
+	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
+}
+
 extern struct backlight_device *backlight_device_register(const char *name,
 	struct device *dev, void *devdata, const struct backlight_ops *ops,
 	const struct backlight_properties *props);
-- 
2.25.1

