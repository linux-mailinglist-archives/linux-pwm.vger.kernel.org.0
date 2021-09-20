Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43E412C99
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352400AbhIUCpt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbhIUCDK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:03:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D316C140933;
        Mon, 20 Sep 2021 11:12:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so68776008lfu.2;
        Mon, 20 Sep 2021 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDRA8PLugfMxJpXAqa8RlnWxOlWeZ2QqIDIb0I+7p08=;
        b=d8JLoar86bYdDuwtQzzRDeL3gNf4SPuMkjOSsa4ZW0BwNFo4Vptre58TdAYXzOFfft
         N88mtW3eOJjL9PzzPZwdpQOZP2h92XNYDl7oCYQAy+uRAnYUYMGh84D8wjiSgRRjr6o6
         R4uproNyfEKfji3ZBxslJOC7pOcUDZfRsV72sVWBsbiG6LA+hzL7CvXf6O0GGDX5sqOV
         m1ZwS5N0DgYSLEdRUs2uIkAC/XFlYLrTASvHL+RoKcH+90V/64UbgL99gBCiQjWHJkuY
         ixiR5TmkTPK6OaD2X4gyjhsCgaBgnd//ZCiWmp6QWfrZOQTcxCcfq7IVc3KdB97xHTQS
         W+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDRA8PLugfMxJpXAqa8RlnWxOlWeZ2QqIDIb0I+7p08=;
        b=VW+tAym4K68QQ1ru1pvCDwN7ZBtvnhG8anxIMyvv5+zGJqcG7y8uaXnVNDTxS62jG6
         0k59ATh/bVLDPnTHPdf0YAQ3u+gD5nSUOHS6uplkfzXrAoCg8gAEovOflBaEvhFHEJsz
         M6YtQqEcvW7j48c2rcoYVfb6uSeNhMg0zH1voSXDpCyR46+v+leD7LKB5sYbRaZoQvv2
         WOjvWtToDzt7twdDt8tW6aqqsIw9766svPlz3xI5AvVQVohurslLB4Ws8Trboht6BgwD
         rdg+gVPd4Cn6w7WhfUIzzAtHmcvUf84lspHkf5nMY46rDsPPV7jHrtvOPR54FcOXhXqm
         sxhw==
X-Gm-Message-State: AOAM533+BNakqnHlI4ctlRkNvkZlvjql5m/ObA0Rd7sGcj6I04g45s/+
        sRoN+3/zOAyBo2vbitc4cWs=
X-Google-Smtp-Source: ABdhPJxzOGQYFhwdTUUpL6T5q6kwkHiReYiDhT778cfXm1Qm6lqbC0qsXVxcjixUC0s1KeSzgwzafA==
X-Received: by 2002:a2e:8546:: with SMTP id u6mr24113878ljj.185.1632161557840;
        Mon, 20 Sep 2021 11:12:37 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 30/35] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
Date:   Mon, 20 Sep 2021 21:11:40 +0300
Message-Id: <20210920181145.19543-31-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All device drivers got runtime PM and OPP support. Flip the core domain
support status for Tegra20 and Tegra30 SoCs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 3e52ceada60c..7c7aff8120d4 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3042,7 +3042,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3103,7 +3103,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
-- 
2.32.0

