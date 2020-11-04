Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C091A2A730B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgKDXtw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbgKDXpD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:03 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E00CC0613CF;
        Wed,  4 Nov 2020 15:45:03 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so177581lfc.4;
        Wed, 04 Nov 2020 15:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDQcvrPMx8drC1s+JMdYzz1VL97g9qI4z34Z2y/XS6Y=;
        b=Dy8bsn+8gKozpA8LFXNo9rNaXYZi8RiG8JuZ7GCiOUv3f8EqLH9Yw1DWyrHCG7aXCa
         nBna2kBpxCxa6756mpfF/sRJLengE1u0981vSeVZ0iww1/R6MDBNg0z7cp8n3hpUWVSG
         FjsBHb432QblMRC0hfqqL4Td+fPBtzgidhCB8OrfImcHEK/zTulOsaqMZyxf2OL4je50
         7YzggrtiQ+LZ1ok9kxO8CnZAsV2JQjx98NF/dI6kmyaIX//EtNilxbc+Qcrm5rRwGz27
         NGH1GnvYdauAc1/ekPxqEtzZNVUC1H9TKTl5j5EZH60kcHtxQ9rJ2uyMKymZmVEh5kbP
         uWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDQcvrPMx8drC1s+JMdYzz1VL97g9qI4z34Z2y/XS6Y=;
        b=fUznQ9Qp9Hz107XWTmbzgiJHdvJuYMjCRHa3SJ9XoJmIRlNv0xOJ2HPoZeGgGLIOBz
         MiIVU30maiDuOX2rwZUEsgO8atvy1IfCGAh0mEM2YhinTdjowDx+SP4Lkbv5GTkFCuls
         ttYhYGlN7Wt+4Mjz6/GSN+l1dhQZWOxqyfgN+f1wgtq5MaP6G3ru5ltsVRX15ii64Frv
         eHJA3eMFFsap5Uh29zGXn9LCDs8T2iV3Cql3IoSMyESshcOODkRNqvPh7lULJ087w/Jg
         0ymCTNVlfF1f7r5zy2QiK4ZOHfy5WivSFeuoXAL+vBBLB6UR4oDt6sCpQDy9FQ36tCbR
         8uPQ==
X-Gm-Message-State: AOAM533LRov397ySNZIeJGRWYIOGWwWeMbXq939FgpRE3WzBRmLSyZwb
        1p/bwV9FQKCMijMHZM6KprXBmFexnB0=
X-Google-Smtp-Source: ABdhPJz3iuYSiUPzblNYJ3AouIs2I+aBCXK/4d5+EJAE3Br8G9yiMX5bbzdh7qOCN/1x3cb5bQOQVQ==
X-Received: by 2002:a19:8285:: with SMTP id e127mr54285lfd.270.1604533501645;
        Wed, 04 Nov 2020 15:45:01 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:01 -0800 (PST)
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
Subject: [PATCH v1 04/30] media: dt: bindings: tegra-vde: Document OPP and voltage regulator properties
Date:   Thu,  5 Nov 2020 02:44:01 +0300
Message-Id: <20201104234427.26477-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new DVFS OPP table and voltage regulator properties of the
video decoder engine.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/media/nvidia,tegra-vde.txt   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
index 602169b8aa19..9854fa9d3cd3 100644
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
@@ -36,6 +36,16 @@ Optional properties:
 - reset-names : Must include the following entries:
   - mc
 - iommus: Must contain phandle to the IOMMU device node.
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- core-supply: Phandle to voltage regulator of the SoC "core" power domain.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: One bitfield indicating:
+	On Tegra20: SoC process ID mask
+	On Tegra30+: SoC speedo ID mask
+
+	A bitwise AND is performed against the value and if any bit
+	matches, the OPP gets enabled.
 
 Example:
 
@@ -61,4 +71,6 @@ video-codec@6001a000 {
 	reset-names = "vde", "mc";
 	resets = <&tegra_car 61>, <&mc TEGRA20_MC_RESET_VDE>;
 	iommus = <&mc TEGRA_SWGROUP_VDE>;
+	operating-points-v2 = <&dvfs_opp_table>;
+	core-supply = <&vdd_core>;
 };
-- 
2.27.0

