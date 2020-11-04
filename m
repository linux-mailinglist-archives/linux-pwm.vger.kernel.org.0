Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640C62A729E
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgKDXsL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733109AbgKDXpP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:15 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE53C0613CF;
        Wed,  4 Nov 2020 15:45:14 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so173829lfo.5;
        Wed, 04 Nov 2020 15:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GdfWHUaJuS5SoIO3s3NHsXGshyNXM4oAFxRbthWkgE=;
        b=P4gTaLsCzg40YfN/+eDtmkytwvz3j6y/tLzbROBla8Lyn2uhMCZ9nQWk13kTV4Zk2I
         bnHXdTZ7JCgH2482+Bsq/SEutpf++F4rOA54+MOWEZoP1878JraQZGvFkgpKLj9EJ9oB
         Ur03LDACJy0Gk205Uogo9GuQ+XlgE8hF5XT1rgOzSpD2VK7CysF1SUQsEUWdgW7G/mUI
         rYhkJpYmOhvAYzocuXFm3t15Z32tacpF1m+u4i6DQO3oVETuAQznjAJx8HWU0saop/GI
         IZIcJRr08uQZnL9VfqjuEXvNgEuv/wV/5Cqn6nFXMW0PNPirIrgP8gZewdRK4OP6fS91
         JzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GdfWHUaJuS5SoIO3s3NHsXGshyNXM4oAFxRbthWkgE=;
        b=Vx2ie8dq7fKKA83ypRpo1CFYhqmOUXJYgo3SCAK6knNOWd3SGHpODOd7uB0Bih08EW
         d4eJUd9MMTMorqr8qiSGzoDcRnHmi4Am+ZXple6rfXXSGpeb2MheyfCiDSa9JbDUnHdI
         m8UMmn9z/9Z353XbtfMi9rGbuLQiigIFz16TZPB91TtdyxEvKjMtkuif5TApsnIIhzjd
         Z+hGDG5xDwC9gQ9dtUtNxe2tnYlBqh9xgdU1ng2nCImKvthB+gQkdcdPVQWlMdOP7C0N
         1HyFAH74n/yln8wQH+CKvmXc2C0wppnSj/hO7XJE34aGcGUo2qoz/MiC04CtN3kecLz/
         fr6w==
X-Gm-Message-State: AOAM532ZP6fPVt/Y6x86cgPp4kD8JvvxUiHke+qgYLB06EK7NV3b4MMj
        Hh4VQ4nsFUHgB/+EMf91Bog=
X-Google-Smtp-Source: ABdhPJznyaKA15G7U7xNtBj9EgmdWFE2bHuNPgYQzw2meXnv4UjsY+M6043F6TKa+k1IIrlJjtZbHA==
X-Received: by 2002:ac2:562a:: with SMTP id b10mr47103lff.562.1604533512794;
        Wed, 04 Nov 2020 15:45:12 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:12 -0800 (PST)
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
Subject: [PATCH v1 12/30] drm/tegra: gr2d: Correct swapped device-tree compatibles
Date:   Thu,  5 Nov 2020 02:44:09 +0300
Message-Id: <20201104234427.26477-13-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The device-tree compatibles are swapped in the code, correct them.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 1a0d3ba6e525..f30aa86e4c9f 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -162,8 +162,8 @@ static const struct gr2d_soc tegra30_gr2d_soc = {
 };
 
 static const struct of_device_id gr2d_match[] = {
-	{ .compatible = "nvidia,tegra30-gr2d", .data = &tegra20_gr2d_soc },
-	{ .compatible = "nvidia,tegra20-gr2d", .data = &tegra30_gr2d_soc },
+	{ .compatible = "nvidia,tegra30-gr2d", .data = &tegra30_gr2d_soc },
+	{ .compatible = "nvidia,tegra20-gr2d", .data = &tegra20_gr2d_soc },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, gr2d_match);
-- 
2.27.0

