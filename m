Return-Path: <linux-pwm+bounces-3597-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2899A150
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379A21C20DB7
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6273F212636;
	Fri, 11 Oct 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAYGo1lV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC152210C2C;
	Fri, 11 Oct 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642517; cv=none; b=m4QTjr7ezGFEA/dWUoinH4KmjEy6VNzQEHYf8rMaSwd9bgHn18vb3UavDDg9aaeWB2psH6tdd+KL6qjPr3ymkDIbfNH/GZH8kQXMgRHgjqjXOuZtAnbWb6xQK1TxgEUYKat0o1bdWMA+EtdB4msSc1K4YB0tFBzjJP+zhMTcdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642517; c=relaxed/simple;
	bh=W41jAi4j+/qIb+rCeD0NIp6ajJ8cer8Du5AZb5Vv+P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ri9p8eXvu4LtGfR51C/QiK53RNdhsp46Yab5vtDqZqDq6SMffwPQZDIgKP2Z+R6LVFHcXmco7PCpQKN/rE/C8loWO1ndjRSsSKNrQUBg+IEb1Kxg4YuuajnueN8RsQqUW+SAq2V+PiUjdUYFSgQNhiCw/N8ZhwfJGCss/WvNBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAYGo1lV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539983beb19so2235791e87.3;
        Fri, 11 Oct 2024 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728642513; x=1729247313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyNP1UPTt08MhflMIcOH9cW9Wb20NwuSNmK2SuTswyY=;
        b=BAYGo1lVg0zyGKHhKosfwVt5SMVGjRpMq7y4g72IcFLdyJfCXZDLQQPmuT8HlCSC8l
         N4uDCZg5KabKjXnxBx4mfDLkcY5XfyvwxhFN67oHcinDr2d7TRfOHNAS1NXSIu2vi27J
         Htq3pKONv0qWc++Mq/oy6VE3Hkdc5heWxuWuu5qkC+GE2o7VZYEcZGp0U4RopMvEnIta
         8VJnIXcmAntBRke8RrLhNYJKmlI+R60q7oJT4Vq84ud4smb08OZmFuIb4LIRw5dp6aB/
         2txorzJezD++YkjinE6gaX0LuZOyA2ZVFc8whg+HhXx5E9JnOIknnB1k2JsxLo8tmMU9
         LE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642513; x=1729247313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyNP1UPTt08MhflMIcOH9cW9Wb20NwuSNmK2SuTswyY=;
        b=ZyDIrZ4s9CFFb7qjozsv51glMyPNc/pkfD/zEg4rYL54RlYoAiwQueDVuYy11XExpf
         LmJkXb6l3D+eMy4HYpG3c/BNxZRHMQ+qSHeLOnjw6AdX8IjxYc4j74UcUO2h0+KHcVFx
         GpmLePMkRFb9999TA9OZw3A6eDAB1lCaCArqYokRv7GWM8ctbNcnWjffyM7x6Qz+eXQ4
         YVZs0Ei98xHRkkWpxUzznw5BnLT5xaiEohXEIh0uhbvVaA6eVTbSHMwB1nkGhRtQiJVz
         FJB6eL3f6cGM3n9I2k6kkNqf8VAWdxgCfAvQ1YEzlZksidfqieNCvJIiU5zOIuppeLEf
         duTg==
X-Forwarded-Encrypted: i=1; AJvYcCUrIiRzBpHEGtSZa2VWVmfMjfSQ/hpC7EtokixJw4bMxDPjVYeIJTGBdY/BkI9kUs1KZiPKukL0mPVe@vger.kernel.org, AJvYcCXz6iQM3aGX4dUMEt+E2NvN89e199FxaHXQosL4cNgVB647UwocouDQu4OHaHETUj2NThkVvN618gxs@vger.kernel.org
X-Gm-Message-State: AOJu0YyebX1WB1qfBVUm+rMkJ81JTwyVoHoCF78qFpiYyhCOxzAQifoR
	smFsN4FbP/8IiZt5soco2/pIiWLaV1/KNH6DXxcix16Xxnj9Z5rhywfFnD3DWAMw
X-Google-Smtp-Source: AGHT+IEj7jxxNUdcfFsGQxfN+JScaynbmfxoEPbLymkkExP6c7pgjdIctqnlqyXUbcu8dqFC0K1sLA==
X-Received: by 2002:a05:6512:2204:b0:539:d428:fbdc with SMTP id 2adb3069b0e04-539da599f64mr944067e87.55.1728642513016;
        Fri, 11 Oct 2024 03:28:33 -0700 (PDT)
Received: from localhost.localdomain ([188.162.200.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f1003sm552534e87.233.2024.10.11.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:28:32 -0700 (PDT)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Fri, 11 Oct 2024 13:27:31 +0300
Message-Id: <20241011102751.153248-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

v7:
 - fix a remark in the driver
 - add maintainer

v8:
 - fix compile driver for 6.8-rc

v9:
 - fix a remark in the driver
 - fix dt-bindings
 - rename apb0 -> apb

v10:
 - fix a remark in the driver
 - fix compile driver for 6.12-rc2

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 379 ++++++++++++++++++
 5 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1


