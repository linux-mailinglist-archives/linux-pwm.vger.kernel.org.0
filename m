Return-Path: <linux-pwm+bounces-2922-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A760F93F84F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528B61F22BFF
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1A15B11D;
	Mon, 29 Jul 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tk2HF6sn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E415B113
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263709; cv=none; b=ZgKlsqc98K0PdIZlyiLmLoNERrOi6MHWLBZUkdy1qrpyOgVT4KCWGt9+JK6NgC/EbDKXgP1cTcNDK30ErDnG/Js4ryR1I0hZk2NTFlNPypZfojd62Am7XLBIKPUN1nW0eG6P+ytDhDRLJUmO+j45VmAPQhw7vG5TaSwp0tn+/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263709; c=relaxed/simple;
	bh=5lbmiKqvBboL1pVsuj1bTn4xbLJ3cUxP0YgCBw+dVpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uiVpuNP45u+mvzta81UqaESGzp9kRdyHtORIWrlWmrCKKCpR0TJIkKZPyMo9YAMj4hMyq3RpnDoFoGSIyOF0UDJ5LITolrHmWENI2TI0z3LWAnobABEWKhotTFLSqOFe8jjMeO8COimoHbAgnjNF8bt4EgnlEDk0gbvMIVFK5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tk2HF6sn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so17519565e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263705; x=1722868505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf2db82vhdizcqTMN+1MBUArjDRrCG8c+iUPxc5CsU4=;
        b=Tk2HF6snxJ2vymmzm8xZ+wlJDNDZRmPkTRaeheqYe+wh5pZeinaA/2vaSAebqMWO3a
         8hsJ+9shnuJhhAGkUxgPc8chXH+YRAVPYoeMoWz21Bm+0MNgQNtUhU9pFFF+U1cIwBFK
         PLAa2L47WAGvUhTaDI2puwFtOTzQ506cWQS69UPkOt+Gz4ewpzPI0YRhtRADxEoOIpDv
         WuyzbJ4TR5JCMdOMaf4diWvUV0iT6YFJJJBFpr8fLgMAw4/CBePNDJx77diYSiHubGMs
         tDjc7d33alSJ/u7vBQKQa5H0C/9FzMeyCfObV3v9o2fS3r9nVJO6Bx3A33mcL2K3S8uD
         k88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263705; x=1722868505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pf2db82vhdizcqTMN+1MBUArjDRrCG8c+iUPxc5CsU4=;
        b=TAlmZPyUZAzCq0jUt/+u+O4flT1cJGpbryKV0Zo7alb/VLqqrj7JIwkCxoVWtbgQF8
         kKb3Sr4B33+cIPsjOgPAqfCD2Ns9o/T4nTEUUMcLbiRLKtnWvPLL2Q1t0KYp/H4GMgje
         QWzCApK3/gtBhm1DptIckvd4DeBCLKlpD2fl8GPpY+dlVP2TD99WbGyCfTvRP+i6WP03
         /Atw3dZAyNmKsioV/RG11SPBQJw7WH0nSrrUiZPi4RkhFv/fgSu5Cbo5gUfSaOxpglbL
         g9MVc+2qePHFf2GQ68d/0AoDKnvV0RUGBpqt+eZmRaMzg/PqOGit6y17Mn16kGUujM+l
         bfRA==
X-Gm-Message-State: AOJu0YwivkDQcwP636wGRfRerZF+nJQldY24FJ33FOTsy/JYOXxtKmn0
	gs1bIPhE8+PeFxcHE8F9Vx08gGJBHU1yMe9H31bESQeLQyfh8vqOOJ2lZ4G7sH4pza2GtpCrLik
	6
X-Google-Smtp-Source: AGHT+IGt6eS97Xgca8KV0NOgFfHn5nHcp4nZrPormB0sSwBcBc31n8q1yejiOGdqCUHmIOkFibwqOw==
X-Received: by 2002:a05:600c:4511:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-42811e12d41mr57503285e9.24.1722263704828;
        Mon, 29 Jul 2024 07:35:04 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280a867e7esm135348575e9.27.2024.07.29.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 0/8] pwm: New abstraction and userspace API
Date: Mon, 29 Jul 2024 16:34:16 +0200
Message-ID: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3152; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=5lbmiKqvBboL1pVsuj1bTn4xbLJ3cUxP0YgCBw+dVpI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6hqpBrMchkTq7UblpQiiB/gXoWgj5QCpOMh5 UeL+gmP5SWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeoagAKCRCPgPtYfRL+ TlqNB/9IGnXLN9EXn6TBjOIgvmlIXGnB8Qjq58LozRpFWTT6bUlCZDNhYGIClk+Gc1Pz+lGVx7+ 4bVNReS62OkAxag/y/JjyVittMs1CR++VAuDxsMtxT7nCUVGYoXGS3AClsDjJQUgYHMv4HNaCHH NvpiitBaP2ro3UIlBLtsUrDVYSzsrK5VBtb+EKUAGC4i1BZvUV6DfJhiKLiX4THlPnxcjMlxrE/ 8AI1yyGUL+dEFeAKwhF+ezl5z5gunHggAc1DUrIO6Nw+R+8zhX/I4ZM8Lnnevce03fLD2Zdu7eB zCBFbI6JTMZCR1kU4Oz9fqKJBo2ugwZfCYLmi49CCy/9iEKu
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v3 of the series to add support for duty offset in PWM
waveforms. For a single PWM output there is no gain, but if you have a
chip with two (or more) outputs and both operate with the same period,
you can generate an output like:


               ______         ______         ______         ______
   PWM #0  ___/      \_______/      \_______/      \_______/      \_______
                 __             __             __             __    
   PWM #1  _____/  \___________/  \___________/  \___________/  \_________
              ^              ^              ^              ^

Changes since v2, which is available from
https://lore.kernel.org/linux-pwm/cover.1721040875.git.u.kleine-koenig@baylibre.com
include:

 - Degrade a dev_alert() to dev_warn() on feedback by David Lechner

 - Improvement of various comments (partly in reply to David Lechner)

 - Add _ns suffixes for members of pwm_waveform, thanks David for that suggestion.

 - Rebased to v6.11-rc1 + pwm/for-next.

Because of these changes I didn't add Trevor's Reviewed-by tag for patch
#3.

I kept the BUG_ONs. There are a few check_patch warnings about it, but I still
prefer these given that it is safe they don't trigger without further (bogus)
code changes and when they trigger crashing early is better than stack
corruption. Also checkpatch tells
        WARNING: Comparisons should place the constant on the right side of the test
        #158: FILE: drivers/pwm/core.c:262:
        +       BUG_ON(WFHWSIZE < ops->sizeof_wfhw);

But as the BUG_ON is about WFHWSIZE being wrong, this order is OK.

There are a few more checkpatch warnings about line lengths. Breaking
the criticised lines further hurts readability IMHO, so I kept them. It
gets a bit better once stm32_pwm_mul_u64_u64_div_u64_roundup() is
implemented (without the stm32_pwm prefix) alongside
mul_u64_u64_div_u64() in lib/math/div64.c, but I don't want to wait for
that. I will address that once Nicolas's patch improving precision of
mul_u64_u64_div_u64() landed. (Hmm, it's not in next any more since
next-20240724, before it was 3cc8bf1a81efde105d8e57398cf8554b57768777 +
dbbe95af0fad2a9d22a4b910cfc4b87949d61a3c).

Best regards
Uwe

Uwe Kleine-König (8):
  pwm: Simplify pwm_capture()
  pwm: Add more locking
  pwm: New abstraction for PWM waveforms
  pwm: Provide new consumer API functions for waveforms
  pwm: Add support for pwmchip devices for faster and easier userspace
    access
  pwm: Add tracing for waveform callbacks
  pwm: axi-pwmgen: Implementation of the waveform callbacks
  pwm: stm32: Implementation of the waveform callbacks

 drivers/pwm/core.c           | 809 +++++++++++++++++++++++++++++++++--
 drivers/pwm/pwm-axi-pwmgen.c | 154 +++++--
 drivers/pwm/pwm-stm32.c      | 607 ++++++++++++++++----------
 include/linux/pwm.h          |  58 ++-
 include/trace/events/pwm.h   | 134 +++++-
 include/uapi/linux/pwm.h     |  25 ++
 6 files changed, 1479 insertions(+), 308 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

base-commit: b9b6bd3dcceed371829a022caeb6b51cb9f67be9
-- 
2.43.0


