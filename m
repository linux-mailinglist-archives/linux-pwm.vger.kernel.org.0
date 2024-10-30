Return-Path: <linux-pwm+bounces-3975-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E269B5EFD
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 10:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FCCB2188C
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9C1E22EE;
	Wed, 30 Oct 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG0Zn9zm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059228F7;
	Wed, 30 Oct 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281002; cv=none; b=gFeP+aEFBKw7kwEak8j9gGKuXVTA8wP0g0N9Hu3pht/ftztk1XvNgiZSf5BJaXorCg1LiE+SKyZ8rYzTN+G0BuefFRk+qvTnWYpdjmQXHRcX8AdqQjmG3LkvJLxfen6muCv0Mekwzi6MBltMnb0sAAhp02+wbv+jadqDBX5FmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281002; c=relaxed/simple;
	bh=xBHSYuV1dOne/zvoSNdQhoyrqDC/WzW1s5Uno8eErAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aFvOw5JYvSE0t83gN2rNSs0vbkqUXW1vDVxM5XVyFnDmwLcgQeftkuv5IdGpAm+qxKLoqLRsdDB9iuf9U9e7Vii0TjPRgB5xeD3aW3XyLdbLi6ZcN1lBBMQJyMQvaIvGa8w5V0u8tRLu87IRVcqxq9yiExkselJ3gN0iyTh4Szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG0Zn9zm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso942789766b.1;
        Wed, 30 Oct 2024 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730280999; x=1730885799; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT/ltCJEXcqVvvu/NliEimm/HZCQrnGCJESxEmRcnwM=;
        b=JG0Zn9zmAGhxJ/tZQgB8llx6GuUA7vHHnOx6/QY8PhmLCl3LfNTBXYkyuIttBHoI83
         SICenQVPrK41AfOXohyB5tcK0vKl/EzU5chnH5ITHbN9CySWNGTc14dXW5O2tspyvWDq
         7pZA0pou327TgAhYqssSBFp6UXIgY+qIH/QPpAmDz/f7PNyAjM8zKxC3Chf9XmMKCaPI
         Wz6ShuwTyYyox0AIuAnaTJFPpVklqUUsTijsj24EupNS/2sSGvCV+Hz4T1llrNv+RfAh
         pVEFEvkMP5AObG/4L7mY5dtkFIRy0BoH3tiDMsfSSAyn6Ka7sPwQjUuEQ5UX2AV4dQZS
         f6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730280999; x=1730885799;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT/ltCJEXcqVvvu/NliEimm/HZCQrnGCJESxEmRcnwM=;
        b=b41tUtMz1PyVZadIieMZZ9y4Cl8awxmMKZrQafhYKwJlFmRUKoEnQJH0Jl02ycEkJv
         WXOeFQqm3yamF0UVB1GJ6/EUPmhDFteZCIrGkgk/5RN8k4gUZuJmLM9z4N7rqejup3Mi
         Eco+V/ewRsiWFChrMqgDFMSshbp+HTh3+3sWBlqSdIno6YqM+zYJqg8fDCL/Ne3Qp9yG
         bqHUCPRxMNzzIinAlM+txpIYmY/trHd+uhX0NfftpYsT9TSEbTmoatJ89rKaXQgzDxig
         Z1a2BH63c2CgDTljmFp3dOjgT7JtKLVRZL68aQNOPyzhTxxtqV9oJbY2bIgWCCjzOtGg
         6DEw==
X-Forwarded-Encrypted: i=1; AJvYcCVFtM8nvRH99s+DkcH7WZkagJcPSfe7ffZR5choMPnrFOqr7xATacJkM0XnGqgteogCQF67xZRPVFZm@vger.kernel.org, AJvYcCXAnXau5S/xITToZiGwXakwUwzx0RULol1/s3pNN09JVXEwBLhJYDxgOipax+RMz4KwhsXtxWK6P1ArAyPD@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUoEwXM2kyPlHpsAaa+zK2ZTAReCfEpEkmSRsemijpS/88Ugs
	KMGXquybGpq/lMHgcXWmb4SVF/DtgFPso4Uh/iCwuG4nvskOnEUO
X-Google-Smtp-Source: AGHT+IHFIA0QGaRJ31X4hzqZFypnasHvO26dsT9bmh85fr3+79VIqB3hvh718kx6oO0fVQ3rEL5Wew==
X-Received: by 2002:a17:906:6a0e:b0:a9a:2afc:e4da with SMTP id a640c23a62f3a-a9e3a7f433bmr214871066b.63.1730280998460;
        Wed, 30 Oct 2024 02:36:38 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm548838566b.159.2024.10.30.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:36:38 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:36:36 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum/Unisoc UMS512 PWM controller bindings to DT schema.
Adjust filename to match compatible. Drop assigned-* properties as these
should not be needed.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-sprd.txt      | 40 -----------
 .../bindings/pwm/sprd,ums512-pwm.yaml         | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
deleted file mode 100644
index 87b206fd0618..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum PWM controller
-
-Spreadtrum SoCs PWM controller provides 4 PWM channels.
-
-Required properties:
-- compatible : Should be "sprd,ums512-pwm".
-- reg: Physical base address and length of the controller's registers.
-- clocks: The phandle and specifier referencing the controller's clocks.
-- clock-names: Should contain following entries:
-  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
-  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
-- #pwm-cells: Should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Optional properties:
-- assigned-clocks: Reference to the PWM clock entries.
-- assigned-clock-parents: The phandle of the parent clock of PWM clock.
-
-Example:
-	pwms: pwm@32260000 {
-		compatible = "sprd,ums512-pwm";
-		reg = <0 0x32260000 0 0x10000>;
-		clock-names = "pwm0", "enable0",
-			"pwm1", "enable1",
-			"pwm2", "enable2",
-			"pwm3", "enable3";
-		clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
-		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
-		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
-		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
-		assigned-clocks = <&aon_clk CLK_PWM0>,
-			<&aon_clk CLK_PWM1>,
-			<&aon_clk CLK_PWM2>,
-			<&aon_clk CLK_PWM3>;
-		assigned-clock-parents = <&ext_26m>,
-			<&ext_26m>,
-			<&ext_26m>,
-			<&ext_26m>;
-		#pwm-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml b/Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml
new file mode 100644
index 000000000000..0344c2d99472
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sprd,ums512-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum/Unisoc UMS512 PWM Controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,ums512-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 8
+
+  clock-names:
+    items:
+      - const: pwm0
+      - const: enable0
+      - const: pwm1
+      - const: enable1
+      - const: pwm2
+      - const: enable2
+      - const: pwm3
+      - const: enable3
+
+  '#pwm-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: pwm.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,ums512-clk.h>
+
+    pwm@32260000 {
+      compatible = "sprd,ums512-pwm";
+      reg = <0x32260000 0x10000>;
+      clocks = <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
+               <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
+               <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
+               <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
+      clock-names = "pwm0", "enable0",
+                    "pwm1", "enable1",
+                    "pwm2", "enable2",
+                    "pwm3", "enable3";
+      #pwm-cells = <2>;
+    };
+...
-- 
2.43.0


