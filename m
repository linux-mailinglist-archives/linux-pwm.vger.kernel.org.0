Return-Path: <linux-pwm+bounces-5385-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64879A80DCB
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C417231D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC64149DFF;
	Tue,  8 Apr 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TgG8G6kB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2711ADC7D
	for <linux-pwm@vger.kernel.org>; Tue,  8 Apr 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122261; cv=none; b=n18kW0PSfNicwquv/6DaopzTicBQeBsykVVtr3g1JD0DRIDJ4mB5CE5WpFRhz5VlxmSKfDUrXNzqvMoKPdRKJYzKjRrBdFhRqVBEyPMJkJbYBbsPUylabweOfo1BI4Pg8V/CuxE/KjcVIVm0fDSNDWegtG3Vuu7yhMCB/jTx0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122261; c=relaxed/simple;
	bh=ur4m7aU44Xyh6TdtFa99xxsKqSj1jWF7QjhxaFVdqwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7MjKBNt1Wf+PwGaVIK3F2+DTiIRZDSnTB9qNN7GMoz2livq9xK8DhS/lBZKY0hLhg5QyBe7cudS6vNv3cSKjrFoJHrSLcv3aH80K1eghMa4DuvYWgqo3r6cYZ0XVG/QahBuXFjPFnpc0lytKVXHCkkwKGpBBXbM9vkrs0uTQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TgG8G6kB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso8728526a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 08 Apr 2025 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744122256; x=1744727056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MtPJRtiyh+SPBx4mLCq9KljUfJgi02xHmVOcg7TVdU=;
        b=TgG8G6kBtlzOkRUm5WRzNnbOSS7GZvkcUctU+kLcZSNOvK0K3GMKG3igG3p/xbjBJd
         lnWZs1IR2+23Q6eMYF1rkyzA6v3O6S2Ent7uA0HlBbJbUqflODavwCyMAr2o84IndZW8
         Set9nfkY4FX/AdNczAW2GcJJ1A2xYCgFM+DL9F3MjLaWe7xgl8MkLYoGEBqUWHPL++KV
         59SpupbKnrS+HZav/G3ADPXyRTUzDlk1RSyCPBv6zYBEGD+eodxixZQ7e4OX66+Von99
         DY0O3yOcmeXRhJ/XHrg3XczCs9+GkVRfEZ4v310R9x01PicAxT1/EisyegT7nF55FJsD
         6Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122256; x=1744727056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MtPJRtiyh+SPBx4mLCq9KljUfJgi02xHmVOcg7TVdU=;
        b=a+IWguat489EMJnpqDolFe/jjLq3R/R4z1yh9TA9KFrV6wG25ozMUYYpUOYbAT/XQw
         Kilx0HexFLIamyXMSMDXWh4R5afwi8uZVGFv10WH6fw7kUZs8FrnGcwZXJsCMIfne1xt
         kG3WSXop6hsr0rEstnHSsn5fTimoh+/pjnsp5KIZ+QdLIqL8fMXGZ+wqWBRPEBtlcSVH
         iGl0E2eQn5Fr2+4+gRfnYaaTfaH02AG9ZVpVKnwm5u+KHt5bI5hFfzOOIiFrubsxHx73
         fKFJGHdk8DgVk6i7PZLUV/+Noa+T4mPiQDRxWLgkXIGVjlTqj5GzcPmhnSW8nBYL+YGp
         torQ==
X-Gm-Message-State: AOJu0YzM/EQDP/+IpMWgA6KIgILJLiG/89yqu53fAQcgQnnKTxwEkIHt
	gkecXtVffTZAhqAUuliFJ6UoqIs5BqevCkQsRVDucOTb5lE61zgodyM25hrWrN4MtJ68Av96wgw
	M
X-Gm-Gg: ASbGnctUjdOY3O0wK5EHsbLpZoFeNpV+YbOKfEYQr1ctWNXh+XI88nZPnzcR/7rI9t8
	5KqNDlnxW6xQtYMMe/ZNVcSXBY7Ap5ycmGJ2bf9nRFGPVVHRTd2JDaYDbfYsxiXaQod5QAQMWOW
	6ZlH4dMqq+XHCt6yn23MC85SR0r8J8DT0Vw0bjl7a+l/SFPM/vKZk8XgtZvnCz0HRIBBfpQfZiX
	tiDaZbBXYO3NZWRK1ZSI+/AJikWD2Z4oDcfG67sgZv3itpDkYqYlnpXtCG0CcX1dGfv7aU12yMQ
	RXLjhdtcvsB2QF2aHQ2Y5hfHmVcx3ZtwKPBfMmN0/KzunNF+5w==
X-Google-Smtp-Source: AGHT+IF8wXFz8uA+4L7c2akpcsetRzXiZR3HHixUfXB9ZLuMwsWg0eKFk03NCvr2THnphnjjgfuQjA==
X-Received: by 2002:a05:6402:2743:b0:5eb:ca98:3d3d with SMTP id 4fb4d7f45d1cf-5f0b661a93fmr13098218a12.22.1744122255934;
        Tue, 08 Apr 2025 07:24:15 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f087ed1feasm8086092a12.25.2025.04.08.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:24:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] pwm: pwmchip character device
Date: Tue,  8 Apr 2025 16:23:53 +0200
Message-ID: <cover.1744120697.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ur4m7aU44Xyh6TdtFa99xxsKqSj1jWF7QjhxaFVdqwI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn9TF6ysVHjqWGQGJhd8cUXhw04NSmZphk90vNx eek/4P6moiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/UxegAKCRCPgPtYfRL+ Tqh5CACmbzHRtvo2P4VtFw31uuIT0MSMnHKRY3QxIi9nxDC44RY2CYgqsn31OiDCx1hWQ5ZVNgK QoZIAaWEZJmhDlp0JJnSh5xnl1h0RutBEmbnnuQ1+t0A0+LPkV6RplrcEnqWKqAsjPh2zSaykwj xunfpijLCNwucoM344MOLiBQIF78rgxh51iGuJGTtWVn5Fiy6RNNeQ3kQuP29sGPdcKcfmy2I3G y2YMSEKD+naQJRLJSomppjghUGMZnnh/zrKOrdDl8t7TRtrx8pTw1yf/sPuJRdb5YKKyuY5q6hC OA1RC5n+zyuPCEVpv3wEbln5dSYEmmN3pPOnJsO0b1hPCd2t
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

after
https://lore.kernel.org/lkml/cover.1726819463.git.u.kleine-koenig@baylibre.com/
(v5) here comes a new revision of the pwm character device support. v5
consisted of 8 patches, the first 7 are in mainline already, so it's
only patch 2 of this series that is left. The first patch is just a doc
cleanup that I created while working on this code.

There is a userspace library with a few helper tools available at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git.

Relevant changes since the last submission:

 - (A bit) more documentation in form of code comments

 - Make pid of userspace process that requests a PWM visible in
   /sys/kernel/debug/pwm

 - The (in kernel) convention that rounding functions return 1 on
   rounding up is hidden to userspace. It's not so relevant there
   because userspace only works with the generic waveform description
   based on ns, and so different waveforms are easily comparable and
   so the need for an extra signal about up-rounding isn't critical.

this is based on my current pwm/for-next branch, the current state is
also available at

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/chardev

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Better document return value of pwm_round_waveform_might_sleep()
  pwm: Add support for pwmchip devices for faster and easier userspace
    access

 drivers/pwm/core.c       | 312 ++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  51 +++++++
 3 files changed, 349 insertions(+), 17 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

base-commit: 957062f2ba4790c495de606ecf8bc7398c0c710f
-- 
2.47.2


