Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7441D3CD7
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgENTK1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730289AbgENTK0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7FDC061A0C;
        Thu, 14 May 2020 12:10:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id o14so4776711ljp.4;
        Thu, 14 May 2020 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXcb5fvumjPwkXBdjr17g9fCe8HBhpUDprGnSWssRKA=;
        b=IDmHNpwe6d3mPVdhTHpjxh9kKdZR9F1sadb+SsnmpGwzd0wlt8H44GHCqgfXMvpDGx
         4fuyt72GdGn2OX5tNFsT5tkuNdTfT+7qSnfT08Udhz0dG52v0Gu7ixWZ2hqMj48BJbNA
         Zo0HY0D/+VFd2Wl1LKiVLUUKLaQpXoVPbzvq0q9OXNu7osS99tmo6Q7LwamfmruYgYhv
         YE+ugRnJJL/cC9iu86uwASoZS9tbauk0UqFGW9pCH5xgufkbi9Blb/r8s4Xt1z2TyPqZ
         C2NbdYCdTQ5ded9Yqx0AVyeB024sJTrxK3n97kF4UV8ZJVx6kjq1DShfT4W3lYQQFeke
         iDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JXcb5fvumjPwkXBdjr17g9fCe8HBhpUDprGnSWssRKA=;
        b=hUcuFJsdhhiB8SRpqD5z4IdJNvZ0ale1dSCPr7O/HCLJhVXXe67VD+CGulX3ag9VKM
         sC0h8vyMZ80c5Rxha0BfIstsirDlqkKD/c4DHPeGVIBaY/o9rCosnxLHYhq7rkvJvBLz
         lDnWPaEZ7ETMlnXqV/qj1ctRNY5ViC6R2iV970cGKNUA6K4KOAh80ELU5gkvOKVeaUOT
         0zCPrq/zt4fZyNmoh/dYz9pYx1BYcCkDYUA3ZdjvOhY0yH3mzoqQ1rE0+Tp3ZwUY3QjD
         hnUZLzmAbIyqjqwB9u2NpRhPKgJz4gOipxiKbveBMoPKg+qOwfQqTaFxbG/t0JeaNh5A
         R7WQ==
X-Gm-Message-State: AOAM5313dCvH5mkfAd9jl28/pKJwoXOU4OdPWXOmybCYsmlGJmRk+pDm
        syWgyRX0caBoJBB28QFuInc=
X-Google-Smtp-Source: ABdhPJwEfhzXKzDLCNWiv662wAHi0cNv35xPMR0eOeZHcYH2WYInKTWYkLQ0Ng5w3INxzAOG1XaPiQ==
X-Received: by 2002:a05:651c:97:: with SMTP id 23mr3892365ljq.17.1589483424521;
        Thu, 14 May 2020 12:10:24 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:23 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Allison Randal <allison@lohutok.net>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        Zheng Bin <zhengbin13@huawei.com>
Subject: [PATCH v1 05/18] backlight: drop backlight_put()
Date:   Thu, 14 May 2020 21:09:48 +0200
Message-Id: <20200514191001.457441-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of backlight_put().
Drop it and open code the two users in backlight.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c |  7 +++++--
 include/linux/backlight.h           | 10 ----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 511bb382c584..547aa3e1a03a 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -629,7 +629,10 @@ static struct backlight_device *of_find_backlight(struct device *dev)
 
 static void devm_backlight_release(void *data)
 {
-	backlight_put(data);
+	struct backlight_device *bd = data;
+
+	if (bd)
+		put_device(&bd->dev);
 }
 
 /**
@@ -657,7 +660,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
 		return bd;
 	ret = devm_add_action(dev, devm_backlight_release, bd);
 	if (ret) {
-		backlight_put(bd);
+		put_device(&bd->dev);
 		return ERR_PTR(ret);
 	}
 	return bd;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index a0f03bb322d7..3d757a850b88 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -165,16 +165,6 @@ static inline int backlight_disable(struct backlight_device *bd)
 	return backlight_update_status(bd);
 }
 
-/**
- * backlight_put - Drop backlight reference
- * @bd: the backlight device to put
- */
-static inline void backlight_put(struct backlight_device *bd)
-{
-	if (bd)
-		put_device(&bd->dev);
-}
-
 extern struct backlight_device *backlight_device_register(const char *name,
 	struct device *dev, void *devdata, const struct backlight_ops *ops,
 	const struct backlight_properties *props);
-- 
2.25.1

