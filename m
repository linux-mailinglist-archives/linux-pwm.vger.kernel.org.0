Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1970F44FAFC
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhKNTnS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhKNTjS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:18 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076F2C061767;
        Sun, 14 Nov 2021 11:36:22 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u22so23882296lju.7;
        Sun, 14 Nov 2021 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyjSvb4lk8LZ0fmi7jCFtYmjUWcyFJSJ9ZWFZBD+V/E=;
        b=maH4dIIKowUpmhvo1nvasbs5OKzNudbTuKFIJsYGWjULge1tHtj4zqOdu1VEo5ThQD
         Glnd/VhdB3vL7F9jB0JYaof5JNlFMcmT2dTkiuBcsy6fdbPTRR9Cosg4q8ld0E3KLoRs
         QCOo/vBwI39ZdFmMrmnpuKUczLMKCAgCHXdLWUyUtBRwoZVaumPhfn22KWhw/uMM97eL
         6HM7goA+Mr6pmmVqQ/KtjQg3ceoyq2vDdCSsa2YqB5hn8QXM9nH36XE782M3t96uMhIy
         cjHLqnfq/ru1C8IAgMKjMGbRkU+0yHj8OmJgPwAuDICjHftwqM1lSMXmdFHtmuAdfqlw
         dvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyjSvb4lk8LZ0fmi7jCFtYmjUWcyFJSJ9ZWFZBD+V/E=;
        b=3veV8dDTe46beTaCLu35JgfDpWAsxIMNAzY1I/Sm4pC9Z+dvP10xGSK3xm/3uz6Sac
         6wY7lFxty37xZH4oflQnJS7pWhWH/q8/hmv3R4yPzWSEDirQW0BZo1ik6aRQayyPBnTP
         MpNtuSSstbfED6GS3giZWRPtlPQ0qfHiaBXx+yeTR1+zoWoGxil5xFyUdO5SSqbdk/qw
         b2XFVUxkOLN2iLMutcL4TULJk9B9Ueq0u2tvBUZ4zQsZ7TEiPl+I7hzpzOiO897PQDob
         tNlhOIDbP6AKVmgVEYg30B0dyUMbhbmYXzZRnP/p8La25W/lGUTnpL0d1Jx9q07U4LwL
         3n1A==
X-Gm-Message-State: AOAM532nO3u0HmT8zGlDhwQ5UJbRS5YCZ7vqcDB1SzDfQdcMqNM2+nht
        wLu07GYteu+REd4ubX9WscM=
X-Google-Smtp-Source: ABdhPJyyX3w24VyTnKWk6OR5+Zr92mvnvMrUZ04yBXX0uU6eSI60ZteV99zQ+/n6hcffVQwWJz3ZLQ==
X-Received: by 2002:a2e:b163:: with SMTP id a3mr33547827ljm.264.1636918580462;
        Sun, 14 Nov 2021 11:36:20 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:20 -0800 (PST)
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
Subject: [PATCH v15 25/39] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Sun, 14 Nov 2021 22:34:21 +0300
Message-Id: <20211114193435.7705-26-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
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

