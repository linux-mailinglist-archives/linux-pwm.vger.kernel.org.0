Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A389B387F0F
	for <lists+linux-pwm@lfdr.de>; Tue, 18 May 2021 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351397AbhERRzt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 May 2021 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351328AbhERRzr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 May 2021 13:55:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A5C061763
        for <linux-pwm@vger.kernel.org>; Tue, 18 May 2021 10:54:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so11193371wrq.6
        for <linux-pwm@vger.kernel.org>; Tue, 18 May 2021 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTjBUDtJCB1J9ynhq80z5EUfzEOQqX8trIBK7k8vqMA=;
        b=K4IpbOBeRCDOgQiM6FDeJT3mk1uhIKsw0dzbEbSPM1skpiUAk+nb9km8r3h/745grb
         /HLeM3mmZwtutSsG50RHiRis51y6YQei9vpzPt8Lz9jAJqcfh5T27atB3JxEUtZjZyIb
         xMIILo0/85wryKnJD9jmv10XAaEHukZ9NYvIoHRzrz42g50p/R5atl2iYlftxJ1zxyoz
         M2Rk93DnSuW1Ijfh2DKwFhi0Fd1VGPcgdrSTH9Pyqp5Ndn7ec4NMbKncBdhIR0ydireS
         Pz3rXpQ4XtkJya2vrNQ8kN0ETSPtXT2znaP1BFE7odo+p+DhnDd2CyGdUumOQ3vp1C8S
         UX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTjBUDtJCB1J9ynhq80z5EUfzEOQqX8trIBK7k8vqMA=;
        b=U/u/NQPxUBB+wMLdYdB1t87cF9zgVAdNDVRSTuZyQ9bHFZUOhX4kTf8UZhYngeMgGv
         n2Po0nxRVcp7+M210/Q3IxrwT1rCTrOvs1QKZwtr9YY2RMt22gMeVAV1hafLRC7n20qS
         i4xze+FIvz6MxMi8SV/+IfADOqLep0fvZTgcNQCzBd5R5P8IYQDUDuL+rR/ouI9SdH/y
         7lNxMbPexPnIRttAR+z8pGX3aCIR0pMpUxLH12gs2TH4oqVw/nMi+dfoX7LDruHs78sx
         21SmcGIMYL+q2yEh6Ic62J7++mtCn5+20hmW3q40cabvDzf+aPo6Qbhwru8+DjHkrSkM
         T7GA==
X-Gm-Message-State: AOAM531jucLa2tNJEA5Bt13Z6YzxBB43+/zhLgqT5L9J1QClviTsnEgi
        qw9K8+o7XazLpAdeBrak7dM7cA==
X-Google-Smtp-Source: ABdhPJw8Tr0azrXxw/3cA5XoNuS3GO362ZVgSmK+kMj5HqdWeyqVqXBzGMEbV+QpbfMIDmo1+rvA8A==
X-Received: by 2002:a5d:4346:: with SMTP id u6mr8631720wrr.304.1621360467692;
        Tue, 18 May 2021 10:54:27 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a17sm14458963wrt.53.2021.05.18.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:54:27 -0700 (PDT)
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
Subject: [PATCH 3/3] dt-bindings: pwm: pwm-mtk-disp: add binding for MT8365 SoC
Date:   Tue, 18 May 2021 19:54:21 +0200
Message-Id: <20210518175422.2678665-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518175422.2678665-1-fparent@baylibre.com>
References: <20210518175422.2678665-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add binding documentation to the pwm-mtk-disp driver for the MT8365
SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
index 85bca1c59f95..548ec7e06028 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
@@ -22,6 +22,9 @@ properties:
       - items:
           - const: mediatek,mt8167-disp-pwm
           - const: mediatek,mt8173-disp-pwm
+      - items:
+          - const: mediatek,mt8365-disp-pwm
+          - const: mediatek,mt8183-disp-pwm
 
   reg:
     maxItems: 1
-- 
2.31.1

