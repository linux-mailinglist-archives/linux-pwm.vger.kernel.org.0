Return-Path: <linux-pwm+bounces-1155-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60800844A3C
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jan 2024 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18109289907
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jan 2024 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354E39FC8;
	Wed, 31 Jan 2024 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rjm2pb3a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1B39AEC
	for <linux-pwm@vger.kernel.org>; Wed, 31 Jan 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737250; cv=none; b=FFfm8q8fJ+AQ2FT/aiBRhzWQFuwUxjMXW13KBK7KTs0c/TONyFPvoDWomk5JjdQtXdwt8s8iZD3C8hLOJ+XkUhZWw+PW7E+ToE6fKax3yOhagfAtRrvyP238EKZp7j87W2bJnS1CbfCk10zFza8JykSX/qevEE0WeqXGXwSVhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737250; c=relaxed/simple;
	bh=0D3PvBuznXcah933PtyrJperA0WBujRtvSxVac3ciJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeYCTM9otsYPQFsPW98BVEtUQRN4LmJB09D/xrlAN7ef7ZC9KWl/Ua6NbbRSy7m0dgZsx7K+jW0xhYPKqOTfxJ0zEK3yWXwzh2YhbBmOfZCWIV2ZB3MNOOaAdYE5Pl0XH63SGNkmB5Mq/enczYhW6th6qKhIk9lf0fxctjIdtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rjm2pb3a; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78405c9a152so20109885a.1
        for <linux-pwm@vger.kernel.org>; Wed, 31 Jan 2024 13:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706737247; x=1707342047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki773j0Ev7Hoz0mDYF2rJmieDOfkk6uGJjHoeASEx1g=;
        b=Rjm2pb3amHOykT0tjpzciG1rmWH1yb8Jeu8cIpkOUaxqRlOHuLXJJEw26g7Z4x9zQc
         I1puo/z+4byT9O4R2cyBx1EqKAhBINVcA13xhtyqHJAMnktQz5jPWqbEnAYF+qUhsZbw
         OaNL8bI4lANDHfcPUCkEyn2qkvvKRJanvuBop3dA6vRcRjnJ/knoF2xA7BXgNND3klyl
         vF7uMpINIeW9A1TlnPXI/d5/yJsTcBNZuCLflr9tgZe6vPzW3KK7yqF9YAvC+wrKCkmG
         mewOmHBjk5SD4zAioCXaJgSuxUassl2WiLJojjy24GTF8Igxqi3ak95c82LwWysMRFVr
         mRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737247; x=1707342047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki773j0Ev7Hoz0mDYF2rJmieDOfkk6uGJjHoeASEx1g=;
        b=VbpugL8XUerySiHrLpylNeE6P0Ad7wn0mq4sPPEnMONNUJ8ePxQxG/T0gRdNcW8FaZ
         IjyVHQB8hC+pR5mJTblMgsuSu6ct3j+0cipq0Y4HSlAe3JMAhT1+/7BbE0NLuUvpWUSU
         alMziSDywufJKL+2imfc9x7e4v8hE74tMuoJfvge/iq+qGTplSAYRj9nXiRxLhTgwa/S
         kzKBmoEqg+oXhJQ27FcFepep/ViMP4mEoG9rPKJSMUV0aXqzgTuTOxOSsnyC36ycCu58
         dOLC5E2+hSMMZy6Whq+TpSdzqM/UZ3DY+VQylb2Eeu+abTIbJ4NzX1JYrsvkc3j1NUGK
         rtXQ==
X-Gm-Message-State: AOJu0YyGXgp8fhLMxnxUcnslBZnkvXZL0MhJ9j8+jXKhluthGlQP0lfX
	dub/de1gRcAS7/IXLp8hZcJGBfLjcb3fXnmn4jt5xgEaKW7/PmowWATWlSHFEHDe53vU/MwVDkp
	F
X-Google-Smtp-Source: AGHT+IFaDhOXjHQMw+jYCipXxDzDrm40IQ5rBwdwqaz+zYtJtbmBYmdynqVDTOLpde+n6lm0TbofQQ==
X-Received: by 2002:a05:620a:4043:b0:783:cdca:7e07 with SMTP id i3-20020a05620a404300b00783cdca7e07mr929453qko.13.1706737247652;
        Wed, 31 Jan 2024 13:40:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVHkkrJMkJXR6adxHX2xRFS15sheDyXeQrz+v871FTb5csux2zwrqce9m4C4G+T5e1RqnlmR/xNby49vrC8h88sM/NAhkfiFHF5dyXEb8nRr6ZG0Qx+EGoLGvXdBMChAWllGzD7CTsq+Dx4lxdCzKBjZPah8OG2z15CeHihNVVHXTL4gog9xrORzTiHuZDu63mGyDNMWIJSbSBADOZA9695LJ81pNTNdRkvGCCLMOVqGXOBtMviZywfsTlR/Y7BsW7IVqKo+4yTjcDMykGpq2hQ7jrMYm2vpwZZ0Ikz+aCEzNCxwRwGw2vT3+2wMFImBNdrPpyGt+l6RjdYwNhmRF+fdAx1xTNNXQAagyxlDU6fX2fdPMTaAnDvGHbPZvsgS/ryEW+GT+sZYuGOAXJ47aI0WJja4aD
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id br44-20020a05620a462c00b007853f040aedsm537160qkb.8.2024.01.31.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:40:47 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Drew Fustini <dfustini@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2 v3] dt-bindings: pwm: Add AXI PWM generator
Date: Wed, 31 Jan 2024 16:40:40 -0500
Message-ID: <20240131214042.1335251-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131214042.1335251-1-tgamblin@baylibre.com>
References: <20240131214042.1335251-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@baylibre.com>

Add Analog Devices AXI PWM generator.

Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

---
v3 changes: None (rebased, added maintainer's previous Reviewed-by)

v2 changes:
* Address feedback for driver and device tree in v1:
  * Relocate "unevaluatedProperties" in device tree binding
  * Remove redundant "bindings for" in description

---
 .../bindings/pwm/adi,axi-pwmgen.yaml          | 48 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
new file mode 100644
index 000000000000..63461920a362
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
+required:
+  - reg
+  - clocks
+
+unevaluatedProperties: false
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
index 8d1052fa6a69..8a4ed5545680 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3431,6 +3431,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
 F:	drivers/spi/spi-axi-spi-engine.c
 
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


