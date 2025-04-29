Return-Path: <linux-pwm+bounces-5752-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8FAA0633
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A4A3B2D15
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67DC2820DD;
	Tue, 29 Apr 2025 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="GpPfLIzu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DC3A8C1
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916684; cv=none; b=WvOlVIzficI6CZCeiZIfMhfur34JrYZ1ozSce6RHOby90lUTnHTFhrrGPVx9lt7G5AUjPBnXy/GAukpmMclkM5Np7qeFiucSxCapDard/TJSFhNjgxn2T5YoQ3Bs8kUMYikVVrXM/qgAL8RSAuOSBfFXhbJVLD44usPHYiNcO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916684; c=relaxed/simple;
	bh=nxp0t+VHyDDz8Zh9ljfkEOJVql6306/CDvJb8L/acNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqQfu5S4MPVnaTuiJh7svdu+MX+XELPydFsS9QyJlm/mWbpoSogixupHt6Uz5jCUsl0H2znI6ZgU8EFp+Qp1C34zQYjczvCRVJr0EzzM9m6kSMKpN2o1ssTDimyLa5AOtE0ZDrwEtj+9TDyte66tx6KSkyNQWLmxG4p0jX7cjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=GpPfLIzu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af589091049so4241435a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745916682; x=1746521482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHJACfgxHpPYnkt6IQy+Z0WabgJ033p5WN25OiCcmgQ=;
        b=GpPfLIzuHNN2jUoUTtIsXSgwNSD4T+ctLgfop5vqp7Ia9KqghxxZpnIvkPf12+9v9+
         6vV0/0cQ6A0aR1v95Yf2wjOiyF8x9tF6a6rf21kDZgDoNi6KnXs1V8POCUnXLSjpTCYD
         4dsMVWNMNCqIjwfGyZazO5cxfAEjvKjg9nSPt+8gNG12TuIZKjdus31pxKaxWUoviYg5
         bmGGdcqft1GAs+JT/MsDAj/4wjWQHLtwupqt3iXt3RCLSsOoNRmn6TYEG1DJnnVoDX9J
         0uVEycD2+OaMLe2Ywpj5weH5cW7/TlyWlhAom8t6el4K+1QzXTSVikWZ6pOXk8FE/DDe
         opJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916682; x=1746521482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHJACfgxHpPYnkt6IQy+Z0WabgJ033p5WN25OiCcmgQ=;
        b=JplJoWBo4KYTy55x0a4y3101m6ZjFmRCxy4Nbtpa6vXjHp3MfTK+ybHdmYslCfC2H7
         IuNpINVXsVm4sINjORVBtR68owkkK6Waph/d1xytzC3MaplC559JE0zkqPsXyFpB+iO3
         /24ZLcQdvta4phwdJcnvp3qtnExa8LLf0fI7KruB7OYP5dnbF2CyS6EXJovAc6ZHlTyD
         kn3DI4ttd7fzHWrUlIlC/Q2kAaEQV4S9noPKRNF7wg0nCOPEyav3NHfs6Ec9GdfYVKLz
         D01bDTWDRCSRA+w/425Vv05Xgaoxn8vj+zwt5urIvIgW29vPOIL0HWYUwKenb5bGmA4u
         +NBg==
X-Forwarded-Encrypted: i=1; AJvYcCUpuPrsRjbtY/OkI1x7esRDrM+xIT/1kvPSeI46AhNoAYPeU2zmbCZ1kjtn6tMOpqJWNfr4f+eWiGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOk6IcMapKC3BbhfzH113H3SFtki7v10VlhxJmA6wPne5HQx7d
	8Gwm1XwDgYTK4EBfC6976Hb+PN19gV3vcfzo1X4F68pI2ePjbxAkqRj59r8nJbM=
X-Gm-Gg: ASbGnct+5Db0x8Sdsjfewii/HBW4Soh2N1Vjcj27Q6mCYC7fF3M98/HC02Q6Z+2nftK
	UgMJKT865j7AChuMOVa+hGDiVt/RtQv6TGKXvXT7uQskHpNEUBEoMtuDzE9R/6NMEEk1G//Zi0p
	2qYAwAR+rM/p21IY6yCyfAR1L0Q9FUKT8KoUrhtehxLOjJt7zkEJFpMnSucGMs7rMI96D3hzVX+
	D3L/VJ2cMhoHbllEuMVWOT8Vi2edoOJ+1yQR8VWpjL39psfwM1vD0jk0h6kZXtrCmZp26iJWDJh
	1BTND6EaO/nDcA7jvX9d0+O48qXeT/HrZ/Lcv2FW52eu683TGgHZ+8VyzpXWhuXDNAU+XCisGSC
	y5mvH4vvsh39QxCk=
X-Google-Smtp-Source: AGHT+IFZEuQ6sdfjCY7tfFhs7M5WchmJ8YCpC4/JeiDTSPbAo3pUkubrMOUkP8IaSDenvQAkORYC5A==
X-Received: by 2002:a05:6a20:12cc:b0:1f5:9961:c44 with SMTP id adf61e73a8af0-20955d042b0mr2744549637.3.1745916682223;
        Tue, 29 Apr 2025 01:51:22 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm8550119a12.44.2025.04.29.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:51:21 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v3 1/6] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K1 PWM support
Date: Tue, 29 Apr 2025 16:50:43 +0800
Message-ID: <20250429085048.1310409-2-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
References: <20250429085048.1310409-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC reuses the Marvell PXA910-compatible PWM controller
with one notable difference: the addition of a resets property. To make
the device tree pass schema validation (make dtbs_check W=3), this patch
updates the binding to accept spacemit,k1-pwm as a compatible string, when
used in conjunction with the fallback marvell,pxa910-pwm.

Support for the optional resets property is also added, as it is required
by the K1 integration but was not present in the original Marvell bindings.

Since the PWM reset line may be deasserted during the early bootloader
stage, making the resets property optional avoids potential
double-deassertion, which could otherwise cause flickering on displays
that use PWM for backlight control.

Additionally, this patch adjusts the required value of the #pwm-cells
property for the new compatible string:
- For "spacemit,k1-pwm", #pwm-cells must be set to 3.
- For existing Marvell compatibles, #pwm-cells remains 1.

Background of #pwm-cells change is by an ongoing community discussion
about increasing the #pwm-cells value from 1 to 3 for all Marvell PXA PWM
devices. These devices are currently the only ones whose bindings do not
pass the line index as the first argument. See [1] for further details.

[1] https://lore.kernel.org/all/cover.1738842938.git.u.kleine-koenig@baylibre.com/

Reviewed-by: Rob Herring (Arm) <robh@kernel.org> # v2
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: When compatible string contains "spacemit,k1-pwm", #pwm-cells must be 3
    Added Reviewed-by: Rob Herring (Arm) <robh@kernel.org> # v2
v2: Accept spacemit,k1-pwm as a compatible string, when used in conjunction
    with the fallback marvell,pxa910-pwm

 .../bindings/pwm/marvell,pxa-pwm.yaml         | 35 +++++++++++++++----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 9ee1946dc2e1..8df327e52810 100644
--- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -11,26 +11,47 @@ maintainers:
 
 allOf:
   - $ref: pwm.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-pwm
+    then:
+      properties:
+        "#pwm-cells":
+          const: 3
+    else:
+      properties:
+        "#pwm-cells":
+          const: 1
+          description: |
+            Used for specifying the period length in nanoseconds.
 
 properties:
   compatible:
-    enum:
-      - marvell,pxa250-pwm
-      - marvell,pxa270-pwm
-      - marvell,pxa168-pwm
-      - marvell,pxa910-pwm
+    oneOf:
+      - enum:
+          - marvell,pxa250-pwm
+          - marvell,pxa270-pwm
+          - marvell,pxa168-pwm
+          - marvell,pxa910-pwm
+      - items:
+          - const: spacemit,k1-pwm
+          - const: marvell,pxa910-pwm
 
   reg:
     # Length should be 0x10
     maxItems: 1
 
   "#pwm-cells":
-    # Used for specifying the period length in nanoseconds
-    const: 1
+    description: Number of cells in a pwm specifier.
 
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


