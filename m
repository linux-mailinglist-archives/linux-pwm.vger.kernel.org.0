Return-Path: <linux-pwm+bounces-7046-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C492B2671C
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1616E178403
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02CD30102C;
	Thu, 14 Aug 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrrPSywt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DED3009FE;
	Thu, 14 Aug 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177717; cv=none; b=XonHUKZX8YgEBN15BndStP5GgzM2ZcTeX0umWlDUTt9vnaDzWPtDy+oE4iVdyb293TmZO9V+eLGHGQKEtXUg6GidKvtsQgFWLTlLPeLfIc8AQmy1vKUq2uAinkFSwGC7JtFPMdlPNQ6bFGG9CQZIcrPU5up8n+B7ePzFBZWMYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177717; c=relaxed/simple;
	bh=x0kOk8eWAry6DbH4ndyacx/LzJHveDzrowCBPYfPE3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjWwtGm+gHzlK99diWnQydsCFk6Xul/lB8K3mw+BHIbUuY6KhskqDs32XFdEYEAIipYZ57hrK95KgT5yY/e6382wZgU8o6QNG/jsvLatUc2RFjjzMX7m0uSswkb/CLX79za7zNj+8qHXAhMTzzZ37Tj7C+fMPnK/u29WKdFJnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrrPSywt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so445566f8f.3;
        Thu, 14 Aug 2025 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177713; x=1755782513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Z5I6dWyMwjN9MucQxrz1rMb+esFAduYn7apBZYxxE=;
        b=PrrPSywtlLfzaUv+T/vhn08oq9xDz21lLeVvVVRYFzQsfzF0Cx40KivVpXQQld9b9q
         A5s1t4+BghNrHjh+J5G9Gi4/bD50uqUg0LA6DFOrFERnuZC30i/FqvlTfrg1S1j4gaP0
         2MJ/BmpcDURoMbBs3WiUJvy903EALHL3uofMqX8DBkb4/25/NqYmdQGFT6h1kBBSaBD2
         L5lTK/cCi23ijcStKdfb1YWciy/bUT4sbWFLuz9VZO+WrW/KVHFFPT2Libe0FnnNqvza
         l7WvnyBHgOb8VYeqdlxDBt2QFazBnJgt1DFTmP1yNK8iRlYRXx/aAI78OqEwwrBXcx+g
         Z5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177713; x=1755782513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/Z5I6dWyMwjN9MucQxrz1rMb+esFAduYn7apBZYxxE=;
        b=RR7ZRKXaQEMUHIQQ26A63XwwH15KFcCauSldr2t/kmVoR1C4ZwjdmM+Kao5fGUVdWI
         JFk8ruzQ2BFQQhAdMP9gmiW/cbt+E2xqVEEfOZrI4uin8l9QJHSRCfbKJxfXnF3AblTM
         oFZzc00qoKpAjr+yczt/FeAAwWodmOvu0isI3VRHkA2/t8ildUrv78pXRT6ya3vkNZk3
         Y0JF5qUG7M23BxtSqcIOak8eyhvqeXaCY85VJXuV9yO4MwRrJINoKBM0dIUGvUXhXS+X
         mZ5mjdmZq88mMJmWVWA5p89JemzK3RtuaBRGp+gkbZHbaREJMnbGoAeQAanvcLxlc6lT
         Immw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ma5N+uRbBZdJyA/1yL5PL8X7MneCOOo+oyZdIQUYoOR3E5dot4zjZWPpZJnD9bkJT881oAnfP6JxEP8=@vger.kernel.org, AJvYcCUF7xK0Stliw22aIUDK93NzOjKfx/84FecmVb50RXUTBYEmCYXdCKI/JXXOCWCFC+PouSngnqxoZQz4@vger.kernel.org, AJvYcCWl7pbP/p2cdd43GdesdrWuBe89p40HtPynUTKBJFHo6TWBsYWs9V1zRUXocGvcA64xncroBPj/A3lVV5E=@vger.kernel.org, AJvYcCWrAcjXLVxYxwXk3eRiLDwdJD6X386Naq3AP3m+MYk7bGcm9WapttY5XB1DovTkhGRGSXC+xdmO7aWm@vger.kernel.org, AJvYcCXH6mGVqxF+MZGVd8VmEK0BXo3DmgFbBrCnhSzvGeTZ+doJfSA/Wn+chzz0Cu1cEzseaBgXD43LoHFd@vger.kernel.org
X-Gm-Message-State: AOJu0YxkctLEn78VgaRjG6jFK2zjRNW9EjCN3G7wWEAuX7fAIzhG63Ew
	quOhTRjSG9hks6nX9BWzQYfCJpORF989bfDBTVk2KSuSBqWaA7/JZTX0DJpb
X-Gm-Gg: ASbGncus5v7OQ5DJqMkKk0Zt3L13utaK2g5wLJ8N1G+t+BMdQOMM6NZfiZv2PYPB5R0
	CVsL+P88dgnCrrJJsOaEpr2BYgV1ZQdl22zYnnNiOuCo8U2vY6wVUN4UvVXyP/LSObokBOPN90y
	R0AR0qoLgxAWzP9V/ZL8MfmKgp5ZyBidmk0BrFRVuYqGWdwVZTU1UEKSimF6u3eYidCNVLz58N4
	HX0ANaUvrflFeSA/B8wb9N8S50u0pvtoSoMUoUZS1hqwXTaIk9p7zp5lJ5uaZl/PtkM6K3P8pL/
	cNX4cpSAZ1ZukmeMEU7ZiQH2sadf5uylPNFdFRooD46QBpDBev6jMCHu1ma9oPendVwIrT/k8Jt
	iXnN/zwFs4syKHZg+E3liqsKP7AksqOqv31JERaXl0e6lp7spimuVaeQbu31o5o94ycbRMdKvf9
	i2q3IqKqsF1uu2XEN0P7qHK2mxzAFTSav6
X-Google-Smtp-Source: AGHT+IHVFoiXUIreKvxXRO3Krsynr7hhwOktTnYSxjgR2e504nGc/2IHEseX0AV0D31qm2NqO/HVXQ==
X-Received: by 2002:a05:6000:26ce:b0:3b9:2960:bf3b with SMTP id ffacd0b85a97d-3b9edfbc9demr2001463f8f.50.1755177713341;
        Thu, 14 Aug 2025 06:21:53 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:52 -0700 (PDT)
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
Subject: [PATCH v2 3/9] input: dt-bindings: ti,twl4030-keypad: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:23 +0200
Message-Id: <20250814132129.138943-4-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030 keypad module
to the modern YAML DT schema format. This adds formal validation
and improves documentation by inheriting from the matrix-keymap schema.

Changes in v2:
Simplified the description field by removing redundant '|'
as it does not affect formatting in this context.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/input/ti,twl4030-keypad.yaml     | 44 +++++++++++++++++++
 .../bindings/input/twl4030-keypad.txt         | 27 ------------
 2 files changed, 44 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
new file mode 100644
index 000000000..2efc88b89
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,twl4030-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030-family Keypad Controller
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  TWL4030's Keypad controller is used to interface a SoC with a matrix-type
+  keypad device. The keypad controller supports multiple row and column lines.
+  A key can be placed at each intersection of a unique row and a unique column.
+  The keypad controller can sense a key-press and key-release and report the
+  event using a interrupt to the cpu.
+
+allOf:
+  - $ref: matrix-keymap.yaml#
+
+properties:
+  compatible:
+    const: ti,twl4030-keypad
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - keypad,num-rows
+  - keypad,num-columns
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    keypad {
+        compatible = "ti,twl4030-keypad";
+        interrupts = <1>;
+        keypad,num-rows = <8>;
+        keypad,num-columns = <8>;
+    };
diff --git a/Documentation/devicetree/bindings/input/twl4030-keypad.txt b/Documentation/devicetree/bindings/input/twl4030-keypad.txt
deleted file mode 100644
index e4be2f76a..000000000
--- a/Documentation/devicetree/bindings/input/twl4030-keypad.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* TWL4030's Keypad Controller device tree bindings
-
-TWL4030's Keypad controller is used to interface a SoC with a matrix-type
-keypad device. The keypad controller supports multiple row and column lines.
-A key can be placed at each intersection of a unique row and a unique column.
-The keypad controller can sense a key-press and key-release and report the
-event using a interrupt to the cpu.
-
-This binding is based on the matrix-keymap binding with the following
-changes:
-
- * keypad,num-rows and keypad,num-columns are required.
-
-Required SoC Specific Properties:
-- compatible: should be one of the following
-   - "ti,twl4030-keypad": For controllers compatible with twl4030 keypad
-      controller.
-- interrupt: should be one of the following
-   - <1>: For controllers compatible with twl4030 keypad controller.
-
-Example:
-	twl_keypad: keypad {
-		compatible = "ti,twl4030-keypad";
-		interrupts = <1>;
-		keypad,num-rows = <8>;
-		keypad,num-columns = <8>;
-	};
-- 
2.39.5


