Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EDA3EE3AA
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbhHQBeF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbhHQBak (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B47C061764;
        Mon, 16 Aug 2021 18:30:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c12so17168142ljr.5;
        Mon, 16 Aug 2021 18:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wojn7XneOlcjLQTZlMLpcmbGjIOEPaqexo+f2WGyphI=;
        b=Xq17kIc6GM80MD2xhnYjU7c3bLn4H5tuMTvcdBwNy9/g5psmoz3S1gVRRgj0w10xku
         S/OHY+MF1OPdTYbYPPJFPFeY4WU63WLX4lpEqf+XHRBxzSyKtJkRoLEZsNrLQUD3aJsJ
         hyYwTr0Z48Wws5sZA3cunYGug92vOCdPP0286zyvF+xLx0QRLRMNonrX8WWxK9M03w18
         x2KNq+2YuwXI/DgRg4TCi8S5zBrr/YRsvFRqgRHtf1EkBhMZn+P2C2QCgMgcjYbkv0RV
         MYPdW+7zuuviGgSMO06r+pSAqvsVA5K8VmFJ2RBZodvpwXKzfElGK+ZIvdNgJ/4RFBSg
         0SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wojn7XneOlcjLQTZlMLpcmbGjIOEPaqexo+f2WGyphI=;
        b=VmyO4krAgCDSvSss0kV8BlzGVBUGsIfwb0KjaPsHm535Eq2JsVV2m1lTtBalw9qXyt
         TIOfRLHeEMWB4J/rlGvE+ywLThYfHYTKNNVZ8Et0ZwGFdts+YN/crv0ABgb7EJfJWtf4
         ZI9xPfoCJc2JN61bXmkb0ulBOAMU+uP0KTjqyMrbo03m/0JslQrzuB8pi9g7oFNUuxF5
         IWAlgNuZgcXsfkOPVQOvontNfPj1fyL8b2+8E8HMh697RvvnNdzI4b5+a9kyvRVoQ8Dh
         8TzxHqvsqqb03nf0FKQV29TYNK7pQOco4ZW2y37TMHQaJQO5DGivNoHGOXSUHPyxol2L
         /Keg==
X-Gm-Message-State: AOAM532/wTsW1PMVgkJn5fEU8LA8x9srgnXwmyUf3mSz7TsUsVUZ5nhr
        X9mphIcKD9NJIktFVJovj70=
X-Google-Smtp-Source: ABdhPJzrAiKknpayvUXn0AhIlpxoa1tdB8UGRkYEeNvPAIQMKmclxsnV8VxQdGuN29ZUiGnqlWbG1A==
X-Received: by 2002:a2e:b0e2:: with SMTP id h2mr848215ljl.23.1629163806184;
        Mon, 16 Aug 2021 18:30:06 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:05 -0700 (PDT)
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
Subject: [PATCH v8 04/34] soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
Date:   Tue, 17 Aug 2021 04:27:24 +0300
Message-Id: <20210817012754.8710-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Only couple drivers need to get the -ENODEV error code and explicitly
initialize the performance state. Add new helper that allows to avoid
the extra boilerplate code in majority of drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/common.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index af41ad80ec21..265ad90e45a2 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -39,4 +39,17 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
 }
 #endif
 
+static inline int
+devm_tegra_core_dev_init_opp_table_simple(struct device *dev)
+{
+	struct tegra_core_opp_params params = {};
+	int err;
+
+	err = devm_tegra_core_dev_init_opp_table(dev, &params);
+	if (err != -ENODEV)
+		return err;
+
+	return 0;
+}
+
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.32.0

