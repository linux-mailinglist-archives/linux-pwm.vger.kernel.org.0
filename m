Return-Path: <linux-pwm+bounces-4944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11152A3D589
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092B8189D42D
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816111F03FE;
	Thu, 20 Feb 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JpTmt/Tk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814561F03DE
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045438; cv=none; b=Twhbz9C1Jwzcd9d/ClxtffB8yo86iyiNiQMfOcTJzZ/XejZmliPt5F7kgK9dF+03HzRjIisHQU919G1qvz+kLbIDAK09wtdxZTS/LjXHTMfwAAHDLuJbPhDIPsTeiog3k/3tGBf90aCBPU1TgUYP/TSI50/174cYqJ0W3uUDXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045438; c=relaxed/simple;
	bh=UE8VdsZW1Y3TjKMak36BMWGqNAJGLcH0M5Xyeq+yS3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MFdRUAb51k02tMWrFw+IEbb21E6QfMKx3+Md8L3+5nr7GPpqPSvhPz2UlFcgB8eH9R1fED4OKB9YJhimL4I3MyKr0Ejcj/fXwm/8CkLGimpIVwFstKHOX5gS994DmaG5oQPBjGOEHDUo2jzgVZ1NnjydQgL3L8WZ3yc016Cwlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JpTmt/Tk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f3ac22948so359182f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045435; x=1740650235; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L74PGy4xk7w384S9Jp0t2dac5Sa9GXRUUDF4600UkaA=;
        b=JpTmt/TkRzMMElNV2BBxyDe33NvBuyyizET6Z8qoI1CF7aGdcOB9VEAP8Iu+JkA9aX
         5Yfe70P13JBVSyx1FGhLDUPDXxY8jS/j5y1UTC4VkXygK9SgxHaOduazYP2nDT2VfoGf
         2Fltd2OBfacmQSaUGPaedgqvfkD8E87lJVtLjc8tVipEY+dO+Edjjuq+vxuFWaql5E/e
         zCYMjBAe/TVeoyxzz5ncAzgt13NsN2Lwk/j071DJkPbGT2ixgpIwilWstJJPJim576pb
         z+qqR/DmOVp+JEIfyZSpi+iXuAqBIl5o7NxKR1W9g2tTEF0Ea8M8hwTQawl5hPA2bL7f
         NDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045435; x=1740650235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L74PGy4xk7w384S9Jp0t2dac5Sa9GXRUUDF4600UkaA=;
        b=tIqZwbCv5OIJ+69xM5HNX7jGMLPQDI7NAEre4VtsDR/i6EfnHoRQ+vVan8VWf7HzV9
         CsNOmtljC1dbtc3myDXN86qUIJDtIZYVurAik/qKLR+4rt0iz3c0rpVbvKMPjAphxDGc
         qJhT8MoxeHG2ADnxg9O3CIbefyG1hzbiRHRHdlKZhepwuJJ+9ILCibG0phMyRNgzE+PC
         V0CjH+JMxth/S9r7C8FfYg5J4Uyx+K6jCOMV/DYpIBhXToi9WCEHpQ2d12Usg9j8JbCG
         Ml/gOfBQIJZOzALIUiyKipeYZOqoy++YZkVU5WToCORhR/JMx8JHcZeD7L+yf0eyPoQ6
         DgVw==
X-Forwarded-Encrypted: i=1; AJvYcCUdSIYD4Ktihldjhqax348wjnLoGnQzvE20Mvx9tZWCKr5exa9OJHTiITtH3jttdbifYVln+l7PgXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANkPvzVBtGjXUgG2jTYYRd8tTX4+LjUqrN0ZS2bQgIEiWPWIw
	9pFrEdWH5rUPpGwyMxTT8eZnv0/zHHybVV7Wt2fJiTfTomSjM80qc0IFKVLw9HY=
X-Gm-Gg: ASbGncuSdO0sjISh2miNZr3kq8thezlEWm+LGI5deHDQ2eUrfAdNE4kYbDhT68rPhWf
	KZU/Tmi7O/eZeXu3SrsSrYDV27XWPmQW7ouhaCtA8lxbPnaKjSrbjGdtAU1JU6UWX/U0VkoFuwY
	Iath7dMrnVI8mgbh+75ziYe+4rLl/zVDGxsnDN7TJWy8PiPzwfH3FVq/QeCpMsOORdrveldb+la
	heq/Xw3ILcW8ZomYusqnmj6Rwv5YorIWNeZJVvJgzL5S93v9OBHilDZtlP4H3/kjkVZStTi/9T+
	jacVdhM=
X-Google-Smtp-Source: AGHT+IGF3UMSgu8WgO410t/xp56WxavhumavZVWocGbzrXyqxd1Hznsmg6Teek+ydtF4Bpr6N3Nm4w==
X-Received: by 2002:adf:e888:0:b0:38d:d932:d9a0 with SMTP id ffacd0b85a97d-38f33f58dc9mr14815145f8f.50.1740045434551;
        Thu, 20 Feb 2025 01:57:14 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 00/15] gpiolib: indicate errors in value setters
Date: Thu, 20 Feb 2025 10:56:57 +0100
Message-Id: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGn8tmcC/2WNSwqDQBAFryK9Tof5RANZ5R7iYmJ3tEEc6ZEhQ
 bx7JkJWWVbBq7dBYhVOcKs2UM6SJM4F3KmCfgzzwChUGJxxtXHW4LBIxMQrKq85THixPTWPwBz
 IQ1ktyk95HcW2KzxKWqO+j4Nsv/bXsn+tbNFg7chTYz1dyd8nmYPGc9QBun3fP6D7CRCvAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4499;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=UE8VdsZW1Y3TjKMak36BMWGqNAJGLcH0M5Xyeq+yS3k=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx1VdukIhyIQsCn7gWe6nh3pXbQJio/dZdv5
 aGCieQY4jyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dQAKCRARpy6gFHHX
 cqDQD/9kbkYYIly/TLaUqw1HUqnAolfFBo5ZbNW5FabTpjACC3l5+lXF1k8G6be5QK43uRRlgGY
 SJKMzYMjVeQMKE1USOfTsvP4YOCXji8zKi4idUSm4UwSxnlvYWmR4aYSFRre/ZpxtuM+kaT68Oe
 erEooqWkHGknHp3PhfwQ16guogibxGpFm0oHVa6rgKODBUpNt1nOf+hHItlExpXdSwnwJ4Q6AcX
 xbj0sUXHxZ4i2MsTc+dL4VzETgBYrrEJJ6PjwaKOKjroGwh6IsmQREzfE0Fw1UQreSL8XLzWago
 EKjFmvXI3r00J9xIUSKL0cqmGs3PmBbbIVbOlr//8nWzmEHK4faq3y060M8qQ2y04lx3r9Et50u
 +zN/mmHtC/If/8mjNGZUnSK72kC9Urt68RMV6tFcGtwbyRQf57Is43/P8WLMCXNjvsuLAbUYOMQ
 4Nqg1VTEI/2wuSJtm8YIoJaMkSMQKcOXoMd+Q6rgCipIMgLY5ps7FK6YdkQlqBEKZZIRfPmi22F
 YDEir8MJERkxjra5FoW3POMLY0h0fkItyuXMwIZ26t1NwD1qR6/HYcEJUeOQw3YLjUMpbzDzZn6
 RNBe6O0KWc1Vh2WlS90WdQC0WUxVjs77adxaAtdvy/YAI80peI5ClV5OyWCy9wAoSYTCWDWUnCH
 g+zNrn+2VKDFPhg==
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

The first patch addresses an existing issue in one of the leds drivers
that will break after we change the GPIO consumer API. The second changes
the consumer interfaces. This has no impact on any user (even though they
don't currently check the retval) except for places where any of the
functions are passed as function pointer arguments in which case we need
to update the affected callers. I only identified one such place - the
gpio-latch module.

The third patch adds a wrapper around gpio_chip::set() to limit the
number of places where this pointer is dereferenced to one making
further work easier. Next we make the existing wrapper around
gpio_chip::set_multiple() consistent with the one for set() in terms of
the return value as well as SRCU and callback checks.

Finally in patch 5 we add new variants of the set callbacks suffixed
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
Changes in v2:
- add a leds patch that addresses an issue that would become visible
  after the consumer API change (reported by build bot after v1)
- check the return values of reg_mask_xlate() in gpio-regmap
- Link to v1: https://lore.kernel.org/r/20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org

---
Bartosz Golaszewski (15):
      leds: aw200xx: don't use return with gpiod_set_value() variants
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
 drivers/gpio/gpio-pca953x.c    |  17 +++---
 drivers/gpio/gpio-regmap.c     |  32 ++++++----
 drivers/gpio/gpio-sim.c        |  14 +++--
 drivers/gpio/gpiolib.c         | 133 +++++++++++++++++++++++++++++------------
 drivers/leds/leds-aw200xx.c    |   2 +-
 include/linux/gpio.h           |   4 +-
 include/linux/gpio/consumer.h  |  22 ++++---
 include/linux/gpio/driver.h    |  10 ++++
 14 files changed, 235 insertions(+), 132 deletions(-)
---
base-commit: 50a0c754714aa3ea0b0e62f3765eb666a1579f24
change-id: 20250210-gpio-set-retval-41cd6baeead3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


