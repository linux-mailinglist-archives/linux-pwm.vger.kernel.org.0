Return-Path: <linux-pwm+bounces-4842-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A9A30B2F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD8C1885B42
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420F1FCF7C;
	Tue, 11 Feb 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="d17uONSO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8E1FBCBC
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275805; cv=none; b=QJI2v17zOha+SQ7PzlG1mE5g1o/63pj0hSgmsEpgB1RnhAalTcyHUlhJ93Lsz0S+rBdt4gsiqP1Fais9Qt9QtKjE6kA9NznHT1VDmrANWR2NZw9sdSwPXcJ14bGfGsrGA+aigrxBqpy88SO27K+XCfpT24yNRKxIB1X4Rvu6h3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275805; c=relaxed/simple;
	bh=HDD9E/2Z87ewoejgSekJJ1livq4qNsHbL/q6x30af44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OWxHxGLFE9uYXRpnxktQ/6zLSpRdsCQEhHDgkLwLxvRhYwvUhYCirnp3CtdAR2DFXZoYm5YvWOEa16J4OMoq0AlWxjzlblLuZhMLv/j2a4/Kn+J1DkUI+0SCARPZngBxfSS+gLZ8SS3SBdduWZFWeytW/9W+jhUZ2o24a5U1vHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=d17uONSO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43937cf2131so18672825e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275802; x=1739880602; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAqcqEbh0cNIQveZUQcmgbC3entXqdkXwlu0giuBLKI=;
        b=d17uONSOco7idci8dTNxSDjivBcBSmQouKJc4/yC8nrgfIqcZ229yGMhvDmu8GheaC
         Z+PbKIYJKDDucIpxfQ22u9JI1oadPIi2jnFuj2utdEhhTvFK+pGcjZFhut7OGK82SUQn
         qrEAGWTnD7Atuu/t02uRKijud6Go0ORl6pvPwRvNXwJ7gACiCs0tqhz3AYlxbkiB1PoV
         0G+IpZV9SQG3LERO4/ZJcAN+xcoNEeD1gFA0m7dnMERjfaeZjTd9tFdIicqLpXGsAxs2
         Rk+mCyk5M48yx7dLK7lN07SMvohEV749dgJpfRYi8uCf+n8adwn3Ng9KRkKbzj/5kUbM
         hi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275802; x=1739880602;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAqcqEbh0cNIQveZUQcmgbC3entXqdkXwlu0giuBLKI=;
        b=o5RNuNTzoN1qniiPOdxo0+jyNBmQm2HlzQ69vN+Xvcu4SDlGBW8tjMdAzaRUsxpeF1
         G3gdiZjd/DGG6BGtu0AxKkO1rcUUI3PcxkZguE4RaoMiC9LvJqdBzD6U0GlASrcsDzOy
         i3t6T6OJy6+V3YS9tbCzp3uN8IT/UNqvqhY84N/BSUJPCHw00ILAKWemjJ8yWGaLCXMT
         Fm63EjZyuSJ9XibXZ1FZnRHG6YG0q6D5Cq9zrLoEAOuaJA5zPZu5lPA6ajn43v+j8XEH
         G3QTAipeS80HN5DWB//KoesQ9YjTb14hDHZ1/nbvs52E6pkDjHVNiTnfpFx9sMaekdp2
         5XiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaxRBtxBVn3Qp0OKJ3K8ZrLAzyw5JTEcBYGtgctWio0sf8BBeJGGECNnEzZ1TTJ7mAd8iizqWACFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywt3MT7OxH7EQLImY33/SkCPJac259kcPDwHzkBGoiqvqlGh4n
	f0/r8s9AGv19VGe/lcouU5rHo9G0zzU7C83v1rzJBan+vUJ9q5js4lyL3BEON/s=
X-Gm-Gg: ASbGncsvDJADUL4B8BidBl57EaoxG9GjQjMs0U7ZOc/3XxVxpcwcNwkjOqFSXIzeMBI
	jl+GEQ4pvpirBXKQ5g+cg0GOtpJ5WmU4QxMzLL2p17t+n1gFFdgGCcsIIpyy3ZG5gxrXcWFuOIE
	ib/deD2owAL+UOhWPSRhWfzdgGF7DQJdsZq9KmhCcqOhfy56DvmP5q/Fhlq9VZzu7k+5390HmFP
	bk2rqDlsysg0LYLsh6ZX+4gyvRqeCi+/mPTBlL3tqTpn1gQCnuHx6ue0OUBqiBya9U1STkoyaMO
	ssmGZ3E=
X-Google-Smtp-Source: AGHT+IFr1fIqfJ/GTLzTv/98M169OWNM99NRo9NjaVqqDynXDYCXU4EDhZH48zI6AcYNLXXLQY0L3A==
X-Received: by 2002:a05:6000:1862:b0:38d:de34:32ed with SMTP id ffacd0b85a97d-38de41be586mr2893246f8f.34.1739275801522;
        Tue, 11 Feb 2025 04:10:01 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/14] gpiolib: indicate errors in value setters
Date: Tue, 11 Feb 2025 13:09:34 +0100
Message-Id: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP49q2cC/x3MSwqAIBRG4a3EHXdB7TFoK9HA8q8uhIVGBOLek
 4bf4JxEEUEQaagSBTwS5fQFuq5o2a3fwOKKySjTKaMVb5ecHHFzwP3Yg1u9uH62gHUNleoKWOX
 9j+OU8wecBY+zYQAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4001;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=HDD9E/2Z87ewoejgSekJJ1livq4qNsHbL/q6x30af44=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4Vt0uh383nG8GM61FhcaSfRE9/2BmD3JA4I
 qYG8oGudm6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FQAKCRARpy6gFHHX
 cizbD/93pVqlu7rLyvmnQFydJXeRf+8azo7YH/5g5F+X0yPLodvrYss7ZbpbjUz3WSw6A7ag+Pg
 fennXxQ3NMrwIwJ8co4BxKM86T6M95YcOrfdw3bd2/Srrw0c/Hleg3qquo2JkHs+S9EvpfRs8Di
 F7h0WfsKZ8GqgCimPcOD3Gxea9RhOMVpvUDE22tyqveFyos2Cao7z94Zw3rqyJylLsu0AypSXtc
 w3HbwmTtimDyNmC/wuxBAJChDwqRM+k0q+5ZCwy9WUcIXCRDdr663tXLpuYw20uInDD2BWxd+JM
 TK5AdA68miwaUPh1LcPrPrwK8XSUVJEsGY/vZSib4TiqKZX+cp+m3JSE7nllSVwPKQIhfsaeZUm
 +QSWpwnhqyQXIERVP/geCDYOblrxBgsFW+t8nR0cNh6gYhsUkJrNlK2hfbeycnowtWNl0m4Uhkk
 p/HYdHZY+u1EgKr1JaPnap+CmTs5ST9BB+rXMMb/J0vC9Vyz2UKupdQCwIvW+CVH7IhHjBQ0zUS
 A9bevsNfA3Ew4lt19WpL9RXrXt4xquGDlr7nLmdMIiOTcA8dYc0fZ9UyRbkqggSKJBO5aTx3Xi1
 l0dhBQm5OjnFzLx3bpc1ZvkudkW3p5w0TOy9VuulYEeUNkrqeeG2RelXN0H7H1QJFfDkFicwUWD
 e4KGP+0wo/1DtBQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The value setter callbacks (both for single and multiple lines) return
void even though we have many types of controllers that can fail to set
a line's value: i2c, SPI, USB, etc.

For the consumer API: single line setters return void. Multiple line
setters do have an integer return value but due to the above, they still
cannot be used to indicate problems within the driver.

This series proposes to start the process of converting the setters to
returning int thus making it possible to propagate any errors to the
user.

The first patch changes the consumer interfaces. This has no impact on
any user (even though they don't currently check the retval) except for
places where any of the functions are passed as function pointer
arguments in which case we need to update the affected callers. I only
identified one such place - the gpio-latch module. I guess we may find
more when the series gets into next.

The second patch adds a wrapper around gpio_chip::set() to limit the
number of places where this pointer is dereferenced to one making
further work easier. Next we make the existing wrapper around
gpio_chip::set_multiple() consistent with the one for set() in terms of
the return value as well as SRCU and callback checks.

Finally in patch 4 we add new variants of the set callbacks suffixed
with "_rv" indicating that they return a value. We privilege them in the
code only falling back to the old ones if the new ones aren't present.

Patches that follow convert several drivers to using the new callbacks
to start the process.

My long term plan for this rework is the following:
1. Get this intitial series into the GPIO tree and next. Make sure it
   doesn't cause problems.
2. Start to convert drivers under drivers/gpio/ until the end of this
   cycle.
3. After v6.15-rc1 is tagged and the new callbacks are available
   upstream, start converting drivers outside of drivers/gpio/. For most
   part, this concerns drivers/pinctrl/ but we also have GPIO drivers
   scattered in media, sound, iio and old board files.
4. Once all GPIO chips are converted to using the new setters, remove
   the old callbacks and rename the new ones to the old name in one
   swift move across the tree (similarly to how the remove_new() was
   changed back to remove().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (14):
      gpiolib: make value setters have return values
      gpiolib: wrap gpio_chip::set()
      gpiolib: rework the wrapper around gpio_chip::set_multiple()
      gpiolib: introduce gpio_chip setters that return values
      gpio: sim: use value returning setters
      gpio: regmap: use value returning setters
      gpio: pca953x: use value returning setters
      gpio: mockup: use value returning setters
      gpio: aggregator: use value returning setters
      gpio: max77650: use value returning setters
      gpio: latch: use lock guards
      gpio: latch: use value returning setters
      gpio: davinci: use value returning setters
      gpio: mvebu: use value returning setters

 drivers/gpio/gpio-aggregator.c |  38 +++++++-----
 drivers/gpio/gpio-davinci.c    |   6 +-
 drivers/gpio/gpio-latch.c      |  53 ++++++++--------
 drivers/gpio/gpio-max77650.c   |  14 ++---
 drivers/gpio/gpio-mockup.c     |  14 +++--
 drivers/gpio/gpio-mvebu.c      |   8 +--
 drivers/gpio/gpio-pca953x.c    |  17 ++---
 drivers/gpio/gpio-regmap.c     |  21 ++++---
 drivers/gpio/gpio-sim.c        |  14 +++--
 drivers/gpio/gpiolib.c         | 137 +++++++++++++++++++++++++++++------------
 include/linux/gpio.h           |   4 +-
 include/linux/gpio/consumer.h  |  22 ++++---
 include/linux/gpio/driver.h    |  10 +++
 13 files changed, 228 insertions(+), 130 deletions(-)
---
base-commit: df5d6180169ae06a2eac57e33b077ad6f6252440
change-id: 20250210-gpio-set-retval-41cd6baeead3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


