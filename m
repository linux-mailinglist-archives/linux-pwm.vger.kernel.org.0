Return-Path: <linux-pwm+bounces-728-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A97C82A173
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jan 2024 20:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC94C1F22888
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jan 2024 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221451034;
	Wed, 10 Jan 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="02WsKl4v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585704F8B6
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jan 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598699c0f1eso1522533eaf.2
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jan 2024 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916279; x=1705521079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA0bcNe9/eac59bnZ/IUUlYB3WuV6EB6kCsXeejEFVs=;
        b=02WsKl4vaIeUkHFh469ekUOkLLs5JbPq5RX9EcQS5BrIbbISSd++VW4XhrP/bHsz+0
         ZHghSUVfT6+KTiNlvBk0KB3tiAosRCdJlqhtkK+IaGb7hrhkCxNYnhZHS42VHFmsza++
         093De/0cvuY4EJc6Iv528DvMX4Q9V+3U46Md5bl8KU6hHJaE3I7Q5GVadA44pZr/0ao5
         XAfnkbsO2ZM+iEY+7R6mX/4V5k+AKMKs4QFtj70CDopfcm2jbN65/f8pHF8toDUPKfIX
         K2PvhHDI7uTufif83DZcj16VGjvLABxyjhMSBTvxwAaJwUF8FSarp8KXf/3Qpm1dfvqZ
         Yp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916279; x=1705521079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA0bcNe9/eac59bnZ/IUUlYB3WuV6EB6kCsXeejEFVs=;
        b=s6pbe7Ut76O4jHeVvw3em3s8izqnnVJ/6Eb4wB/UxoOrCby6e+uCbLRLDoRiZrOduK
         3rgxYbnMAy6mog588nWJILo3j64XxISWry6kMT1cLSMyVGX33KLenk+xBCNUqsFZJ0aL
         LaGfHRLJbmj6CO/1zOfX+oHTlrTETIla2sFySpbPetep4TEfkP6NKdIEp+bJ7PcC47Cd
         hYlaJlErOliqgcAVdIGiqcPsvbcSr3K/5jjkl0R7h9ilzm80CBLuOGipOOMedKb3nq1/
         AatLnVTka/0bz24R2zXoj/RnaiwIDPFx/LEbhkogrc9Kl6OtbSQE2G+o5pHhw+PrrKrg
         sWLw==
X-Gm-Message-State: AOJu0Yyr8+cENy35k/pkM/10xtzmwlVioLjqhjum/WjPZOuDBQTPWHiS
	1/seOsDWC5ZXTNYNCgKayr9p/EQPPTpyPQ==
X-Google-Smtp-Source: AGHT+IG3BhDUaaPc6LLu2Tb07BOZGRGY+lvsOSYjZywg5P+2QNwScjXEW1AdXp5YXMWGQ7WWlOqVlQ==
X-Received: by 2002:a4a:58cd:0:b0:594:cea0:eeda with SMTP id f196-20020a4a58cd000000b00594cea0eedamr108844oob.2.1704916279403;
        Wed, 10 Jan 2024 11:51:19 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:19 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] dt-bindings: iio: offload: add binding for PWM/DMA triggered buffer
Date: Wed, 10 Jan 2024 13:49:52 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-11-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new binding for a PWM trigger and DMA data output connected
to an SPI controller offload instance.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../adi,spi-offload-pwm-trigger-dma-buffer.yaml    | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml b/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml
new file mode 100644
index 000000000000..748cfab19eff
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI Offload with PWM Trigger and DMA Buffer Data Output
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  This binding describes the connection of a PWM device to the trigger input
+  and a DMA channel to the output data stream of a SPI Offload instance.
+
+  https://wiki.analog.com/resources/fpga/peripherals/spi_engine/offload
+  https://wiki.analog.com/resources/fpga/peripherals/spi_engine/tutorial
+
+$ref: /schemas/spi/adi,axi-spi-engine.yaml#/$defs/offload
+
+properties:
+  compatible:
+    const: adi,spi-offload-pwm-trigger-dma-buffer
+
+  reg:
+    maxItems: 1
+
+  pwms:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+required:
+  - compatible
+  - pwms
+  - dmas
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        offloads {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            offload@0 {
+                compatible = "adi,spi-offload-pwm-trigger-dma-buffer";
+                reg = <0>;
+                pwms = <&pwm 0>;
+                dmas = <&dma 0>;
+            };
+        };
+    };

-- 
2.43.0


