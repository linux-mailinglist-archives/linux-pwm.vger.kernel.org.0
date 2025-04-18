Return-Path: <linux-pwm+bounces-5568-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83CA938F8
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536FB467529
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D781DE3A4;
	Fri, 18 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5F+5k0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906E1DD525;
	Fri, 18 Apr 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988120; cv=none; b=QOC2NJwe2gQY9vUn7iBs5RS8LNj/dxC2+iKxgERzQuUYVJA5s4vqHf0vd24otIXL87pXeI9RW4pOQs2nPwze2U2KrUya+GlyXH726fDwAaId90m8Im+MQyv0IB4KSIsAETU+Wz4cbaRm0nHJgBJblcEKr+M7fJVsSGsAaR8BtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988120; c=relaxed/simple;
	bh=RoN3cLeK/9p9mwdRIwmQYy7Phi1BWqjDBzsnmtQBFGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I4zujKTMdbTDQEoHuKIv6zYel3cFOevuzQcPMm+i2PMzDSVKgsM2JzbABm0aRmwWWWRoAO+W5d9aAUMZyGDd5jFUSAEuWgqgL+mWKH6hqDrf/EYwgwKmbTegzFA5FYj5esCMtJ2uVkWkykOdzTJywmcxwL4iGfwUTmrVha4BgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5F+5k0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fd89d036so24372575ad.1;
        Fri, 18 Apr 2025 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744988118; x=1745592918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7AL4unDmRg0o0GGoNE8HkFCc4SOWy+X7dzSvx+7jpEM=;
        b=fk5F+5k0wYz3nKF9MJo+2UiJgrsQuQjjTPEKorMtg4KZmJYX3HvfuIc2jULGUs+CKm
         M2QJKMvyiXnVI9dQtLzVEGpk5EZmXO0LdBQAP9KLwdzIgzCup3VvnUx9WuXKrt7KGx66
         0GkypsOUcxGrJnX5wEoaQjGmNnK8Kfm6sA5X35kB9JQtQiGqrKUVWCNQIqUq9B05NTSr
         KF8wvgZ8asVp4SUPCF5trlGzTRhXLPvAXKO5dVWPSWfpB2a6QsYYHW23b/zCMX+PQFwY
         Wi64HG8j3NwXVD5MMeVUsdjfvPj0Z+pyfwx00KkP30k3TeJxbIBuq8IchOmrwusbHRud
         MnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744988118; x=1745592918;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AL4unDmRg0o0GGoNE8HkFCc4SOWy+X7dzSvx+7jpEM=;
        b=XbKW1iR4md0iQnwEMNHPhrbMUCinNkJhNbZezIZbAcsbF+0IKHJwa49otzkBcZDW/d
         I1ZRpDAHEoXRjw9vKsgIF/hm7qIt/jrZnw7nV+H/ZHhcW3dQ/0Z/eW0LzRPvA9/+Vv+M
         +KmWkQShR4NSIGBqTMwN3EJK/hWfRLWcWE9fCeWw2fFQftthdw5TujZLJtqEOiFBSRgK
         EVPQ0dPt1c2oJPmxA55qfUh/uMvKK0GJaAuX6IebpecHKJLS6hzb9wMvEzTr830scTl9
         01xc9VFZ5gKaIEYIlGCOVCCDp9aaQ8UiDWx+OQ6cV+g+4JT1381b46BKu5ZaTkLmO4rT
         I4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVsTcQCeVVxBL/NXGdQbIC6cNW/9dx1qLglqlNxiANypqTpXEj8Uqhux0HZp6YZtp+04j7caq30Ntqy0+sc@vger.kernel.org, AJvYcCWBeJyvZjsjXkkW5Lus2hYiZJ98laE4PqN/ItswDGJNtluPMIlbrLa1hHVbqkO47qnQsG0f1bTgLs+h@vger.kernel.org, AJvYcCWcJ/ya15plXMDDPOCeRYAlvk4IrcIx1eh2Q0oPQrkCnLlC2FrHSkdpejloHvXSE3GYeylWcX+++V4z@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1Gmo5EiU2Og2/HtNMUYd2PM45o53oMWmaQrbdwriarSYxHxV
	cVo/e5C20bHSo15vmcWAOreo23ma3YNkpw3X9ceuOckc0ivytIrznapTlxTvFdk=
X-Gm-Gg: ASbGncsNvHWXnR1g3T5oOoeg7fEo38kSiKyBC+717AjNvpWmxbzIcOqMLwRUn+wFZIH
	E38kYn+6VD8aXOgmHJwapobQh0FBiERRsD/eRW/zZ93UK4GgtAtQ7Ua+KWyfiRjVCClC0sIEbSI
	TQsttBbyj+xJbO+U0iemf5EkwwuvfVViGukuzeOFIaFrAV1DvMEhYy+tUWds+71rvSTH5+zSHGJ
	K1HYQp5pGgfGCpzQgpXSe3rbc6RlHxzo03RPeL9O2fm8+nWyW6M/azFOZIYrjY9NhlE4TE6xrdc
	yX0uxyjwEF2hdTwKlvMgsg/6PF4r1H9Yf3d9P/ObMB/33pMf5skD
X-Google-Smtp-Source: AGHT+IGCn/S0qj9GuJ44fQmtWgz5m2TwXqJJpT6TiLeYnQy6Y2uJkuYa90jtpXsoVH052J0M2cNJCg==
X-Received: by 2002:a17:903:3c6b:b0:227:eb61:34b8 with SMTP id d9443c01a7336-22c535a7eecmr49716645ad.25.1744988117862;
        Fri, 18 Apr 2025 07:55:17 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf18e4sm17854525ad.62.2025.04.18.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:55:17 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 18 Apr 2025 18:55:07 +0400
Subject: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMpnAmgC/y3M2wpAQBSF4VfRvjbFIPIqkjAL+8Jgxqnk3U24/
 Fat/yILw7CUexcZ7Gx50g7S96gdat1DsHImGcgkiMNM7FxX8zFWDWvFuheR7NI2RgKFkNxrNuj
 4fItF+dlg2Vx4/cf7fgDFRsFZdgAAAA==
X-Change-ID: 20250418-via_pwm_binding-32f7c4e5ede1
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744988119; l=3573;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=RoN3cLeK/9p9mwdRIwmQYy7Phi1BWqjDBzsnmtQBFGY=;
 b=LEtfxtqx3xa3LOsxdPHifRaAXT5Bd6L98wJoxAe3kyGxMg3UKZQxWyxWkoyl3r+NjtusWljVE
 3vyWnJT18z5A38kVLX7VFmV/ujaBPJffn9OXKAF7PHUjKEk7C29CeGp
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Rewrite the textual description for the WonderMedia PWM controller
as YAML schema, and switch the filename to follow the compatible
string.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Split the series from v1 into separate bindings patches so as not to
spam all the subsystems with unrelated changes, per Rob's suggestion

Changes in v2:
- reordered nodes in the example same as in properties (thanks Rob)

Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-5-f9af689cdfc2@gmail.com/
---
 .../devicetree/bindings/pwm/via,vt8500-pwm.yaml    | 43 ++++++++++++++++++++++
 .../devicetree/bindings/pwm/vt8500-pwm.txt         | 18 ---------
 MAINTAINERS                                        |  1 +
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml b/Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d9146ad715ba74c1f5641c33703ab06577fe80dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/via,vt8500-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
+
+maintainers:
+  - Alexey Charkov <alchark@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: via,vt8500-pwm
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm1: pwm@d8220000 {
+        compatible = "via,vt8500-pwm";
+        reg = <0xd8220000 0x1000>;
+        #pwm-cells = <3>;
+        clocks = <&clkpwm>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
deleted file mode 100644
index 4fba93ce1985a1e4c5a361423725fafb10eaa339..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
-
-Required properties:
-- compatible: should be "via,vt8500-pwm"
-- reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
-  the cells format. The only third cell flag supported by this binding is
-  PWM_POLARITY_INVERTED.
-- clocks: phandle to the PWM source clock
-
-Example:
-
-pwm1: pwm@d8220000 {
-	#pwm-cells = <3>;
-	compatible = "via,vt8500-pwm";
-	reg = <0xd8220000 0x1000>;
-	clocks = <&clkpwm>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b82704950184bd71623ff41fc4df31e4c7fe87..b4a7e04e586bc0fa2913dc97b99ade0680510bf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3428,6 +3428,7 @@ M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	Documentation/devicetree/bindings/i2c/i2c-wmt.txt
+F:	Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml
 F:	arch/arm/boot/dts/vt8500/
 F:	arch/arm/mach-vt8500/
 F:	drivers/clocksource/timer-vt8500.c

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250418-via_pwm_binding-32f7c4e5ede1

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


