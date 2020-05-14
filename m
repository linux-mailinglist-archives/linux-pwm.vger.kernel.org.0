Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BD1D3CD3
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgENTKY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729256AbgENTKS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D07C061A0C;
        Thu, 14 May 2020 12:10:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so4713301ljg.12;
        Thu, 14 May 2020 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J916F81BKXSH1NRVPofwjNX6i7ySZukl1DQn7KOtjRY=;
        b=KhTkE42CZnDvo5d4tHCxFOUM/fdSLjbFY/mCcZEoAqhx8J5I7dtrJTI2Of9JD9wiu0
         ngMdA6sgzjKks/LuuWupwhrnbv0fh8R8+mCxe3sgMOguRjwh0ICfRqPYYWmcgIa3lC7g
         FBfd2sqHT3rlSOxo0Cxx+Hm1wuzoIfTuu/KKlkM+IiANb9Zi/DwYnj67dlZMXQsylTDo
         xtQrkDqz8Hu+5hloVAHFN6cGpn221+2SDJ20D8qtErm9fpIeca5I8w2u7Y2752HehSqu
         ou4r2diGpibjXDuFwwLJEI5+nxyHYBkMKCk9mQQEK0neEE7PlBJ4KB7iEZL2pPb+AWOQ
         xIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=J916F81BKXSH1NRVPofwjNX6i7ySZukl1DQn7KOtjRY=;
        b=Zosx+3H4Xhb/lLF1uWvxChqGOham2w11sS6ishCiYq3vIJRbVIuOoE1z8+dWb83mRS
         Q5DaO5YfuY+/lX3LA3T5wTdtBRH/upvRvbOjx0VomQ7tscav25EO/aUJ2oWYDV/Ch/xI
         qaDBqDoCwHXth1EPEwB048B9KKrm3O7FhcVuDyEl8xZyv6F7mo3kaxULYR3vdcwxVBBu
         ZF7+uXpTucUNg/KHSWWmMc1jHnhh43gaS4Q5I7yTjrDrIgtNVHTsGb1i3k4VFJzLw6iI
         DNbfuOiV4p/vSeMv6PGFLKMcH1Nf/XdvpzWqy8FPRnpBPkrMuJGtVxa1e/egA6oadZHZ
         Dahw==
X-Gm-Message-State: AOAM530+FE8jdxyrVL3Kj0WG0l8ZeEkX4Z3aF06xaDomUMJINy9++TYR
        dOX5axR+BUCekK9M1wlEDEU=
X-Google-Smtp-Source: ABdhPJzmOnNVIJlWDEc/Vi8Cs/lkpqkVwdrbcdNjtNuimAeT/PfHkeObjIoyXMQnn9rV3ILgNFk0Hw==
X-Received: by 2002:a2e:860a:: with SMTP id a10mr3924004lji.20.1589483416265;
        Thu, 14 May 2020 12:10:16 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:15 -0700 (PDT)
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
Subject: [PATCH v1 01/18] drm/omap: display: use devm_of_find_backlight
Date:   Thu, 14 May 2020 21:09:44 +0200
Message-Id: <20200514191001.457441-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Look up backlight device using devm_of_find_backlight().
This simplifies the code and prevents us from hardcoding
the node name in the driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Zheng Bin <zhengbin13@huawei.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Enrico Weigelt <info@metux.net>
Cc: Allison Randal <allison@lohutok.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 3484b5d4a91c..faca5c873bde 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -1163,7 +1163,7 @@ static const struct omap_dss_driver dsicm_dss_driver = {
 static int dsicm_probe_of(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *backlight;
+	struct backlight_device *backlight;
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct display_timing timing;
 	int err;
@@ -1216,17 +1216,15 @@ static int dsicm_probe_of(struct platform_device *pdev)
 		ddata->vddi = NULL;
 	}
 
-	backlight = of_parse_phandle(node, "backlight", 0);
-	if (backlight) {
-		ddata->extbldev = of_find_backlight_by_node(backlight);
-		of_node_put(backlight);
+	backlight = devm_of_find_backlight(&pdev->dev);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
 
-		if (!ddata->extbldev)
-			return -EPROBE_DEFER;
-	} else {
-		/* assume native backlight support */
+	/* If no backlight device is found assume native backlight support */
+	if (backlight)
+		ddata->extbldev = backlight;
+	else
 		ddata->use_dsi_backlight = true;
-	}
 
 	/* TODO: ulps */
 
-- 
2.25.1

