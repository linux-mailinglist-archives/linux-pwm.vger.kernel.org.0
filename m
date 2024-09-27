Return-Path: <linux-pwm+bounces-3380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F39885D7
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95510B217C2
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26C18CBF9;
	Fri, 27 Sep 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMLdEShr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245018C92E;
	Fri, 27 Sep 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441873; cv=none; b=UpeNUx0DDjThknTtYmzirWnEY6dS0IWe1qrS8/gyNQ81FuNBAMpRQaQuR7HUaLY8FAxB9ewwtMB3IDPlA9mM3jy2WTaVLRwW1v37dCynHTDuMJcJhW2KGx08SjPnOEXVFsfHe2OviBlWIo/ivqKAtSZ6TMt5khx9F6yyZNTXrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441873; c=relaxed/simple;
	bh=izhQ6lq2bq8+V9CcKU5ErJWoCpB9VeRuwzaNhQvptTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VptyyXYnhHiBH8tb96yL9hRSODp7eJKWLKJU+U8GERJckq+NrU23eDS+Q8BTXYfK4Lz+sMWXlujnmyo1Xl3dqbQ9iL1H1e+3L8VqIyDmCR24Wk9a1dXbnb/A4CB767vXejtdHSiWHBQ2aWrso7hu466D6zijDh2Ts05eVgB+ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMLdEShr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cccbae21fso1529606f8f.1;
        Fri, 27 Sep 2024 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727441870; x=1728046670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdQEgRr1w/6ACerbhBiLNceY1UfQYpLP4c/0/U+Z+jA=;
        b=EMLdEShrZQ2GHnoDWbSESs8b+TkraDxQ4ItN/B7jt2uTLlE6Lc9op5eMmcDJcvM+/D
         /KHVEPRtUjHDPUN5Wc19l5YHKRYUgMfeRFehxcyAekgaYPjWMrSFc/lBlh60ncJYUpGf
         OaWmIdGTf463XWUMqDADR/KaWvXn4oaQG2cJBa9VXsI0FfyahfK6DKPIBfPyMdS5M7MY
         QjCa2MM9p6Uw6H7kuRTq5VNdbOplLXxSrCKydzZh7Ie1zYjJXfT9U4njE6bojhU/TUae
         fx3g1Fp5XIrOuQWrqdMGTY3lCFhrc9JxPUXlVeE46rsIPagS8fJXsFy0q/iL9Wnull3X
         BcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727441870; x=1728046670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdQEgRr1w/6ACerbhBiLNceY1UfQYpLP4c/0/U+Z+jA=;
        b=UnK82XZFw5fVFxjhtMYNVtoicFRw9e1pRwuHSmTW/X3qXZxFDzinjvrWClzahv9+je
         lKCifiH/lbzbux2ZvA/PsPiX8rsWr88IGv3m+5S5FXlo2HZPiO2YcpvIDBhPBo0OdBIN
         PnYiC0XP4qW5HPajrMv6ALg4P6Ycl+e+H5gpJjnPWe450zg1iJOBFt/zvjpea3aKdBVh
         JhNpp14Az20hiEsycUGXPBWGBujrAm1af2sBlr5iaK6IOKuDw0lvn+mRrn/RzA/msX7R
         gNMNm4fcR6MWE4kBoDduvJ2m5Gbir7aUSiVqk9pjUAlurIf+htP3gNwdDfVWpWIC8cDP
         XA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVSDoU/B98qpDV0ulEBv8Hyif8isBLJr/FV8PQIg3F/xRfCKpx+4KNNaEbtG7CIeyLGAtgwg7W2LMIT@vger.kernel.org, AJvYcCXNP9AgAvmg5j1Xxs1l5nOEoeZZ2BWwCECWPsQblC+WwZhUH3JQ+osdt9bh/MFh2A9RElCSAAIYy2bkY99B@vger.kernel.org, AJvYcCXsARCvQKEAG1WHAlhz7FMVscrPFl5mYCyRWzWUbC55zvK6+inZQpXIijP6q91GUqJFB+0vu6XEDrXU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlrr1SlwttIPucGkBpr2NC8eZU6QTKA/s7fwQmW/LBe3aLau7g
	216ZoXnPmXzpSIkDVOPlT5ilcV05c9LKaFvT/6qdxRvKarrfi4KT
X-Google-Smtp-Source: AGHT+IE2WalEpRqihSYCQMgc6PxLPanv7sYJH9ax+9bFI7n7gLDxF4D9+12fBRBR3p3FduUun2acNg==
X-Received: by 2002:a05:6000:46:b0:371:8750:419e with SMTP id ffacd0b85a97d-37cd5b1050dmr1793449f8f.47.1727441869649;
        Fri, 27 Sep 2024 05:57:49 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:666:ff00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddad1sm73814575e9.9.2024.09.27.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:57:48 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri, 27 Sep 2024 14:57:43 +0200
Message-Id: <20240927125745.38367-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Changes in V2:
  - fix title in devicetree binding
  - fix commit message in devicetree binding patch
  - remove external clock from pwms and create clocks property
  - switch to unevaluatedProperties: false
  - add missing properties for complete example:
    - pwm-names
    - pwms
    - interrupts
    - clocks

Changes in V3:
  - Add description of the general behaviour of the device (limitations)
  - Drop unused defines
  - Add ranges comments for defines with parameters
  - Drop MC33XS2410_PERIOD_MAX, MC33XS2410_PERIOD_MIN defines
  - Drop mc33xs2410_period variable
  - Round down when calculating period and duty cycle
  - Use switch instead of loop when calculating frequency
  - Removed ret variable in mc33xs2410_pwm_get_freq
  - Handle all accesses in a single call to spi_sync_transfer
  - Fix comments in function mc33xs2410_pwm_get_period
  - Fix call pwm_set_relative_duty_cycle(state, ret, 255), instead
    pwm_set_relative_duty_cycle(state, val[1] + 1, 256);
  - Use devm_pwmchip_alloc
  - Fix typo s/Transitition/Transition/
  - Drop driver_data
  - Removed patch for direct inputs from series
  - Tested with PWM_DEBUG enabled, didn't before !

Changes in V4:
  - removed include of math.h, already included in math64.h
  - removed include of mutex.h, no mutexes are used
  - added include of bitfield.h(FIELD_GET, FIELD_PREP), fixes errors
    discovered by kernel test robot
  - cast parameters in DIV_ROUND_UP to u32, fixes errors discovered by
    kernel test robot

Changes in V5:
  - Fix comment in mc33xs2410_pwm_get_freq, selecting steps instead of
    period
  - Add comment in mc33xs2410_pwm_get_relative_duty_cycle that duty_cycle
    cannot overflow and and period is not zero, guaranteed by the caller
  - Hardware emits a low level when disabled, disable if duty_cycle = 0 is
    requested.
  - Fix complaints when PWM_DEBUG enabled, round-down division in
    mc33xs2410_pwm_apply and round-up in mc33xs2410_pwm_get_state.
  - Add comment for disabling watchdog in probe

Changes in V6:
  - Add link to manual
  - Redefine MC33XS2410_GLB_CTRL_MODE_MASK as MC33XS2410_GLB_CTRL_MODE and
    MC33XS2410_GLB_CTRL_NORMAL_MODE as MC33XS2410_GLB_CTRL_MODE_NORMAL
  - Remove define MC33XS2410_MIN_PERIOD_STEP(x) as there is no need for
    parameters and use instead MC33XS2410_MIN_PERIOD
  - Rename function to_pwm_mc33xs2410_chip to mc33xs2410_from_chip
  - Add comment in mc33xs2410_pwm_get_freq why count should be rounded up
  - Fix incorrect comment in mc33xs2410_pwm_get_period
  - Rename steps variable to doubled_steps in function
    mc33xs2410_pwm_get_freq
  - remove cast in mc33xs2410_pwm_set_relative_duty_cycle
  - remove duty_cycle from if in mc33xs2410_pwm_set_relative_duty_cycle

Dimitri Fedrau (2):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 +++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 422 ++++++++++++++++++
 4 files changed, 553 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.5


