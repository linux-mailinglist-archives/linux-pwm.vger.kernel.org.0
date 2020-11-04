Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC72A7257
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgKDXrS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733148AbgKDXpa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:30 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD4C0613CF;
        Wed,  4 Nov 2020 15:45:29 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 126so154664lfi.8;
        Wed, 04 Nov 2020 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN6bYFk4IWxOu+d/QHUvb5Vdquail4zOQtI7YW8kabg=;
        b=tD610N2LtXl0A/xShg01YubajXnOhuEWWAyuR72lZg9Ds8ZFIwJxpGdVeQHfBVQ2Kj
         p7wqBVm35lvdMWEqtwdl7LKaMYY69/bYvlQJKRefXH6Txqv9VIfoN/eru3nXimT1cgGc
         aJLWnRCsDLjb5LFHHLiih35bvzicP3icoOeJ6QZhOPvdTEjIfcCdnZjfF14+CP7kgYCu
         mIvGrWIR2h24M0xfzKZsgmDh7c9ZqLVsanS95avHsCTbAVBBRwjfXy0mSFI9wh7rBO71
         xPprbWClr+RHceHpdVIlzCaoTTsHvolCzXoD+AkYq9Wp8c550XEbwgaBCALWsA+KfaSG
         tTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN6bYFk4IWxOu+d/QHUvb5Vdquail4zOQtI7YW8kabg=;
        b=ZmO/gG6GI+ChwBdgc44cr427olEQYnozeolVXcP/8sWS3v1czYjWeX0RPFlKJUA6YA
         rkfCy3PsvPcXQf4qxJXZwj9wFSccDKDgWBwRDdZiOiKAUjXfWsOH+KQPGreevI9Qbnk9
         o422w1VCw04+Zoxj1SV7HSw79jWlxkvwET88X0a9e9KeulrV8q05mqmfpRoXVvsYyZXx
         HfyT+OCHa/iOrKDbaFV1C8/4zeouHgI7WpSxDTQzK6BrbJd3BW3C2C41m4YtxKF7GwSj
         ofig2LMfbmJ4qwhXJJzTqoqHFm/C+hTxM2qXESB1r62Bl5tyMSpS0RRzEdRxO0Nudae0
         e8dw==
X-Gm-Message-State: AOAM531GSIDpLXaj6L/LbCBA7MeRZbSlcGBqNFEeBBe/Dklq4+suDFst
        FlCP1MvewyUcc7kBIvaSqlc=
X-Google-Smtp-Source: ABdhPJw14mWy3hZ5zhhgkxRLWuktqe/gXtUzbFW7RYvVSWvKRy6DLpTPn1wG6PiegG0MPpIECG+lPA==
X-Received: by 2002:a19:e305:: with SMTP id a5mr36969lfh.549.1604533528154;
        Wed, 04 Nov 2020 15:45:28 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:27 -0800 (PST)
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
Subject: [PATCH v1 23/30] memory: tegra30-emc: Support Tegra SoC device state syncing
Date:   Thu,  5 Nov 2020 02:44:20 +0300
Message-Id: <20201104234427.26477-24-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Sync driver state using the Tegra SoC device state syncing API, telling
to regulators voltage coupler that EMC state is ready for DVFS. This is
required for enabling system-wide DVFS on Tegra30.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 6b20ce9f16af..dd7474065346 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1666,6 +1666,12 @@ static int tegra_emc_resume(struct device *dev)
 	return 0;
 }
 
+static void tegra_emc_sync_state(struct device *dev)
+{
+	tegra_soc_device_sync_state(dev);
+	icc_sync_state(dev);
+}
+
 static const struct dev_pm_ops tegra_emc_pm_ops = {
 	.suspend = tegra_emc_suspend,
 	.resume = tegra_emc_resume,
@@ -1684,7 +1690,7 @@ static struct platform_driver tegra_emc_driver = {
 		.of_match_table = tegra_emc_of_match,
 		.pm = &tegra_emc_pm_ops,
 		.suppress_bind_attrs = true,
-		.sync_state = icc_sync_state,
+		.sync_state = tegra_emc_sync_state,
 	},
 };
 module_platform_driver(tegra_emc_driver);
-- 
2.27.0

