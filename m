Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497232A72E9
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbgKDXtv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbgKDXpF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:05 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F61AC0613CF;
        Wed,  4 Nov 2020 15:45:04 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so311101lji.5;
        Wed, 04 Nov 2020 15:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6xeyw6ZqKT/K4JMygz/BmuhCT9ICHlbp1KBA4DEr4A=;
        b=nqm2X6ZZJuj9sZgSTybdOUi83IBwYn9f7Zvfx06NhWRHbQaEo61dn0AWICDKuDsAzX
         WcnvRncZgz7BZ9/CebWWEjbmvtTisywn31eZ4pmGs2UNS0RRtZfCOBhiTwow/n6mPe9r
         7agAHRD0R2EELNcElIqennHlgH8OGOPHoFL2PRl+Ja/SdoRvkx4BsTmnP2gpWNQvarxG
         SjryQPM6YqWLBzOv3L/jKhwY2mKEYxloqIA7EIeYrN+YlKNWbDi4sdhMPjwR1DWYKbqi
         vxBJYm1aGkZ0x3sS+0lBKRX7ZCwqw3mmTLFKmuBg1cW60xhkD71EveU4NYFDyWJAnfX8
         8m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6xeyw6ZqKT/K4JMygz/BmuhCT9ICHlbp1KBA4DEr4A=;
        b=Y4b+7OImCnBVlJ+Z663vsf/jYtMe9v/tOiwVp/RD907m/yEFEWjdwzcBvHOkKU6qUr
         Qot8d90Bbt2sOH5rwtQLsqT49Hnlxj91zjWMKcLoraAzq/B4zDYInGcVO6qXbzDeY9ts
         6UnmHpBAMcjF58JUg8II3ztnwhBAi5kXTgtXpwnDcb4YfiwvoZ1c9uy+CSDWZObRivQb
         64P+S62TUDlYsaEw54JuCT6Aa8B+MEod5JzoSzhKFzCPwdjxB/lW10IxDniLYC4MMkTW
         ads0Luv84kxEsVdb2cPOyokOsJbbGzRCZKyoYyCdHU4QPn/XDPB2TAehaSYr85M+HH62
         etnA==
X-Gm-Message-State: AOAM533/xtgzEhIAy07fa3Ds9wgK+ykUHzPZ1a28X44zvkliEo2QOMxP
        aoflnOj8SFUyMJKjQ2rlh/A=
X-Google-Smtp-Source: ABdhPJzDTd1dZ6QvpxBBESnqfpznl55p7ubyewQPaYA9itl922HIytqPgmIH/zsQSw8jZFmiQ9g1kA==
X-Received: by 2002:a2e:b619:: with SMTP id r25mr134978ljn.465.1604533503104;
        Wed, 04 Nov 2020 15:45:03 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:02 -0800 (PST)
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
Subject: [PATCH v1 05/30] dt-binding: usb: ci-hdrc-usb2:  Document OPP and voltage regulator properties
Date:   Thu,  5 Nov 2020 02:44:02 +0300
Message-Id: <20201104234427.26477-6-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new OPP table and NVIDIA Tegra-specific voltage regulator
properties.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index a5c5db6a0b2d..f02a98201062 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -90,6 +90,7 @@ Optional properties:
   case, the "idle" state needs to pull down the data and strobe pin
   and the "active" state needs to pull up the strobe pin.
 - pinctrl-n: alternate pin modes
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
 
 i.mx specific properties
 - fsl,usbmisc: phandler of non-core register device, with one
@@ -110,6 +111,9 @@ i.mx specific properties
   The range is from 0x0 to 0xf, the default value is 0x3.
   Details can refer to TXVREFTUNE0 bits of USBNC_n_PHY_CFG1.
 
+Tegra specific properties
+- core-supply: phandle of voltage regulator of the SoC "core" power domain
+
 Example:
 
 	usb@f7ed0000 {
-- 
2.27.0

