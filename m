Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9444FA62
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhKNTjh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbhKNTjK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:10 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88883C061202;
        Sun, 14 Nov 2021 11:36:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t11so30718208ljh.6;
        Sun, 14 Nov 2021 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6s6Y176eM92G3urbum9u/lfNUjhQPz0PnC0xf51/Fs=;
        b=kxmpEbZsrYeuGpqvbXc+Y8jZAlLJKCqpQBqiX14xcPNo7jWOif712vX9/s7aimAjhi
         YlY1eZBNNhv8sH07VxmpkcWoRB5FkOi2x7UH4ysKqiuo9ZeygWmjFchBWyl5IvdNe1x9
         W6/jLsjVHU9iNo6DImtU3xKQA7iA2/YLiZ85KxS7Js4K8lr3hA+Ubb7yvhmkDD67Gbya
         9iMutsmj2gnHivXOKQKOeIociZQX4TNmJFEEKOsORmG4OqPf5OJ5rLJ/r06qYwzkcW+W
         bXuDh2C/jegF+xaTP7aASTYY7QaqfViuvpE+tlPjWCX8Epa5nf9+PqjPZiddJVOFLAdW
         MjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6s6Y176eM92G3urbum9u/lfNUjhQPz0PnC0xf51/Fs=;
        b=oZTeEdHdu/vkOrT6McMP/ecWH22o95Tq/x3YA2h/zXYI0tmXMvOrY0bdr4TipXoT/i
         sMpKZVeg0i3pzBkRVxNLInRjfgAmdAumCoQZhPSmKTv0yGrqPDSpmaX7lHMtQqZzQQZR
         FxA9N7Of8TQBBva2flG1iapfSzXJ892ztZZPPwJIixh9LGoSQGBoFb+XlGz6xeOZwt8j
         VwQ/YZ+EPMbrbunhDi8KRUUrJV+dKRA48n2CP1e9/ZeNEh+hh1qEF2+onxQP47JAoGtt
         fWQnAV6uacQRk2HW1syQOI8kjKk00HJlAz+p9t0HX+vmDE0Fr+ba0M60LU05+RTCpAqI
         ComQ==
X-Gm-Message-State: AOAM531k36+ftakq56xd8+IA/cCPqC8UNEe7nUZcPBVS4dVl4pZSLXVD
        Zxxu+qZcAICdDdZG8cR70xM=
X-Google-Smtp-Source: ABdhPJzT77hE2tzcj0ks3igJnufShKNdn8bWLA/wWGFj5JjeIPuW5/f+fNS9AU9jzf3kemhW8YnJyg==
X-Received: by 2002:a2e:b058:: with SMTP id d24mr32403728ljl.237.1636918572975;
        Sun, 14 Nov 2021 11:36:12 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:12 -0800 (PST)
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
Subject: [PATCH v15 17/39] drm/tegra: submit: Add missing pm_runtime_mark_last_busy()
Date:   Sun, 14 Nov 2021 22:34:13 +0300
Message-Id: <20211114193435.7705-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Runtime PM auto-suspension doesn't work without pm_runtime_mark_last_busy(),
add it.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/submit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 3bbd8de5711c..6d6dd8c35475 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -504,6 +504,7 @@ static void release_job(struct host1x_job *job)
 	kfree(job_data->used_mappings);
 	kfree(job_data);
 
+	pm_runtime_mark_last_busy(client->base.dev);
 	pm_runtime_put_autosuspend(client->base.dev);
 }
 
-- 
2.33.1

