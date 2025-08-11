Return-Path: <linux-pwm+bounces-7008-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E36B21895
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272E27A3FF0
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5422E402;
	Mon, 11 Aug 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYVM1c+0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FA22B8D9;
	Mon, 11 Aug 2025 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952489; cv=none; b=fNFjQzF0qvXCzprypq68SBpPuxxvi+vlrp6AP7ciaepZLH6X3Qj4l28oBKwhBQ5NQO+IV+V2blQs9/30CLYrfKtukF2mr74BGR7Qbov07910+V6G03iKaQrU0FuWkrWaD16Vw/CFw9cQaWPyCu8pmAtho9pPcl7DoAMakmrLkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952489; c=relaxed/simple;
	bh=MV7S+kUROvQAoaVH4pGfcJ+qdDPaS/Ic5YlRl7A1Hgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1SEEzZfT7yWZDi9w6ffXpPiuDgxBx10AOKXZBGkCXS7OjsCu/opf+Xw4gzxU+p69FE5BGKb1RaEbZ6TWg5PTuZLGG8mIG898NK9z57awYS9s8uEKTeXRkkBBtsCTZnUHH9/dftsOWYJjd1f136DfdKi27eAoueWC7KowtrmY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYVM1c+0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so44981495e9.2;
        Mon, 11 Aug 2025 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952484; x=1755557284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ1sWi9Ld+mn8Dm52q9eQg3nj+VNEnJN00cm1PT+gdg=;
        b=BYVM1c+09FUAsXiQhqZ2+KtpMDYYoyWz+TVqvj/Dr+up+2Mcem/F3DFx+mLv7nA7Td
         XhJXhjOlqH3c8hJzD7lZA1DLiggAH4Q18Gciv3NbHP6waGSlXvOXtedZfn9bWuYQRDpr
         5RIV8bNH9QGD0ms3bXHzAOoep1yVuzf8htCg6ANwGNPtC0XYyBHdVhBpM+PVzl8jKAVW
         ow6NAYZyo4Hul8XUu7aLa7D2dPkSBJCGWdhrYbb3Sp1ZTKKSdhOjIqtLIqRPh6dnPKbf
         V+e+JevtirV6alBmaxLy+RkkIf1xIygz4vps4w2q7xZ7f3Fh0nl3UH2l8vyXc0ibYzjR
         dghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952484; x=1755557284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ1sWi9Ld+mn8Dm52q9eQg3nj+VNEnJN00cm1PT+gdg=;
        b=R3Aprd3A7joQPHBgocCfUesy/jmflfU/4ZeURKlq0P1VB6URBuN+6nY8EGNATEk58E
         A04JPRugxf54IYjf57ywZM6N1dvL3aCGVVWEbBDYLeSGHYqfVIExN9c//Acc2xKijule
         ilZ68MM53EV0WSKt4tLJEQU1Nfpy7+kOYV+qjr+187KNtnr/yy28aNSl705AF4kEhFAp
         Phx5TAgykPoCyEZAMb0IYnOF2iCEPkIvZeRLMKVKJdPdtMX/b7eIirGljFMkLDLuFOnA
         Wb0iWrr+SyBlOCnm2FxymM1rhKyBnKdWt9j4iN7YIxUP/MXcDL6AlQhlTNTf7yUIF6qa
         14hw==
X-Forwarded-Encrypted: i=1; AJvYcCUCETjIcak3WbVVNN8E9D4FOMRYYW7MUJNLrj6Wmqt/xIrdvGjAEnP2LoG0CmfYOEc3TaGCEfcyuY0H@vger.kernel.org, AJvYcCWmCVNro+wAkp7B0Yt6/SgyvYoSsG0oNvrPCXRREwQZrOF3qB21Mmwm8k96HONhQT+z5IBLEZ+ADVGH@vger.kernel.org, AJvYcCWn3N6EMjD4DbOXuZCsMZD8CdMZgLANOTwSac+SIyR4x2OmXmBgsG/8odNepv9qcvclpNvASog/y4Iy@vger.kernel.org, AJvYcCX/nftEc2mNUTh8JU7liHPBR9fX22tF9OuNFyWV2DaGT2ymCJc3zd16Qjni7MQsctacQ1T+UfOQCTJeZ1E=@vger.kernel.org, AJvYcCXawVYF9uWrZ2ytYEMdbNosW0wj8giAg1oYhxxug4k9M/HgaKDa5JQdlGvCD9LCsc+xMavfeR/hlCaoQag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgQVcfYwqhLdqMNR2znyqJAKaUwjGCv5BJ+L/6mhJUP+T6srS
	cX6wpq+FWr7ll9UmR1c16lDKiPjpsJKbzm/d4tv4l6sexIs4SpqwKu+r5mibSkw=
X-Gm-Gg: ASbGnctv86e8kb1xo9Od8YhSIIMVUwcPz2d/EIJ3Keu82r4TtWDpupxjjifT4OfRZin
	M+xcElTMZwt6t34NkUdnwvh+WVS5nc3XW5ayP8SyQX4J2nrUbt9x/4Ua539+mi9fSa2NYKIvMo7
	bunR4/X3c3D8JwB126O5RuRz8NYjYUYAo+HeqKM70a4/Z59/ZBgBApg11TVjN13yqpi7jeAY++f
	GlFIdEpi4V/6b5KkHKS69i537f1FAeENQfShTQyrO9f2uDGsTdlR8E/ibAQYcAVPRN60HbmWgUw
	SGnwLucCfwRf6b6k7DpK+5c7DrdO24UKG+KEGpLQG0dv1aVxsgv/eYXeo0pLuMlAFse1erp8/xt
	ZjveCUwKSwEAM1lP1A2c0AWhRHsrxL7e+GUoCyut3KIugjaE=
X-Google-Smtp-Source: AGHT+IH8yt7+06Jn3LuuEvBNd74fBDIUCZN6ZWbu9kAPVJtO3BpqSjli2yf4acAYvyRt3wUBZurWUg==
X-Received: by 2002:a05:600c:1c2a:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-459f4f3dc83mr108399665e9.7.1754952484038;
        Mon, 11 Aug 2025 15:48:04 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:03 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@gmail.com,
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
Subject: [PATCH 3/8] input: dt-bindings: ti,twl4030-keypad: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:34 +0200
Message-Id: <20250811224739.53869-4-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
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

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/input/ti,twl4030-keypad.yaml     | 44 +++++++++++++++++++
 .../bindings/input/twl4030-keypad.txt         | 27 ------------
 2 files changed, 44 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
new file mode 100644
index 000000000..a7c4916b3
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
+description: |
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


