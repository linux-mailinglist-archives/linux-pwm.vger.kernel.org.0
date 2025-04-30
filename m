Return-Path: <linux-pwm+bounces-5783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9600AA4A68
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882381C028F0
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3E253F32;
	Wed, 30 Apr 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kdIyckdR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63B1E47B4
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014184; cv=none; b=hQY7iNv519O3GqajMP/+UitiEKTPsWah9f4bUmi3neZrtuO+8t6opaIc1IRIkYRJKPvnl+yBd64oNr2Ljb3dbklq4QvZQhN5nv3iPP7lljLz1hk0U/80B1FhO/8SsZtFkaG/ktj4T/7YqkqfO3Jle/zEZgTLYbFtoWib7swseBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014184; c=relaxed/simple;
	bh=+DkcJUUcvjZeQMMqsoPFA0SMW+ilrUpwRUdNYgKcY/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VjN82N4iRwi7B+H0nxrLqx9KbRCmXOOfE71l1DRcZl0DULxId7iYoUPhCl2BGKExqQc3Bol8T0bSbb491PWL/G6RTxEFivpJxgjyQRw5/K+NxU4WzLNa/CdBiMXObw+aS3OL1e02pqFrdRdZh5FoTmlMIHfzXhRcOdETzEuaJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kdIyckdR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edb40f357so44996765e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014179; x=1746618979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GohQdJZxAc8Y+aN/5Hw8gvn3YsSdchhiUeIPWILiUng=;
        b=kdIyckdR1UAKRvYRqT0A2xjg3y99aiUO3ec76HOC3M4pUyRLm29jPu3fvBi5BokhXb
         DMSMgIWo+KA2frvsWz7I2r1rxuNnUl/Avx6goYs1ytJQBDy7GfBSb04wXoYrYjQsUk/0
         CoYf9gR1fPkd/njBzFZghA1TObxoX7Rf+Fntswz19erzEHUf8nylmKSfExKSfdN+DsHX
         wj4gVzRCGG3+LTV2J1Q9FOqVEKKAoBExnTVcEM5ltwE7Cu7qAdvU72K6+GuzXkNjQS6j
         11GpVuuEkAWG3YiPIUSv3kVfV3eKrTHMZolCS/qMv+N8scYenfBXq/xfRuWf1RlBD6Le
         Ur/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014179; x=1746618979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GohQdJZxAc8Y+aN/5Hw8gvn3YsSdchhiUeIPWILiUng=;
        b=h/Nc25quw8E1MDpCGZhZ+1Gr/yRSTvt8AjRpALF00fT3pguyLYxn78naZafzbKYJ6E
         XppxBVdqaAtxzfRhCRmQR1dV5uucPXSSInzryuIMjS5beocyZnRZP2GhAaQN/XzRsdCb
         b7gUL9puQWwO164HZHSEoyIr6ZNnPVqHaJVHxX/sePs4Mnu9UPS+unrGdwQafZPZG9BY
         XcxK+MaGOrk1Krg5TQxB3S3xJGQMpHDHStPnvNT/H7OLLhjzoMaeKbFXcmJAunvpZuVJ
         dDsw6PLfdIt1J4nzPIAaU6+Zfl4apgSV/ZBecl8ee2UDo8wPgTvR+nXLfKpqIl/HSfC4
         zRKA==
X-Gm-Message-State: AOJu0YxTbAF65bYE2K2Af/5twrGStZWXfsGg3CDkzu6k9Dph3CPUFHlm
	ClSMhvgLJIN2rw+5gNwMD2CxJWwPUq/n2nZXAPnHKHYbUtTxYXbAnkdqt5KSIE2u4NrJ84LBAhy
	6
X-Gm-Gg: ASbGncuCxD2ikmUjGYzC+NL2kuvpYl201xUT8hPuDooQMFkdioZxXdID4NxDqw9uDyz
	08WHqgEnFNCtIuGM1zmE2piWhcBjWSi1sT02Rkdvx/iz3jHEYLCki9M3yIJ3mXd++9p/iYoFhv7
	IdNtWBJu84iWjfYc9niE2ibawGFge30Qju9E52H1lzcD1Vi+/IuCvBJ388As6mEOyqLqpm0ME5X
	DWv4wi/YKjn7yS1AFRESx6CgfUkQEOIWUfjwC/rTnojuhsgfptLIdx6mSHVoTG5FAoHBtgTZLcg
	GBqEvt6cwAZK5rmjbLcvRd40/sq39J0yAnrInzd3lonpw/PqpAisJguLtTlIuYV3lI4EREXku76
	1vegynMY=
X-Google-Smtp-Source: AGHT+IEFUxJ3WS1utlqV3dUgwG8Ke3V4D4/4+XSpcrhNtH5kcCGmSwkWKeP1OKP5WBD/Gq6BCFoz1A==
X-Received: by 2002:a05:600c:4f01:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-441b1f5b8ecmr23207415e9.23.1746014179328;
        Wed, 30 Apr 2025 04:56:19 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2bb5ec8sm22522495e9.23.2025.04.30.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:56:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] pwm: userspace support
Date: Wed, 30 Apr 2025 13:55:57 +0200
Message-ID: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=+DkcJUUcvjZeQMMqsoPFA0SMW+ilrUpwRUdNYgKcY/w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEg/OenXMSbEhIAiQ3asN3UyPcph3/OJSxaPPs EoaKbzFDJWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBIPzgAKCRCPgPtYfRL+ ThoiCACDLpGudfttYVlsIvqzM4lEf+ATXZTPxXP68F6gKP3MJpjM/SxvxvcvJ06UKmctxt+ykRo EEGe1GgisB05tOntMASuo1TEzlOxSIsgX31V92CJArJ6j/V/+IlEiFgyn5dm2fG4FYHfO4LCXhW Bepgs52KMDBaS8eiCENsDYyFSli4EX9pWsSJ9qtAhocdx+y+r2B7/OboAPlcpxua3tFrWySjwIt iMqvxxnyTPTuqTcx7E1jzgOtbQO1HYO8zg8584V/TfJWX+Rg9UpfMFy3uUXm9rr7xeZyNpa8pFW STznxVQ3kGvBzTxskzU9/UCkJ6eBxCr09vwnbYA//M1+AHX4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

after the feedback I got from David on v7[1] and some internal
discussion here comes a new version of the patch.

Apart from rebasing to a newer base (current pwm/for-next) the only
change in the relevant patch #4 about return values from the
PWM_IOCTL_SETEXACTWF ioctl. Instead of returning 1 if the request failed
to apply exactly, return -EDOM.

The earlier patches in this series prepare that and implement a
similar change in pwm_set_waveform_might_sleep() to simplify also other
users of this function. Patch #3 is only a documentation update that is
not strictly related to the userspace chardev, but reflects the changes
in patches #1 and #2.

Feedback welcome.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20250416094316.2494767-2-u.kleine-koenig@baylibre.com

Uwe Kleine-König (4):
  pwm: Let pwm_set_waveform_might_sleep() fail for exact but impossible
    requests
  pwm: Let pwm_set_waveform_might_sleep() return 0 instead of 1 after
    rounding up
  pwm: Formally describe the procedure used to pick a hardware waveform
    setting
  pwm: Add support for pwmchip devices for faster and easier userspace
    access

 drivers/pwm/core.c       | 369 ++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  53 ++++++
 3 files changed, 404 insertions(+), 21 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h


base-commit: e373991eb9ff0a9617634017c7f19fd36ec4f208
-- 
2.47.2


