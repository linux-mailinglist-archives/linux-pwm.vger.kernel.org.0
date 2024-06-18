Return-Path: <linux-pwm+bounces-2507-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71D90D3FF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362101C238FC
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3A15ECCA;
	Tue, 18 Jun 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvpY7Ypc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4215DBD5;
	Tue, 18 Jun 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719208; cv=none; b=aD+RospM9yJl+EY0ARgqsYVocuU5e30TARvcsRzL5rqtEZUFzKcz4+jaymeYFf9kcORdw6iT8dDZcUj8YiecnP9s1r7lMhW1v4j43jrOgCYnK63EO27IVn0DXvFLBixy4jd8+JfdcAkeumTOjUXzPJrBIJ6R3GCvyz0Y5x7nf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719208; c=relaxed/simple;
	bh=7GuLNZWYidLfySwdnHMlO3cKyzwike5F0Axou4kYDbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sj6hHiJ2fCzT+Ld1r3iJ+dnxaXjtYJ1EzlGK7KzAkzcU7p3SLq0y1tNJ1FpuJWNPZ9AeZlmn4nQirKfhY8VNizoWXfbEO24/5/pvbMEYt0A3+BYkf5xYpNCJSkf5bmQrhcWtwXJ3QO8UKyb6l331SWNMl2bZs9siTUQp0AgdN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvpY7Ypc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso7346558a12.0;
        Tue, 18 Jun 2024 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719205; x=1719324005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amtZh6cok3kVxxh2UoadCf51Ge+lbZ422aIWYrzWULU=;
        b=fvpY7YpczSg8xf034VDQ73Ulz/AYfNLcRsj6ViByhg5Mzs8fGdJfnsNYlatzWKuAWb
         RjhebBRLNgU6sU1YN27C0H6BJ6bgcgPq2ojkbe4KnL/gPspe91gyJQgkUrHFC+8QFusT
         JpFIeSE5VKP6XPcwBjVBRpFaaNTmdFh5TUu6jpqUMD9WEyHQX8No+rdJASdvngJjO2vB
         ICaS7yvVHK2LkpJzEgj665UDgw9Zz/Urlnr2TUeClAwwIXuTJzSbwXX3ePJ93uYbfvUV
         Hsa0s36NW2D/sQwZ7wEUTG2Oqgmf/pL6qom6zqhpt+SIH6YlOgc0E3XsSHkuaMPxgDL3
         BvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719205; x=1719324005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amtZh6cok3kVxxh2UoadCf51Ge+lbZ422aIWYrzWULU=;
        b=nEI+Yo2gMKqnA9agMuGzFzTMAmv87msNYPIaqzXy7joQnN6FNeFnCm6BkhRihBVEyq
         dadd/HJ2h4PzB1ZJ/CkWdODbcw8Z9IbFTIBie8CHQBYRQfVjcDkNQmXKDHKyh4d/663a
         kwCymOXghoUd7Ii+BAtKuXY5cQONy/XRfhD1+f1M7uwbabIqpvNm1vb3ZIwlXo6/OQ2n
         k6eZpJzB1HWmVL5His8XioOk+4RjmKCPhpXOVM3yieAzBBDw9vD34mtxcPDfi73zEX9F
         OsYAVXOP5w+GRwovpSd6bwuNTGfvdT3TqMMxX13OP2XX19gFlHjo2QkyG5XDIlq6T683
         vQeg==
X-Forwarded-Encrypted: i=1; AJvYcCU7D1LJdAv1/5SqcgBYe5kBA10LBzV+D23pia0eD4kTvV56vE78kjS6Jl0r9JWM55vwVnqdo+XHI6rAErHXgx/3TB7KEhvR2LpicOK1qaR/d+7kfLYnvEjbFTLttoRpJOFxYSASn1ofZadAS0jHXbZhCQzcFyyuY39Kq43NugUY0PtbFV+YI6Cqck1kIdy3LyfPqYjHgynIbAGQEl/P70ThQ+A6DDPN/cvXj0MIDhL5cs8xyJA98lGCZ/mJflSKXGA+OAMxvzi4CzEL20mnMhfCI07CzM0rwAGixyPBUMQQ7tqRAG63B1kq4REDD/Enb+uB6JAk23DQKIcmMtPsJ5yGdLTbwUSvdI8MS0P9e0x/2MZ3LEnEm/PduAgH9AKc8Li5/29OAhxKwaUZuJO+xLG8JK9NOpsq
X-Gm-Message-State: AOJu0Yx9aDWib11lOHpPdCQIgCwTedY+XYP/fB/FSb4Zu4pZNFqTbj/4
	ded59l6MIeeEIWY71C17T7jPFBnnVhw9rzlnG7vmfjJ8qP6Us+r3Y972BlKT
X-Google-Smtp-Source: AGHT+IFacU/UFpIwaTa6wZ4f7sRQWphBmkbeBykRZgSzZFVXbMNWcd77zosms23rqaQYfYGh0AnbgA==
X-Received: by 2002:a50:bb44:0:b0:57d:57c:ce99 with SMTP id 4fb4d7f45d1cf-57d057cd44fmr206656a12.2.1718719205082;
        Tue, 18 Jun 2024 07:00:05 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:04 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:42 +0300
Subject: [PATCH v3 08/23] dt-bindings: led: add maxim,max77705-leds
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-8-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=1609;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=7GuLNZWYidLfySwdnHMlO3cKyzwike5F0Axou4kYDbM=;
 b=wXF+V0LgvlhWhOUO8mOS/t/tdcu8fI/3fxi/NQRj3GlXy4qHn3uq8gHX7IrZD2ooIQihcNAZe
 045YHR9yMxgCijG6bla4uPQq0zI6T5wO2cJU1U6TcVPhCbOH+3UPBUG
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

add maxim,max77705 leds binding part

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../devicetree/bindings/leds/maxim,max77705.yaml   | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/maxim,max77705.yaml b/Documentation/devicetree/bindings/leds/maxim,max77705.yaml
new file mode 100644
index 000000000000..7c512545788a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/maxim,max77705.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC LEDs
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705 multi functional device.
+
+  Up to 4 LEDs supported. One LED is represented by one child node.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77705.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77705-led
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-3]$":
+    type: object
+    $ref: common.yaml#
+    properties:
+      reg:
+        description:
+          LED index.
+    unevaluatedProperties: false
+    required:
+      - reg
+
+required:
+  - compatible
+
+additionalProperties: false

-- 
2.39.2


