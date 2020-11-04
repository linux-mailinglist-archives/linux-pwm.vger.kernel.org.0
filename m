Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62F2A72E7
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgKDXtu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbgKDXpG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:06 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB2C0613CF;
        Wed,  4 Nov 2020 15:45:05 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m16so307120ljo.6;
        Wed, 04 Nov 2020 15:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQimpkIRWNQnMpbdhCpUPNBZvo/GpufqvOqt4z0qAwA=;
        b=ERKSO83J6tv0QUdt8vnWSOE1GpIwg7mIR1JUrs4PyfgPVzV1mH7mEpyAJOsSR12xY3
         rsldAI/5QE2rxBoNdwYh3hxk/wzRAkSsKIoHuD22P4lN8jkkBxNCFgbBpKfwYVwMtiZk
         hY1Z1gChPo7sDA1p9MxN+Mx1EdAo2nz8TwGsz+e38nVaIbWMWUcpVKqUAWxqflyFUc2z
         zmVkx897k9/dL5uXgyLRVGwDyjmwfMJMHjINdfH3z7T1O6RmI6/62I+J/f3RaDIG1/F3
         b5/NryfWaEyEXi653d2wn4BVQldGJhyt9pi+F4OHBx7bGp4zD1BVXptYQfB0SIoKU8RY
         hraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQimpkIRWNQnMpbdhCpUPNBZvo/GpufqvOqt4z0qAwA=;
        b=IwgLlblmv4oEz0X8GFhXSi1NawTXzJBOmCqbT24O4Z/uou33FoZn6A2xIc686i6Byy
         AWVsI2bhBn7Q/PVQNox+kKh0hMina6igFUtwQ5LKa/9OqXHXELDeY96PqtfLJuBrXlfX
         /uT+cS+5VkPufQ/D/cZGygUyH6brjSCD4tJiXvT8r7hX3jF3bgrVkDKbI9dOvv1FoqO3
         44CpLq6KkynYXK2O4VybELiyhEqowTyMvGSQyv4/t4g3e3Hen2E6FWTLO2Ajm6WO+Dko
         42DnU+/W4fcUKeHOQNrwSOJbrjd52FAmyRKVHE0StPaOZAb6w+FecGuzjpKU9NrDOnZg
         p4kg==
X-Gm-Message-State: AOAM531/WLVHSJg+Vgvx261wVKzzp4y+FyLZ1ASQl80C8tPaM8o8UP2y
        2P0EvjAdgGRCLg5a/hkTs18=
X-Google-Smtp-Source: ABdhPJzqZV2lUSiNvg9T7GHr724oG0dGwDbtok/GVt9MVRYZxSxIwkdsf2v5hnfIaDwbq85V2zwywA==
X-Received: by 2002:a2e:b169:: with SMTP id a9mr156579ljm.84.1604533504504;
        Wed, 04 Nov 2020 15:45:04 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:04 -0800 (PST)
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
Subject: [PATCH v1 06/30] dt-bindings: usb: tegra-ehci: Document OPP and voltage regulator properties
Date:   Thu,  5 Nov 2020 02:44:03 +0300
Message-Id: <20201104234427.26477-7-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new DVFS OPP table and voltage regulator properties of the
Tegra EHCI controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
index f60785f73d3d..e4070ae21fd9 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
@@ -21,3 +21,5 @@ Required properties :
 Optional properties:
  - nvidia,needs-double-reset : boolean is to be set for some of the Tegra20
    USB ports, which need reset twice due to hardware issues.
+ - operating-points-v2: See ../bindings/opp/opp.txt for details.
+ - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
-- 
2.27.0

