Return-Path: <linux-pwm+bounces-4316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6B69ED79A
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 21:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898A9168849
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D752288D5;
	Wed, 11 Dec 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pDSf7vzv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE222912F
	for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950504; cv=none; b=E+lZsdg/yKVFIxZ16a/AS4wTq9R2r1ggN3sbJyZJUaqvm99fAwC2+1rlWRTazfM6vBSXAYNpgYQvILUl+1vjtm8ghaub3jtQIlDtVWsxE8LWnNQLLpozKBNU0TZhclrBvZ+/UZX7D8mUKLT0IyKsMhZ2GOcdpNfvOKy4nRVrCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950504; c=relaxed/simple;
	bh=XZtUpr/DURpr/L2sxiom5IoH3+HQHJD/Z1pBX1+yTWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4O0FBfWsSlzEsX+GR/mhsC/3IHjefQ3H7mRQk8nqLLGx5bXnr7pMA6p6odi+UIRIiVaEsSsMh4Aie4E+4Rjgt+dB1S/rEiFLQXdzWqw6oxuiYsEjytpWj5OeWmmQIgbR6u8CS+lDf7h4jvBmLxVYRiJjWtIqSeraMNZ7mITFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pDSf7vzv; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e1d6c7738so516937a34.2
        for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950500; x=1734555300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13F43V2/MzfKP/yJr1bHKQJVOtOvlPMBJZi2ZlwKDuQ=;
        b=pDSf7vzvR7Uk/cANUdnE84v5WYVrmVsrE6SKptWAWrBM5fs+eXobtYNckPxOwQT18M
         kg2jz7aZJhUlqBpMUoAskMQruxKo7FNFg68g0TNl/XufutkKepdLC2XvvLU9V32D4jUh
         ARabx4BySMqocNXw/94PnKNO5GL/zPtopGGLf6iSP0PT0+k52fXpwXIgpz/sjs+03Lj6
         oiOB9QgWIK17MwidX8cd9EtkH+T0aOg7OP722RHfjM2kws4FMJKL2B1YcGkRmApWauLr
         CnNeqahVygVOGRXhTWrh5cFbd4UuNgBaUrtreKCNe3585aZtYQ6JdaakgcCsTcxEGSBO
         EYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950500; x=1734555300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13F43V2/MzfKP/yJr1bHKQJVOtOvlPMBJZi2ZlwKDuQ=;
        b=ZS4j95Y4wnj+JaDGZcllVuvseAadaoyYLEgFPTpqBtbjsfmB7rMeV3vULfQyU7AAbG
         M/HxpqzSo3HAH3sbpMLGeHye/s8MCYnvl5o/ACFg8riDq6fDbtXO93cWjm+X+BeTL7EH
         rqLYw8CJGPZ+Jzx4P007IAYNF2k4IApGHtVvD6Vo5Ez8QeCLUOjc/m0IQ/Y66Qrc8jM/
         +2jw1ZWbMK8H/ItNoT/OXZAyUV+KNss8xSG7k25FOAAz3usv3EXDyVMqcLlB4ed+wrEs
         tJAmms4bSOQltywusgR2IW6KJwkGl8QZKxahu9Tasol6FAKEFZkhsPLX8vdzJ930egFn
         ihEw==
X-Forwarded-Encrypted: i=1; AJvYcCUaocMeaf1tl+8EkHmCQwAtROL9DSFRlN+CNWqBPpVs5UNba4HDYROZ44eYASRWSbPaD87z1HDBPqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN12b7AyfPLcVmuTGuNyJVwkHt58PEcfPlynK6wXXVsaIqcBfa
	UVFvVKakhQyLTRp0OzQo1tWUZEN8J4jZRniwRmOBQgCwYTMeQ7AbK3xftltoc3IJSBOmWLvO/F8
	3
X-Gm-Gg: ASbGncuZYHXIWFNld9fuF+an5gjlJ3rPcvmdc8/2lwcQNjKBtRJnf++fasT41IHEQwG
	ORvwcNhuuVZaCb8tkJg+E8f6H44WeWHR3v+kW9qyYtP9J7oupvtyxMx323Qrnq/nlvPFUx4R6Xr
	vjoV/4GJ89eb7eNrvnM4u1A8xYJuS7/8ADdXgv3MU0YCAOWwIKbywW51U3F4YEmKjPsdGNqIZew
	I1ZeghtlQQC9CgCoQhDhdR3VRpdqzKPmJsE6OnwniZ/KgDxzixvkc5CZlIUSL45DbOCR7Pkci0h
	YHk1TLtG8g==
X-Google-Smtp-Source: AGHT+IFj7c/njNJ9PwxP0C3GEgabzaeOT+72JrS8RcScb/tiWJFWNji25E8s/KzbYVZsbfcjXdh7VQ==
X-Received: by 2002:a05:6830:6e87:b0:71e:1ca5:fc90 with SMTP id 46e09a7af769-71e29c5d7dcmr541603a34.26.1733950499810;
        Wed, 11 Dec 2024 12:54:59 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:54:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:40 -0600
Subject: [PATCH v6 03/17] dt-bindings: trigger-source: add generic PWM
 trigger source
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-3-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new binding for using a PWM signal as a trigger source.

The idea here is similar to e.g. "pwm-clock" to allow a trigger source
consumer to use a PWM provider as a trigger source.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Moved file from bindings/spi/ to bindings/trigger-source/
* Updated description to not mention SPI
* Dropped $ref: /schemas/spi/trigger-source.yaml#
* Swapped order in name to be consistent with "pwm-clock"

v5 changes:
* Add MAINTAINERS entry

v4 changes: new patch in v4
---
 .../bindings/trigger-source/pwm-trigger.yaml       | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1eac20031dc3cf921aafb8aa37f4e4eca1075835
--- /dev/null
+++ b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/trigger-source/pwm-trigger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic trigger source using PWM
+
+description: Remaps a PWM channel as a trigger source.
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+properties:
+  compatible:
+    const: pwm-trigger
+
+  '#trigger-source-cells':
+    const: 0
+
+  pwms:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#trigger-source-cells'
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    trigger {
+        compatible = "pwm-trigger";
+        #trigger-source-cells = <0>;
+        pwms = <&pwm 0 1000000 0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9284a257607a740ab7f6fd960c2bcdc34ead7586..b2aa6f37743e48353c60e5973ea8126590c7f6d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23879,6 +23879,11 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRIGGER SOURCE - PWM
+M:	David Lechner <dlechner@baylibre.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
+
 TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev

-- 
2.43.0


