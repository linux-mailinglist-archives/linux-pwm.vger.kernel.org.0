Return-Path: <linux-pwm+bounces-5130-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D5A5C1B4
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Mar 2025 13:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C347A78A9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Mar 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4EE250C11;
	Tue, 11 Mar 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cua/WpJm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6A2222AB;
	Tue, 11 Mar 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697908; cv=none; b=imsOY3n/FJwPiwPXvs0Mpms63HrTfhOBp6p/fZqRD5NwIKEXEi30U/eKfGyIXlhOeDIYZAtkRVHFVQi+KTpNot2LuONV9sPW8SGXl/kNZWN7/sU8ys6R/8tMVsdFKyYvy8Ekvx7VN3gdxxyOqZWrmdv6cMRpmfXvJWi9zcM30po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697908; c=relaxed/simple;
	bh=89yiYRKikh+mG1mA0eKihs3nHmA67H+M/VwyHj7ih0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VmgraK8ks/1YlKZr/kgHMeedVcJoPltlB0SBy3GgAMUVeNyAWMZ7PuUlXXTU7/Ov1hq581zc6G4bpA+suP5zB4Wp+IpSmLMJ3K8oYf+AxGxjLVuUJS2tciHVQBFZzzM+oRl8lQBAh2Zkc2Zzd1E0vF2UsLw5IO7jXuE7XeUbdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cua/WpJm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22355618fd9so99605415ad.3;
        Tue, 11 Mar 2025 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741697906; x=1742302706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HybHSX/cYkHQKvO6mzXLR82O5IN46nB/6HHTSuvxJ9w=;
        b=Cua/WpJmpR86TvnChD3vB+Na3werqGkqwM1/iXpzLYiMFEYnv+7ZFWmWALUxrpqkNf
         Cmdg7FNkWFlLvDwWW7fEGUO3UN/nnILMemDpw5WmM77W31QERSFvdVz6C/tZj/3lP+aI
         ZOX44cYLX0E0DR2foIefGuAdFiUlSj9yDo50GArzmckJySc2xRDbSWO8llV9rKWuPyWg
         2R7ODDMj4cMlNKysf/qG5eEUQGilhXyZvrIxBD2TNV93qHh9Oufazs+wletemFvSowd8
         KW2vnsN/5+CXS1O7HuZB9BCyIeTXTCe1LuMQH7JkEv7zdMkWbvXMbUu6smTBhYqwB8ho
         DfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741697906; x=1742302706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HybHSX/cYkHQKvO6mzXLR82O5IN46nB/6HHTSuvxJ9w=;
        b=nXBiF18ffWtqCSakKFng0f0bqZUcUo6veezQSlJgy3sKVVIGe9bsrs/i+y/svp3nyT
         wBHrrD3hBpu9Np/wfnbQta91vJSUForlYpFNOFb5fC0zVbf8vcoziAecGSR9AOL2qVvF
         YK/kR6SarZir5iS9xb0zQFtX8WiZ/CyWWQ/L9xwpqIDQTMUaxmTymIBwWrhfSO85GTq9
         bSPlsnQYei1flWHazwAnmgZ4ceDMtejpEKNhvO+LEBbFD9PGCTnDtxYNh2ax6dg6Josq
         GITlibk1fsrYXjP0clcRYImu7zjn4hpBVPRMY+aZCE12aID6pZ73ARHyoOSR50kHyhpZ
         GAUw==
X-Forwarded-Encrypted: i=1; AJvYcCUKKnvtfZgoA6aVO+Xyg3mLnOooI3BuGZdD5JR0RRhkQaORT6n9qhvPYaFGGYi1Gfo+QyoG2wvQyKnAnb62@vger.kernel.org, AJvYcCW+qfVgDIIrOxo5NdYfFKgip4SWz0ZwVrDMDsSotd+PA1aIx8g4cd3TGWLTGErH4wIiDQnNvmV4oaWM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+qL1OSnd6BA2cus9acaRobS+CUIkHwYmOrNMxzRxgwNM9s0T
	BvTlwJSIbKEuvR+2vsZQeTRQxtENIwzpcTeG4iEcsLK9vpd0jm1E
X-Gm-Gg: ASbGncvNM/iFVUCPOfV9ppALGeylYl02v5cLWOYj0txHaUWAQ1g/CoUFhZDl6CfnNvV
	dS+Hn+VDaQL5coy+8v/vJiVE+NafUZUpOUyoF3gB9iNr0BA2nADpKOmpipHmHCCxcInU+IPMowv
	iGzq0ZO44mDVZNxodEFJBlrWAs6hmQG2fvoeBytRHqQ1MSgNv7UjU3+AXmI70XGwYw7jjES8aFv
	XMbdjomGLyAAGrGRrGeQA0OOsx3S0vZ5G1OkRgAf0aS0DckPaNsJ5o1VhhoQ6Zr+QdjzgVCyQZA
	//a8mKAPQ9VbX5DKj3Rf4zHf4CfZ652LiQhxdJtFLZV9ab5nP+x0Alhsy4o0ifj5ZRzLXzkAvsR
	FDrfh
X-Google-Smtp-Source: AGHT+IEOf4e2cGRATnJTbW2bOROibHi2zYAh0ElgqYv/rjSNcReiFylmnMGtump4zwxMszEZz/Y4bQ==
X-Received: by 2002:a17:903:440f:b0:223:7006:4db2 with SMTP id d9443c01a7336-22592e47c93mr62081545ad.31.1741697906379;
        Tue, 11 Mar 2025 05:58:26 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:1188:3708:7bc7:f5b5:1c3d:ad0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410ab45bfsm96871375ad.250.2025.03.11.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:58:25 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML schema
Date: Tue, 11 Mar 2025 18:27:56 +0530
Message-Id: <20250311125756.24064-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
YAML schema (`lpc32xx-pwm.yaml`).

Changes:

Add SPDX license identifier `(GPL-2.0-only OR BSD-2-Clause)`.
Define `$id` and `$schema` fields for proper schema validation.
Set `title` to describe the LPC32XX PWM controller.
Add maintainers as per `scripts/get_maintainer.pl` output.
Reference `pwm.yaml#` in `allOf` to inherit common PWM properties.

Define properties:
Restrict `compatible` to `"nxp,lpc3220-pwm"` using `const`.
Limit `reg` to `maxItems: 1` to ensure a single register range.
Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.

Mark `compatible` and `reg` as required properties.
Set `unevaluatedProperties: false` to enforce strict validation.

Validate the YAML schema using dt-validate and yamllint.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 .../devicetree/bindings/pwm/lpc32xx-pwm.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml
new file mode 100644
index 000000000..3e41cd291
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,lpc32xx-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPC32XX PWM controller
+
+maintainers:
+  - "Uwe Kleine-König <ukleinek@kernel.org>"
+  - "Vladimir Zapolskiy <vz@mleia.com>"
+  - "Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>"
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: nxp,lpc3220-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@4005c000 {
+        compatible = "nxp,lpc3220-pwm";
+        reg = <0x4005c000 0x4>;
+        #pwm-cells = <3>;
+    };
+  - |
+    pwm@4005c004 {
+        compatible = "nxp,lpc3220-pwm";
+        reg = <0x4005c004 0x4>;
+        #pwm-cells = <3>;
+    };
-- 
2.34.1


