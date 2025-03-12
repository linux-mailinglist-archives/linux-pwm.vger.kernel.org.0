Return-Path: <linux-pwm+bounces-5135-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E6A5DC92
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 13:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B4C174501
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A5241CA9;
	Wed, 12 Mar 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF8Hbs57"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58924168E;
	Wed, 12 Mar 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782488; cv=none; b=ZNyHFwUOOL1BdwbTy3k3VFrtde/NKOlykCiHdRaMfS8NSPxmiII5VtdLWAMVx+aqXcHjahyVjKmQA4uz2K63VEomDf20cFOucwjDyq7sM76WRTXgiqiuZ9DWtsV2AqXxdmlq/CC6BmX1hO2mfWnt11tvYdF7+AQP5SpU9wiEj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782488; c=relaxed/simple;
	bh=eLI8ZQpDeHJjUFJmDAEO+qwnlSA/Gq6OLz6UDxl1fsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJtL/AggcI3baguyAedlAQLHO5qVY6d83NXBzbpTLiF13QAQopB+CvsabqevJsb/1zrxB+EpiupA9TYSVqMkVPDGz5W1syOyNYHw+O2F1/LukPBt1S2hyNyK2VA2retsYh8us1SFnxobLlaXyQayad8Fi4X+iSjFcVMC74NAPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF8Hbs57; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223f4c06e9fso13614475ad.1;
        Wed, 12 Mar 2025 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782486; x=1742387286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxUbYz05EixkTPFqKStUgtk6UPZfDa5JQwQa/HwWCZ0=;
        b=VF8Hbs57zgutOPomxXSsVJMx/FUgDAPNv0wCpNmKel1OWdHO69qbZCsOywHSpl7f3k
         C574BOZRLhb7Q3TyW0Dw+ol3Vy0Mu6t2GzTakOz9uYR+a6eNLYX7CYfGjAYh7vTe26Yp
         r7X6Q752J/zQlIGBoQWn6NRZr3rc+ulpx9nDfEI8dt7x/9+k72QmXHCuGvoMzPoD3Jqr
         +OlH9KcU9KUFWYRCljyMr8obl7sskFVBFUfVKqgq5BIJmwbHl55eNNymR46j+WhepNNy
         nj7EGr7H/gO4bSxjCWNMgt1Zik/ApZEcwgTxVngUkt4pBfa/ezcFTtbcJH0qg3cfiNNh
         AU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782486; x=1742387286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxUbYz05EixkTPFqKStUgtk6UPZfDa5JQwQa/HwWCZ0=;
        b=tYHtYncIaXCil1lBLCgTtEyWl4+5cYTn/xRLVAvOA8w/UYLNR5K9D35zLKAvXXOg6B
         cM27B2cxMtJImf3avV+dVTvOUB1W6ckSx1bushOjGQ9tQQsVPGmgqZRNbJwiukst0ij+
         OTtTWKR1QqSLTBeOVoZVI6IMtsImuHLeY0dSGttUAUWTQ94JZiTHrHigD2xXNPlwzFU6
         k3Exw0wqALijK/vbLAKVlGcxvuWsudaE0fjuLKIiAghdim64GxKMjDJxwfbnxN0+Sqlg
         O4d88rM5Pjs8P7zjABq6WBdwACv5ERnoG95BrlGrhh7Z34uArcRGCikAWSQP9AlzZcT3
         STow==
X-Forwarded-Encrypted: i=1; AJvYcCW2PajoKHAS1bl1KzwArlWyDn5Y2LrEwJZTLBSfAfADDqj+aYponSSp/wk74sU5inA1azr0TXRVMGMwZU4b@vger.kernel.org, AJvYcCX5fxeRPcXmvRTnKuirpWKR10Vs8bcbhYqKpx4YgD92PKnedTTL3TtLQckzvutPxsexre7U5RRqKmsF@vger.kernel.org
X-Gm-Message-State: AOJu0YwvETTj5hHRaqPlMEJ/RX5cs8sKYFlvwAJ+G2/aMiVIilPImhZq
	7yUlsnQYSRruD5jx4I00sMZ3PSTaZlG1mM1RUJGDsveSGiyFXc5IDuicKphQzHs=
X-Gm-Gg: ASbGncsk4lhoaGhhcJXE135eVZ/CoPR+Sr0BNppKOvlFIfIhYJA0XztxwQvqaVUFfGO
	WfuzaxHNKwpj2ueb4ctJkd47YCVRp24ElMyM82/M9PtjNE+yJd15sQmx/WxsCXKqukGvV35aiPG
	dIFSTceggGDOUXv6bkZhBPwuLUgzBcgi/INuQk+jmFz/e4L//CHKoGQEGQfg/ezSgzHChEthExl
	uZVcKrsQbboZ2dMmbkwNi7jjvB5Z+11BgwfqbEd6vyhE4qoK3TM4wy1M/bl7YXRfX8cVszyIw7w
	SWH88cg5Imh+G7fCjgNHQxkizl+j+EKtuSpencikmVOLQzqcDVMMdrdrgMl5RLNvF+BOvB7zOAM
	=
X-Google-Smtp-Source: AGHT+IGMRstxw7VlBWo5AclJnc80nudS0j2DV/XKis75x33MKdrmONuUAwxabjmT8wMAvLHS9LgnmA==
X-Received: by 2002:a17:902:cf0d:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22593d9e8dcmr90162505ad.20.1741782485826;
        Wed, 12 Mar 2025 05:28:05 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8532sm114691035ad.56.2025.03.12.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:28:05 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
Date: Wed, 12 Mar 2025 17:57:50 +0530
Message-Id: <20250312122750.6391-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
YAML schema (`nxp,lpc3220-pwm.yaml`).

Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250311125756.24064-1-purvayeshi550@gmail.com/
V2 - Correct filename to match the compatible string, remove unnecessary
quotes in maintainers, and refine commit message.

 .../devicetree/bindings/pwm/lpc32xx-pwm.txt   | 17 ---------
 .../bindings/pwm/nxp,lpc3220-pwm.yaml         | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
deleted file mode 100644
index 74b5bc5dd..000000000
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-LPC32XX PWM controller
-
-Required properties:
-- compatible: should be "nxp,lpc3220-pwm"
-- reg: physical base address and length of the controller's registers
-
-Examples:
-
-pwm@4005c000 {
-	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005c000 0x4>;
-};
-
-pwm@4005c004 {
-	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005c004 0x4>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
new file mode 100644
index 000000000..432a5e9d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPC32XX PWM controller
+
+maintainers:
+  - Vladimir Zapolskiy <vz@mleia.com>
+  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
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
-- 
2.34.1


