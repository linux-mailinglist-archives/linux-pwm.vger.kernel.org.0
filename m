Return-Path: <linux-pwm+bounces-7010-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B2B218A5
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD167A8079
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCA2E54BC;
	Mon, 11 Aug 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSSsX6mz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8152E54A0;
	Mon, 11 Aug 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952493; cv=none; b=K9NWVR+ZYBUQ9ebULrpZz1B9OYD+m31JBoJmO1SXwEM0WM4QwCrYM+CFXi5cbjheloCqNUc8weACq479zkomLoSSuAqcx4kNOMGLvw6f9TOoPF8851KcCln1xJXkgk2YyfKhYv4v9lfAEP8P/5McO6jOfHoezQ2j8WN+J2wcwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952493; c=relaxed/simple;
	bh=gY4ipD8wWPl1M6+6JrqYSWAvtJI6laAGzkb+xdQRfv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaAFl3uPyQoRolSodaOqz5FV5I1e5y/AOzPPRiwQC9UIFq2SgQ0K04Ji27y3/OtU/IslFSefNfzkoLjrnQdyXzsI1jJioLqB0g5YSJ9s7rx1lYrZYIMt7VwYHJJXn9OH/h+7FTsio5cWuAts4t/qp9uZ86tGwVQiLaR1gR2K6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSSsX6mz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso31180565e9.0;
        Mon, 11 Aug 2025 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952489; x=1755557289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3zYiSbWa/8gFr74O4y8591kMrUTTGd8r0VSLaU0hTQ=;
        b=RSSsX6mzLmoiNgQcHBla4e+oteJ6f6CJbEpQyxZP3rJBedWYmK1NRdUh41ULv8K5vR
         nWndm7AHk6bOrknQbkhK3DJmt/3yFlJQaquYgMRBeJXVYMl1JFVH6lNrkvSUSJxhhXlv
         wa/tY2RsAycjhtZ2Nzp/e2KpXNJASkDziRCJrkZ9HG3CgwPQVPB3uif5NOXYyonWFtG+
         3Ohg5YxtCWWW5eoD2fI5ZjBs0XHpwoEy6Ozb/loXlKZc92RAPWysKAY+urQAd45BzLkb
         QzlMtz77VruOc4mqZMxfO/sOVg1IIGDZeq1k0oGOk1i12+4Kk347qgBK4hJaj/Q4TAhQ
         +mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952489; x=1755557289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3zYiSbWa/8gFr74O4y8591kMrUTTGd8r0VSLaU0hTQ=;
        b=CzFNaDMxP5iocmQ06JchD0xq8dzSG9R+nytFlIBGXT7+e/0a/1VWBlBhs0gSan1tuj
         Q+bkQ0eirh9uyKLAPGTc4b3wmR6JHF8x3yhq3KsLB+K/J2ie3kLtVATFZNAEyDxE8BEw
         OopFmUbhSOS6btTxYHGPfFc/ISac536d6n3IR/uiYMIgXhq+jJjBcU8bF5EHJ68Eh6Pv
         Z5wpCoIqb9/NjPS7n5/yABo3es4XQjxT+1dxr7qZySKnh+YIeQYNIzZ3eZ5bokb1Uh5u
         kdbCYbeEzwpgey9L6KbXXSlDL9yv5n1jbEnO+khJ8BzoL7PKeRmsVPFwKz2Wbtr6+Ibm
         fwow==
X-Forwarded-Encrypted: i=1; AJvYcCUOIB4k5zpWW0XbGT/cZssSYg3nGgSZJgtHRhuVYjyiMalUHo7MdPWz5TzJQYOs3gCBOmco2yAxi3NOefg=@vger.kernel.org, AJvYcCWaY1nha1ClRcwBv3+PC6Or26ur4nDWr5ko5uOCNyGfprPF2mT2FLx5lZ+1Xdce0cNVQK4oQDTCtirJ@vger.kernel.org, AJvYcCWfFuznBCQcsfJdjPMw8Z+Tnbr1grlnNkwAoXibLQK4t1FqYTZb6QAdzRwfc4gfJqoMux2EM+J+dZ68@vger.kernel.org, AJvYcCX7hmFro/QVXzGrH4YeVpF54CmE7AIS2SggZqn8d5MtQzS4BUhYwotdrShaVmcPyu1l6nagWmnXUD85e9o=@vger.kernel.org, AJvYcCXar0RCffpl3E6oLJNQs2adK6ZdZvhz+3OY5iyKOCFNE4QoCsDfx/2LnIDhJEezFuMuuHU7SNqa5HFY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6F+Kq1+xVvDiiCR69nzAplKKcm00jVKKC0RMMUk56rSbPpVdn
	hciEx7lvQunniNu/5nA0cG8/XnesoRHM8n6X7sqkJURH+emAXZQt95GxZcK8u9w=
X-Gm-Gg: ASbGncua6M0C79TE6aJlMpKpsw4QZ8UUTO61vfJQ+wWe9U6BhsP1om0Vq7jgJquOQYL
	CLiD1a3TGb+lfLvgF6RbUtjFJ065o1nxAyUGsjGF6C/6+4A6SoAKW6JM1XeNEpXaPBrZsT8wsq3
	orgSptp9XTHaR+RyRpJZe40vLBLII1vrwJs5znrbLzCKN/dRv9gCeNla7BY8W0wod8memYX72/C
	biLyx0KsVV2MoZmv+z2fKpRAVTHtYcfGkt1qPRIKBkmWTVDyUbQlxJSfcDYZXMQaCAhpdrHK+VQ
	iZj7JdaIUluYT+hy3ewSolY21BT7EFrb4+iBcqZ+0CRb3FP4eryD7e+ECT0OvLD3BI4G7aWfynV
	CsSTHIl5WIvMlDiNFgWJi2irmGGZU+oqBT5KYX21W8ZwGNA4=
X-Google-Smtp-Source: AGHT+IEbcxCUEiLSDqA+CHfoPnRRB51Rzie+AnI7Psr4l0HcGT08f8lk/aT0ytV8oyesZdQ1axi6Qg==
X-Received: by 2002:a5d:64cd:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b910fce9a8mr1003465f8f.10.1754952489318;
        Mon, 11 Aug 2025 15:48:09 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:08 -0700 (PDT)
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
Subject: [PATCH 5/8] pwm: dt-bindings: ti,twl-pwm: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:36 +0200
Message-Id: <20250811224739.53869-6-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL-family PWM controller
to the modern YAML DT schema format. This adds formal validation
and improves documentation by inheriting from the base pwm schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    | 17 -------
 .../devicetree/bindings/pwm/ti,twl-pwm.yaml   | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
deleted file mode 100644
index d97ca1964..000000000
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Texas Instruments TWL series PWM drivers
-
-Supported PWMs:
-On TWL4030 series: PWM1 and PWM2
-On TWL6030 series: PWM0 and PWM1
-
-Required properties:
-- compatible: "ti,twl4030-pwm" or "ti,twl6030-pwm"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-twl_pwm: pwm {
-	compatible = "ti,twl6030-pwm";
-	#pwm-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml
new file mode 100644
index 000000000..5bbbdc13a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ti,twl-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030/TWL6030 family PWM controller
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
+      - ti,twl4030-pwm
+      - ti,twl6030-pwm
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
+        compatible = "ti,twl4030-pwm";
+        #pwm-cells = <2>;
+    };
+
+  - |
+    pwm {
+        compatible = "ti,twl6030-pwm";
+        #pwm-cells = <2>;
+    };
-- 
2.39.5


