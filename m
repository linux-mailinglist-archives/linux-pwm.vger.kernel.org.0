Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B41E9E8E
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFAGwi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFAGwi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F4C061A0E;
        Sun, 31 May 2020 23:52:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u10so5510709ljj.9;
        Sun, 31 May 2020 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTAgQ0/+by/AFCHtw1iOg7GKteKKQa3tJwaqwJToo1s=;
        b=pT3RA9tpY/ttV+F7JpvmxfJbJnSZSfBhqafI59EsUccx1b1tYuvoUDNRs5Vo7tnxOe
         qecKoCV9H6Ri3NKNFmtFYyTq+R3V3gQZ+xGnTTEVta3UIgi1JOmB/x+dtLjEoAt8C6q4
         t7Y4yqcG+h0R8J5KTxPRwM+mTP9KjnEdCLyy24UqY+7se1bDYK6a+y2d3FEXNexGIs9j
         pJqB7Vo8V2tmyJGgF3Wx/4zdbcr92ufm130gqJ0AGirICGeAj6m8Y7uXD2V+DCWSS+uj
         pwYAQQQBc5UL5/iV9dXIB+bBipimkJGzCLLPNGfjs9DBPf9LMF+w9eH/AokUH2QHxFuh
         zETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VTAgQ0/+by/AFCHtw1iOg7GKteKKQa3tJwaqwJToo1s=;
        b=ee8rXP2HNhnnyd5fFWGUe9tmG/Ty9QSWj+H2LtoIeIVSOVvri450BtBQBBqjxMMeyd
         SncBTQt+i2BLDIbUdmvzkhpGH7YyGyfeFwHWGr+98AyKAwVEzHn+ssMidcQeZqKwxRp6
         ejI9Xax4wKcPjEou4hllr0Cku3YNyBGAOLebgAokToQ5RTLM8gG1PxDj4M+v98FR1aNW
         mlYTFr6TZtzORJSBF/jqroJyyC0Doyw4P/QR0s/yHWztEa6vmRqJWZlHkqMY6SZN7/p+
         BNEDg51gajYJ6/3FQ/IPwn9jNn8XSW86SHiw+O+tQUxTNvESUms8P+bfGRz4070v2daR
         zvgw==
X-Gm-Message-State: AOAM533RNKGN1vlIvXiA7bkS6Am1f8iyeEjtIU6nM/BITjAnClbmQkNM
        tm/lYR2njZXbXr1kyAEtc1s=
X-Google-Smtp-Source: ABdhPJzl8Fs749+ZgMHWRo08UWn6h05dlQMe31AthZ5mkRyww2y2SCrZPCwPjKghl3VnvYogfvbsAA==
X-Received: by 2002:a2e:868d:: with SMTP id l13mr2107229lji.306.1590994356092;
        Sun, 31 May 2020 23:52:36 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:35 -0700 (PDT)
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
Subject: [PATCH v3 09/13] backlight: drop extern from prototypes
Date:   Mon,  1 Jun 2020 08:52:03 +0200
Message-Id: <20200601065207.492614-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

No need to put "extern" in front of prototypes.
While touching the prototypes adjust indent to follow
the kernel style.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 6bd981a600ef..25a3aac89618 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -417,22 +417,25 @@ static inline bool backlight_is_blank(struct backlight_device *bd)
 	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
 }
 
-extern struct backlight_device *backlight_device_register(const char *name,
-	struct device *dev, void *devdata, const struct backlight_ops *ops,
-	const struct backlight_properties *props);
-extern struct backlight_device *devm_backlight_device_register(
-	struct device *dev, const char *name, struct device *parent,
-	void *devdata, const struct backlight_ops *ops,
-	const struct backlight_properties *props);
-extern void backlight_device_unregister(struct backlight_device *bd);
-extern void devm_backlight_device_unregister(struct device *dev,
-					struct backlight_device *bd);
-extern void backlight_force_update(struct backlight_device *bd,
-				   enum backlight_update_reason reason);
-extern int backlight_register_notifier(struct notifier_block *nb);
-extern int backlight_unregister_notifier(struct notifier_block *nb);
-extern struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
-extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned long brightness);
+struct backlight_device *
+backlight_device_register(const char *name, struct device *dev, void *devdata,
+			  const struct backlight_ops *ops,
+			  const struct backlight_properties *props);
+struct backlight_device *
+devm_backlight_device_register(struct device *dev, const char *name,
+			       struct device *parent, void *devdata,
+			       const struct backlight_ops *ops,
+			       const struct backlight_properties *props);
+void backlight_device_unregister(struct backlight_device *bd);
+void devm_backlight_device_unregister(struct device *dev,
+				      struct backlight_device *bd);
+void backlight_force_update(struct backlight_device *bd,
+			    enum backlight_update_reason reason);
+int backlight_register_notifier(struct notifier_block *nb);
+int backlight_unregister_notifier(struct notifier_block *nb);
+struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
+int backlight_device_set_brightness(struct backlight_device *bd,
+				    unsigned long brightness);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
-- 
2.25.1

