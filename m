Return-Path: <linux-pwm+bounces-789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42F82E155
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jan 2024 21:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D25328388D
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jan 2024 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C7199A1;
	Mon, 15 Jan 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qkxkutBw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264419471
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jan 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-598e01ce434so1173465eaf.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jan 2024 12:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705349545; x=1705954345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoGYdHuOEch5eGoOUgb3CbwIdtVZ1B+1VuVUe8FdGw8=;
        b=qkxkutBwONnkNLDxt2Rt7GfUg+ZG8foCxf/FhUNUN4cDCJdsbhrDbCV2tQf6U6Hi82
         hlC3R03m5a/Cnqo32GQDSAIr3SmLcRSG9CQ7szwJumS6/aX/mRWjF6h8Ijug7gnTXkRI
         gyUTqOmZYIzD7lK2vLgRvpLKwrQXNEUcZldaxcWxs8K2TViwEj9K7REjJPdfYt9BwlRD
         ynzovUHmAw+Phs+hkAeQU5NYW06Y0SlW5F1LprGIZADaZfVY+7etv6NJzBDKRmXXPu87
         Cc1HBckSML0F9ZNs1TtPRwAcuJptqLqLFcfObgGsqkPEdQrHtNCAqZMENmP0jqBj1IYE
         jxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705349545; x=1705954345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoGYdHuOEch5eGoOUgb3CbwIdtVZ1B+1VuVUe8FdGw8=;
        b=dPSEkodTiHrc59ZvkXh5GyjQtgLwQox5+/fuQnA3RlDd5R/EqI8lCCtAn/Cz2JL7t1
         TQnA+AwPyj1nj632fSRERqsDXX5XPJjiQFJYBSEF5orgzObgdHu1GFkoaLtiWfMfP3qy
         KDwJ0XCGUzmkRbqkUh1xfoaCGbutrTjDWeE8Ymtd+7yBcivZ565rwD6Q1annOhnle7DM
         TFONE6X0u4qUiYb127NwpXGwb7YYaEwtT7oTe/X7jnn0u1PtRJmMYhHcFr/XlXdRMlwM
         7rEExLmaRp2eXcrd3+LJSAcw/cL1ZNUCOQapJ5csM5Tgpwz4A9KZFi+Qf+8pReXvZhDo
         0nSg==
X-Gm-Message-State: AOJu0YxdK3yoTXaEzXybFiVsM+At0ki2Or5BZJivN1bSuwUAUEwMiAoz
	YGVBvR0vTkiZQVfSiNySmzSNkOd7mDi8izL7dZqx/8wWNFA=
X-Google-Smtp-Source: AGHT+IHnusVFj+YA3xivR599tPImC6bULBVIHPYSM+PjDD1HCrUKJZuqs61Cdx3c+wH2pjzpb2J/hQ==
X-Received: by 2002:a05:6359:6b81:b0:170:64cd:8aac with SMTP id ta1-20020a0563596b8100b0017064cd8aacmr4081881rwb.62.1705349545406;
        Mon, 15 Jan 2024 12:12:25 -0800 (PST)
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id y26-20020ac8525a000000b004298b33cdcasm4219170qtn.50.2024.01.15.12.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:12:25 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 1/2] dt-bindings: pwm: Add bindings for AXI PWM generator
Date: Mon, 15 Jan 2024 15:12:20 -0500
Message-ID: <20240115201222.1423626-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115201222.1423626-1-tgamblin@baylibre.com>
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@baylibre.com>

Add bindings for Analog Devices AXI PWM generator.

Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 .../bindings/pwm/adi,axi-pwmgen.yaml          | 48 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
new file mode 100644
index 000000000000..8f16b2e14154
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI PWM generator
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description:
+  The Analog Devices AXI PWM generator can generate PWM signals
+  with variable pulse width and period.
+
+  https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: adi,axi-pwmgen-1.00.a
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - clocks
+
+examples:
+  - |
+    pwm@44b00000 {
+       compatible = "adi,axi-pwmgen-1.00.a";
+       reg = <0x44b00000 0x1000>;
+       clocks = <&spi_clk>;
+       #pwm-cells = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c6c7b50e6ef6..7b0f3aec5381 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3415,6 +3415,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 F:	drivers/hwmon/axi-fan-control.c
 
+AXI PWM GENERATOR
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+L:	linux-pwm@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.43.0


