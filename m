Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A0412C95
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351905AbhIUCpq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbhIUCDI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:03:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28988C14092C;
        Mon, 20 Sep 2021 11:12:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t10so64978232lfd.8;
        Mon, 20 Sep 2021 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkm6XIjMcFvBv/Q8SMVuuUrOs216TrQ7UEhmgPQFIpc=;
        b=AaRBZPLDR+Kst0J6B8/r8JAR7iOBhbKOBpoVNkl9gjm3N+roOd89PhBOc4NiwG1Hun
         hcP6vI6fjUMTdeWo3QYdgwSupPHFGdceUsLJLd7gnDIOlRDoPsbddt9aJ3FnmEdUOE0n
         DahWqhgtBgCF1t8DDLmjLDrDcCHV0iRptuvRyfdQ7Z7ZsQYerxbqSaVkyaVzKyZqifj5
         I+a6/jozizZCAeyvLjsQA4OiR5eqUd+FuuxraHbZ+tBLyhduNWyOT+HpfXOy6yhRsGtJ
         zDpKlw5SQxQ7vof7G6wv0IXZ+L6OT9fdy2pqwvxjzK5mYsfJZVKsxIRQeFau014NCzzy
         60ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkm6XIjMcFvBv/Q8SMVuuUrOs216TrQ7UEhmgPQFIpc=;
        b=KdJZrZ/6OG6ASt6K/DUA5FlcswTocDkn8WjPzobpbm2hNxqv+QKIax7Xcy++DwQcxd
         RM0qrArvqWo0Oke/wAOLpy+jDmhOCRIgirN1F4Xn6CgNYHjMbtIhUXYWiaIS2TGBiewa
         iVL6ED7y1IFLEjUyj8IVz9nd33KNSDVzymZ57z+6gI/LMYjaNkYEzjqWuTZmIiq0NYON
         c8DaDwgWliPzMuBzomJUncUOTEu2MkPbifhHOHeMu7sjI6jMv9VKDuX56gh0nZh8V/Co
         R4OC3JRTve9nVMt2bXyJiNtgGhzTyYPg2Hc8u8QNy1gm4+VWna6h3WBatITCXAgl9hEa
         tqkA==
X-Gm-Message-State: AOAM530hbkLC6CEn2HSReJpLLp29wi5ifmtKtgWXl/pAN9uA1ATKxu6T
        VPmWwQSMeqm6R9zdTue4O7U=
X-Google-Smtp-Source: ABdhPJyf6sQAhsGtHx+SSBxaMArpxSssCTj2xbvUgwVarTw3ZVWMrMDiQt7a2Z1ptBZ8/syBj4VT1w==
X-Received: by 2002:a2e:a909:: with SMTP id j9mr11997665ljq.374.1632161551233;
        Mon, 20 Sep 2021 11:12:31 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 25/35] soc/tegra: fuse: Reset hardware
Date:   Mon, 20 Sep 2021 21:11:35 +0300
Message-Id: <20210920181145.19543-26-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
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
2.32.0

