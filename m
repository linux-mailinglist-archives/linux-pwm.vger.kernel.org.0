Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E323F43A7AE
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhJYWvG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhJYWt6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:49:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898FC079788;
        Mon, 25 Oct 2021 15:46:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o11so19485080ljg.10;
        Mon, 25 Oct 2021 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geO1923AWqbQV0ZHVSFZZlCETWhtbpam6KIpanWLvLY=;
        b=DVHEJ18tuxzBcbjTR840zMvey9CCXY2CvoS4fRQuXym6mNzzDQxq1509R9XPaxgT8J
         BQd2inC3sAs5K6b94joZQVgZYL8U0LrlEIBMtYk/MFNrIPA3BY7XxczS8OYyxyJqilOD
         880F2dmg9+MDhqQK5Cz0O4pCuTMVffCCJL9GCSHDhvkXXtQd56Jv3zkx5XTZam4ncquw
         IuHAy+K82y7IQjENz75atzENY+kGokoZtJkwFnsj1qrhtdefTQ3dNnrXXfhejdN/owvU
         ou/PiwNyOvwogZKVlaoUNdinf9vV2jo+WY9bg01kti2iChZNmg6zLFDCxVLmd2WMBnVS
         LxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geO1923AWqbQV0ZHVSFZZlCETWhtbpam6KIpanWLvLY=;
        b=2IumGydCVjyQcYLIrSAon1bbJYDE7l4WRy5NayaW9TNIwYlLKg+V/V8Y/Ek3RWOrqW
         Or5h2bl8kFiK/EBH2rlck2aMHhPOsoXICOZEhJDRFMcnUKrws9+Cnkle+Xj9DPQtS/mS
         Oy7pq3ZGlfUwKqSutX9jYJH/CJ+zolIaAiz0563VpfC214SuBkd6DPmtDheTtTz0iGgt
         G8MGX5SiAyDv+hCutUsSqBoJkAVmcIzcID4eaB/KyaFlMUdu9Nv/j0gZecL2rd1tvX3O
         gmGX3RJd+s4oC4+s7TSOhwPyo+eM5nfKvozLnR4GgYkWuIN3tAXSijkdxX4lPpdaBc2/
         vxJQ==
X-Gm-Message-State: AOAM5308MPxNQWwcD9LD6cJPIKBjCZzb7k29cUpU44nSpGG/0/+Ru/1q
        0LOIUcy3bLv8JbFm5RTYsnp12I27I6I=
X-Google-Smtp-Source: ABdhPJwZZ6JrYXaHlvUTnSapnMScCELz6b/X2rjYOT7ih4JhhzNhVrQbb3VcD2jBz2wtN+9v9xeRvQ==
X-Received: by 2002:a05:651c:c5:: with SMTP id 5mr21766849ljr.48.1635201973727;
        Mon, 25 Oct 2021 15:46:13 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:13 -0700 (PDT)
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
Subject: [PATCH v14 30/39] soc/tegra: pmc: Rename 3d power domains
Date:   Tue, 26 Oct 2021 01:40:23 +0300
Message-Id: <20211025224032.21012-31-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Device-tree schema doesn't allow domain name to start with a number.
We don't use 3d domain yet in device-trees, so rename it to the name
used by Tegra TRMs: TD, TD2.

Reported-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 575d6d5b4294..5c6d58a27c39 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2963,7 +2963,7 @@ static SIMPLE_DEV_PM_OPS(tegra_pmc_pm_ops, tegra_pmc_suspend, tegra_pmc_resume);
 
 static const char * const tegra20_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "cpu",
-	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_3D] = "td",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_VDEC] = "vdec",
 	[TEGRA_POWERGATE_PCIE] = "pcie",
@@ -3071,7 +3071,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 
 static const char * const tegra30_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "cpu0",
-	[TEGRA_POWERGATE_3D] = "3d0",
+	[TEGRA_POWERGATE_3D] = "td",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_VDEC] = "vdec",
 	[TEGRA_POWERGATE_PCIE] = "pcie",
@@ -3083,7 +3083,7 @@ static const char * const tegra30_powergates[] = {
 	[TEGRA_POWERGATE_CPU2] = "cpu2",
 	[TEGRA_POWERGATE_CPU3] = "cpu3",
 	[TEGRA_POWERGATE_CELP] = "celp",
-	[TEGRA_POWERGATE_3D1] = "3d1",
+	[TEGRA_POWERGATE_3D1] = "td2",
 };
 
 static const u8 tegra30_cpu_powergates[] = {
@@ -3132,7 +3132,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 
 static const char * const tegra114_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "crail",
-	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_3D] = "td",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_VDEC] = "vdec",
 	[TEGRA_POWERGATE_MPE] = "mpe",
-- 
2.33.1

