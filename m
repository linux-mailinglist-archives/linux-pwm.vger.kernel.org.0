Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F2143A790
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhJYWu2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhJYWte (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:49:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551FC061237;
        Mon, 25 Oct 2021 15:46:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 188so2243726ljj.4;
        Mon, 25 Oct 2021 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyjSvb4lk8LZ0fmi7jCFtYmjUWcyFJSJ9ZWFZBD+V/E=;
        b=SX/gnh45gslYMVUdGkMRUsgcC/8rE9TZMnK6bGOrBe0m9m7Es/d+v0MXP1d0gbV2mU
         qwFkFwhrxyZw9dtPtgVCJA/6OUD4jlZVtIFgPJF/55jilzMNCXe36g29FqFg2wLRJMGg
         ljdpNqZB2DA0HyJI7jmbSewnooe5Rc8/AH7W2hDyRAstPM6zA3lGeKRmad4o8LOhfgsh
         y6tLuYY1LP+3aQjfw2JQDu1Odx1uT/l8/a2KaQ5ftQ4H4RM+0XU3fpuKEozuQx5Na/wF
         aEJj4gv/IQlPuyelPoDN+ZEJ8deGIY3iiC32rb3oi/tWue1datDxTQXrpSRK9ttaRNOH
         jv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyjSvb4lk8LZ0fmi7jCFtYmjUWcyFJSJ9ZWFZBD+V/E=;
        b=dY0Mo/STk1mW5LLrB925JMb5VLVfSVoXsT5PCwnmKlZCIb081+f9B1leMzqgrvH2Bc
         kX08tl4grIUPRZbD3U3nGB5UIzmqKskmK6o4//N5rzEtcqnBzO/OL3fwSLIADfZAIKq9
         4f6z0TadXDv2MGn5MSX5YpfK4ARCvhf+TI51q8laQtlwllOiCt/dxJn36SO6Ln1QkBSt
         Np9JMSidAWgQ7tcYfzYu/YBsFcz6dX44zEfIEerIBZ6E8Ec5aV96K/Xj+0EBxCeDL4Av
         WwEaE/DGSB+EoVMj8EuFKHgs5eczZrj88/AGgFG72n+XgcSCRbKSHFrEK3FBqsKe+dEU
         OIYA==
X-Gm-Message-State: AOAM530JCVT7kYEqsP8rsN6gIvh13ePyMqOG3DbeNx3yCdBhkIiNk4ZR
        yimX0QP0c3fh71TtcO6KUr0=
X-Google-Smtp-Source: ABdhPJwvUcwgS2ID7/43ZFFbCQ4NtHWCU/zB6tUvOE8lJoNPgwB90NoQwOL130kVjL0DmoRpJBuFLw==
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr23222224ljq.300.1635201969271;
        Mon, 25 Oct 2021 15:46:09 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:09 -0700 (PDT)
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
Subject: [PATCH v14 25/39] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Tue, 26 Oct 2021 01:40:18 +0300
Message-Id: <20211025224032.21012-26-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new OPP table and power domain properties of the video decoder
hardware.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/media/nvidia,tegra-vde.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
index c143aaa06346..4ecdee1be37e 100644
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
@@ -68,6 +68,16 @@ properties:
     description:
       Phandle of the SRAM MMIO node.
 
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property,
+      which is a bitfield indicating SoC speedo or process ID mask.
+
+  power-domains:
+    maxItems: 1
+    description:
+      Phandle to the SoC core power domain.
+
 required:
   - compatible
   - reg
@@ -104,4 +114,6 @@ examples:
       reset-names = "vde", "mc";
       resets = <&rst 61>, <&mem 13>;
       iommus = <&mem 15>;
+      operating-points-v2 = <&dvfs_opp_table>;
+      power-domains = <&domain>;
     };
-- 
2.33.1

