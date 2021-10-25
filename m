Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A078B43A726
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhJYWst (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhJYWsY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E7C061745;
        Mon, 25 Oct 2021 15:46:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u21so16869592lff.8;
        Mon, 25 Oct 2021 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRTBr+1EKwnrblxYU6KiE9Za1tTDPhy0IpCkSUvLN6U=;
        b=mJZTOApKq8IOETkBdt0w3VrYFXh9qz0d9WTMDTD1iVAGsn3l5A7H9isTyfdXqCahvq
         kT3D/XjfhGPXgzA91dIphL6c6R18jd01dxkhqkgJlT9/2unbZUcdlCxIkLffAjIRHUrl
         1ica7yjJCK1gAwEd9o5wgSljQ/hO8UBqZCGcYjd578HRHuMJOn/VPtOhsnSCKUag+TGh
         SPGwtDbqA1wRjLDFvBCI0hyrlzxhc0FnSzNYxwztW0046REVuMICZfDnqHu+hFf3b2Yu
         G1OtUHNFOqGd1RaQakv12QOENNLNUs1nTMTSVPj1MsjtQVhs1TSI7Yl1jpwx6sIN/oWp
         lUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRTBr+1EKwnrblxYU6KiE9Za1tTDPhy0IpCkSUvLN6U=;
        b=SRHTTgQD9pCIvJeWCxmAGpsLQ9QUpAnfpgdKBpIlkaNBlMo5TyqDPe54wcQEbvm07+
         RJlSh0P/niZyciS9b0khENVo0ScNrHmCOGQjY331zKdlpTsOFmeZ7noctEFZdUuHy2d0
         yD3NIIWSygcHK5Mu3uQVxWw0LwULBbF3gwpcNdLznniPXUAG13xuDBIUtRsr+XBWvIuk
         0N9h2LrAprXNwuyzNmifpCpgoACn5lYH928f8tjyLEyZ6yWiz0LN8AC32dbN3uIPSnrB
         6HYN65C+NM3PcdnajDzq75FoPzHSldFTRelmNkEuQciXkTODCQLkqLbXqwfC3xcng5aM
         yNsQ==
X-Gm-Message-State: AOAM533mZIWF3yNVmYjofc4rRL9YgEi5y2n40KpM7k7iNM1CsYVhQj2p
        FG//A7YBtP8OCyhNxmwBXz0Dcg7bLAI=
X-Google-Smtp-Source: ABdhPJxnluwGwvlNbP91TjoyX5694jh9Ed0xWwiu4EPUR9Sqz5KQ729bUW5S95vKw1S2HVhrDXf5zA==
X-Received: by 2002:a05:6512:5c8:: with SMTP id o8mr5890825lfo.339.1635201959292;
        Mon, 25 Oct 2021 15:45:59 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:59 -0700 (PDT)
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
Subject: [PATCH v14 14/39] drm/tegra: vic: Stop channel on suspend
Date:   Tue, 26 Oct 2021 01:40:07 +0300
Message-Id: <20211025224032.21012-15-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

CDMA must be stopped before hardware is suspended. Add channel stopping
to RPM suspend callback. Add system level suspend-resume callbacks.

Runtime PM initialization is moved to host1x client init phase because
RPM callback now uses host1x channel that is available only when host1x
client is registered.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/vic.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index b58e2b99f81a..9622ca96c539 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -151,9 +151,13 @@ static int vic_init(struct host1x_client *client)
 		goto free_channel;
 	}
 
+	pm_runtime_enable(client->dev);
+	pm_runtime_use_autosuspend(client->dev);
+	pm_runtime_set_autosuspend_delay(client->dev, 500);
+
 	err = tegra_drm_register_client(tegra, drm);
 	if (err < 0)
-		goto free_syncpt;
+		goto disable_rpm;
 
 	/*
 	 * Inherit the DMA parameters (such as maximum segment size) from the
@@ -163,7 +167,10 @@ static int vic_init(struct host1x_client *client)
 
 	return 0;
 
-free_syncpt:
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 free_channel:
 	host1x_channel_put(vic->channel);
@@ -188,10 +195,15 @@ static int vic_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(vic->channel);
 	host1x_client_iommu_detach(client);
 
+	vic->channel = NULL;
+
 	if (client->group) {
 		dma_unmap_single(vic->dev, vic->falcon.firmware.phys,
 				 vic->falcon.firmware.size, DMA_TO_DEVICE);
@@ -315,6 +327,8 @@ static int vic_runtime_suspend(struct device *dev)
 	struct vic *vic = dev_get_drvdata(dev);
 	int err;
 
+	host1x_channel_stop(vic->channel);
+
 	err = reset_control_assert(vic->rst);
 	if (err < 0)
 		return err;
@@ -482,19 +496,8 @@ static int vic_probe(struct platform_device *pdev)
 		goto exit_falcon;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		err = vic_runtime_resume(&pdev->dev);
-		if (err < 0)
-			goto unregister_client;
-	}
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-	pm_runtime_use_autosuspend(&pdev->dev);
-
 	return 0;
 
-unregister_client:
-	host1x_client_unregister(&vic->client.base);
 exit_falcon:
 	falcon_exit(&vic->falcon);
 
@@ -513,11 +516,6 @@ static int vic_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	else
-		vic_runtime_suspend(&pdev->dev);
-
 	falcon_exit(&vic->falcon);
 
 	return 0;
@@ -525,6 +523,8 @@ static int vic_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops vic_pm_ops = {
 	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_vic_driver = {
-- 
2.33.1

