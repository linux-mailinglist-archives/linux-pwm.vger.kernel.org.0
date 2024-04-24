Return-Path: <linux-pwm+bounces-2070-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD78B0A3A
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA2283F29
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8215B15A;
	Wed, 24 Apr 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b4ZKGQYH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7115ADAC
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963536; cv=none; b=ACT1GWfqYMMZAhq255dMyKLwGhs/v36JEF3YoCI8/D8s4SjUwmIwjkYZklxLJP7PlCt6U2ksU2y5nRzY8upDrdAf416I8iup3vJ0Us9HVDP3DfZ53+BkxEeBCwm8kTSZaFyGtmH5zDITRpQLKo0feOBZ6RLBusjcQfv6Y574Lu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963536; c=relaxed/simple;
	bh=T8lLPOkWXbFH7sg12jo67en/77SFP/tup9Kzi/vq+14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzfcICtYHUZ8ObQ3ZFKHk5XGm0R54lw35RYqCCYj+YfJp5JhJjcAojnowj1WNh1fNREIR09VPp+mOFcgbazva8oY1eOUakrMShOwBFXZrF7a82q+PxcEBuiFN4mA0tADVVYuO9TggB3DmEHYDnRecdk5C/LfULal8Ag7FlAX+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b4ZKGQYH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6164d7a02d2so79108777b3.3
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713963534; x=1714568334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6/gcqb0M9BBcfqCyY9UV1SBtUrd6nOAQzyn6kSwMpc=;
        b=b4ZKGQYH2rm4UKLDPmoAMjffphcqNwoInzlsOnE10QL6PNgOu/WFkyGSe8EjbntG69
         SjFjFpPkuI3lZxc6pb24UwO796ZBQp447sH/UTdXxzB2jN/KjlplzuOxKyUmiVDcZZop
         861C6Ncro8w7VcsTXhoX6TTbh3q5ugFJ7Oq4MUy7KzIsdQXZTmBSjAnE7mKSeMbIQ0eL
         dR7Yr+iVoQsD7ou7+PNJOzw2jynAV+cPgOFq5v6STHt7RDY3d3t0m4Ud3O1z0x3nwtrt
         DOFDRzcRRlmcnbpi1PuUuUEex0aMWqahQLHs3Dv+yJWnysrajxZBs6mTa/zcUAT10+Y3
         hICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963534; x=1714568334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6/gcqb0M9BBcfqCyY9UV1SBtUrd6nOAQzyn6kSwMpc=;
        b=vCl0Zj/dPDcAJMMfbFO2UJGJbzwbWd7qEdoKESjBMVOPJeDgtu8sEg3+5XiB7brJc+
         qvrxp6sWVKBJJvDkeK1JE4KOv39ULWnmKHgvykWvtFh9MIND0i4+QgnsxD1RsNwdVz3b
         f3cc54DU7B3Z29WhQgbs69C+Y82g+DOKlRw9KMhg6fEZWIJShNBTvhuJqEAomiuEgt0a
         yujQI8DkU3gyv5h/byqH+B/+5rUAD/P2TzEK7qmndENlpl5jrzKkTr/19H0odg+gmOCh
         Qviene6on/t+M7gtT+DW/aVevxkgIV3uucJrXUlKl4K2Bkeh3Fa+kAiTg/UKBRbvyNvV
         6YiQ==
X-Gm-Message-State: AOJu0YxcOKnBeVAthuPtak779IUsKxpOIXRvoZ4ZQ8sD2YShcgBFX/Vr
	3URU4nkYKnXfTYvV5SEGmkJCU8juLGSg+vteGSxWjGUFzuNWFotTe4+MSnsac0aSXGxVST3G9Fi
	jP/Y=
X-Google-Smtp-Source: AGHT+IFZkgGJhB2y9pkhaWJT1sXfkpt1OOKspaR+8y+y3E79ioRpknJzl3WvHQ/I4U86brhszVuRHA==
X-Received: by 2002:a05:690c:67c5:b0:61a:d86d:fad with SMTP id ic5-20020a05690c67c500b0061ad86d0fadmr2166628ywb.51.1713963533965;
        Wed, 24 Apr 2024 05:58:53 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id ki16-20020a05622a771000b00439c3072d24sm2399995qtb.15.2024.04.24.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:58:53 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 1/2 v5] dt-bindings: pwm: Add AXI PWM generator
Date: Wed, 24 Apr 2024 08:58:47 -0400
Message-ID: <20240424125850.4189116-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424125850.4189116-1-tgamblin@baylibre.com>
References: <20240424125850.4189116-1-tgamblin@baylibre.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v5 changes:
* Modify to list only the supported axi-pwmgen-2.00.a version

v4 changes: None (rebased, added maintainer's previous Reviewed-by)
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
index 000000000000..ec6115d3796b
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
+    const: adi,axi-pwmgen-2.00.a
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
+       compatible = "adi,axi-pwmgen-2.00.a";
+       reg = <0x44b00000 0x1000>;
+       clocks = <&spi_clk>;
+       #pwm-cells = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..d02ece54ccf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3465,6 +3465,14 @@ W:	https://ez.analog.com/linux-software-drivers
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
2.44.0


