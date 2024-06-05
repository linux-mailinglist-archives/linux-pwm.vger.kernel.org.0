Return-Path: <linux-pwm+bounces-2360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656068FD794
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 22:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E546C285E5A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524115F301;
	Wed,  5 Jun 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c8ILcfTq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245015EFAE
	for <linux-pwm@vger.kernel.org>; Wed,  5 Jun 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619722; cv=none; b=C1cTZ4ADaRc81kWwg4Z8H5roh2TuzMEFIRI5qjKtMDdaX435XbrYYrrdAzqblNnSE1/46ojqHbrDjNoVbpzWyx3H+pmCMDXgMdN3pP+f9NFEWEAIs+RPfUd4y2gUglXlFQ9wnH6Z5q25LSSDe7DcVcnHtxZTz2hbpiyl1tDVBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619722; c=relaxed/simple;
	bh=5qMF4uBuJ8Ip1AMHaJyYMz8hLXxQs5EuH4BboueFRaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEyB+rNxZrQOvzh2oX9ZwP4gkbnELBkuc/rvBailQPqwHKur/5HASIkwBg16G+drfiu0TCisDx33ugLi8V1XcL/Dme0CQO+6WjbCFBIuL9xeWGD8A7IEHnUOvxA5agxtG7B85ZO4BMXSEhYm0O/wD+eope76L0N2BFnI1Cl4JS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c8ILcfTq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627ebbefd85so1868247b3.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Jun 2024 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717619720; x=1718224520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lbZJPsUoa4XmTTYCaRxmeVDL2GHCmOmzNtYyrZpNQQ=;
        b=c8ILcfTqqrpGPAreJQvIqnCoSP8L0211K79MtH5QKUHVBnCtehcGMNhhkkKpW/8YHQ
         FoupHzhemdXvzX4rIKHHwtKh2BLuFOHOf3ztheLryZku3VBVMQv0FbDTys48RB7MudQk
         cPgD+74KcfiAaVNAMcOD+qOqJuqb8ozatAtPel3dN1fdUZ49aLV928+A3H499RouBNnu
         hXY9BMpLlp5yE/3hJ7eDG6+yCaJCME5XunF9ooPMoQP9TLPNXYUhSSU4wP/vnZRPsU/M
         xmnxXJO2XOO/lyIRkSiQFcmJH5AJuCsYYX8cRVvd9E1WXELgYXnm5DT1fuRGK5hGY0Tf
         XlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717619720; x=1718224520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lbZJPsUoa4XmTTYCaRxmeVDL2GHCmOmzNtYyrZpNQQ=;
        b=UFz0JH9c8LF/edsIIKCRo+Xw7URc4oUAYGygFSNqGU04KG4Z8z1Cof0vrTnABnHSua
         it4hZhOqHqiuhpHPKAWrb9f0dICMqBSmXJuPYo4zEEtxMLF4yLZZ8/NnvCc6nJrPviBr
         NtPyTfcHkoGIUxC/P9DEBTifg7+vK+LqCO3jb9WnF/CiuzGs+Qrm/7xaOkcFmBhAlG8l
         Coz/1UYTWEIXLxd7zl49JmQyKZ9EsUX5BQg7TuvAdoq7wFfq/dSnKnbTclVVYiEf3v02
         XBNS171TBu6L4YiF6in/GWPYnij3D94Vtd7Av02qEvnBDpTNKmgOhwXgIwZbP7RBSrDk
         JrXg==
X-Gm-Message-State: AOJu0YxCUExd9iTnXOPQztR+L2uR3UUwIeNKaDIQ1N5qLYc+zkaWFpLS
	I6enJBh+s2ckiyK0w+WE887xx2I2ymMzBDRJtdBhSeWDbvbSwycDIvrq3ydH2PWK+/phyMUiW/3
	6
X-Google-Smtp-Source: AGHT+IHmVL0m3Zafcrk3XxjYfA+Q2EMdXM3ZKqgeXEDiAlh6uKEOwUKVuaQbuifmUIi4qJNYCNgxKg==
X-Received: by 2002:a81:4f43:0:b0:61b:28a:e567 with SMTP id 00721157ae682-62cbb4b437fmr36738297b3.5.1717619718217;
        Wed, 05 Jun 2024 13:35:18 -0700 (PDT)
Received: from localhost.localdomain (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afc72485f8sm25359866d6.5.2024.06.05.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:35:17 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ukleinek@baylibre.com,
	ukleinek@kernel.org,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 1/2 v6] dt-bindings: pwm: Add AXI PWM generator
Date: Wed,  5 Jun 2024 16:35:05 -0400
Message-ID: <20240605203507.1934434-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605203507.1934434-1-tgamblin@baylibre.com>
References: <20240605203507.1934434-1-tgamblin@baylibre.com>
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

Link: https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Nuno Sa <nuno.sa@analog.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v6 changes:
* Update documentation link in commit message
* Make sure to include missing Acked-by lines from v4

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
index 85a32423e9ed..e3cb7465fcc2 100644
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
2.45.1


