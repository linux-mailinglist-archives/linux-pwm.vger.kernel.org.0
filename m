Return-Path: <linux-pwm+bounces-7049-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E9B266F2
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D31AC4E599C
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042D30275E;
	Thu, 14 Aug 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhvErttA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0943019CE;
	Thu, 14 Aug 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177723; cv=none; b=oNeo16QrfsAgujZJPN1wk3qfUuG96EeE+Y6Q6lFK3YB7YF5ELJnkqsV9E93FSW4XXbkUcjOIoNcF9MtdoX9OD/cYsAGa9kjYrvwAT0YwGbTK/U6jLbQ8xcjEqIlzmfKRdfaF0q9egJ9IPn2o0miU54nwHSSeMt0z7GgEuRhg5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177723; c=relaxed/simple;
	bh=Rnl8w+SH/nw2JPdcQ0erKjjymCdj0uvkgeVYoBTMisA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7ahw0G4mLvbI1hbviK0He+/9VEFe0XPunyYYvZvcFzN9n2eMOslvWOjlaHMa1E0dqOFdp5aaGCxmFV4699E3CF9wPyWDPtx14atF7yhrrOS4Rby5Yz/J5Tzzm5InMbGrsVPjJWxDvTKf7UgW+jH4JlW6Yf65uKmSv6IvjS3slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhvErttA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so469899f8f.0;
        Thu, 14 Aug 2025 06:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177719; x=1755782519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT6KB9uJF//5o0bC4Hfp3voC6koE6Q4zGOMWpbC4QzA=;
        b=ZhvErttAPheMOkpjI9Uowq3OvyX97GMUZP1ZeTC0i2zYsUs+qsPlbhP+EemHElsjLz
         5lWaZrSXMIo/7ETnm/8Tjm9+aeSBzBCzOMou7F+JTHQLZClVi4Asr/4T7zVLDP9KOP4g
         ge7TBXjkuv3QUeVB2qKX5MnK5hXvB3uuTjiOmwYhakk9bT9K9f5GUppKynWDzlzitaBN
         2h92vn/60tV7BLaXvn4LaAqJ1Nq05Mr90pydWUO4e+rj7dR8Bj4UHUmLdPPWWlseReRT
         X8r6zfdIBsT+ZfNWQwlxf/QvzggMe4FIXPbVaGPVvDSejJJozxNpzjrGEVJpAaE0xQHE
         4xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177719; x=1755782519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT6KB9uJF//5o0bC4Hfp3voC6koE6Q4zGOMWpbC4QzA=;
        b=FgoG1xyQXdF8GkdFa6g8/XlIVllSbQcF40F7w4wyiWWKPDgHtuNevHR759l4Lm2cJ/
         HNn1AOuiePQqbBoz0oqhF/x9Nr2lgCzyonPxg5AaUpyjVNIb85pY5YT2xXdGCKFXxMs6
         jxoDbzM+PB0AemAVLJKHcpBlDD1vC/Llz+zjFfTYHGMCTF3DGqP/NsB8ywW9f9HxpDxy
         oTDPLMPABmVItlW9ei5GKIf/mZhRqI3AY+GNfbxJTS2GLILku/ZL4xYKkHRLTJpD6p6T
         A7/YOeDb2upzGk4wVvYZGzLKOMnPdGRA0smHawR5jFst/6d/McL1Jk5AB1rFcCjwwHvj
         oFtw==
X-Forwarded-Encrypted: i=1; AJvYcCUWOJKcE+1+0SAg0YVKRagFvxahnY+Qoj1+7fmI0EyYWmeuvGi38+YvMQbb0ZJRWNh6KZFCtYlXuhNTk1Y=@vger.kernel.org, AJvYcCVWCBuyQrSQv4NyXwb+tXMA5qYii3aN2hNtFb3NcIlqIPcL0NTIxHYhbNGzzuBJ26vz1YEcZnk3zFtD@vger.kernel.org, AJvYcCWqifmulKsfGzlZ+2knAOoArRRp6luBIkZgLvCsNyUZlDhecDPiIYAfQNnwKx5SqdPdXml9YMLiZmBF@vger.kernel.org, AJvYcCX/8Us2mRD/VUUWs2D+KxSM7dFByYYDsx/+kC85th74+dREerd5cWJTsbBzUiS9A/BSQ+f66tk+t17n@vger.kernel.org, AJvYcCXzS/xHi+OfP9yA0ZTAL8mg5+SrTtry5O+9jmrownOJLamkmfe5bI/Yi73lDIDRip3eGWlos+/jUrgeW6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuW1+JvwbrTpRtuBsXTaK4X/0tN+wi9wpc6rshwD0BOhH7cl+
	pyd9X9QB1hD7eLgWCzELZwTnVFg1x6iKeHd9d9w0fECaMipUywiECyWeJyFj
X-Gm-Gg: ASbGncsmwReiT2gk+JR30nJ+FAJX/JufzrRPhJKMANFjRQ0U2EuwqV5GiUGEsk7y21V
	AEmedx5aS1WmezLMMZH4xlsQSfNmQcxXdAEkl2EXCu/uhU6bLm6jHXELx5FMpBly9MRWnkrphW2
	o0AJQHPP6+mEFN/YRALqhEqC+YavZs58eOhapBKryqfMYaCO5fht2pwuigYBrTshol61cEilN7p
	bg1HPIdMeI601vGa0u3ztJhbjM0Iiaqai7fl1QbuNs4+L0ZzvIw6eQf3A8MJwgEW+eqKZHwWQTz
	5ngWKk3V0w5DmLKUUW/DQgt2YO0vViQoqx9Yny0n09LUdhALmzFfl27P/OGO6LvT2qPh7XdgIKz
	NSPrnZ19ULoQsOAS6PRKXZNbNkF+VmeF2Ww1Aw6fseitSVwtyDPEIm7xMrRm8TR08NB0/S2ixLZ
	qmvQmTYwiSnlhT+j57Mj9c4A==
X-Google-Smtp-Source: AGHT+IG4bFMPBZfDJuCxmQMh7yt7kKJurWok08IzwpwnCbwB4739ifTjCd73R1fEe04W6bs6xOZ3bg==
X-Received: by 2002:a05:6000:430b:b0:3b9:6e:5242 with SMTP id ffacd0b85a97d-3ba50c8ed1emr2223388f8f.4.1755177719127;
        Thu, 14 Aug 2025 06:21:59 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:58 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andreas@kemnade.info,
	peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	tiwai@suse.com,
	conor+dt@kernel.org,
	lee@kernel.org,
	ukleinek@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2 6/9] pwm: dt-bindings: ti,twl-pwmled: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:26 +0200
Message-Id: <20250814132129.138943-7-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL-family PWMLED controller
to the modern YAML DT schema format. This adds formal validation
and improves documentation by inheriting from the base pwm schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt | 17 -------
 .../bindings/pwm/ti,twl-pwmled.yaml           | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
deleted file mode 100644
index 31ca1b032..000000000
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Texas Instruments TWL series PWM drivers connected to LED terminals
-
-Supported PWMs:
-On TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
-On TWL6030 series: LED PWM (mainly used as charging indicator LED)
-
-Required properties:
-- compatible: "ti,twl4030-pwmled" or "ti,twl6030-pwmled"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-twl_pwmled: pwmled {
-	compatible = "ti,twl6030-pwmled";
-	#pwm-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml
new file mode 100644
index 000000000..411cc4c8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ti,twl-pwmled.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030/TWL6030 family PWM LED controller
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description: |
+  Bindings for the following PWM controllers :
+    TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
+    TWL6030 series: LED PWM (mainly used as charging indicator LED)
+
+allOf:
+  - $ref: /schemas/pwm/pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,twl4030-pwmled
+      - ti,twl6030-pwmled
+
+  '#pwm-cells':
+    const: 2
+
+required:
+  - compatible
+  - '#pwm-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm {
+        compatible = "ti,twl4030-pwmled";
+        #pwm-cells = <2>;
+    };
+
+  - |
+    pwm {
+        compatible = "ti,twl6030-pwmled";
+        #pwm-cells = <2>;
+    };
-- 
2.39.5


