Return-Path: <linux-pwm+bounces-2185-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC088CA21A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4BE1C20DA8
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F1E138495;
	Mon, 20 May 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH258/8x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71213848B;
	Mon, 20 May 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230575; cv=none; b=sJz7dk4xb+fVQ7JGvIzeTdnnyyg0zWL0p5Pmq4N9ye2rjWn7wmwR6YDg4ffxW102gyQhgyDc5SSliUKVWwUtlkUVJfJavunT8meTnjeQQiLITRNzUcLzfy8Y2H5AHxD2tCiG0Va0Z7BBs0mwhXLrW9UNF0OI3okUc+ELrEeC4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230575; c=relaxed/simple;
	bh=RAL8/W82ql7maGP9+Gccu8VKK+bvQNcePTIKExMfiSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULXv5gOojOo5HR00adDOZ2FM9mrygqQ9htRHIggX9scBX7KyfuAtXP/Mr3eTDvDnKXgAldAY/hqgx+1iYi+EAu+46mFmUUvNOipJkWNa7eMM4CUNxDpjiDSJW1j55bzh+dyb2iBwxDMD3OTp0lpQ+kl5mOGUYjYl4MIGR+xM8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH258/8x; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f174e316eso3698959e87.0;
        Mon, 20 May 2024 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716230571; x=1716835371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d2oO4m1fNwQVp4jNZt/1i65mTC9NxrLa2XCOe6bVJYw=;
        b=FH258/8xU2piMGWfR8+Y5UG4ujMPnZbpT5tkWWdYuVpJvs86j/JChM9QAAGQmXVQYL
         ZNQ4IyDhsy7mq7sSlAoZivhcWxOdsZxeinnc35YdPwzjQhGSzh3SOSThlR+2LDwfAMmy
         NmnqY5zOKNK42QXAAGMERwhVfDbSw9Rc/RDGQ4Ty+wK/gw41WBIsOXkBsCVYKvJbXYS9
         D6DY1Y1vljIBShefrogbjvTifnDvlng6PATFb66cnKcqlPRWJbliFx2VxOy01sDaW61r
         uDDa7rYRfMKiLe141cXo+Nm6wX1g+D2ydRmOqgckx+rJuW4pbj132Hz4OkMBvcopde+3
         jlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716230571; x=1716835371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2oO4m1fNwQVp4jNZt/1i65mTC9NxrLa2XCOe6bVJYw=;
        b=oYpCYD/EFrRlx6aw4B9caD3Z8NePWwWVF261f6AtCnEKQFzP0vLttvShbnVcVuiCXk
         40MGAejmU8yGxttgALFNDYPs5Bm9qUnQsVFbSEorgFFFouXWKcRTBTqnrmyX5ms3dXxx
         YaMm7M0JCpC3irII90/IgUql45LUrENV6yAi6gLLaTETNipdcDE4u76wnFtBWmFoxbua
         JAebQBxFqTUIHbDSZv2WpMhc/IGBhH7WK7vNGw3mlIJKSqFNsaBpBwn2ukF1x8lU4PHj
         7jOaUXdh2tizzv9UIjrnNDTgTEeO4DPQppIgq6Qs5JySZNgf9v5etMLxt5hozUbACI5Q
         V/tg==
X-Forwarded-Encrypted: i=1; AJvYcCWPDx49lDurbvgBDQa4WjJTVNqsyQDRsiz0fDiOrjlpjf78URvHYB3yYxzDsgU4KobyVQ2dbPlMW60RJa11O13HVmv+1UUA1v3VU+jSdGzd775i3DjdnPepyUkzir+3InoceXfcsA==
X-Gm-Message-State: AOJu0YyGT4JAB8dp3KIDAhoR7Vynsf4R/1HZucTui+fsPOSIRLRxmn+1
	7BCFNFv6zjWlt4wu1URNkHK0pJkgRwSGRcebaPwqXJorBj3mkZjSlcao/bHGjyPo
X-Google-Smtp-Source: AGHT+IHowG1lUazF8YIjo3wKGFKSPdaQrkEopgqvVcpbn/3onng5ZcWOPaKYiEgzwOJh0DTC8Q41xw==
X-Received: by 2002:a05:6512:3494:b0:516:be80:178f with SMTP id 2adb3069b0e04-5220fe7934bmr19194028e87.43.1716230571213;
        Mon, 20 May 2024 11:42:51 -0700 (PDT)
Received: from localhost.localdomain ([188.162.49.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d335csm4368967e87.125.2024.05.20.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:42:50 -0700 (PDT)
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
	John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Mon, 20 May 2024 21:42:18 +0300
Message-Id: <20240520184227.120956-1-privatesub2@gmail.com>
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

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 387 ++++++++++++++++++
 5 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1


