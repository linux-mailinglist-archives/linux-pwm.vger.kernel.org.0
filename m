Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0461D3CD0
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgENTKX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730283AbgENTKU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C22C061A0E;
        Thu, 14 May 2020 12:10:19 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 188so3568903lfa.10;
        Thu, 14 May 2020 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iALLuERW1McwN1PgISrEqSKRl+DwcpATFhkrhtmrlJY=;
        b=OrqDrsx57GbIKMFC5gURmUlwlXbmOqs7a3uuD/o3zYSUdLnKOrLToMPE2u3vlFpT5V
         IeWIeABYAjFRkBDUmkWSD7Zo0BHCtMufMofSC4wm+JJX15TjGKcS3I3/DFmzqZ4/A838
         r8Xx7r7Fq+bAYTtUVfvDWLP0yqUSXEhYUytoyezBaSvjJ+EBiqNTid/xv2f3u0p10FLp
         6guun3D6rhS65c3eG0fOvGkSRCLYI4XT0HjP6EclM79x2NS4ZsRjkFsTes6d35P7D3rC
         FN9FegLPZAjO9n9n2+a9YTTfdgJDRL127KOe/jD+CtixSxlf4DJ02r/tSSxLWw9SOppY
         7ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iALLuERW1McwN1PgISrEqSKRl+DwcpATFhkrhtmrlJY=;
        b=ew5tl8ZLOQ5l8CmMoGxCm7Pi005zHbDiV9nqnuH67edjJH9WoQxrzWYQiy8PZTLK+q
         rQzJcPgQuKQ9yBlPtZXFtiq9ifwdg8BChznIN9ryp6kwsnIf69eIx1LV9+sJQpZyvo3u
         pVIikhr6PQp9Gl/yy41rJ03OaNKeqSDynJ2DhsBhptRDSR8rja2dEGgIif+Ryxq1XIPK
         KtKRDz07+UbGQ6ndEDbmPvF+uD3UCkR76m4j4MmvJc+pCKnEF/MTScsxdjhJ5fp5HVrn
         KTuqonTaore+2ObTUp+6AExPvVPR6Db+5soUlTzwlkPoS7xsYUiAswR09XlWBBzdogEe
         OJlg==
X-Gm-Message-State: AOAM531F0GSNwtNGtMPXU8WH2lJpIShylBN2qnLFjyKoQ9cZdNgr0Lgg
        idyd0QDqRpZE3vlADNUK0IE=
X-Google-Smtp-Source: ABdhPJxtOgNHrWlT1g6kVCkaO7bY7+x7AvNWUz2afNrA3i5zMlrlrAvEYJLlXd6AdF/rD1Dg4wHqew==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr4314956lfh.87.1589483418267;
        Thu, 14 May 2020 12:10:18 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:17 -0700 (PDT)
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
Subject: [PATCH v1 02/18] drm/tilcdc: use devm_of_find_backlight
Date:   Thu, 14 May 2020 21:09:45 +0200
Message-Id: <20200514191001.457441-3-sam@ravnborg.org>
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
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 12823d60c4e8..b207b2f19d42 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -299,7 +299,8 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
 
 static int panel_probe(struct platform_device *pdev)
 {
-	struct device_node *bl_node, *node = pdev->dev.of_node;
+	struct device_node *node = pdev->dev.of_node;
+	struct backlight_device *backlight;
 	struct panel_module *panel_mod;
 	struct tilcdc_module *mod;
 	struct pinctrl *pinctrl;
@@ -315,16 +316,10 @@ static int panel_probe(struct platform_device *pdev)
 	if (!panel_mod)
 		return -ENOMEM;
 
-	bl_node = of_parse_phandle(node, "backlight", 0);
-	if (bl_node) {
-		panel_mod->backlight = of_find_backlight_by_node(bl_node);
-		of_node_put(bl_node);
-
-		if (!panel_mod->backlight)
-			return -EPROBE_DEFER;
-
-		dev_info(&pdev->dev, "found backlight\n");
-	}
+	backlight = devm_of_find_backlight(&pdev->dev);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
+	panel_mod->backlight = backlight;
 
 	panel_mod->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
 							 GPIOD_OUT_LOW);
-- 
2.25.1

