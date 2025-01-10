Return-Path: <linux-pwm+bounces-4566-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285CA0890F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A55F163312
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CD207A35;
	Fri, 10 Jan 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh3RZ6vw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673EE207A0B;
	Fri, 10 Jan 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494683; cv=none; b=m2n+FrYakGi3tzy4hZ2B85owKLmy0B0i9VP5JDN9+6/DzXN6oV9gycbWQ8VbBdLPK8d/9ymqJjr1cxlwYeSUCeGVh2Xg0uNvHIg3U9RE7csTbV7zOJ1yg98GoPnpoJizaZggHIAaJii/iE5fd6ZlUqqaspHpPegDPOGII4In9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494683; c=relaxed/simple;
	bh=xw3Eav1FLVC+hH8GZYjdh7l5t24J8TPGmfK8gy4jRCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IxecjwIZujqeQkhQC+te93S5AZGKhuSyH9Wtw8lUVi7AuQ+TDbroQDmashxSbqgddulfU/t6q4NDwulqQImHd/lrFjqzcr2tvOyjGVoafi2himyE2JWdee+5jxyTSZP1n7qEG/BPvjXd+pGzbS0usTE6XfYbcQQf/+VJKmCox/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh3RZ6vw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863703258fso1822739f8f.1;
        Thu, 09 Jan 2025 23:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736494680; x=1737099480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BnsD2G8Y05Q7WzuLzmWJHBR7d3f0pD6hbm60eMhGJM=;
        b=bh3RZ6vwo2O8Yn4THQfvKjCcr6CYK3EBGoe4iQ0s1w8Vd9SCpu5BzUo1twJjS85JwV
         07jgBmhcdRixf/h0e9LrpvJ6iaW8+PPyg4DBRKuZATndEJv/FnMZTalli3wOlYUXPr4t
         auz+UXEfyaLK5c2+0RQup2f1TB9Agl0RsKwVVaiBOoX+SwkZ2nKqssmSrmnYNxODwIsB
         eYOhZBiHF844yygjX8SupT/LAshMuw92co5LYgGvXpEYAT6H4iQf0GK5aMERQGDNLr2x
         zUx1mSI8J/31u87pLR1VsstD+Cp+6NtGm6JUSNEU8N9+4Y/WLa25v2kzcQAius7VYHyZ
         BevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736494680; x=1737099480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BnsD2G8Y05Q7WzuLzmWJHBR7d3f0pD6hbm60eMhGJM=;
        b=FJoVDhFm38x9QuDRkWthMhn6N/Y6JvGSz/nvMBtuwS9FiTEasfiBaUOKUSVtcRPInR
         Bv7Y297BMHA7WiThrXWY/HwqBm7RvjD+nPlYApRxERPN82EceG+iH5A+EzMqhnmuGgF2
         65dbH6wPrXbzg8B04siptbDiad5ckoxyrodqzCk8nnfLUjEWEn01BvKWb5pVTgv3GDtC
         Sq5RaQOMxI451tvXJk74YCDLKVQcDh65wkI98kxIjryNTET4lAyakslYiVabjpXjMOcy
         op39zhNW0fANJB5EWQAJR4Gw8x4F0Iu5cAihJX8J0LxOArUj5u8m8aq7fpXjwygyH1JS
         zC/w==
X-Forwarded-Encrypted: i=1; AJvYcCW+jvqsIOzTkVGAZGUs9c+wDGd4XSJf73jI3owA4TOEXZSS/xuPVy89PncUDR2SKiNqOSrxnAQd+7/D+tBl@vger.kernel.org, AJvYcCW47EAhu5968RCNF7nGiuTrNKOj5aWtSrQiOXRLmsa/72FuzEwHQE3XKSFKcoNQRNwzWP9WCqcyqMBf@vger.kernel.org, AJvYcCWyEoKCf4NHF8stCco6nJdOaTpT/XztY3TyZonZpaqIu3yUe82mzuRHLNhL9zeoGbTch1QwlhGMqJuz@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGMIV8o1thiRK19q8gNLO6CTiqqPh00DZyl0JBXqyLHwMlV0w
	qEqAnHE+HgOcFwOflrWBW13TAF/ntcSNEvdBK/aq3nduDPMNL/qa
X-Gm-Gg: ASbGncu4R6KP7a02QEc0WZt3YDuIgm67pleelO9O/Ob4clqw8EuhifdAsvAyo0PnoR9
	YxQHczySEMvuMWDBLGBcnjFz9XlFPrnsWJPPeMU9GEEdkajeZJTk/9eHpvtQlHEN3yJ6OF5F+6m
	x5NuXFipN5Ve6h54KMJ/jlH0HBXDfahXBQKstIgX9YEISte0giCS/bnOKBqnKJJr1uI0QFNYwTf
	Yh/yFOd3ADkG6I9rDBJNhVjko5SOk7Ql0HGrv+OKsIE/lyrjJkJKbctlZCFN6I1aQ==
X-Google-Smtp-Source: AGHT+IFa3vh/PKJmzDi+cq+5kzK8poltzLjQTCEwPiEGk550+bfpk0MVlxLPUJTmcG3TndKEQ46FeA==
X-Received: by 2002:a5d:47c1:0:b0:385:fa30:4f87 with SMTP id ffacd0b85a97d-38a8b08c0cemr5985858f8f.0.1736494679488;
        Thu, 09 Jan 2025 23:37:59 -0800 (PST)
Received: from debian.fritz.box ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38397csm3726478f8f.24.2025.01.09.23.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 23:37:58 -0800 (PST)
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
Subject: [PATCH v8 0/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri, 10 Jan 2025 08:37:53 +0100
Message-Id: <20250110073755.29541-1-dima.fedrau@gmail.com>
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

Changes in V7:
  - Add empty lines for defines with parameter
  - Hardcode into:
    - MC33XS2410_PWM_DC1 -> MC33XS2410_PWM_DC
    - MC33XS2410_PWM_FREQ1 -> MC33XS2410_PWM_FREQ
    - MC33XS2410_MAX_PERIOD_STEP0 -> MC33XS2410_MAX_PERIOD_STEP
  - Rename:
    - MC33XS2410_MIN_PERIOD -> MC33XS2410_PWM_MIN_PERIOD
    - MC33XS2410_MAX_PERIOD_STEP -> MC33XS2410_PWM_MAX_PERIOD
    - MC33XS2410_WR -> MC33XS2410_FRAME_IN_ADDR_WR
    - MC33XS2410_RD_CTRL -> MC33XS2410_FRAME_IN_DATA_RD
    - MC33XS2410_RD_DATA_MASK -> MC33XS2410_FRAME_OUT_DATA
  - Change range for MC33XS2410_PWM_CTRL1_POL_INV
  - Drop mask suffixes
  - Switch to unsigned int len in mc33xs2410_write_regs and
    mc33xs2410_read_regs
  - Remove define MC33XS2410_WORD_LEN
  - Use a single spi transfer in mc33xs2410_write_regs and
    mc33xs2410_read_regs by using SPI_CS_WORD and 16 bits per word
  - Break the line in the argument list instead of having a static in its
    own for mc33xs2410_read_reg definition
  - Remove u32 cast mc33xs2410_pwm_get_period
  - Unroll mc33xs2410_pwm_get_relative_duty_cycle
  - Unroll mc33xs2410_pwm_set_relative_duty_cycle and remove check for
    state->enabled
  - Remove ctrl[x] and use instead a u8 flag which indicates from which
    registers to read

Changes in V8:
  - Replace x for MC33XS2410_PWM_CTRL1, MC33XS2410_PWM_CTRL3_EN,
    MC33XS2410_PWM_FREQ and MC33XS2410_PWM_DC with chan
  - Add bracketing for parameters in defines
  - Replace x for MC33XS2410_PWM_MAX_PERIOD with step
  - Add comment in mc33xs2410_pwm_apply
  - Remove hardcoded 4 with ARRAY_SIZE(reg) in:
    ret = mc33xs2410_read_regs(spi, reg, MC33XS2410_FRAME_IN_DATA_RD, val, 4);
  - Remove struct mc33xs2410_pwm and save on indirection
  - Fixed wrong bitoffset of MC33XS2410_PWM_CTRL1_POL_INV:
    BIT((chan) + 1) instead of BIT((chan) - 1)

Dimitri Fedrau (2):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 ++++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 378 ++++++++++++++++++
 4 files changed, 509 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.5


