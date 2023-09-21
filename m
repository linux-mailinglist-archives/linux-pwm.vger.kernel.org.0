Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35D7A9B3F
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Sep 2023 20:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjIUS4x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Sep 2023 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjIUS4m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Sep 2023 14:56:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D3ECF4F;
        Thu, 21 Sep 2023 11:44:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5a223520dso1597855ad.1;
        Thu, 21 Sep 2023 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321871; x=1695926671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcgcTESH6/uLiICTVNF75Z76g5C0U09gLoJNGsFvxiU=;
        b=NpoeGUGZ+31XTaZqQJn2uJKMZPQxRs91fRazZMHOwOHOI+aMqilqcoZDLzpYV53Tym
         5UopdRl8qX+KJNQUko9tI9T5iq+xSwH0QPrdVRlfhTr4P7CkjhfJo57WznFKtDc9R7jW
         uJHGBnyiudu5zmvW9NgZQGY2C+3tjvxNi3K52LRGKuTitv7Sw9XMf5q27Xq32vBp23R1
         GjxgteoKxD6yIHVCn0bCWPjBztGgmVdA3Uhsa6qI5c+nSKE9CDiGRPmL8YOJL2oNdW5W
         nzBOF8sgaAf5imcre2bxSxRlgUyHpHXG5giE4f7T9J7XSB6lClXRYCka89dYIMEI8gy2
         W0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321871; x=1695926671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcgcTESH6/uLiICTVNF75Z76g5C0U09gLoJNGsFvxiU=;
        b=kO5B30UDRPRyd6tEikIzHVQu+PrWUtdww90nZIa7Kv7CYbjfjOSLi9ADHmtakn6wsj
         BUQtLIzXfv1UZ3Y1ruG8XJ3LBo1KywPky5iO9oxtmKHQgvtubYLuKma0iXLU3aHgZAYY
         dQmqv1r0jxz0gqQxUr26SPCOUOEbYHQlL4kMUVn1I/wes+YTCHk3qZsK0ukyYlrrKMOK
         AK1AwN+m4NdRe7rkwDBP5+gjddX3NzakpYQ1p5vGdQ6HfQuGAnWiW3bL/xFFETLftbkJ
         d2W7fwOAgD7/yDYF/ZRBDTOFqaAt4eD7tQnnIa4SzwoLptClmfpFxnd8zIgoAWOQsDQ/
         vdvg==
X-Gm-Message-State: AOJu0YyvjKfQMOaG1D32sGIq3KDTWPtpPE+2V0JIQ06JJRyfmH9y8pPh
        YB0sFYdmzfW37Nvv8ixRI4Y=
X-Google-Smtp-Source: AGHT+IGfrEo+fTzVOhVyIvLpWrVwIhQfeAURNfE8+QfZGqOMPnoiwlrD3+WDzITNd8LwcSLZQjvZsw==
X-Received: by 2002:a17:902:d492:b0:1c4:1e65:1e5e with SMTP id c18-20020a170902d49200b001c41e651e5emr6565170plg.0.1695321871311;
        Thu, 21 Sep 2023 11:44:31 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3568:5db2:51a5:e134])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001b8b07bc600sm1852730plh.186.2023.09.21.11.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:44:30 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] dt-bindings: pwm: mxs: Document the clocks property
Date:   Thu, 21 Sep 2023 15:43:47 -0300
Message-Id: <20230921184348.290261-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921184348.290261-1-festevam@gmail.com>
References: <20230921184348.290261-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
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

