Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171281AB0AE
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2020 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416815AbgDOS0z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Apr 2020 14:26:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36866 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416773AbgDOS0m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 14:26:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id r25so4472984oij.4;
        Wed, 15 Apr 2020 11:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GOQPtpvUxmmtoqM4sCMHO0noy2hG9IMRj4zLo4bodko=;
        b=M8lYosc1DuirpiGQ7Gu4HJbEsw3MepUpBX8+WpLIKs3rx/dGbFhnvWR0CS7vfcUcEj
         j2oDzJqWTYYh8KgK2uMZ5NPsiie3xSTvyBJyDa54Y+HMhuDuzgmdUFglz1wEs4wVjic7
         VQ3xcLjaepLTHTnXBZkizg06gJTwgjEigAmILj4kkLHQh3p5+Ck6KLGfmsNYF10/luEs
         PM5ZpkBq7zv6BLFgbWdmbjZeQyNjOAie3T48k8ffpJ3hiecmx0/v8zOtJDPD4K0ItfiI
         cvrcyIMlrEtxNuoHSKSH1yzGBDiL67PJIMMbCxzw6C4HhScsGn+Mx6FfSRjxhXQu2oR7
         4hEw==
X-Gm-Message-State: AGi0PuaxY4YYMT+T1dW8p6np7JO0o3RHQX1zi+T9zLoOJrK82rDMbCV4
        Xq2kNwg+jpw60qZ5f0pR2ZSfwJ/QKg==
X-Google-Smtp-Source: APiQypIkmUJHofMrMWSmFECjbIqPYqBmqGI/9Got6TMQR2A18rHtb+NpU4030rrtiIRTx/Ir/HQQ3A==
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr410305oij.91.1586975201199;
        Wed, 15 Apr 2020 11:26:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o186sm6573687oia.27.2020.04.15.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:26:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg' warning
Date:   Wed, 15 Apr 2020 13:26:39 -0500
Message-Id: <20200415182639.18534-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The example for the CrOS EC PWM is incomplete and now generates a dtc
warning:

Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dts:17.11-23.11:
Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg or ranges property

Fixing this results in more warnings as a parent spi node is needed as
well.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pwm/google,cros-ec-pwm.yaml        | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 24c217b76580..41ece1d85315 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -31,10 +31,17 @@ additionalProperties: false
 
 examples:
   - |
-    cros-ec@0 {
-        compatible = "google,cros-ec-spi";
-        cros_ec_pwm: ec-pwm {
-            compatible = "google,cros-ec-pwm";
-            #pwm-cells = <1>;
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            reg = <0>;
+
+            cros_ec_pwm: ec-pwm {
+                compatible = "google,cros-ec-pwm";
+                #pwm-cells = <1>;
+            };
         };
     };
-- 
2.20.1

