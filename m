Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB077AB252
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjIVMmp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjIVMmp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 08:42:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56938F;
        Fri, 22 Sep 2023 05:42:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c4456d595cso3810185ad.1;
        Fri, 22 Sep 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695386559; x=1695991359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nywMer+Mj3vum0HNAimi+OFLw1xlk4qhC7kYw/lyJjE=;
        b=gt+an6bAPBVuPEVr2zjZc8396+cBGLJU3j2aiBNbfCYCCZjlhOs2BTBGvhACXTq2C3
         ErDRQcKVRQaEu3JRYeX6svP6hiGTWSwm4qkP0sQEDyhPAokmplRsNB5q6PiEK6va29XJ
         3+ZE76r40Wq8KGroLbKtJ3hgFmRwx5OqemIrNlNOBZMP9z9h1qb45NjloNpb+FcHghcC
         JpXIEa6Qlp9SyTyxwixoviXhyNAqQx0UDSNcQ6F5FnH+P7zHI56e6MLPk7jzt9/YtR2X
         2uF17D+Q0L4H5ZwOnpR0QD/Pp1j3L10xLx8H0QB5gD31WG+C9TfeSizoottrlScSGvu5
         V/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386559; x=1695991359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nywMer+Mj3vum0HNAimi+OFLw1xlk4qhC7kYw/lyJjE=;
        b=wMyAqK+TXv9fvStlcU9XMn7dxApHXyt+5Zs3Lir/iKTtBdYLcUK2mID0yqVsGZcnUH
         7GT326nPcqIoetLWieiDLw2ipNi06HVJasE5Ia6X1tfx/XwiLWDxB8tgeVuhRXJJi55F
         jiRyavXz4iqA72lqQh1zAMLAS3GuPZzP06s/5wWDv5hssSjJU1BH9tVGvx4fe86DzIKV
         Darp2cFy20MXNiHVMlZerqqTIwt5cN0+jwWcn395qp6M0Z2ewhAc0NYscfV62EqwDXaH
         s+8XEXlhROwF3vJzrx9dGSTiEO9JDHDMI/80+NXSmSq2A7sZCNN3ZgsNGPasY6lM1pZn
         GPmw==
X-Gm-Message-State: AOJu0YzcDdJR2mE/YWFWg+nRT8YnarjgJfGa2oX2EHjX73Tm7vbx3gw4
        3rny6OLIbH7hq5iS+YNHBZU36E+Do0Y=
X-Google-Smtp-Source: AGHT+IFZ4ZOOnJhg5/+HD4kDbMuvkgHPN0tgqhlRUeBRi9yf3KTQLliylVhvzNVngckGnyUvDK58yw==
X-Received: by 2002:a17:903:2303:b0:1bb:d7d4:e2b with SMTP id d3-20020a170903230300b001bbd7d40e2bmr8422397plh.0.1695386559195;
        Fri, 22 Sep 2023 05:42:39 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2546:6c99:4de0:9123])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001bba669a7eesm3368170plb.52.2023.09.22.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:42:38 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Fabio Estevam <festevam@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: pwm: mxs: Document the clocks property
Date:   Fri, 22 Sep 2023 09:42:28 -0300
Message-Id: <20230922124229.359543-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922124229.359543-1-festevam@gmail.com>
References: <20230922124229.359543-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

The 'clocks' property is mandatory for the PWM to operate.

Document it.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- None. Only collected Uwe and Conor's acks.

 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
index 655f008081d5..8f50e23ca8c9 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -25,6 +25,9 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   "#pwm-cells":
     const: 3
 
@@ -35,6 +38,7 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
   - fsl,pwm-number
 
 additionalProperties: false
@@ -44,6 +48,7 @@ examples:
     pwm@80064000 {
         compatible = "fsl,imx23-pwm";
         reg = <0x80064000 0x2000>;
+        clocks = <&clks 30>;
         #pwm-cells = <3>;
         fsl,pwm-number = <8>;
     };
-- 
2.34.1

