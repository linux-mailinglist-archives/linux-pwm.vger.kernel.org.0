Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B6412C7F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbhIUCpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhIUCCb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:02:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC11CC140094;
        Mon, 20 Sep 2021 11:12:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g1so71794003lfj.12;
        Mon, 20 Sep 2021 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3yXsdmsWJbu2CaukGByuPBPrpPUHlzf8e1vIPRsAi8=;
        b=mSz7uU/bRRInYFwuM8f6B84EvUoksh7ddPhtlASBvZ85dgMc6wSlwy9SyUr71eh6Fl
         8aF/ejqZiLi8ozfYp9/gUV4vYRxtIvgQjgPnZXtQL7Y+v9G9Y+cAaoQ21eYKgU3RZGA1
         UOWbjyklkTrEUyaLSLrxbDkrvqYVMR0YBcW59uTVr7/Ot83fYGy4c+QiJj/Xy92xKSgB
         EfV5X85nt0Citt1qMKvG2qkwPH6VuQN5kOywq4zIlYwPZtXGr+a27VopPVnjFYxmMedy
         4bzfzsT9EaigD80tFXxFOEytgM+rMwHIS7FkhnwqO0rdhVONYqcKyeIkWnAmXAWihsxB
         g4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3yXsdmsWJbu2CaukGByuPBPrpPUHlzf8e1vIPRsAi8=;
        b=C44XylXvqNOC/bv8IF712Kxdj+QqjQsDkoc7U2mEz6AzuVktSlswd6pg/C03OzT+67
         3lxI24zwEM+3+7auIqwpylmtZ3PHD/jL0oj3OmwaPs/tf5bcbMisu2maRvYl7l4AkCMB
         MPICZrZJD3n/qQBvKZzYw7KAm18YHsZsSiXV2LhRyQeY2JxIgBmlxRt9+IHjA6nZP0Ah
         G+bFO+GMqcPdPgXhsXa+sUjHFfm67zSG7O+4brsfH/vUvEzcX/g1kLWQJquXCFebZFOS
         fphQk4pnvAVLuFjPZpcMxexVxuVZJDN1NCt5dDOfcRDHt39YUrRxHcqT3TteYAuYy7Cr
         XQ1Q==
X-Gm-Message-State: AOAM530KBJk3CDaC1vt83kxQiQWFi1sMgO+dJL8RpjUBS9Qcvan7KPx5
        81tX3Hzqmi+Nn8Kv9hebIeU=
X-Google-Smtp-Source: ABdhPJyyop5T5u9zSJ7UMIl5EYQj77IA6sm5fQ8onwEgRAuSRlsCeH7gqEyvDQr6Gg0QHhoOer317g==
X-Received: by 2002:a05:6512:3a82:: with SMTP id q2mr20094513lfu.543.1632161520309;
        Mon, 20 Sep 2021 11:12:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:00 -0700 (PDT)
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
Subject: [PATCH v12 02/35] soc/tegra: Add devm_tegra_core_dev_init_opp_table_common()
Date:   Mon, 20 Sep 2021 21:11:12 +0300
Message-Id: <20210920181145.19543-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Only couple drivers need to get the -ENODEV error code and majority of
drivers need to explicitly initialize the performance state. Add new
common helper which sets up OPP table for these drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/common.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index af41ad80ec21..5b4a042f60fb 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -39,4 +39,28 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
 }
 #endif
 
+/*
+ * This function should be invoked with the enabled runtime PM of the device
+ * in order to initialize performance state properly. Most of Tegra devices
+ * are assumed to be suspended at a probe time and GENPD require RPM to be
+ * enabled to set up the rpm-resume state, otherwise device is active and
+ * performance state is applied immediately. Note that it will initialize
+ * OPP bandwidth if it's wired in a device-tree for this device, which is
+ * undesirable for a suspended device.
+ */
+static inline int
+devm_tegra_core_dev_init_opp_table_common(struct device *dev)
+{
+	struct tegra_core_opp_params opp_params = {};
+	int err;
+
+	opp_params.init_state = true;
+
+	err = devm_tegra_core_dev_init_opp_table(dev, &opp_params);
+	if (err != -ENODEV)
+		return err;
+
+	return 0;
+}
+
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.32.0

