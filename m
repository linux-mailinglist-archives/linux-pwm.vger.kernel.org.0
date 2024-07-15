Return-Path: <linux-pwm+bounces-2799-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCFE9312E2
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84FA28224D
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B31891B3;
	Mon, 15 Jul 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DayN6fDz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1D18787F
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042205; cv=none; b=VfiXjU+qg2BzRNWoo/2Q6IfMeH1TwAd0+fzd75Lr9GyhzShEr/taBtx1EIuejERjRMuAvQxk5//6yHcG3uYc51DDUlTQZp0vr+GrUy7rgMbOVK2ae0wsRhJiHqUOBkdQUwenW7E4+Tinmtjg8pA5TOwiKWO7qs0/WDQummbGFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042205; c=relaxed/simple;
	bh=eh9hN9t462SVKX6v6uwNmbb01W8DO75Hm7OOrqCLPWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOt5YCiwUA7C2ryQ55gZTj95yRoICxqP8EHTOsigUbgTyEP7FDghFD3XeyJRo3lOxBs2tRlZAC5jR1SBhrILerH57adiAa7gTHXYRlnlhp2G+VQK7UmeoDk10QufIxlSUN8FuT8Gkkbt+IJd8IhH0W3rRQRO5q0ND7ch7VeiEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DayN6fDz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso30203175e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042200; x=1721647000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDEe+GgmEIyvl8fJ1s7eesBAT988ruji28MPbEudHF4=;
        b=DayN6fDzaAPOIw00o57Q/vYnnQLWZLSEXzGDgdITQk6maUdn+poWqwgycAtBGKy4+u
         ZhJZ/W0+FU6gjc8gILf8B8ITRSpFpnJbmKXEmm/vYJY5LzzQXlCIDzvHHljF/u2uZfDs
         JYGuBLQrljBaOoUn6irLsI5cWJUa9cHAtAW6s8yIxWDvIGOWxsKwqdbyTlYZPfOG8zyo
         SR5TsraJoRg/sBJYHs4jqH+6FpYczUQiwu0LkEtOBDiVxWszQxX0B4J6nylmSEkIDcPu
         6OX5Y2LRQ2pHVZ+7NFHyze34lshtQ1hNy75xoMgoXF5TTt/2PYgRF8n3uj8ib9A8L7ln
         2KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042200; x=1721647000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDEe+GgmEIyvl8fJ1s7eesBAT988ruji28MPbEudHF4=;
        b=lX5FXLSiRQkQqi0UN8fLCBfVnI2B8/79aYDbETUQaJauGmw8kpE6q3RlkkkzewjhIm
         k18eKopV36IS+yzvAPC3lzspF4yr+jclU3eLLL/fvj6vxXr4pYlF1nbsK+1ywakOzk8e
         h7h7axc0I4xwKa4QwIo5fj6dxSQ497e0RMj5+IMyspDNV5gmy6oJk348KPzjvk6w1X6E
         EXXqj/7r9aKSE0od1TXepC0SLLVq5EkEDZXeTG90Uj3Yx2O8w8FeKXyRvImqDwBZbiek
         rqE7v3tbdof8IGMLsbZ4Z7LvVEyJfSxQjxYGet5A0G47xywD3ADgkccRrcT3LylQTMeB
         fDxg==
X-Gm-Message-State: AOJu0YxiRoN7EBGf3j1ZK96WdHa+xP2AsP/xiGmqLOJWg/9hFyqz/gc3
	QRdgyMZ72BCU59ITeQZ98t9ok5qYRKrCClBGba0InJN9ttkQik2XDM8D6w26uhHC2zZqobdzTi1
	q
X-Google-Smtp-Source: AGHT+IFNc51WNJxBoh0wGkj0v/mcoaVhCF7UkAjpUvg/Hxwws9StpBp/dMU8F779yfEHk8bjXKSdmQ==
X-Received: by 2002:a5d:548b:0:b0:362:c7b3:764c with SMTP id ffacd0b85a97d-367ceac47bfmr11611245f8f.48.1721042200179;
        Mon, 15 Jul 2024 04:16:40 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccb7bsm6079548f8f.55.2024.07.15.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 0/8]	pwm: New abstraction and userspace API 
Date: Mon, 15 Jul 2024 13:16:05 +0200
Message-ID: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=eh9hN9t462SVKX6v6uwNmbb01W8DO75Hm7OOrqCLPWA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmlQT2KnNa33bSepixkxzQfYOaLfzTcL1hclhk4 tiFZtT9zG+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpUE9gAKCRCPgPtYfRL+ TrlhCACuoE5BUQ6msGNlIrLAy3JIPxpihEJDH9jxrjCX3PQqKmk6oHXQuTrMngb/kV+/XWM4LcE Mt0KKCPY5ZUxHnjCd4t8FS/AVb30w1AHzRM+pie092QAvui3hjWLzU0uIfvmbCcx/vftrYGjonF IXHT83F7QPhiuInX0oZG3NQLqzo9gC4Ul80i0xPisz9Vwm9eyVCjPIijFGh4nsZ2k/ddlKpuSsv MjA1+YuszR0frz2lpx375I6KvuuvkbfjLr5SSG2IHz5mDh/FjawuT1IP7ugAHvYWN61m+25sVUL GK77ySrm3RioKQooRKPjb5vdHqZkpR62DP6ezPda4LXnNWCh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v2 of the series, (implicit) v1 can be found at
https://lore.kernel.org/linux-pwm/cover.1720435656.git.u.kleine-koenig@baylibre.com/.

It implements a new abstraction to model the output waveform of
a PWM. The main improvement is that it defines a duty_offset instead of
a polarity and so allows to model more wave forms. The motivation for
this is that we need a PWM channel to have an offset compared to another
channel from the same chip, that is something like that:

         __                 __                 __
        /  \_______________/  \_______________/  \_________
        ^    __            ^    __            ^    __
        ____/  \_______________/  \_______________/  \_____
        ^                  ^                  ^

Compared to the previous submission the following things changed:

 - rebase to current pwm/for-next

 - Some more simplifications and cleanups upfront

 - new commit to provide API functions for consumers
   These were added as needed in the respective commits (and not exported)
   before, but it should be easier to review this way.

 - Add padding to the userspace struct pwmchip_waveform

 - shifted the introduction of some helper functions to earlier commits to have
   less code that is introduced in one patch and then refactored in a later one.

 - stricter input validation

 - implement PWM_IOCTL_ROUNDWF ioctl

 - Commit #6 got a change log and sign-off (was #4 before) 🙄

I updated the pwm/chardev branch to hold this series.

I dropped Trevor's R-b tag for patch #5 (patch #3 before) because the
patch was modified in non-trivial ways. I hesitated to keep his T-b for
patch #7 (patch #5 before), because while the axi-pwmgen patch didn't
change, it builds on top of the previous patches. I kept it anyhow.

Thanks to Trevor and Nuno for feedback to the previous submission.

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
 drivers/pwm/pwm-axi-pwmgen.c | 148 +++++--
 drivers/pwm/pwm-stm32.c      | 605 ++++++++++++++++----------
 include/linux/pwm.h          |  57 ++-
 include/trace/events/pwm.h   | 134 +++++-
 include/uapi/linux/pwm.h     |  25 ++
 6 files changed, 1470 insertions(+), 308 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h


base-commit: 240b129d597cb8a8880eb3a381ff10eb98ca0c07
prerequisite-patch-id: 0e21153cd012f41ba9db52357fd08219af53e26c
prerequisite-patch-id: b22c91bbc4e3412f8e7e1f796ed18570ae021c96
-- 
2.43.0


