Return-Path: <linux-pwm+bounces-2720-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80D92A087
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4A41C20F99
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C117721;
	Mon,  8 Jul 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lpUfoC0d"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486178C70
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435980; cv=none; b=V/43wgzGuR3U6mjjKzjOMNCg3rCvi6xTv84I96tI3QLeVbZ9+D4rWwVTnd8SMt4gzVW2wBz5vVU0UljVSSV05Z8iGDGlxLH4ZyYErOwLc86qYs3tThGuQhlzyTEk8rp1JIs/6aoSix45Ad7c2W8MZBPOMN0UemK8Wt38xUtIGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435980; c=relaxed/simple;
	bh=Yb0WIAoaOKNp5Xv4PSSI4KumM0UVBL2yI5MvTxK0YKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1jMVGvgheCkI/3UHmgFhYWXbno28XmD//ETAxAF/McgWZlOK49W/AAnGeOKMV1hUf5Gs3CtR/HpJ0/0CIetPRDixfOU/+1derL3tmoJ6nq5NgMX/AT9ZsUqj7tENobkTy0TvudrWRSb4os/egWotDrHttNFfvhaOA1bbF4zwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lpUfoC0d; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36799fb93baso2534701f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435976; x=1721040776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9t9CW2ikDJ93nVzHMjsfMYNAYP8IQbMk6FtSVUZ+Oyo=;
        b=lpUfoC0dLAyD9F/v1/cnFdgcq9/TJtG0vk8VwrRsPFlT9x/tMH4pQAzH1OfGJFLuC1
         2y2zKrTVD0RHWUehsJbdbkkoB8GdwmwpK44JKRztK7IFZZ2rgJutyoNgwGeJzhiznWww
         QXGTFkfO9CAkJoyEaYLPOdQICnLRxauUs2lFDbbi9q5PjVIhMP2z9EWwW3qjQYSg+yzC
         ZbseQYn/vMufCgh5/kuytEVG35zfb5C8+UZrjwso37QKNCGVr1bwW1RlqPz+zc7mj054
         mhrMu2sefqiik0kdT2/tLA0cUhL2eNoltXNk2Wgxot0S30PzBqxiJD2vDwjIOsGMoF3Y
         T7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435976; x=1721040776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t9CW2ikDJ93nVzHMjsfMYNAYP8IQbMk6FtSVUZ+Oyo=;
        b=TrYmzI9eOE1SAV2T1kIGsqpxyH06fynSQ/ZRf8s1e/Y8RnSxQGXnv+Mc2jrTv+dGwh
         qpEqDmLTLMGWJzKC2Gjz4UgT9q7mtHbasdxIFqJX2qsZg7DhzG2kAwTHTlo+LdLLTnZ3
         nrOHljE/ahksB11kE+EckoAzW2agIAGhMdkuH0bmZTwQvKUTwZTZeXxkVL+zZ8UraLlz
         Id8urjriwllnSCfXcfw793C0a56M1sOh3PuBFtXUQkw4qAAfaPEyVPCiWE3HEUN9+lB6
         SQKfn49rzIgDVC1p69biaA7SB8Wbnr0uqrVfJI3vFW7swGZ5iM+Rep6hNfT9BYBoDFtV
         +xXA==
X-Gm-Message-State: AOJu0Yx+Mazix23f7nJ+7w921r0GGvjpcrgwPnV7ixKw1YhtZZIqr+uK
	ud8plbIThCQ1YZX+Uoja1DsTJG7D3dfLt3x5q+nmgUaxXHc/yjaEe3Q1tOmFckvgtAOSHtQtdLT
	R
X-Google-Smtp-Source: AGHT+IGdYnypB7xTlH719+DjiVuD4czKnIEonrQHHTOzz00kZsM072lcPEtJDLFCd8IDnJcosZHsxA==
X-Received: by 2002:a5d:698b:0:b0:367:8fee:443b with SMTP id ffacd0b85a97d-3679dd56208mr7132968f8f.41.1720435975893;
        Mon, 08 Jul 2024 03:52:55 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678a648dd3sm15478080f8f.89.2024.07.08.03.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:52:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] pwm: New abstraction and userspace API
Date: Mon,  8 Jul 2024 12:52:26 +0200
Message-ID: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2672; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Yb0WIAoaOKNp5Xv4PSSI4KumM0UVBL2yI5MvTxK0YKQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8TrEwrhSTsU+WYFtDXfVOsElXp4JJimZYycX tewSw9AhzyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE6wAKCRCPgPtYfRL+ TpT8B/4vQpye6kHDXbHQtKqAcG7Sgx9KXOlhnKnRcpDujDsY4SrDDFUOJPa7BlanQ0cSAMjHreK rHzfyEKef43R5JBJF5F3jR9u1rUqEEeAiYbT9S9VnekSqSWvIM3urOm4iat7fF9u0rZcq6Vu+iB 67lAEXjus5D3kI01bmaOWTP07W2orpkPJJB5Wa92l+VIjTTLy0TzjfjWHDjdMdaIwS0sDlnWw5Z hFcXNfJnX9eL+HgkJ375kbLNlfZ3fmvCipjYjxtX/R6i+WszdErNUBtImwe7LEf1+8D0xo7drSn w2P2Sy2CLGEOZahAreDlzGG6Irq+Q8QsMCPI2lsnw+hBK1XH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series implements a new abstraction to model the output waveform of
a PWM. The main improvement is that it defines a duty_offset instead of
a polarity and so allows to model more wave forms. The motivation for
this is that we need a PWM channel to have an offset compared to another
channel from the same chip, that is something like that:

         __                 __                 __
        /  \_______________/  \_______________/  \_________
        ^    __            ^    __            ^    __
        ____/  \_______________/  \_______________/  \_____
        ^                  ^                  ^

The kernel API for that is still missing (so it cannot be used yet from
the iio driver we intend to use it), but there is a userspace API that
makes use of it.

This is actually the 2nd series that implements a userspace API using a
chardev, the userspace lib from the last iteration is updated
accordingly. See

        https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git

The series bases on top of

        https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

plus the patch

        pwm: Make info in traces about affected pwm more useful

available at
https://lore.kernel.org/linux-pwm/20240705211452.1157967-2-u.kleine-koenig@baylibre.com/
.

Unfortunately this requires a new set of callbacks for lowlevel drivers.
In this series axi-pwmgen and stm32 are converted accordingly.

The documentation situation is not optimal yet, and I expect that the
locking patch triggers a lockdep warning for the meson driver. This is
however a false positive and a problem that needs addressing in the clk
subsystem.

Looking forward to your feedback,
Uwe Kleine-König

Uwe Kleine-König (6):
  pwm: Add more locking
  pwm: New abstraction for PWM waveforms
  pwm: Add support for pwmchip devices for faster and easier userspace
    access
  pwm: Add tracing for waveform callbacks
  pwm: axi-pwmgen: Implementation of the waveform callbacks
  pwm: stm32: Implementation of the waveform callbacks

 drivers/pwm/core.c           | 678 +++++++++++++++++++++++++++++++++--
 drivers/pwm/pwm-axi-pwmgen.c | 148 +++++---
 drivers/pwm/pwm-stm32.c      | 605 +++++++++++++++++++------------
 include/linux/pwm.h          |  51 +++
 include/trace/events/pwm.h   | 134 ++++++-
 include/uapi/linux/pwm.h     |  24 ++
 6 files changed, 1334 insertions(+), 306 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h


base-commit: 120a528213b6693214e3cbc24a9c3052a4b1024b
prerequisite-patch-id: 0e21153cd012f41ba9db52357fd08219af53e26c
-- 
2.43.0


