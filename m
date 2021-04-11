Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3295635B483
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 15:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhDKNKg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKNKd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 09:10:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A0C06138B;
        Sun, 11 Apr 2021 06:10:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ba6so11803652edb.1;
        Sun, 11 Apr 2021 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCYzJwo6K1czJ3Ha8iJ6GUOmqyR2V8U9jZN0dmotAHY=;
        b=ZkeBDZ2ncD0wsYopNcEnE9+zUHPk5WjFI72xM+ZgXw5uYivPtVuSBMhLNSwVDswUoI
         NbNW8LlwM8lfsRLBk272IuTJaKQ4B0e1ikaYM1b8hlYswP23KudzecNpphb7q08rf8kp
         XGWukKbNYUJ8Bmp73bzFIyaHX+mr85op4Wmh2K/dwGb84tIl8nie1TnIkKucyD5sJak1
         B5DO12scqQ/Nu3al4iwdIxLn2+R3yZdEc/yZPgAkdbbNJJ91sAFV+CUf3+XRZN5fwT2F
         xTSL/4exjRN7gT6/jV3IHh7ZbLdJKZpElZkzR/bq53M4HTBcgSWerj1X/5TflJWZmYHU
         mJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCYzJwo6K1czJ3Ha8iJ6GUOmqyR2V8U9jZN0dmotAHY=;
        b=P4qC+n4nSazMse8pxkcQGHTVMwECth10c4G8bgyazh0ID2GjqMxxRolC4XRsFi7OEd
         Dy2gxaMyEPdXMh/qoZEuvx/IoUkgGwyFkZEfUy7gYEFViLrDpav4dOLX0DMygQIA27Zy
         fNgLU1uZqrbUo/6U0J0BKyeutGRMgd9TvY9987ztpD6mFo3zFQfZL7oXdn0FB9vFgJDT
         068teOvikMrklH+qwpqkEgKfmtlg2cFssCDXaJkMM7VuC7JBNra+kSerX+Xl7dkv8Kvj
         1g1HCQ+cj/m6AAB30kLbhE4oggal2gc2or8AI9nrTXI62C2+0bvvD1d1+R7jTgxRij4p
         WtNA==
X-Gm-Message-State: AOAM532LJh3i7wDpj65ImvGUF2jI3TUnoZBot27XSA2ZbLppYVT6fFbz
        JGYgf1wLPmnM0D+rArZATjA=
X-Google-Smtp-Source: ABdhPJzpGqrXlZiBJI9Bz3cPk8TE7002GNinO06PQVO5Eh4H0wBgWlY84Q4Bp7s40YrvLiHFHbW5Rw==
X-Received: by 2002:a05:6402:26c3:: with SMTP id x3mr26213604edd.126.1618146615122;
        Sun, 11 Apr 2021 06:10:15 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm3983520eju.71.2021.04.11.06.10.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:10:14 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: pwm: add more compatible strings to pwm-rockchip.yaml
Date:   Sun, 11 Apr 2021 15:10:03 +0200
Message-Id: <20210411131007.21757-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210411131007.21757-1-jbx6244@gmail.com>
References: <20210411131007.21757-1-jbx6244@gmail.com>
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
Changed V2:
  changed schema for clocks and clock-names
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 142ce85ce..5596bee70 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -14,14 +14,22 @@ properties:
     oneOf:
       - const: rockchip,rk2928-pwm
       - const: rockchip,rk3288-pwm
+      - const: rockchip,rk3328-pwm
       - const: rockchip,vop-pwm
       - items:
           - const: rockchip,rk3036-pwm
           - const: rockchip,rk2928-pwm
       - items:
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
@@ -49,6 +57,7 @@ if:
     compatible:
       contains:
         enum:
+          - rockchip,rk3328-pwm
           - rockchip,rv1108-pwm
 
 then:
-- 
2.11.0

