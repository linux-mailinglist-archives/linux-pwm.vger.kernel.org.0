Return-Path: <linux-pwm+bounces-2499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9190D3C1
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21F11C25240
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3F155A32;
	Tue, 18 Jun 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k36UooHe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8B1553BB;
	Tue, 18 Jun 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719191; cv=none; b=pT8n3wR7vIetnW/n/TRGTVJB/mivYwKc54p3PjdoKXVn89B/jcBgXX/ce7I/RspYde7/WzX/fX1QvDHBbs3L/AxtEsWePrk6vNRqg2hrDSWz67Rc0U550bvojlYa9EoeOQ/l3gygLMcjemAae0pj+yeBucEjU9ta+1xsOl+C8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719191; c=relaxed/simple;
	bh=NSipSLp2nG6EjiX/c5tUJTeTkiL6bf1l/S7iaC8WvW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N8t5MzQ0f3Wqsw8zVI+4jTr4KHHY1dxV76fuA72wlFLG6U50CGmCtRaom3wD/2BeFBYZI3SeJkETg3UCYlD/5artVCzwIY1bgysUBIlz0akgPGdJSPAC0O2Z43kwggAIbv8rnN3dj9tsNaCpqmA9JwmPe7XCL0VloR1sc7GlVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k36UooHe; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so58990a12.3;
        Tue, 18 Jun 2024 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719188; x=1719323988; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Adi2wWb7CQgdnxLc6JlMBQCMQ7TabQhjqNcj/v5iN0I=;
        b=k36UooHeJsTzPzoUQkRKYHspmF+qjBs70zwjpj6VGnnlq/Td7A4NJLAnc72Vez5e81
         dHGuKFrKUI6x9rTurN1oP/xJCdl2R1ymgBb2wd1UL5Whc8ZFTReerZbS4zwyHF+WhoWU
         5+hitBYr0xyTmGN4RxC2RWgYmUJDDyzB8Vik7J7xz3e/h/6wavFtEitdA5nLuoPfECwV
         ZlDQeWA7Nv9dC6ZJ6YeYcs9xxhKQfIdim4Qx9SXY5kbSLczMKwp9sGLgp3/jszzPELT8
         QPpQuo4LmupEB0qu+hwvR6dGbz+U85pRKoKOWzaLf6uteq+Mn268f+isRXbYQoG96lEt
         cvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719188; x=1719323988;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Adi2wWb7CQgdnxLc6JlMBQCMQ7TabQhjqNcj/v5iN0I=;
        b=hLG6LKtr2t1iFVXMT3/5qfKKxW849qYE3nfwxz3aehWVXxAEXAzsEcflNu/oexWP/Q
         g1W+A8+F68nKFAIE4LG9BkZpmEh4aY7VLFQvdfpjk9/rl/rYqA9IgWh3K7JhPxAkSjnH
         uh4jeWiCehjEDZf/1/E4eJ+H5aFbuhGmuz68zUQ785fbufx2kQ/cq5ZolPFgG0BBA4dt
         76BuiQtuvDjw7NxKoVBDr6xFkT7lUKxqq37ds6S/2LIrIT04Z8sWycrs5wmOtSAaui0P
         8+hHBIQzxx359AGYQV2OhfpcwQkbbQqHnZrUpGitEm6FVcYHpy9gvNMupndGWkZ+l8Zr
         foPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqpiFRUSJomeHWzoFHBkqyqX1mTywGAWRu+vOomHyyD1DDnoy479eYAMsUf32sgv2LJqbZyOgLJPM72xodXuyFh1t8TWqZkRMzx6Ob36GPAsyx2LLlUUd/Pi8RJvhw1EYssh+vcwCu2GfBdeUq3b1XOsFMEvXa1OUa9j8e1b4tWKEijT66SYTPgz2pDvlfXX44vn3WyKxRXmgGO2wwPY2NaI/ONhoh/lo33MH77ikJJfuRBRjoCYsfFEH1JKfmVFt/o07GeU/MQzedAr202bqtKpR/9GUBofHoQ21bXcCfpnoin2O7XBjXVTgb3Y9FuUuHDdV/FJT3VT5aNubqL+G2xC4G4MKh5Jbn6SqUbarOk5Lg82Qr8CkQuPmquH9Khr7mAgh/7b6iF4E6OG5FulcugS9gz1yb
X-Gm-Message-State: AOJu0YzW2x+xDevQnVd+y2gzWRGwYwzNtsbwWBDCRx15Lnb+lwxm7Sha
	Qq7JWgy4NMLYqz74S6ujYeetJz3jnnI7LEYVHuwYDLUThgTqExH4
X-Google-Smtp-Source: AGHT+IHkXZgoTKxIUb0ylYKUXiHMUMsGLjdaUUwhyfeBvSUWkw++uYmoTYRWLAznXRQEGKmegPpZkA==
X-Received: by 2002:a05:6402:2c5:b0:57d:5e:83f0 with SMTP id 4fb4d7f45d1cf-57d005e8481mr820906a12.14.1718719187201;
        Tue, 18 Jun 2024 06:59:47 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:59:46 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v3 00/23] This is continued work on Samsung S9(SM-9600)
 starqltechn
Date: Tue, 18 Jun 2024 16:59:34 +0300
Message-Id: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMaScWYC/x2N0QrCMAxFf2Xk2ULddA5/RWSkNVsDNc60E2Hs3
 w0+ngP33A0KKVOBa7OB0ocLv8SgOzQQE8pMjh/G0Pr25PvjxZWK+s6VYpKRpdKsWG0zrkupSvh
 0IQ79cPahnagDywQs5IKixGQhWXM2uShN/P3/3u77/gNgLEi3hwAAAA==
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
 Dzmitry Sankouski <dsankouski@gmail.com>, Rose Hudson <rose@krx.sh>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=5095;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=NSipSLp2nG6EjiX/c5tUJTeTkiL6bf1l/S7iaC8WvW0=;
 b=Sr8pA2ujQFTHIDig3qhFg2f1KEeBbgU4VxItfHedbfa6oxlb7f4Sec7x5JgfHjY52G/css65m
 KY4otbWl+7dB0CpeN2Z/x/SuDr4cWH2saHT22U9tDUZGj+70EOppvtS
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for new features:
- sound (headphones and mics only)
- gpu
- panel
- buttons
- MAX77705 MFD:
  - charger
  - fuelgauge
  - haptic
  - led

Changes in version 2:
- s2dos05 regulator:
  - hex to decimal in regulator values
  - fix compatible value
  - remove interrupt specific code, because it's
    empty in vendor kernel, and I cannot test it on
    available hardware anyway.

Changes in version 3:
Version 3 has significant changes:
- more drivers added
- s2dos05 driver converted to MFD
- disable crypto patch removed(disabled on distro level)
- dts framebuffer node along with related patches removed,
because panel driver added
- fix 'make O=.output_arm64 CHECK_DTBS=y qcom/sdm845-samsung-starqltechn.dtb'
errors, but it still complains on 'monitored-battery' and
'power-supplies' though I have 'power-supply.yaml' link in charger
and fuel gauge bindings.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Dzmitry Sankouski (23):
      power: supply: add undervoltage health status property
      gcc-sdm845: Add rates to the GP clocks
      dt-bindings: panel: add Samsung s6e3ha8
      dt-bindings: mfd: add maxim,max77705
      dt-bindings: input: add maxim,max77705-haptic
      dt-bindings: power: supply: add maxim,max77705 charger
      dt-bindings: power: supply: add maxim,max77705
      dt-bindings: led: add maxim,max77705-leds
      dt-bindings: mfd: add samsung,s2dos05
      dt-bindings: regulator: add samsung,s2dos05
      drm/panel: Add support for S6E3HA8 panel driver
      mfd: Add new driver for MAX77705 PMIC
      input: add max77705 haptic driver
      power: supply: max77705: Add charger driver for Maxim 77705
      power: supply: max77705: Add fuel gauge driver for Maxim 77705
      leds: max77705: Add LEDs support
      mfd: add s2dos series core driver
      regulator: add s2dos05 regulator support
      power: supply: s2dos05: Add fuel gauge driver for s2dos05
      arm64: dts: qcom: starqltechn: remove wifi
      arm64: dts: qcom: starqltechn: remove framebuffer
      arm64: dts: qcom: starqltechn: fix usb regulator mistake
      arm64: dts: qcom: starqltechn: add new features

 .../bindings/display/panel/samsung,s6e3ha8.yaml    |  76 ++
 .../devicetree/bindings/input/maxim,max77705.yaml  |  31 +
 .../devicetree/bindings/leds/maxim,max77705.yaml   |  45 ++
 .../devicetree/bindings/mfd/maxim,max77705.yaml    | 112 +++
 .../devicetree/bindings/mfd/samsung,s2dos05.yaml   |  89 +++
 .../power/supply/maxim,max77705-charger.yaml       |  30 +
 .../bindings/power/supply/maxim,max77705-fg.yaml   |  35 +
 .../bindings/regulator/samsung,s2dos05.yaml        |  36 +
 MAINTAINERS                                        |  15 +
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 607 +++++++++++++++-
 drivers/clk/qcom/gcc-sdm845.c                      |  14 +
 drivers/gpu/drm/panel/Kconfig                      |   7 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 426 ++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max77705-haptic.c               | 378 ++++++++++
 drivers/leds/Kconfig                               |   6 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-max77705.c                       | 166 +++++
 drivers/mfd/Kconfig                                |  25 +
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/max77705-core.c                        | 278 ++++++++
 drivers/mfd/max77705-irq.c                         | 299 ++++++++
 drivers/mfd/s2dos-core.c                           | 141 ++++
 drivers/power/supply/Kconfig                       |  21 +
 drivers/power/supply/Makefile                      |   3 +
 drivers/power/supply/max77705_charger.c            | 772 +++++++++++++++++++++
 drivers/power/supply/max77705_fuelgauge.c          | 624 +++++++++++++++++
 drivers/power/supply/s2dos05-fg.c                  | 427 ++++++++++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/s2dos05-regulator.c              | 362 ++++++++++
 include/linux/mfd/max77705-private.h               | 281 ++++++++
 include/linux/mfd/max77705.h                       |  20 +
 include/linux/mfd/max77705_charger.h               | 225 ++++++
 include/linux/mfd/s2dos05.h                        | 123 ++++
 include/linux/mfd/samsung/s2dos-core.h             |  21 +
 include/linux/mfd/samsung/s2dos05.h                | 115 +++
 include/linux/power/max77705_fuelgauge.h           | 107 +++
 include/linux/power_supply.h                       |   1 +
 41 files changed, 5927 insertions(+), 17 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


