Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF343A7A6
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhJYWuh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhJYWth (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:49:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10E3C06118B;
        Mon, 25 Oct 2021 15:46:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w23so11207314lje.7;
        Mon, 25 Oct 2021 15:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0CiXiCgdAf7V0lL5IR2r/8ROuTZxmoZVkGc0FfQhBU=;
        b=R8xw42jJPC/nZlTh96fip2LUlB7X8ag1mdDfAb+xZm92uSpxOhkrnKOTV6Vibynjxp
         QIL8kuID5lNIBsdk9jziNglv8mXqkqlusjl5lPkehEM+4SH9tlUJOapT2HOE7AXHf2UZ
         N4HgHnTnR84SrLObUTuG57D3rAZxE1esK2MyecGj3wh0FzFrnXwpbwE2Dx0luRlraoRY
         d0KhAbA0VbtAQ7qIVSkmAf7ZPrBnI/BhSnxpELlHQJ2tZdLfW3KNizm3iiTjYlwLTkya
         BnelVNq2RsZQOgIacv7BwEylvZbmrCQlpTKrybm9rGGQkyzzqQ4oZzTNJklcFlYR1dl0
         zcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0CiXiCgdAf7V0lL5IR2r/8ROuTZxmoZVkGc0FfQhBU=;
        b=Jvc6IsNKiLsfRxeINuOn/3amH+PV4QKzZyYEbC1F0oP69sWcaXWeCry3T2gbMkkOKr
         hphvLEaFrI+0J1EkLuCfMsFP1uwAbNx8sKuzBVKj95f0k9QTB/h0nG/zVRyFOR1Gb0ls
         LvSVUOKj157oHPSpoSvRrySrlzLjspBRBpNJG1MzxKNpxT7W3ttVG0Cszhu2HfaTU9aV
         rH2HzjVrICiYHVXXqzxvu6wbHSUur4E3ErnhN33XtfmzTWN12FPCmDryhfQBy228yr1p
         aVKQFJ+aWWREwjDwop6YtqIV+oeK2tg611535MpFwtJWHhu4ca0RY47hwSIDC0jqADoL
         ZmmQ==
X-Gm-Message-State: AOAM532Ph/GBZFri5y/s8l+0/IX+cUQD5f3NVDB7NOUpV7aR/5epDeqa
        2ShS4CVdu320Wx7CdJOwRvc=
X-Google-Smtp-Source: ABdhPJyu68X54r68x9sMK6kFrngVo1ABGEkqpbluzyUNtkPSxX9NOIZVlt6ut2/CeIpId7gtQXJHiA==
X-Received: by 2002:a2e:969a:: with SMTP id q26mr15421975lji.325.1635201971086;
        Mon, 25 Oct 2021 15:46:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v14 27/39] soc/tegra: fuse: Reset hardware
Date:   Tue, 26 Oct 2021 01:40:20 +0300
Message-Id: <20211025224032.21012-28-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The FUSE controller is enabled at a boot time. Reset it in order to put
hardware and clock into clean and disabled state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 25 +++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h       |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f2151815db58..cc032729a143 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -243,6 +244,30 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		goto restore;
 	}
 
+	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
+	if (IS_ERR(fuse->rst)) {
+		err = PTR_ERR(fuse->rst);
+		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
+			fuse->rst);
+		goto restore;
+	}
+
+	/*
+	 * FUSE clock is enabled at a boot time, hence this resume/suspend
+	 * disables the clock besides the h/w resetting.
+	 */
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto restore;
+
+	err = reset_control_reset(fuse->rst);
+	pm_runtime_put(&pdev->dev);
+
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to reset FUSE: %d\n", err);
+		goto restore;
+	}
+
 	/* release the early I/O memory mapping */
 	iounmap(base);
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index de58feba0435..1b719d85bd04 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -43,6 +43,7 @@ struct tegra_fuse {
 	void __iomem *base;
 	phys_addr_t phys;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	u32 (*read_early)(struct tegra_fuse *fuse, unsigned int offset);
 	u32 (*read)(struct tegra_fuse *fuse, unsigned int offset);
-- 
2.33.1

