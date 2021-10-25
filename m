Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9170143A733
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhJYWs4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhJYWsZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ACEC061348;
        Mon, 25 Oct 2021 15:46:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u11so7038641lfs.1;
        Mon, 25 Oct 2021 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kVn44UJl6fsxwvVMnWN4rWlwALC4wEkQ8Ltx5Ru85I=;
        b=bEH2cGpchvDPwkMd9z0LQIcOmk/u440rjJmMCVazujsoPMTB5FQaOYLbejY2sEP9Gx
         T878kU7T8oIW6d/dHdQfHyNVcW+oMMbcJYsT/VitwqzWZr1NREBLGiqUl0GYqbgHjPtw
         g1mR2hYLaRScSlzZuq3XBoK45Xa8ByejW+Cva5qJRQZDW9UwMZqBMzjQ2lxIFZg2q4M9
         Fw6CHUlM/V57XsTOsufGVchiFI80I1KoIl0Gy5iUx5KJzo9YRHEbVn78j57mKV2ZUIuj
         02dJLQFrBSQokLUL8BOan0yJIsr8oMhTYIk5yHnsv61clvQXVEvQ9X5CyhMV4ugJKLN8
         bF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kVn44UJl6fsxwvVMnWN4rWlwALC4wEkQ8Ltx5Ru85I=;
        b=zY4+1ImeBCKiubqNWyRrTr0cLWLjJrfXo4KhVBm/TjN+joIf/CYickrgxJ3NU0a3am
         5S0Lo2bi4Zei5IEQI3DbVTWqMs0I3RIoerfzRpcCzYIEflSe+XcO3vvxsO5wkTEr0Rwp
         VAi3Elf281uIqr8PWYNEfnyaR750OBPoPEhE1W0JL97O247/oqY64MQOQlztp6HzUptg
         P8TViRrWE+VUZ7aAtZ7nnG1Jl/rmaZt//sjA+08sw3etSuAKBP/Uo8bWdaTpdTVWPGue
         +4SuYv1JWMrNaqqff5CSRLz7zBCy7763qpgmehmM3jA9leLRc2PXNPKuzdx8MP8CKVwg
         Wqjg==
X-Gm-Message-State: AOAM533RThNT/79AXSyuZzhflT/n5WJxwIDxzNqSQZDCvnIXz3tfc4+v
        P5ngmx/fS+aXJPFeBxq8Hbk=
X-Google-Smtp-Source: ABdhPJyFH33zgAFRFRVBFFB9Y/6hkGd0ZRgecxsZqpM+QDY3ZTYFAnvBykhg3Eh7aWgyJB9OIJDR9Q==
X-Received: by 2002:ac2:4c88:: with SMTP id d8mr11635926lfl.531.1635201960189;
        Mon, 25 Oct 2021 15:46:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.59
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
Subject: [PATCH v14 15/39] drm/tegra: nvdec: Stop channel on suspend
Date:   Tue, 26 Oct 2021 01:40:08 +0300
Message-Id: <20211025224032.21012-16-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/nvdec.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 48c90e26e90a..0f1146be9d6d 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -112,9 +112,13 @@ static int nvdec_init(struct host1x_client *client)
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
@@ -124,7 +128,10 @@ static int nvdec_init(struct host1x_client *client)
 
 	return 0;
 
-free_syncpt:
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 free_channel:
 	host1x_channel_put(nvdec->channel);
@@ -149,10 +156,15 @@ static int nvdec_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(nvdec->channel);
 	host1x_client_iommu_detach(client);
 
+	nvdec->channel = NULL;
+
 	if (client->group) {
 		dma_unmap_single(nvdec->dev, nvdec->falcon.firmware.phys,
 				 nvdec->falcon.firmware.size, DMA_TO_DEVICE);
@@ -267,6 +279,8 @@ static int nvdec_runtime_suspend(struct device *dev)
 {
 	struct nvdec *nvdec = dev_get_drvdata(dev);
 
+	host1x_channel_stop(nvdec->channel);
+
 	clk_disable_unprepare(nvdec->clk);
 
 	return 0;
@@ -411,10 +425,6 @@ static int nvdec_probe(struct platform_device *pdev)
 		goto exit_falcon;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-	pm_runtime_use_autosuspend(&pdev->dev);
-
 	return 0;
 
 exit_falcon:
@@ -435,11 +445,6 @@ static int nvdec_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	else
-		nvdec_runtime_suspend(&pdev->dev);
-
 	falcon_exit(&nvdec->falcon);
 
 	return 0;
@@ -447,6 +452,8 @@ static int nvdec_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops nvdec_pm_ops = {
 	SET_RUNTIME_PM_OPS(nvdec_runtime_suspend, nvdec_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_nvdec_driver = {
-- 
2.33.1

