Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223543A750
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhJYWtR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhJYWs0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93399C061224;
        Mon, 25 Oct 2021 15:46:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u21so16869747lff.8;
        Mon, 25 Oct 2021 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtFEh3DLOYLlHvOQTkSDJCzq6CQ57SdIMJKKnFVuN48=;
        b=OooE5Eeapdyj8IGR51B47FnYiOIaeLVA5B6lqBHK1NQdk2xAjkeyvZryOJAdaL5m/W
         O6Gb2UFv65vJSBuOTgyNX9uFTlQZarcezGZsaiKOEqRh2hEqq1opuMJJ9OjlFj70oW2m
         BZqZ2rTwR3RZlfxjFGZTcShNcLPJFoo3kzVLFR02R3jg6HXsZAA7eEiRN2H6dLUXCC6M
         Cj29fJ9tPwd5KG0qcwHAyKhGxXG7kLxBePa2pmAZnCqvcPXsYZf/HSPBwZUm3Urp1TNT
         VgCJXtbBewFNob6oxZ7CSl2v4ku8zgdCw2IqiJr9xl583V9Cq8TCSgMsS5cSkgQhxwgC
         G5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtFEh3DLOYLlHvOQTkSDJCzq6CQ57SdIMJKKnFVuN48=;
        b=4AdHRbN67IbUAhMEiUSuBllpLIlEJ+pZr0h19hzQr01APrQPuop5L5lZ7MxfzghuR1
         qON6dyKDh/yL8MJ31okiBDN0VLDam50bzAWI+d/Oy/p2oQZi8bhKxUGxrqAgyFlNSZRB
         i/HAfKhDRF4tmMEn/bojS11OBMCDTXMJeXgyJH8sOT1g4eRpLFOmww+mHmleI3Rs4s+c
         xftnARkVMroN7VSduluF5R8cDA0o4XTB4QwZ96oT5/+WTfN+gOqxgoGu+SKsW3Irllpx
         dLDDAqu16p9XhD5c6osPM7eH5e7UkTc6a7ZXA6Iq+cYCaMJRPwWUURyWAzGpgDcKCkre
         NvEA==
X-Gm-Message-State: AOAM531rcSebzYjateZ+b/Bvq1V5CZHTBFv6qKRWPAt5RcEcCkNSgtm5
        4EzzkwAP7k0XJ2rrtVO42FU=
X-Google-Smtp-Source: ABdhPJxscxs5/E+RNVAzaQeYRt19KEG0ltRBScfY7uoXNg58pwqyDc3FpLwIXCvkEIDe7Z0HurnEIQ==
X-Received: by 2002:a19:e00b:: with SMTP id x11mr18671820lfg.87.1635201962032;
        Mon, 25 Oct 2021 15:46:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:01 -0700 (PDT)
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
Subject: [PATCH v14 17/39] drm/tegra: submit: Add missing pm_runtime_mark_last_busy()
Date:   Tue, 26 Oct 2021 01:40:10 +0300
Message-Id: <20211025224032.21012-18-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Runtime PM auto-suspension doesn't work without pm_runtime_mark_last_busy(),
add it.

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

