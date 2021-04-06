Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4568355882
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbhDFPvM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhDFPvM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 11:51:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D55C061756;
        Tue,  6 Apr 2021 08:51:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r9so206364ejj.3;
        Tue, 06 Apr 2021 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qj4ZbUSCwnNRsGsyd4823o8NwDOo/ZM9rO1POtn+Q7M=;
        b=mMTsP8eKqHQw2U/phTGdhcue3frO4TNws7ugE+cWsrZeQtb0YH6uYR3KOUZEGH8tmq
         sT3OOHCOJeJnSFSLmgn8qiV8O8kJ+4amDvi5kPSPZh7HwFqsxe7qGkJFGVV3Wyskrvbb
         vX4nZROVWP1lFWuBdJN9i3vwL7qw7rZRBAzdKs7sHMB/KDp5GJrE2V/bQp6I0C/gAOB1
         Q/PJiJpH1AZssOpVgcvm4+ujyKpjE8R+MwcngypfdJpTrWJSJd4hoWmXDRBivbZhAAYi
         tDJaZjE/6RKGBRHtVgALilx7DtYjr5tUwW5yLRa7hev6k0oNKzJJaeRrYAunKPFY1zH1
         Eyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qj4ZbUSCwnNRsGsyd4823o8NwDOo/ZM9rO1POtn+Q7M=;
        b=Omi9XimasZ5kDm/u5k25DiiWbGWic/0xurgZnnHplinLcaR3pe03SSICEB7A+UfBh/
         d8vqTwV1ddTJieAfeXcj6YdXdY6IvXLZRoAZSVxYKQwCLjway0PKzU+WJPYGWrqNtK1G
         VlxeCtnZFQC3ZMNy3SydXxe9B4SGdHKZTgOFid0gXbRXVBs1FKlIz8QQztvnyw2xcXLZ
         joNomIQuUWwmLa75SgPVZw0aRWgf826rtH1ENWdNlULBU6h65wcHAebYws5obeTbvwXa
         6AkYmR1o1h7jmOMBZcJAjGWfSH+DExdMvkUCh49A8lY6qJ4uuUV20bEWW9l1zgSD5Agv
         LtUQ==
X-Gm-Message-State: AOAM530soilWdKgfqrtvnsvPkxXYEU61Shb4xFINHGyZVMtVpbKQXSbI
        dLCG+dFG6TSHvgmxgjfyVqU=
X-Google-Smtp-Source: ABdhPJyG2PqjLSzQz7sM421IaGpYPRDFTvC2MggBRpVNNsIld3uI8NWFbgb77DuQxdTZYdXa3dDQyQ==
X-Received: by 2002:a17:906:6dc9:: with SMTP id j9mr17253967ejt.188.1617724262892;
        Tue, 06 Apr 2021 08:51:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h8sm13894327ede.25.2021.04.06.08.51.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:51:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: pwm: add more compatible strings to pwm-rockchip.yaml
Date:   Tue,  6 Apr 2021 17:50:53 +0200
Message-Id: <20210406155053.29101-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210406155053.29101-1-jbx6244@gmail.com>
References: <20210406155053.29101-1-jbx6244@gmail.com>
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
 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index cfd637d3e..3945d586c 100644
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
-- 
2.11.0

