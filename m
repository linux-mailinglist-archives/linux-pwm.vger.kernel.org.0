Return-Path: <linux-pwm+bounces-3233-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE44978361
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5AC28BB2C
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005323B782;
	Fri, 13 Sep 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGkq9+RJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB426AED;
	Fri, 13 Sep 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240093; cv=none; b=VikjrV2D7Yf67dAKI39aDsvYvzzvWkyDnnvnKbPPl1NoFhELjBGR0fDQGE5YzQakxBiRK8HRi+qb9mP+/PYM/GM/zlR0v/veyP9J0+kmE3siX2EFaNW8Q6GpUo+67yHq1R4B6taUfMr1WfIQnA7JeaVyqd2dpuxJhRNu7RtAWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240093; c=relaxed/simple;
	bh=zNden+m4S4qeBBrgrI7oJVPZCF0D5TInPx+aEZ7wheQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rQRqmiwm6fbt51wmOWaVSlXNozrMrQY+3krgBtKE/1pSLEF6btAGeYXlr1AIagTuOENtYekVk7OxOpYOjeCa/ItBTRyk4AsReewsSDd+fCXNyM8yKe1Y9qYk8ZXrCiUJ66lY1NYD4NaRNjLAE2UUEk+idXnghleRHd2IS6Wa40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGkq9+RJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c4136f7f1fso2521810a12.2;
        Fri, 13 Sep 2024 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240089; x=1726844889; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TL6f8TKN7Y/fNaq3ZvIvFLqSapBDT3e44bO5HpzYRM=;
        b=lGkq9+RJaP5Xldycl/gkyudJeHK1E/APrNpM8CuDUJnPKMlUH48mfVH2eWPbaPH2OE
         NDg+uxWz8UPkOXQxJbmqUyS1+XO2dNXWbGtl0y8EOlzgqFXiVjqGfJMlGfoZYnXOjHHC
         O7vqZJBFWXaVMh0c+SHirm39rK8Fw7dig3JAWSotk/pg9th3jMd93FXGNikACJAmzu0g
         C+B9Er8nCgsWpbqvJLbfhjuv6nSPIkwCIVIe8u52w9L/1b5cqom82K/wBS+95eOuiGyp
         oxT+kv++T8BcOE77iz3srsQxnzXN2QDmeqF3Cp7IEYVnvMSZ4t9PUHN3eibGWIn9OX76
         BP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240089; x=1726844889;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TL6f8TKN7Y/fNaq3ZvIvFLqSapBDT3e44bO5HpzYRM=;
        b=c7XQwZoIVqs7cfnpRtUH8LRmvmAPltvOtDE8oPMzRPs1rAWOq/v9Wd7IoVCnFJT6cB
         iL86Mip8Yz+3ocv3PDM6Q2yiPlrVUmvmvnLEiqh5k+9Yzo1i2zZyi8L3ZmtSOby3VhFH
         qcaqfgxgFDWoZkCEginOBFW1lStBesrSJmllU8e9S4jAguhnUiS62e2S5rtjMaPbukQ5
         fvkvDBuLQk1W3LE2Rx705d4o/O6RI/THE3L9dPwBZX83mFTbdk/7rcXQcBeD3/lIktxP
         2/eN5OaZsxQ6hzbNkKaMUALPyC0t0jqLf1eQlnRBtlgc/xYD17mQQmdo+ekxhBZEMP3A
         SHsA==
X-Forwarded-Encrypted: i=1; AJvYcCUOedyt7/reIr5de7j/J+psibw97xFeYQzMX8+6tIwArJ5QarqtYsZgnxP4/ViIfh39DOD6MlTZzzLjnqw=@vger.kernel.org, AJvYcCUdYOSdZ/vtQWIAW3NKhLOBbONNSlt8BW7ppvBlKpzzOszzeF43kfIPzR4V5oTa7GVsvURABgiYkX19@vger.kernel.org, AJvYcCVbaDgp/6M41ae/7c+/yTtkpmjcyYlaLqS08qmQjzpY1EmeRffhgC9VPo40EodDla0qo5RPuIbTzKeufJok@vger.kernel.org, AJvYcCVu7tGxB4zYAWLXNkIQ6FEOP8itaYkx7XrEQWeFsXl932QdOD5XV2L6m2onHKBTcQluYthq/02BoLwIFQ==@vger.kernel.org, AJvYcCVz7vD8iVbjn6786PRMHxRzGWDcYsSiJr+JrHVA3IWBJ97d+70CvgtsyayZ5tvfWeOpuapSuuib/H2aJqj2Se4X8Kw=@vger.kernel.org, AJvYcCWkPAZkskQF5XtcFmrNtuSghYzTSro4mHydLKOsYpZzzScoApm5787LS5ozazNyOfTw9Q5I2lbWmgWK@vger.kernel.org, AJvYcCWt9XWAR9RrmoQZmMb9wgPQPifnZrixc0Dst/mr551SpUyiiXr1Az1svIJUQTJQVXLrJtziZ6ICGlPAbO16rQ==@vger.kernel.org, AJvYcCX+LKWXhBls7H75euJbZ3jwdZEvhG0KEMHEHu6ArkkHrn7HPJx8afmYQBgN/auqc40fkpG8k27pLEIh@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFP+ijDCwzZoqOG2Ytb0dzd1ivRRpVlKVUUPRgWZ8DZuSY5Ml
	jDAsVoqOBapiNEdBzanlI7juSPQVovJEvvx9igN2/2I3NCnnX0krCfCtsA==
X-Google-Smtp-Source: AGHT+IGCrPHc6XJmItNolCKG1S2T9m458hednz3DQSJjw+4zbXzSksgr4EytAX8pJ7+f4cKbcW2T4A==
X-Received: by 2002:a05:6402:254d:b0:5be:eb19:ee56 with SMTP id 4fb4d7f45d1cf-5c413e4beb1mr4913390a12.24.1726240088850;
        Fri, 13 Sep 2024 08:08:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:08 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v4 00/27] This is continued work on Samsung S9(SM-9600)
 starqltechn
Date: Fri, 13 Sep 2024 18:07:43 +0300
Message-Id: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEBV5GYC/4WOQQ6DIBREr2JYlwbBoumq92iM+dCvkCBaQNPGe
 PdSk667fJPMvNlIxGAxkmuxkYCrjXbyGapTQbQBPyC1j8yEM14xWdY0JghPl1Ab31mfcAiQcqd
 b5pgCwkiVbmRzYYr3KEieURCRqgBemzzkF+dyOAfs7evw3tvMxsY0hfdxYxXf9Gds/htXQRlF0
 UspOStr0LdhBOvOehpJu+/7B8ia1HHlAAAA
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=6082;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=zNden+m4S4qeBBrgrI7oJVPZCF0D5TInPx+aEZ7wheQ=;
 b=UUZqRammNe7VcfWZLb30fPL0Xxh1/CVZzJysjzjyy73+yDJfntHzaz6edzfCSsVZPKwnXtfqT
 U0ypRVySOtbBmhAnJqwywXsdHXAhJEiJ+ZWn4X6xLJ47gQEVHvejpSv
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
Changes in v4:
- Rewrite max77705, max77705_charger, max77705_fuel_gauge from scratch
- Reorder patches:
  - squash max77705 subdevice bindings in core file because
    no resources there
  - split device tree changes
- Use _ as space for filenames in power/supply like the majority
- Replace gcc-845 freq_tbl frequencies patch with new approach,
  based on automatic m/n/pre_div value generation
- Link to v3: https://lore.kernel.org/r/20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com

---
Dzmitry Sankouski (27):
      power: supply: add undervoltage health status property
      clk: qcom: clk-rcg2: name refactoring
      gcc-sdm845: Add general purpose clock ops
      dt-bindings: panel: add Samsung s6e3ha8
      dt-bindings: mfd: add maxim,max77705
      dt-bindings: mfd: add samsung,s2dos05
      drm/panel: Add support for S6E3HA8 panel driver
      mfd: max77693: remove unused declarations
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      power: supply: max77705: Add fuel gauge driver for Maxim 77705
      leds: max77705: Add LEDs support
      mfd: sec-core: add s2dos05 support
      regulator: add s2dos05 regulator support
      arm64: dts: qcom: sdm845: enable gmu
      arm64: dts: qcom: starqltechn: remove wifi
      arm64: dts: qcom: starqltechn: fix usb regulator mistake
      arm64: dts: qcom: starqltechn: refactor node order
      arm64: dts: qcom: starqltechn: remove excess reserved gpios
      arm64: dts: qcom: starqltechn: add gpio keys
      arm64: dts: qcom: starqltechn: add max77705 PMIC
      arm64: dts: qcom: starqltechn: add display PMIC
      arm64: dts: qcom: starqltechn: add touchscreen support
      arm64: dts: qcom: starqltechn: add initial sound support
      arm64: dts: qcom: starqltechn: add graphics support
      arm64: dts: qcom: starqltechn: add modem support

 .../bindings/display/panel/samsung,s6e3ha8.yaml    |  75 +++
 .../devicetree/bindings/mfd/maxim,max77705.yaml    | 169 ++++++
 .../devicetree/bindings/mfd/samsung,s2dos05.yaml   |  99 ++++
 MAINTAINERS                                        |  12 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |   4 -
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   4 -
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   4 -
 .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |   4 -
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 573 +++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |   4 -
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |   4 -
 .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi   |   4 -
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   4 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 -
 drivers/clk/qcom/clk-rcg.h                         |   1 +
 drivers/clk/qcom/clk-rcg2.c                        | 243 ++++++++-
 drivers/clk/qcom/gcc-sdm845.c                      |  21 +-
 drivers/gpu/drm/panel/Kconfig                      |   7 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 350 ++++++++++++
 drivers/input/misc/Kconfig                         |   4 +-
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/max77693-haptic.c               |  15 +-
 drivers/leds/Kconfig                               |   6 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-max77705.c                       | 158 ++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/max77705.c                             | 248 +++++++++
 drivers/mfd/sec-core.c                             |  11 +
 drivers/power/supply/Kconfig                       |  13 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/max77705_charger.c            | 585 +++++++++++++++++++++
 drivers/power/supply/max77705_fuel_gauge.c         | 348 ++++++++++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/s2dos05-regulator.c              | 176 +++++++
 include/linux/mfd/max77693-common.h                |   6 +-
 include/linux/mfd/max77693-private.h               |  11 -
 include/linux/mfd/max77705-private.h               | 180 +++++++
 include/linux/mfd/max77705_charger.h               | 215 ++++++++
 include/linux/mfd/samsung/core.h                   |   1 +
 include/linux/power/max77705_fuelgauge.h           |  65 +++
 include/linux/power_supply.h                       |   1 +
 include/linux/regulator/s2dos05.h                  |  73 +++
 45 files changed, 3627 insertions(+), 101 deletions(-)
---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


