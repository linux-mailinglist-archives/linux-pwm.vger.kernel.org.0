Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4543A73B
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhJYWtF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbhJYWsZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032AC061243;
        Mon, 25 Oct 2021 15:46:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c28so11648355lfv.13;
        Mon, 25 Oct 2021 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJarTkNTEoMlksCf38GHnHNmMaOZo5rLjpR2+6rp6ac=;
        b=DuNY3RgV6b5E0HRk5wiok3CV4aymhY8nc62i3OPlTGYABwzcbBbjHC+wFjs2xZ/01z
         Dli6udhMR5bcSIRDbfm+x79bwSNWkSPP0Cuuo5mu7fZha48ucJUZStvuuWg1N41f2SyQ
         H4A3f0M3HvGKRD7W0x1eIFeYXZM12DTibMOkgW5BhBqo81qSEdC56haL/jKaaT7uNQFA
         Kfln32k686TIRae5eUqsReXHCbUGt1FmsbEN3/4l152M6nWwjOJym7jvgrl/Hpb4KDE8
         k4z5ubUmeKNIvQSKbmdfqrVEMXpFlgKDaLcFJNlCYucP9w6kQmFnmgH0LHCbpNAPF6wH
         Lalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJarTkNTEoMlksCf38GHnHNmMaOZo5rLjpR2+6rp6ac=;
        b=HaLtWOS3uhXXu+WwlzVRGDsa8rGGOsy5ZVWCvzGloeVbT/eR76oMHV/cXX/SPM6D0V
         YMYyV/i3LIjI1yjOiYSm8XkHJtCBye1Lbs1aWCXn7alWZ6MomGL8gB1BDYRrfz7gegQ3
         Mworn4omTx3Ag+BnozWhYPImwRPoOf4ZW45qov11ZUSEjbhcWSQBQr1qJwBplXTQwi74
         pz1LcPY8J0mFj6EMFQ7+IQMKfN3xJcHaYYJFTQb7c1/QOxqdfrfG2rDhjJ+ah6MPhTsq
         BTADZPWP/bFizJprf6Ifs97jdarhXnmaNCom+pF+V3Rk76aiBLvpApTY/dPfQjEGaZt6
         SVIw==
X-Gm-Message-State: AOAM533gaWZJwGgSmSjm0X2ubO1EobsI51Llm2fd+WJ2vsR3qQYkIJ9C
        F7w/4+zmESFOP2dffVaQ6yc=
X-Google-Smtp-Source: ABdhPJzCMRNjjko6GLKt0sLL7ix8/6D4t6ztVcc38PF5qU5R381WDWrVETaFqH/0HiPEphfr6UnV6Q==
X-Received: by 2002:ac2:5968:: with SMTP id h8mr6720554lfp.24.1635201961138;
        Mon, 25 Oct 2021 15:46:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:00 -0700 (PDT)
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
Subject: [PATCH v14 16/39] drm/tegra: submit: Remove pm_runtime_enabled() checks
Date:   Tue, 26 Oct 2021 01:40:09 +0300
Message-Id: <20211025224032.21012-17-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Runtime PM is now universally available, make it mandatory by removing
the pm_runtime_enabled() checks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/submit.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index c32698404e36..3bbd8de5711c 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -504,8 +504,7 @@ static void release_job(struct host1x_job *job)
 	kfree(job_data->used_mappings);
 	kfree(job_data);
 
-	if (pm_runtime_enabled(client->base.dev))
-		pm_runtime_put_autosuspend(client->base.dev);
+	pm_runtime_put_autosuspend(client->base.dev);
 }
 
 int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
@@ -589,12 +588,10 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 	}
 
 	/* Boot engine. */
-	if (pm_runtime_enabled(context->client->base.dev)) {
-		err = pm_runtime_resume_and_get(context->client->base.dev);
-		if (err < 0) {
-			SUBMIT_ERR(context, "could not power up engine: %d", err);
-			goto unpin_job;
-		}
+	err = pm_runtime_resume_and_get(context->client->base.dev);
+	if (err < 0) {
+		SUBMIT_ERR(context, "could not power up engine: %d", err);
+		goto unpin_job;
 	}
 
 	job->user_data = job_data;
-- 
2.33.1

