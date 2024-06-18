Return-Path: <linux-pwm+bounces-2506-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374690D3F7
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB51C2375A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110015E5B0;
	Tue, 18 Jun 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ/cRBIw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4015DBAF;
	Tue, 18 Jun 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719206; cv=none; b=pimzDSjoxa+vn+lJrFWQJY1TTkwSzFJ4kzMCWf/Ib9xo72DznzZd1m+tP/YE2qA60cOfrVLrD4RbmAAatttBV+Rtsn2qLJGNM3lN+mJ2BGPUQ2NiQfsUOoGGPvWEBXeaCJghVPn7CKwmqb/8aHIy9fJtMbTyO8GpClVWA7qN/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719206; c=relaxed/simple;
	bh=kcP4CRKDseKYJTmDRkTK1Kkwp1UjhNtI1X6qAeNdmFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWviC1dXG+kUn0uNSLiZRKe1L5N64wYJx4krYoWc1eCw/i0p3L0HgZvDKWRBfsDYWT5RHGX9JllcBqlV9Hlzey8iC78s/sfVDwiZ2d6sghFlsSpjWta0wdnqmelGlzrl+CBruZIots8tneB8kP7BRt4wOO0SxvGn7pMFKAYp7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ/cRBIw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so6223120a12.2;
        Tue, 18 Jun 2024 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719203; x=1719324003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAPyRIfn0zoFYR6H5DZfvZ7lLQ098EkhxsFz4D8wcf4=;
        b=XZ/cRBIwH/nW8ieZhABkNJQJDbiZ3xfORQdCkem+Fnm3ZYdzJQJCdRX0Vzog0AXpbb
         XDUMibdz3gi05FSN8UNJZBl4ZR9Y8RHUL4S+5xhyi0SGh6PSzZbQanacmYdeklV9EAAB
         92yWXSMdqjqEgjNA0qdlda9I/RWM4Fh4zovZ213ppdzWa495hDMAQIPYH2A5VACMlm24
         eqXcsI4avA6bJrQTKlhb1ViC5Sd3sUG8mBsaYNKPgSU6bm9bAbuPPwg78wYmtHMlF3IO
         CgMjYzpnvshVgHboRCrZ3ELyREuREW93LmJ0NV4bAE0NzrMqLNKzVUXKKWwRDu8MwR3q
         5/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719203; x=1719324003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAPyRIfn0zoFYR6H5DZfvZ7lLQ098EkhxsFz4D8wcf4=;
        b=e3kCusskxE25UWoReVS76cBfVcYLyWlt7l5xgD64rHh+XVVGTgXbf2mvpd1gY5HYzq
         DuK0CdHk4K+O4DX9ls6H5Y0ASW3ZISSt8Ld/uo0FflOc/WSJvic4vJskYmf4s93GmrGO
         g0NchBkgTr0wD3tQlkHSU4bgGvTqG6NieXyVvvuJXLVTYr5evu/UD9oyGGJBoMPcASRV
         K7RgLekcx6WVpK23pDpCv07XI/gR0x9cpGeCBH3BZWiMQ1gwSRGD1A0OTFXf51CBe5Fc
         mQ4fH+foVB6plYcyRz06LYL2uJ9ac5kihZqmD7COcBVU7oaqQkP54zYqqKVlBN+62+iU
         QagQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNhNOqC3Eou/SGvCR+4gNRrWV3cny2aDGpuiURPPCsVzon1XHxshZYqsP2c2seUu3UONCV2OnBOvClb0z9NQjrFC0YB6NO0x8IKLpqPfKXh7yeWj3uUpO9sshAeK9ZJSMFl8i5M+NvWBPJMjbD6mrG+RfHTopnfXw06ha2Yax0LbSxZKF+5eiyCiNIlkn9V+kE6fIir8RMlJz3wmQn877SsYMskuCor/d0wqOupk7IqMqdKrlWFMaPsmMCOcHcPCK63QnrslP2LzRmp8KU0wa5xNyhvBCeD1nOg892bvfB/qoZwSrXJs7s8RlIdfvFSEbT50PEi5s1unwJrULBI/Ly1PeXfqpanbfFJxo5zxcSn1BFVLCSA1UTjUzhvO9zioNViThNoi/kleuaemqQ2v5n2nqZDb5J
X-Gm-Message-State: AOJu0Yz0NY6jU9kSaH6BgscA4jgya53UtzFZoen66RUYyZyW4hdwqZNV
	G7uSw3yrza98jXW7/0Ou65y1el+HMWYChhbCqZNMrSLqQFIpMlJc
X-Google-Smtp-Source: AGHT+IG+4lLZCtVPgURwIdcirf4nRr/hvjtf29y9VmITCHT3oab1SqgnU6wHrBAh8A/Xff1ksbBLsA==
X-Received: by 2002:a50:9f8c:0:b0:57c:73ff:d13e with SMTP id 4fb4d7f45d1cf-57cbd8b9c60mr7324128a12.31.1718719202882;
        Tue, 18 Jun 2024 07:00:02 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:02 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:41 +0300
Subject: [PATCH v3 07/23] dt-bindings: power: supply: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-7-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=1491;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=kcP4CRKDseKYJTmDRkTK1Kkwp1UjhNtI1X6qAeNdmFk=;
 b=/cukwzpYHF5iN3FfFAFfgniEdjw64YdmmzDzpAuzFjD3j6+McSzPALs9l5MdhIDFnxkIqnEyv
 8YlqGe2NodRB8QMkSwE+giD0jR5APPEnJte16G5TK7KUZcHwrklY4zl
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

add maxim,max77705 fuel gauge binding part

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../bindings/power/supply/maxim,max77705-fg.yaml   | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705-fg.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705-fg.yaml
new file mode 100644
index 000000000000..b24db0aba0d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705-fg.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77705-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC fuelgauge
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705 multi functional device.
+
+  MAX77705 fuelgauge with ModelGauge m5 EZ algorithm support.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77705.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77705-fg
+
+  rsense:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Sense resistor value in mOhm
+
+required:
+  - compatible
+
+additionalProperties: false

-- 
2.39.2


