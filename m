Return-Path: <linux-pwm+bounces-5727-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F05A9E385
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 16:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A4B7AF167
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669E1A8F94;
	Sun, 27 Apr 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSIEgrwY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEEA1B6CE9;
	Sun, 27 Apr 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763923; cv=none; b=JLtLoTE6vmF7MtnMCi+0HvQik6xTABxhG6UrxBI7/2Q2vnaI8VM3sPaaYef71O83EHpIfJLxr7ZYMbdjeQzJH/ia6nMM6fSQ9mk2akS3N03iQYOOq27IFkU170HnwCrXerKSxD/2w+cBZuCkg5U8xaVtJsFHRtPBr0FqzvEsJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763923; c=relaxed/simple;
	bh=8R/7drFls+sUFj4bK9oIhMc0TsrE4kzlmhIGxIAwqCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVexewZgaiVHcxSvNA/uEpuPolto57Ue1ik81MIpdUIkdFBcIQCdXDEiLHvBeuGjnoNtYD80OoZqTA4bDU9HMCpLJ3vuknYHlMeFOEiXl0iQfTIFciMmgY02nJkHlp63mC9nLdGgDbO2mLdmsSig/86rPdXeURAvNHytXT9BDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSIEgrwY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso38683621fa.0;
        Sun, 27 Apr 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745763919; x=1746368719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwcfEJKJXKQ5UF4yDTp+oj9WuQfkbNaZErmbidvOOm4=;
        b=hSIEgrwYl2HeqnwArDRe0bA/C+Eh3Kmlhc46ci6yiyqL0fXwtUK4Gh7tfCvc7SUpuP
         oh1MjF/ygy39p82OkFInisZDXs2UV1RIhwIqiAt+GPrEA6OnHiQc6NGNm4qBMfAOXt5s
         Z3dj8OHdod7ssvF6X1rkDV5MvJSl3Un7kQCbvnsG4bfhxM/utGF7fUkQ8Yqol1J5WHT8
         JLnn9gWMM9w3oOeFsPI2j5zfH8bsSYNpABB/652Sapz/xEk6C82k8SxAsE1fYCcxqH0s
         J9jlizL0grOllMDKSbjw+Dkk9A+8WGoFM+/R9AujXzgQaH4XPVKFl2zzwVF/jIkR8B5o
         gPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745763919; x=1746368719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwcfEJKJXKQ5UF4yDTp+oj9WuQfkbNaZErmbidvOOm4=;
        b=B9BLGwLf00iptqXdkG0EG7lDYwbODz/DCt7zhaIA/zXnIjXVudlP4/zjbd3lcZJ6Aq
         MNSQWbG1LQiJ9pPY486KIOb/la/5DSbNjwCNuplA/nqDYU0luDY6QIpxFMc3ebA02X6Q
         20HrUUEcKgdPhpX+k1kBlzSp74fdRvRQF8y3QOpJ9wRETulPGBkvpvSqRziX/X2232Gh
         GC66vOPJz0FcZFUeuwAQr3NkAJdGzZ/wCFhz78av26MJ4ie72977kO5K+v2MDC9TL5uJ
         Oc+0lYnrzhB0/6Gzo8AxQz7Fs0zBJAckwAZAnc9aaEgugRMfiVsRxpqUiE1jCH0z7UpZ
         kCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+4e/EflsMmq26gvouJn/Oco4HAOtt6+CcmrME1cfwy3m3uLT+JN+dt1Z5xVyV8lmIQGPCcNLku6W@vger.kernel.org, AJvYcCWX2i5zLo9n0Ay5phHjqXBaabvmCOmcdbtn9RZY4RhDdH0GfvEMV44c7cdVn6CfSSx9YcFiUESelixT@vger.kernel.org
X-Gm-Message-State: AOJu0YwabuCBq4QKLxGves/ZQVNt64/tHoM5uJ3YWkDf6s/qnroRiCkZ
	Fo81kuK70gpA4SYcD4Cdiy6zIGsKTaZoZJeUoyMvO7oxdKYoMsGbmtv3SS1Q8I0X
X-Gm-Gg: ASbGnctAaH4gHIB4TQ1E6gPAxdG1JK7+n5Q3AOTL2tD4VnNCPklYcful/Rfy2I8B709
	ak+pC2wmiyfEl/Tp7IqRLjGJe6G+prPn/Bf95eBQboIyj9wSlJdUmngS8nZ5CrHk/RGbAtcN4Zd
	38lctlqXjUvi4IDQwWtZkiV5tCHzAfuvQhqOjiGTf+ESDGoCzyeu4PdscniUT3Lv2RBpDjaFQuI
	N90U1MdoSaJkf4x7WadRvcvbjbN310x3SUIQ8W/0K1dHOiKynEo3ILHfYSf8rR0UT52xRF54I3p
	CVbKtf6OTDL9MrUWIIrgIfJes2/WK+lUV48UgrowT2PM+Z7xOkosas93
X-Google-Smtp-Source: AGHT+IH40FyLml70Ii4+KAHoqq8gBUgCUu7aKtYSu3EIPb7DPGagejX7iuNwaI0UDK2ngyYpGXmoyg==
X-Received: by 2002:a2e:bc94:0:b0:30b:f42b:72f6 with SMTP id 38308e7fff4ca-319dd1c2407mr17109731fa.32.1745763918681;
        Sun, 27 Apr 2025 07:25:18 -0700 (PDT)
Received: from localhost.localdomain ([178.176.177.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cfb482b1sm17659191fa.29.2025.04.27.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 07:25:18 -0700 (PDT)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 1/3] dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM controller
Date: Sun, 27 Apr 2025 17:24:53 +0300
Message-Id: <20250427142500.151925-2-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250427142500.151925-1-privatesub2@gmail.com>
References: <20250427142500.151925-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
controller witch is different from the previous pwm-sun4i.

The D1 and T113 are identical in terms of peripherals,
they differ only in the architecture of the CPU core, and
even share the majority of their DT. Because of that,
using the same compatible makes sense.
The R329 is a different SoC though, and should have
a different compatible string added, especially as there
is a difference in the number of channels.

D1 and T113s SoCs have one PWM controller with 8 channels.
R329 SoC has two PWM controllers in both power domains, one of
them has 9 channels (CPUX one) and the other has 6 (CPUS one).

Add a device tree binding for them.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
new file mode 100644
index 000000000000..4b25e94a8e46
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1, T113-S3 and R329 PWM
+
+maintainers:
+  - Aleksandr Shubin <privatesub2@gmail.com>
+  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun20i-d1-pwm
+      - items:
+          - const: allwinner,sun50i-r329-pwm
+          - const: allwinner,sun20i-d1-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: Bus clock
+      - description: 24 MHz oscillator
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: hosc
+      - const: apb
+
+  resets:
+    maxItems: 1
+
+  allwinner,npwms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of PWM channels configured for this instance
+    enum: [6, 8, 9]
+
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-r329-pwm
+
+    then:
+      required:
+        - allwinner,npwms
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun20i-d1-ccu.h>
+    #include <dt-bindings/reset/sun20i-d1-ccu.h>
+
+    pwm: pwm@2000c00 {
+      compatible = "allwinner,sun20i-d1-pwm";
+      reg = <0x02000c00 0x400>;
+      clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
+      clock-names = "bus", "hosc", "apb";
+      resets = <&ccu RST_BUS_PWM>;
+      #pwm-cells = <0x3>;
+    };
+
+...
-- 
2.25.1


