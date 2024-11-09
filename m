Return-Path: <linux-pwm+bounces-4051-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69649C2EDB
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 18:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5701F216DA
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67919DF44;
	Sat,  9 Nov 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOUqwQYi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B612556E;
	Sat,  9 Nov 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174105; cv=none; b=tpj6GJzihPlSNCpMPhzfEbBl66UrTUrDuw0mF/JylrNYQ9weGFzdV4LRc9iALnRAy/DGTtgp9dy4P5FkhXxECZxhFP6gfHGek22/7rxlG1OYLfNmqc25zepFULFGs0dJpEgarDmsFzjO/9ysYxD3KjsyNb5JtKzoWINQ4U4i3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174105; c=relaxed/simple;
	bh=dTvJYOkoE1f4F1tHTzNw8Qs/H3DeiNEj+RAk7PgdRpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYVrB4otxs1KkYS1CHv5bPhEt+jJGTULluP5pyRzH7/uPM34eSbr5+n691QjJTHXHIVX7Oadel+exohHpEh84+dR9CSR2wqPFEAhJcyb9NbsUG88w31Fk9HlmBonO4adAzF1uG4JKrHr+NVJrh4OKcYS3WrbcCRKP8RNgt3+Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOUqwQYi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43161c0068bso27667235e9.1;
        Sat, 09 Nov 2024 09:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731174102; x=1731778902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p42kdSg5X+QbjzAtyCojljK0tRBvSq62OLyKQkdrGcw=;
        b=EOUqwQYikEGlTkroJlr47Q/sTDzNFWphH0L5RvAFDZdObj2ysFMnGiU3Ty3Myzisa4
         wlB7ptajUEEHKmBEXlXCt4Z0k3tVfIo9wo6Sq+qbric/vQTltuBfUb9VFH2bfJqA/811
         Y9qhx5/084XlIj2aH5/ooTETJB+ksQHfSLOYL0y2ToIBWKJ60OpmMBe9IkNlhuixSUpP
         tOuu3Nlukom0aCZTCjLUv+tu5jswpmR9AG0Hi4sZ6lIf8xT9TxHnbnDrpMC87oJoeS06
         nb1WJ5Hiy5wGMKUV6QJk57yqErlsg7z6unRiJA3gZ/QSkggxXF5R+9QJawbiW1lOPEv6
         nulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731174102; x=1731778902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p42kdSg5X+QbjzAtyCojljK0tRBvSq62OLyKQkdrGcw=;
        b=H6VjnNscakhaZrkk1xN7R2KdDflYmDeWl8XmrL22bJAACo1KTR3pJMPikmozS3xvDg
         b2RvmGX6g3DnRiPk3FNhsPKrnaDOeUYnMLKfM0NEFuSvAfwzXdN016Ycr1Xt4IgX3w22
         epFkJwAxR4uLWKv5jX57ly9nuMkwbG5w8nnu8OCK2Mq1l8oqhQ+CjzKIlEZ8fW8yUtc2
         kLK/bXEC8MBos0649RwMp0Big8Kz6zYN+EqzBqDggOlEMSgCCeE6nkIdWMjWBH4TKRYZ
         Tw4ObVpv5Tou2NNHlnthejZcN4eTO78YW1DmsPrPKNYHoWoa2V4ztWGgwhlo2QDRcw6+
         nVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCpLSkSRBh27SIU/NNLSd0ExmLuyPPbcvurxpOrmj4zfE84VboAl1ScI6bigmpb10bQHB9dMKaZkhQRhYt@vger.kernel.org, AJvYcCWYNJysLqhpsuMR3aqWB8654sdieEZQkApSueCGVE3yhqv9zJaZv7vBrVo1JoztYA8qmABD49HwtnDh@vger.kernel.org, AJvYcCXDsE02W9puo8XaXL6mLFnOxmMvoUsDjyeQ/gjL5Lbp3Gs2JcQXieVcXLvifCVxEACmyEsqb7+uzcpo@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdK7odXGfOAUaEdfYp6fljoNBM/gCx0Nf7j7gSzWzshF1BBlm
	/IyTlEJu5KMVSgpCsOhS0ULdXl7m1jgkhsYdnAOKZ8FnZyUnZqsw
X-Google-Smtp-Source: AGHT+IGSAAGcsqym35eljJ+OR/erLDOIhsA/VgcN/4zQOhabPcFzZ1gspDt2k2rgvb44i/NACTxVMA==
X-Received: by 2002:a05:600c:1c11:b0:431:5bb1:f088 with SMTP id 5b1f17b1804b1-432b751f00bmr60446275e9.29.1731174101546;
        Sat, 09 Nov 2024 09:41:41 -0800 (PST)
Received: from debian.fritz.box ([2a00:79c0:605:8200:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm117582285e9.30.2024.11.09.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 09:41:40 -0800 (PST)
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
Subject: [PATCH v7 0/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Sat,  9 Nov 2024 18:41:33 +0100
Message-Id: <20241109174135.26292-1-dima.fedrau@gmail.com>
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

Dimitri Fedrau (2):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 ++++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 388 ++++++++++++++++++
 4 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.5


