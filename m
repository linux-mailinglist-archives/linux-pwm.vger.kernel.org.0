Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F173387F0C
	for <lists+linux-pwm@lfdr.de>; Tue, 18 May 2021 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351353AbhERRzs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 May 2021 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351319AbhERRzq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 May 2021 13:55:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18CAC06175F
        for <linux-pwm@vger.kernel.org>; Tue, 18 May 2021 10:54:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p7so7457879wru.10
        for <linux-pwm@vger.kernel.org>; Tue, 18 May 2021 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLVQ7hIqXEULCgZ/4wiK8+ueeFxBJlxUXknsRaEIBHA=;
        b=Fw1hiSEKJwwWL4NurL0SjZg9GALsBP+nS9UPU6oFcZOXSdUM3c25El70ylGrJ7XPBZ
         JplQI+zkgEdFTLbJ/DJEEry6En7TI1P2kUM1wDrZKIS5FMp60iwF5y/5ctYpLqEdfaje
         zsP5m/516eJcdr/aVZFMEMVSC0yrRLz7zrhbHDnU40OQk+UyYTmT9KczAfN1pQWBW2mm
         /nnyQfkzFsOt9EGCaNN/4q5lFYd3XHKk6oD+cXu7nC5V6xBma4pFnwYn/V/cZckuQ7ao
         6zuKdep4qJflBGTs7ddu+uh7vP5JsONiuRJAnLp0ZF2CL/Y9jJzPo2HAMFppOfxgfMux
         prrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLVQ7hIqXEULCgZ/4wiK8+ueeFxBJlxUXknsRaEIBHA=;
        b=Z7n4p7siNY2nB1FoDNi9vblreLFnSQM1rXASvhbYcCd1sr7z2vK0BD80tkdrqaISVh
         zgCI5EwGdTarvWJ7esxb5Mqy5uelCS6Pzn5PEpqjT7AgyjE+PLsvgV8NGVS/GcLZKkyx
         SEzJfcaKleC/PI1baQK8PEGqWa1Z9MGWpfzzxIBzhZ2Qg9f4fylCbEFhdwK+zb7QN2LH
         uFSeujQsb2oFvqFxC078jx5movOY7tliNidM6PZ/ZFGB1hljl6RpL8tqXcBGAVSyrliO
         PTeYkpLqlZ65SNnfKhlCNNhqWNcVWyPaKub6brNbHpj45hznMjQNHRQxheNQL4H5+nuV
         9dgg==
X-Gm-Message-State: AOAM533uqrIBux7vLqtt7N0ts2SFjBPteatHwKpM1fda2tzsPTtc4eQk
        ifkeXKIpqlXTBhbMVPjcZXw+VA==
X-Google-Smtp-Source: ABdhPJwm91GbLiu6awzKvHAEIvP7ZGY0aWkr8qz5BvRRbbR/Sgfv5RR/wmv+HKpYkgxbUn5hDqfw8w==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr8455935wrr.116.1621360466340;
        Tue, 18 May 2021 10:54:26 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a17sm14458963wrt.53.2021.05.18.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:54:25 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: pwm: pwm-mtk-disp: add binding for MT8183 SoC
Date:   Tue, 18 May 2021 19:54:20 +0200
Message-Id: <20210518175422.2678665-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518175422.2678665-1-fparent@baylibre.com>
References: <20210518175422.2678665-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add binding documentation to the pwm-mtk-disp driver for the MT8183
SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
index 0f016c81cd53..85bca1c59f95 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
@@ -18,6 +18,7 @@ properties:
           - mediatek,mt2701-disp-pwm
           - mediatek,mt6595-disp-pwm
           - mediatek,mt8173-disp-pwm
+          - mediatek,mt8183-disp-pwm
       - items:
           - const: mediatek,mt8167-disp-pwm
           - const: mediatek,mt8173-disp-pwm
-- 
2.31.1

