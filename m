Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676D53EE2B3
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbhHQBba (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbhHQBbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:31:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B2BC0617AF;
        Mon, 16 Aug 2021 18:30:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d4so38104913lfk.9;
        Mon, 16 Aug 2021 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lLAJV89hQcPlyDX5yfRwTHcihc/r1AqZv/5pRsMLxM=;
        b=nwrGyMxr7TkokoAbKrZt8dmendcbwZ/KglOYAoBtkklp0BVOYjBE6OPrXf8u2d0QSs
         JYJkalIYEYZY+URP5BFOM3PuBRhSKyvy8KCdC/rx8InfIY2vyXdT7bnsx67YVsK3yyDk
         TkFSDgeuVXYwWRPVubotA6I+kOxT5++AJriWNKLk5qzlP67E32aPtTnhVVg7sPhLoFDq
         F4wGo4eWbDPCAQY0oBCeUh2eY1FGe1yC6o5DeAI/SL7hvqLmmnRTITxwj3pV7KwsBons
         EzwYyNAwszjKMGVw+qrqW2pmosbwgrw1V5vmLfVDZeczzI3UsacNhxC+Ilhf6fIDM6QR
         GHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lLAJV89hQcPlyDX5yfRwTHcihc/r1AqZv/5pRsMLxM=;
        b=UttBLl3z/7PH2HhPEaslglZqOzlecrf668EkvgKIM+CbnC0RlmW6o0NSSkQ17LzckU
         L2lDwOhz4lwvk2ijNbZgk7+raRFrD2UqTb0FveO87yTQYKoYs4M4ev/DehL8NBqsPvPp
         KyR+DqqweUNoencgEdAW1eRKvlEMy/av6paPJgLFHDt93Cy79EOVbBB0jETsq0YuKEZY
         rXhvUd7dzOPJGy9dBKE3bbaD/nxLBxIK79dCVoAz3clcDMBek5kNL/+fEuM2zXY2mgOL
         RE1EPjVqUQoR3XLGLI4wtt83GZzF+YjaDclRIee80rDg0BkQDyJm8ARCSawBfEYH1y8c
         YBHA==
X-Gm-Message-State: AOAM530IvvYLHaYi+OP7gbnYuM6jiB7rqJ+reZm6iLqYDvqyiePzfRPw
        cGjpHdR8S1zijseaMte0ieE=
X-Google-Smtp-Source: ABdhPJysm3N4gOhYNuFKEDPKN7Uh+i4G/iAeuT5GxXfDxPml3wY50JIEVz90Yl1goWbq9lgObhlGSQ==
X-Received: by 2002:ac2:596b:: with SMTP id h11mr492625lfp.558.1629163832433;
        Mon, 16 Aug 2021 18:30:32 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v8 26/34] soc/tegra: fuse: Add OPP support
Date:   Tue, 17 Aug 2021 04:27:46 +0300
Message-Id: <20210817012754.8710-27-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Initialize and sync FUSE OPP to set up SoC core voltage vote needed by
FUSE hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f2151815db58..d1b66cd9339d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
@@ -213,6 +214,10 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
+	err = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (err)
+		goto restore;
+
 	if (fuse->soc->probe) {
 		err = fuse->soc->probe(fuse);
 		if (err < 0)
@@ -259,6 +264,12 @@ static int __maybe_unused tegra_fuse_runtime_resume(struct device *dev)
 {
 	int err;
 
+	err = dev_pm_opp_sync(dev);
+	if (err) {
+		dev_err(dev, "failed to sync OPP: %d\n", err);
+		return err;
+	}
+
 	err = clk_prepare_enable(fuse->clk);
 	if (err < 0) {
 		dev_err(dev, "failed to enable FUSE clock: %d\n", err);
-- 
2.32.0

