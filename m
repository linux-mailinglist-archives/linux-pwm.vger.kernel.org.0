Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942135D19F
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbhDLUC0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhDLUCZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 16:02:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCFEC061574;
        Mon, 12 Apr 2021 13:02:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h10so16527400edt.13;
        Mon, 12 Apr 2021 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+jLQeqDVwDZITNTxZ7lqCyLYCdhzsUWl09kewB6trH0=;
        b=YZNwcdEImrCzGnD0FqZShGAeqfaj8pc/By0os1O5rLpJUb/eSLjfO+VDrRDeNSdhIA
         SXmJQcCGibEYDlGYCn18CYjpWEBBljP64+NGWLMMj6LptLDaCWupuVU/msVFN72yvABt
         ez5HLfMajASimP9jgXLAJf+WK96umC3zciy52o3+kpU+t+vwXz5vHTa7bE16YO0xmzVQ
         LSC5BLSeuvPwfB+Kl4TeBH3cLUBWlpvzSh+jH3lBBJoqna2pu0R55YWHEtl1kJu2mi72
         fSQj5rStNeNNB6Jr6ek0zooBcMlWIZfLNPBJV2bI5NDoQyQf+dRU814O4uFQr4fYW2hM
         4nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+jLQeqDVwDZITNTxZ7lqCyLYCdhzsUWl09kewB6trH0=;
        b=qLNFZIQM3qUN+0hNCAqV+Li6OAPt0Cem1k7eRNUEMHUatXqNPgGgFn7L0S4sp5ooVR
         /neZzClj7exFSt9NV03HO9QIBCHrONL+arb3c2AaB/OBGcZLoFQCCaGIdr4E/xkIJ0rb
         R1VJ14s/GZ4xN9Pgz3fIel5DAWq4rV30Vlq5zpCyhRvAo63W3nD9YotxpdBLWSqZ1vXa
         GHfGLzVRo4FXUTeKIQ6YV4xjqMgN6toI8yY8/axzJD+hvGg+jH1qTJegPPsrQwPdUgwt
         s9vbPugi3qoomnSuZm+TZeS1jfpaaqbcuN82Bs392hLQo6t2YmCboEx2cJi1cUh1ALRH
         EALg==
X-Gm-Message-State: AOAM533MbI8aF6fg29pDemQBJ8J3jR3CgvYNYAfC+Cc/gl1Vvh0xuRVM
        WtduENSGDfE/REKBpxOrkHI=
X-Google-Smtp-Source: ABdhPJx1jtaE/ZUGMEI+E3LxsIWY5rpu+gPFvZf6AVycYUhjxG8W4PL7/+hE1u9gNDTrCW/QkrAd0g==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr23721636edd.81.1618257726232;
        Mon, 12 Apr 2021 13:02:06 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x9sm7514531edv.22.2021.04.12.13.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:02:05 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: pwm: add more compatible strings to pwm-rockchip.yaml
Date:   Mon, 12 Apr 2021 22:01:53 +0200
Message-Id: <20210412200155.5316-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210412200155.5316-1-jbx6244@gmail.com>
References: <20210412200155.5316-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The compatible strings below are already in use in the Rockchip
dtsi files, but were somehow never added to a document, so add

"rockchip,rk3328-pwm"

"rockchip,rk3036-pwm", "rockchip,rk2928-pwm"

"rockchip,rk3368-pwm", "rockchip,rk3288-pwm"
"rockchip,rk3399-pwm", "rockchip,rk3288-pwm"

"rockchip,px30-pwm", "rockchip,rk3328-pwm"
"rockchip,rk3308-pwm", "rockchip,rk3328-pwm"

for pwm nodes to pwm-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Note for rob+dt:
A tag was not added on purpose, because by the change of schema
for clocks and clock-names I add "rockchip,rk3328-pwm" to
the "if:", so strictly speaking V1 and (V2) V3 will not be the same.
Please have a look at it again.

For some SoC nodes this patch serie generates notifications
for undocumented "interrupts" properties shared between
PWM channels till there is consensus of what to do with it or
someone makes a solution for the whole PWM block.

Changed V3:
  fix mistake with compatibles introduced in V2
Changed V2:
  changed schema for clocks and clock-names
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 19b42d31d..5596bee70 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -14,11 +14,22 @@ properties:
     oneOf:
       - const: rockchip,rk2928-pwm
       - const: rockchip,rk3288-pwm
+      - const: rockchip,rk3328-pwm
       - const: rockchip,vop-pwm
       - items:
+          - const: rockchip,rk3036-pwm
+          - const: rockchip,rk2928-pwm
+      - items:
           - enum:
+              - rockchip,rk3368-pwm
+              - rockchip,rk3399-pwm
               - rockchip,rv1108-pwm
           - const: rockchip,rk3288-pwm
+      - items:
+          - enum:
+              - rockchip,px30-pwm
+              - rockchip,rk3308-pwm
+          - const: rockchip,rk3328-pwm
 
   reg:
     maxItems: 1
@@ -46,6 +57,7 @@ if:
     compatible:
       contains:
         enum:
+          - rockchip,rk3328-pwm
           - rockchip,rv1108-pwm
 
 then:
-- 
2.11.0

