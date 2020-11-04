Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE92A7258
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgKDXrS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbgKDXp2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:28 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11FC0613CF;
        Wed,  4 Nov 2020 15:45:28 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t13so277303ljk.12;
        Wed, 04 Nov 2020 15:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q04sc3lZzk/7Y2Vrk729DLPvzmihTnah64pqG8qeyNY=;
        b=TONR2+QYbapieLnDTf0Jk1QPqXZDWAjT9sIbfsQFU3S1ETVVTGWoJK1Ebv6MvCDAxu
         iFk8mmpyuk40cSTU2xGCAu0IvpyN9KggSBaUQ0HHUcphlkxTbwyPOPgcJyrtemqawCUZ
         IzkDtKXECzbZCA4IZob2ibn2+8dNPZTXjcCGMnrjW2yoErdNbjFSO1mXDS+eEXyo3O1Q
         MiuzyQ7fZ3tJFl2zUxr54tAVzMmTWH5TTg40i9bJj1HAViKxiTpO4EWYns9q1Jeg+pQs
         KLY3Dznjpa3LVkpFr2X2vcRQjrEZceJCA+H2N4jXkG7kOszuNZZdKNm3I1X6sEtQCAK/
         tPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q04sc3lZzk/7Y2Vrk729DLPvzmihTnah64pqG8qeyNY=;
        b=ttrFGMrWo9Od/wPrCniM+u/qV/rAbQdlShPfD/6ngGAWCvxiBSowQwPuWr0r8ZOFr3
         gvonxSBk/utw+vFWWs8NR2il8NtUI4BzhMJ5fhRovdKu3VcTjmShpjOspVBiCpGd9Rmt
         6AaqHwr4QxvA5CeoaPesgnqUZQPBBrGkNKmgvAoB3yVhJa3+9IVZTG2naz7JPkHi6oS6
         10oVLuXuxaIkC0KQObw0E7gzSq/5pndSUmSb98ULAx5+DOcjVI+m7RZ2FIrhsYs6N3qS
         BMt6Kllc1Ug4wwtcE5mm2pwTEKtXxP+o0MmisnyRvP3dxjWXE73OSO3nIIt+j2pm4UxI
         sCBQ==
X-Gm-Message-State: AOAM533mOLmZl8T0f4DQ5Gb+GOSKyCtl2cOqNok+cEE3buXOAaSjWi5i
        CibJ1gGLTjMmXLiRMvQHLUzhLe0YfBs=
X-Google-Smtp-Source: ABdhPJy4JvIN2UzMvC1UGoXxnZuYWhG4YhonA0JFk9Z9oJ2zbTum5L2HXCOgLCmGf47Q0qaQDlrH3A==
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr161088ljn.30.1604533526786;
        Wed, 04 Nov 2020 15:45:26 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:26 -0800 (PST)
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
Subject: [PATCH v1 22/30] memory: tegra20-emc: Support Tegra SoC device state syncing
Date:   Thu,  5 Nov 2020 02:44:19 +0300
Message-Id: <20201104234427.26477-23-digetx@gmail.com>
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
required for enabling system-wide DVFS on Tegra20.

Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 9946b957bb01..b1b0a2439689 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -1129,6 +1129,12 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void tegra_emc_sync_state(struct device *dev)
+{
+	tegra_soc_device_sync_state(dev);
+	icc_sync_state(dev);
+}
+
 static const struct of_device_id tegra_emc_of_match[] = {
 	{ .compatible = "nvidia,tegra20-emc", },
 	{},
@@ -1141,7 +1147,7 @@ static struct platform_driver tegra_emc_driver = {
 		.name = "tegra20-emc",
 		.of_match_table = tegra_emc_of_match,
 		.suppress_bind_attrs = true,
-		.sync_state = icc_sync_state,
+		.sync_state = tegra_emc_sync_state,
 	},
 };
 module_platform_driver(tegra_emc_driver);
-- 
2.27.0

