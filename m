Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761762A72E5
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbgKDXtQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbgKDXpK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:10 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D81FC0613CF;
        Wed,  4 Nov 2020 15:45:10 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id e27so160756lfn.7;
        Wed, 04 Nov 2020 15:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFGG01cA595FrKS40PcuSC81ebTEtiTSpfS/ywMG7UI=;
        b=qCfnEwxe9a5udeJa2CYrqVZ5I2a9hmgiqZ2QaqEHjaKRgf2VXGvsewyVcIb28yZDc0
         NJtW1jYdxYxihEwtJ1JhHLt9GCrLEFLun5Srgpe/bZELevxRnAmujiK304OirJi3UZ0h
         OezhThzvVvw8gpQg9av4VU+hB8LuL1lQEpkLkPSBAJ44qZcPhCH6IpgDnyi1uDWq2TP8
         RYuqmPWz/JIvDnAxVgHW78wUUMZny2+47MlJ+gq2nxNa+CFz2O475KuV1N/UI1JeRY6C
         ieR4nU66wpG5FBdE1CzoaJ8S3Cn+p4XlpoQHf4l3Z7bAPbdtXXraV7xxJFeb1rAmopbi
         NZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFGG01cA595FrKS40PcuSC81ebTEtiTSpfS/ywMG7UI=;
        b=bKDygx+mdm4k4btO5Hsi/u/V6m6qm4Fdwh7V9FGyHeOm9WPxEjx1h42s4qhfgfbLCx
         /33b9LgrpOyv/QMeNyIqGvzpkldfrT4rOscwkP8lpq//ejTbHSCeiuZezRzxITXXWsBK
         Jsd6kmZ4UH4OTscpYxogiQmuh78FCVDoI/55UimxgOltNZyClQqsEQ++U6gyYKJog/93
         onXzsoHI5Or1pzCVuThq2j6Y6S8BUhdINO+O4dmnlWdXwnXSNmdNYigHKte/EjdVIXY+
         5IC4fLETYizg9SVoB0YnEZy5Y2gJDIYaY4aLmyOehZV1/MA/CMWdMTATgkCZazSkbKAP
         SA+g==
X-Gm-Message-State: AOAM530t5lvImsbld2HUQBoXjhloBs5UbhzuEfOTiZZBEJgnyqKrNZk8
        yumQJSmyAhUV20Ur9v0jQxM=
X-Google-Smtp-Source: ABdhPJxQAtS5/q5gEZTmOVMhIUSEXN1Ufp90D/WwdUezL1q7/08kLqzAjVTVWhHK+ZA/8JqkDwT3GQ==
X-Received: by 2002:a19:c55:: with SMTP id 82mr55638lfm.84.1604533508654;
        Wed, 04 Nov 2020 15:45:08 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 09/30] soc/tegra: regulators: Fix lockup when voltage-spread is out of range
Date:   Thu,  5 Nov 2020 02:44:06 +0300
Message-Id: <20201104234427.26477-10-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix voltage coupler lockup which happens when voltage-spread is out
of range due to a bug in the code. The max-spread requirement shall be
accounted when CPU regulator doesn't have consumers. This problem is
observed on Tegra30 Ouya game console once system-wide DVFS is enabled
in a device-tree.

Fixes: 783807436f36 ("soc/tegra: regulators: Add regulators coupler for Tegra30")
Cc: stable@vger.kernel.org
Tested-by: Peter Geis <pgwipeout@gmail.com>
Reported-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/regulators-tegra30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/regulators-tegra30.c b/drivers/soc/tegra/regulators-tegra30.c
index f7a5260edffe..fcf824f73131 100644
--- a/drivers/soc/tegra/regulators-tegra30.c
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -198,7 +198,7 @@ static int tegra30_voltage_update(struct tegra_regulator_coupler *tegra,
 	 * survive the voltage drop if it's running on a higher frequency.
 	 */
 	if (!cpu_min_uV_consumers)
-		cpu_min_uV = cpu_uV;
+		cpu_min_uV = max(cpu_uV, cpu_min_uV);
 
 	/*
 	 * Bootloader shall set up voltages correctly, but if it
-- 
2.27.0

