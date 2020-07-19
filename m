Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E1225096
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgGSIIS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFAC0619D2;
        Sun, 19 Jul 2020 01:08:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x9so17028880ljc.5;
        Sun, 19 Jul 2020 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMIhGECQ39mxsFBNf2RZfIR0vNjqITM52PNfMW2B2fM=;
        b=DrMCaLN734Ri4P8SqhdAMQEzdVLEPUC0MbptJBkJOnJWDe8EH1rk+SQWDmT3yoWYvs
         7KqXeMmpHxTy9CDma8rd9kRmSY5z/Okp5TWV+MjNhlmA5gK0FAhVYtv4WcKOFlnPzNF1
         3BbrfZ/FgOljtsOUcVipDIjOHZE+o7twRqZFPcUCa9eS1gfikEY6L+edCgRcECKJzBNu
         dXaUbib8vR9jC3nECUUdBjiLzCf8XuMa0Y9SJ6v4i7X7PSssefA6DANpkmRPkDGHgi6A
         mNqr00GuAbVbEq04HWnjnV0DZguN3vK5OlGYOG78UbW631bJBUoeGTD8Nqrp9qPKPn6i
         TWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QMIhGECQ39mxsFBNf2RZfIR0vNjqITM52PNfMW2B2fM=;
        b=UJQKloptQ5RYY9MMfBqe7JJtuIEPH5PF/XVGHKcOgRAx1yskVrHj5+r9LSG85MzVWR
         jgG4XQ+qB4TF+fBUEZPQUwRn1+IDMi0RPSGUa3dspkDt0SF1MHFRQArJDvFsdlHKF2aa
         K4iS824n3/8pkxvP2RzMteED0hHJyMQGC6gd2D5MH2kiMcPn8XqZ/ehnoajNofGZ1dld
         pIcUTJW64hTtb8dlHwdWuq2yKyTPKT8sxAp6bt7G9fxKGwopk3rcjVbBXa3lQjJxzMtb
         ShU8ImUvh/dZdRMU+M0tGJF26ZyGH2z8U4OBssTgKzcspxejEb6NGN/CFQOpBmRmHoV5
         sAwg==
X-Gm-Message-State: AOAM530D4zYSAsNtjqlaYko3zbtYSZg5HbuCrnCyOtdGZ3XjkcUFk84e
        YDQpG5wbmalOwePu73/lB8s=
X-Google-Smtp-Source: ABdhPJykvLiMLexX3kWmPLDd9DX4t2wM3QhET+M7lM4xMxR7y0hTe4TGEX4+xcoiOxnSENfu2ss8sQ==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr8270437ljj.143.1595146095864;
        Sun, 19 Jul 2020 01:08:15 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:15 -0700 (PDT)
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
Subject: [PATCH v5 09/19] backlight: drop extern from prototypes
Date:   Sun, 19 Jul 2020 10:07:33 +0200
Message-Id: <20200719080743.8560-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
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
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 8f2005a6f8a9..c6ac4cbb9ddb 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -417,23 +417,26 @@ static inline bool backlight_is_blank(const struct backlight_device *bd)
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
 struct backlight_device *backlight_device_get_by_name(const char *name);
-extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned long brightness);
+struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
+int backlight_device_set_brightness(struct backlight_device *bd,
+				    unsigned long brightness);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
-- 
2.25.1

