Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046AA44FAB7
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhKNTje (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbhKNTjJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D55C061767;
        Sun, 14 Nov 2021 11:36:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m27so13151747lfj.12;
        Sun, 14 Nov 2021 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQQ64DHAwVUDK+O7zZPErxA1rL3KEtXVNyJE4UYdy5Q=;
        b=RRycqGZwIueXzgKSSOzpwNjNa6o/QJ+QS7jxDbxPJ+hGPatfo5zz8HTxHc2u9t62NH
         7JOaNBfaZj4waNTd+FUfABgSPWSlQCC2E5ejfGtAUYhhhDqRwCuRCjKc+Ajb9aGFQeNR
         DdsvjPwCmZltNAdZr0oYyOItqi/KK3HPfaLD6twSiLCuqvZQ4bxvjTQkDAgRY10tDQVT
         xaYLXs5Hn+Q1JoCQkbivp2aYQKkAt2KTeClhJDfRLWY5eE36FFYlyUQTZLHsA/V51KWL
         54Z/xObrEUu4htF7XcIWl74EZeRoJuAPh+T6wqIOBr/Fh/SG5+MdVYHSgicWWWKHPTrC
         R/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQQ64DHAwVUDK+O7zZPErxA1rL3KEtXVNyJE4UYdy5Q=;
        b=1vg3BbWpjwhDegILUkk/ClEdQQJWytjR/MZq59us6NHeDI1TsATA7oyYwix41XgjKN
         2pDnlDLBgbCMCVg93i3NXbgYP3uGA1Of6MrzDHZkTRqqB5StiJ12/LMZIGlHL13v0iXK
         au4T0ZPQEubIdl+q5Q7tNlnrxMocHllCYLHDs2Xct04sQHsZ5bv/a/HNCJJoJtgdhhXU
         TYeeY0xnfvWIDvo2p2d4Tvty540eVZGt+d9L7NONNc5baBr4XoEcq87iPkU15ckV5pAF
         YDo0iGJ+rXyBaW3fy187jCMWJOBhyDZNxTLEvYZeumyzGEKrp+hcwA6pAvKErur+mE6q
         KNsQ==
X-Gm-Message-State: AOAM531CvozmxWLYJaWbXUvmbtgMtb0O2UWIPfLBUvcLzqFJuYgK/2q2
        WNXOUnKMBYl218K+sqMdqBk=
X-Google-Smtp-Source: ABdhPJx8rfbMoBXZQtumsweyBh+F01dCj6bDPAYPmXKgdBjuaP6k7Gj2NTx2ugCwz9uGwHNl7tiXxw==
X-Received: by 2002:a05:6512:3b90:: with SMTP id g16mr28888069lfv.216.1636918572036;
        Sun, 14 Nov 2021 11:36:12 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:11 -0800 (PST)
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
Subject: [PATCH v15 16/39] drm/tegra: submit: Remove pm_runtime_enabled() checks
Date:   Sun, 14 Nov 2021 22:34:12 +0300
Message-Id: <20211114193435.7705-17-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Runtime PM is now universally available, make it mandatory by removing
the pm_runtime_enabled() checks.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
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

