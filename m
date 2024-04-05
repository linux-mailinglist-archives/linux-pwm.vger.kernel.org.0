Return-Path: <linux-pwm+bounces-1862-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D589929D
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95711286820
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47006610C;
	Fri,  5 Apr 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kxpa2wFs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615E800
	for <linux-pwm@vger.kernel.org>; Fri,  5 Apr 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277033; cv=none; b=cpJUZoXQ6L2rrlc6eH4BLElCi3Nx2MWzkKZcrehZnlQ/LKq737adevqV5ed9c1brj1vjdcvdABhhMfovJHgB1CVL1ihqH0njxWqg73vWXkk1gRQbIHW4wMZPpF/ZHe2TtQQJTnXRLKFgMX1STrjqwY1WsqgpP3U9ljc531wfsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277033; c=relaxed/simple;
	bh=jm2S4gXt5t03+EYoZp2cT5abCQ0PDuVgQv0IOQbbDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aczcfBiUx0Dzqbkx+a4YGlsNyU2G7GzZ01V7YxeiKuRlgtUZkPE3k/F2e3Xno1wc57B5Thgf5AAXzYqkObYG/irbEhcBmlpWdhzpXegrJ1fMten/XAd6+Ns1haMSC5wa30Syp/2Yr1dZwf3IOQuFHZrHZ/21YLSCf1XlzyaCbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kxpa2wFs; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d423ab87dso69320885a.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Apr 2024 17:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712277028; x=1712881828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGt59heqX0LzwtX6QO6FxTaNLRifoHIlymDGYTHl+14=;
        b=Kxpa2wFsJnUkxI3KZ8h/XKqngVhIal5uRK9tSJLCEPTyeI9qt3IkP+ZDx0nDTW5FhO
         CjigdYkjD57jI1PFamOQrum/vTwDYmqR/tGjTQphkexU3yw/lvlOs5tKu1CSpLndVkCi
         dCeUCIPqP99ATCESnyA1kq9VOzQ8sKMVhLbP0VWwo9OsiKG7l9rEMgq1HEYUZVuJZqks
         Liud8dz8tzYuj0tSGzDJmjmgXuEu7By/DUDdAVo5bhxz2ox6QwHOZH/pLaQWSxJc2AMb
         Pa9Lkcsb73kImFS/zru+zzkvg9P9eFJEBX1zsqWoEiXzC9De7A4iSy1dl7NstxXJM7Wa
         o2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712277028; x=1712881828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGt59heqX0LzwtX6QO6FxTaNLRifoHIlymDGYTHl+14=;
        b=C0nxFo3O+bprSvAt9xqdNKeInG+Lbo/PXOeMYTut0KsZaNfFlDQzq3avkkzM8zkZFj
         B/sz6tAjS4GBbcpyHfqWQBrFjDoalwKYIW8djEf9Rhk9wnY3VIyDVcDSmdgs1em0AemZ
         FS4Nq953bf3RSgd0vQ4E//wqOuu2xY30zdZIhiofx1U4fyZ8IxE9b18zViyfbO3q0ES4
         NUvOOcGKucKYQeVspyjmBHmxQLv/1I9Gc2y2GnubdchUYvBHtTOgkMrXAFygDWT/vxUo
         2/QF98Labe1piL8KyN76I0r0jVhZwimRHT7WfjRIKxg/bw8NzPz4cWhR3BLx5YVXuXRk
         GQUQ==
X-Gm-Message-State: AOJu0Yx+QG7Ns4wwgcojPrSSpMg/w9oYbZZJQlQ7HcmO7+7QJ3GPYK9Z
	TXdeGkMBWxeRQbADkal7ttj1TAl4LblOb+6MT5KcWpfhDYhnlRWwwGU2oU8O5+TecHYPqckOzK8
	Fqh4=
X-Google-Smtp-Source: AGHT+IHx4gIxWhwWoSzOIck3XCQ8tqWEopZ/vzlXy0x9e6etkvAlfJ6lZ2KoG7b6kvOlbBlREJZgFg==
X-Received: by 2002:a05:622a:296:b0:431:51d:42b1 with SMTP id z22-20020a05622a029600b00431051d42b1mr1253239qtw.42.1712277027867;
        Thu, 04 Apr 2024 17:30:27 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o4-20020ac86d04000000b00432feda5986sm232728qtt.35.2024.04.04.17.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:30:27 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [RFC PATCH 0/3] pwm: add support for duty_offset
Date: Thu,  4 Apr 2024 20:30:22 -0400
Message-ID: <20240405003025.739603-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the PWM subsystem to support the duty_offset feature
found on some PWM devices. It includes a patch to enable this feature
for the axi-pwmgen driver, which can also serve as an example of how to
implement it for other devices. It also contains a patch adding a new
pwm_config_full() function mirroring the behavior of pwm_config() but
with duty_offset included, to help maintain compatibility for drivers
that don't support the feature.

The series was tested on actual hardware using a Zedboard. An
oscilloscope was used to validate that the generated PWM signals matched
the requested ones. The libpwm [1] tool was also used for testing the
char device functionality.

The series is marked RFC as there are some outstanding questions about
implementation:

1. In drivers/pwm/core.c, __pwm_apply() was modified to check that the
sum of state->duty_offset + state->duty_cycle does not exceed
state->period, but in the character device section these values are
being checked separately. Is this intentional? What is the intended
behavior?

2. Should __pwm_apply() explicitly disallow PWM_POLARITY_INVERSED and
duty_offset together?

3. Are there other places that would need duty_offset handling which
have been missed?

Note that in addition to the other patches in this series, the changes
to the axi-pwmgen driver rely on [2] and [3], which haven't been picked
up yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/
[2] https://lore.kernel.org/linux-pwm/20240301173343.1086332-1-tgamblin@baylibre.com/
[3] https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/

Trevor Gamblin (3):
  pwm: add duty offset support
  pwm: axi-pwmgen: add duty offset support
  pwm: add pwm_config_full to pwm.h

 drivers/pwm/core.c           | 75 +++++++++++++++++++++++++++++++++---
 drivers/pwm/pwm-axi-pwmgen.c | 35 +++++++++++++----
 include/linux/pwm.h          | 52 ++++++++++++++++++++++---
 include/trace/events/pwm.h   |  6 ++-
 4 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.44.0


