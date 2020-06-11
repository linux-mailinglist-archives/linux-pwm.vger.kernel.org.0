Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33381F6E24
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jun 2020 21:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFKTrm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Jun 2020 15:47:42 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35271 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgFKTrm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jun 2020 15:47:42 -0400
Received: by mail-il1-f195.google.com with SMTP id l6so6661891ilo.2;
        Thu, 11 Jun 2020 12:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK+t43t1Hiu49niOjoiAk6QT8hsunadSZgg0ZsAlxO8=;
        b=qqtX388uYXgwv/C3B/0Tc4VuCHJb0RYQaEaJaMqe9WoTEogbd9GWpKtyoyL9Gn98tm
         puBbubWxaYeVNULTzbKPN0fH5e1dxPcSgxKBd0UypxNVcKYTpumKdpIB4h2EJGiYWoLb
         16d/OXOGxuNil1YXwEO3QYOVl7Y/IszCtZKV/dgOqkYXivWMI6ZCgOqzgVfZtd4lGh7z
         HYPAYEGm02I1T53UmCpfKa4WFUjr4RlG/tJl/1MF9nsEhfrkkBNiF3mYlGXdN9wohKKp
         7vc0uike7BIYlKy9ev2flrIXsM8HcpUtYEcAxbploIqNYYdSr5ECjOKAc9/WqNIkK5ax
         n3Vg==
X-Gm-Message-State: AOAM531ThvgPLe4qBmG2xw83ih0ov91IJLavQs1UmzxCZaq4eDow/vD2
        WUcNGVIxoLFb/1DduqRK3ONUV4w=
X-Google-Smtp-Source: ABdhPJyWUfp54QtbeRz0aH44OOIGxZU6qXCIt1YYjL9q98Gde1llyKez2AP1i5rbhCjvRVxcl/jCJQ==
X-Received: by 2002:a92:5e59:: with SMTP id s86mr9749046ilb.104.1591904860052;
        Thu, 11 Jun 2020 12:47:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id t28sm2081905ilb.49.2020.06.11.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:47:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove redundant 'maxItems'
Date:   Thu, 11 Jun 2020 13:47:38 -0600
Message-Id: <20200611194738.1480393-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There's no need to specify 'maxItems' with the same value as the number
of entries in 'items'. A meta-schema update will catch future cases.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/imx6q-clock.yaml     | 1 -
 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml    | 1 -
 Documentation/devicetree/bindings/clock/imx6sll-clock.yaml   | 1 -
 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml    | 1 -
 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml    | 1 -
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml           | 2 --
 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 --
 7 files changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
index 429e3b62b965..92a8e545e212 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
index 135568c46350..c97bf95b4150 100644
--- a/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
index fa55f1ce3e57..de48924be191 100644
--- a/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
index 982d698e8c54..e50cddee43c3 100644
--- a/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
index 3c779eea6394..36ce7667c972 100644
--- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
@@ -23,7 +23,6 @@ properties:
     items:
       - description: CCM interrupt request 1
       - description: CCM interrupt request 2
-    maxItems: 2
 
   '#clock-cells':
     const: 1
diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 4b62af27d4b3..01df06777cba 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -30,13 +30,11 @@ properties:
     items:
       - description: SoC PWM ipg clock
       - description: SoC PWM per clock
-    maxItems: 2
 
   clock-names:
     items:
       - const: ipg
       - const: per
-    maxItems: 2
 
   interrupts:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index c4ddc0adf101..0073763a30d8 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -64,13 +64,11 @@ properties:
      - const: hs_src
 
   power-domains:
-    maxItems: 2
     items:
       - description: XUSBB(device) power-domain
       - description: XUSBA(superspeed) power-domain
 
   power-domain-names:
-    maxItems: 2
     items:
       - const: dev
       - const: ss
-- 
2.25.1

