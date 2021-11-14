Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977C044FB2D
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhKNTox (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbhKNTjH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789DC061766;
        Sun, 14 Nov 2021 11:36:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f18so37575901lfv.6;
        Sun, 14 Nov 2021 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5LZNzGJpLsApxqpURZGyur77JxFewe+cdR7kou+Iuc=;
        b=qmZz34wSh7u9dpKcs7jjNaOLOzbV2HaJkselRvIcb5m4ECncO8n6gjyzaDtheiKqq4
         iKudJUQ48V0w7/2y5vAwZNT+9t05V3D5q3Cswe4mszHsaBJKVbbm1YOkLWAVU6sJ7NNM
         YVJCct5KhZ9RA7+E2b+XIeFmVqyQQMPlHO5xb7RPtb5Kft2cTeAFC0CGoFQbj1O0Lztc
         FV3rZqQutBFNaZaZ7BYrhPnrpHJ+3j+VP91/nSefV1gHXlcYTDhTDKBdyPW3YCW+Ax8y
         uNRIWx1HFgS9GVs6pQJgKCmkUwCD0cmiarkmfvQ+KJoTYXcHOdtxiJ/Wub6Vi/UoeFfs
         yJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5LZNzGJpLsApxqpURZGyur77JxFewe+cdR7kou+Iuc=;
        b=XGxt9n3YQuvqfKG8YZRHa10WY1wPzYmZhS1L92lo5KNOI9okVZkiu3VqJgZDRq1drU
         zlFtiu2xLUDuhDI4mhnqTFHkLLxlqectrZ916+B7mcHN0L8gPnZdHvJhUX8TJiiKldIY
         UejG4mHoNxVDwNMPyFDFMatErobNbsjZ1rgXdyguWizJucJHZbT6TVwM264d37MX3hqd
         MneHg1tlnA0g3MafJqmEORd710Loqr9Zj3RiC22eUbUiwORiGyhm0KAa5W/rc3SA7DHp
         ou8nK13zXGaTqnRghQnOzzhay/seLMmSzWnixJ5JCRxW2Tr/iHfo+Issr4my8NPNFnac
         jHuw==
X-Gm-Message-State: AOAM532m8QDgyHCDCOsLrDlE2fnFdei/spT+zLc+HWUQQZkmtjmU4X2P
        6/lviW+ThnD5Pi/8+Px9CrE=
X-Google-Smtp-Source: ABdhPJzHcx/oQdmNE+7tf2qpDNOBRjQYKFGCCSffWCINlASE9wLhUWY/zBszI1SZMZN2XEG8jP3Vzw==
X-Received: by 2002:a05:6512:39c4:: with SMTP id k4mr28631313lfu.79.1636918571054;
        Sun, 14 Nov 2021 11:36:11 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:10 -0800 (PST)
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
Subject: [PATCH v15 15/39] drm/tegra: nvdec: Stop channel on suspend
Date:   Sun, 14 Nov 2021 22:34:11 +0300
Message-Id: <20211114193435.7705-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/nvdec.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 791bf1acf5f0..15f036e09e5c 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -113,9 +113,13 @@ static int nvdec_init(struct host1x_client *client)
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
@@ -125,7 +129,10 @@ static int nvdec_init(struct host1x_client *client)
 
 	return 0;
 
-free_syncpt:
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_syncpt_put(client->syncpts[0]);
 free_channel:
 	host1x_channel_put(nvdec->channel);
@@ -150,10 +157,15 @@ static int nvdec_exit(struct host1x_client *client)
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
@@ -268,6 +280,8 @@ static __maybe_unused int nvdec_runtime_suspend(struct device *dev)
 {
 	struct nvdec *nvdec = dev_get_drvdata(dev);
 
+	host1x_channel_stop(nvdec->channel);
+
 	clk_disable_unprepare(nvdec->clk);
 
 	return 0;
@@ -412,10 +426,6 @@ static int nvdec_probe(struct platform_device *pdev)
 		goto exit_falcon;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
-	pm_runtime_use_autosuspend(&pdev->dev);
-
 	return 0;
 
 exit_falcon:
@@ -436,11 +446,6 @@ static int nvdec_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pm_runtime_enabled(&pdev->dev))
-		pm_runtime_disable(&pdev->dev);
-	else
-		nvdec_runtime_suspend(&pdev->dev);
-
 	falcon_exit(&nvdec->falcon);
 
 	return 0;
@@ -448,6 +453,8 @@ static int nvdec_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops nvdec_pm_ops = {
 	SET_RUNTIME_PM_OPS(nvdec_runtime_suspend, nvdec_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_nvdec_driver = {
-- 
2.33.1

