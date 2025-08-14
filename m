Return-Path: <linux-pwm+bounces-7048-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6166EB266EC
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDEB1CC1869
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0C3019B9;
	Thu, 14 Aug 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVvL8fbY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407C30147F;
	Thu, 14 Aug 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177720; cv=none; b=K5xFtvWJpAI2pCdLx/bYLtfjYCauzBYxaX3QVD8vL2S32cJUdVGV/nfpYsd+WK6q/tyPUAN7Dj74YiJ+mW93ukTqaxM+rIGtPYc+Zv4+tv+5hqxqXnIWdN+01HOu/GcP5dMnk6E2slME/TnLj/S57y3OtB/jh7szOBKO4a4cTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177720; c=relaxed/simple;
	bh=gY4ipD8wWPl1M6+6JrqYSWAvtJI6laAGzkb+xdQRfv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Seb8HXFfSy9ap/ZuHhHVLh9ph4BH9qaxmWBMG7flQ2BzammNoAFBOKa9nfAjLuEnEzgAVYXdQzz99uwaBJhchmbpmV+KpDcg7zJo6kJDdf3MyrEqRjsr0hpOJ1eVGqxLOSqNxCpr50g0iB6AjoGZ63xaIr0SsitwfO2prkjTqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVvL8fbY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so469888f8f.0;
        Thu, 14 Aug 2025 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177717; x=1755782517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3zYiSbWa/8gFr74O4y8591kMrUTTGd8r0VSLaU0hTQ=;
        b=OVvL8fbYouASrLKughJOCG+NzzVNUpzU7nRe4l35JXC6onUsyYGZAynjdpnXlvB0Zt
         eyg2zu3/WUjrp7kEY2BoZEOiua6HtXvnH2qdschVuMmicdwah5OOIt89QFA0c4ZQPmC2
         hDggnoZi34Ug1XqGJjNGP0yvGs61i/IyWGD0gBMYSkyOj5ULzbVQLkpwxpSjhILW6DfY
         2X1XKL4K2oZxp/IHAnz/mKpO2ZBUsjKGf9iBrCeRxMEGT3b/MZcfrxX3HdaA8FIgQV1k
         gvWasw3Z2vtVTlFGdHtgcy+0d14lsW51R3AmUtpI8YsTjQhTbCI3NqwZIgxFeD7N4+3W
         i/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177717; x=1755782517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3zYiSbWa/8gFr74O4y8591kMrUTTGd8r0VSLaU0hTQ=;
        b=ssR7yrktRICgKtbFxTodxJ9Cv2244gDdO/NhGQzKHNpIz9KISAvFgJnaFMXD8pmLZH
         uu2d8PTO+fmrB2RnVd034NYUcF2av4FbEUvCHg+wHBOxZPWzK8fFWtjuLga4nLGkFnht
         fQWdYf0WMqeSIeYYiYJzV6T34PTr34+ovhaqNSRCgrCEHASKVJeSHc3ituPfir6qzK1X
         K5KfrjNKm5HOGomz8srrE1g/cunn3KYJqxB+9eoazkmedRaf976+kMg8Vl52rvTDwMHq
         lqFsCuKAtVY/XMlQ5V40N4u3gMBFDu+EpTDViCFUwX6S2kX+WoSLpNp91StiKUI5N/SB
         D9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDHtdIJJbPSPue816isfPD1mE4oLx6X9EO3BaAM69z+aILVSqAgxzwtfmwB9rV/8xTkcgD9bhnnFiLUJE=@vger.kernel.org, AJvYcCWBKhodPBHofqo9GwW7vZY4EEJPrFfp2OYwwk8A/VnmO2esEQ5p7mTUc6+kT+fDZ086DH3jRo9yfaLq@vger.kernel.org, AJvYcCWS7JYcWQh9dpHYjUh3mT4f8DGx6k1QUfvfCJ2JJSmOgtQJbSLmGVqKvIhjzBFPWD49zXZX7pC11MXD@vger.kernel.org, AJvYcCXOlKHk7zKwgJ3KKq3vGcW8yVrmg5zuhJvggrgn3EKrE3mUs1Wgyyd5Zk19ZMZcfnQHGY3rMa4sPSw0VY8=@vger.kernel.org, AJvYcCXQw+ytoflnjvjtanHL+rBtSB5OlJ1eg+1QPRaccMoNXfyRmpd0LKDyXLQs+9QpaeYMT9KwIpjdYskz@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUXWTSQp7bbxPsv7uryeQxWWUX5MELzmRFw5drx064rlVb59v
	WHFwIdqH8j/wmk+IsMjKsJ/B97RusBN/5KPeV3GoY3KEuF4qyOv3/0hkjvuZ
X-Gm-Gg: ASbGnctWmi2yY+SQDHmjysNoZtuDrpay363GfS/FvCUdfqvz+cc8LnMgEkBkGBdhdsG
	iS1AQOne+kRcLIyNRx+rnltFFK49XlQHXhyZGiTvr0VaSa7h7LRNquFnwR0BJFBfihCRpURD0Y0
	9ymVZPb+jRDdEPLMOEeD7LECFHmP3Qh8RxZSLjpaFehBZWxfqV9hC6wmrqYbv0VZxXE9B+U0M+0
	s3WMPecZUOPCFPa1i+IoWUOCHYL9T1B/ZQRdzgzU6NaGDg7EicPMrfJwYVmp25hx32ltz4vWetz
	FKqjPBDhGjdbWZNUzDvJh7c5SteY0TStL0i9NXeUMu0oMEqg84Zyz/4wJv01/HiKp4nC7ZvQkMR
	ETnxZA0rA8MNLlgQzDMLUtPwhFP9aoYTEGyvX3HUVQwU54N+LXAV2hbWohtlyBEWhe7LS/spWcq
	YnzuYJEUpqPngsCLCs5sN/4w==
X-Google-Smtp-Source: AGHT+IHgGhFs8cSuMf4qweZoF+v6DINXFMJXX2lXCahskB/Rjoe0LzYw/gxXtHKVqO38o+C4nZ0+Qg==
X-Received: by 2002:a05:6000:40c9:b0:3b7:905e:2a32 with SMTP id ffacd0b85a97d-3ba50c8e0a4mr2109502f8f.12.1755177717177;
        Thu, 14 Aug 2025 06:21:57 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:56 -0700 (PDT)
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
Subject: [PATCH v2 5/9] pwm: dt-bindings: ti,twl-pwm: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:25 +0200
Message-Id: <20250814132129.138943-6-jihed.chaibi.dev@gmail.com>
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


