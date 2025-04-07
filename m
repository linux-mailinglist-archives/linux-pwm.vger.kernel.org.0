Return-Path: <linux-pwm+bounces-5356-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA754A7DC1A
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E95318879EC
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63FE23BCED;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYpMF8Uj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD622652E;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024921; cv=none; b=c9Nln3/affhF6gk65ToUur6CwVXBJbsWws+F0V3dmrM3yP9hsPM0uqUVceNzk2pZltbuRTITQ4qLn+23ZWI+7pngFPIhSHLaALkMJI/Gv7abTnuRS9F2K7VymBW+gqlKPkIiTQ6c0m6QPlt8W2/xrvyJf2AB1VUJZdPIybZJ2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024921; c=relaxed/simple;
	bh=THVYVAji2RQH4cDQsWSjJnLysay6oDzbDCqWSmvOAT8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KJVH4sjVTJivgOdZK8aiqbHN6+KsWwzKqcR6g5vsBGbNh1ubO4nmnj2Z2CtKMOoN7S60+nL5s6rj91yKflqgdqB9O9vbC6MKIq/1Jy7GDT+ttx4zbhQaLUWi4ef1CErXLwYxi639R4dJCtP17JMiMqGqeBL2ipTSQMG0VzRIVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYpMF8Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 228CEC4CEDD;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744024921;
	bh=THVYVAji2RQH4cDQsWSjJnLysay6oDzbDCqWSmvOAT8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WYpMF8Uj3vpexa65oJVQ9MRVVmu2HexqQcxvMu6yLu3AiS3K9x4ujBN/q76bag8v5
	 cLEtqCGYl9L0i+EEUfqhxAp+gfCSmS2wnQGhi1m73Pjv27WeTborhN06++5SCQRXJZ
	 GKEINu8y1BKez5JO7HDTXMRaiTy6XoyZCtQ7cs+egZ6m0GHUuI3Iapgu7rhH1TyTwc
	 eMn0dhY+i2GGXcQXaCta0X3uJYYZPer85QGQtXZ5qBltVbKZxi/ItKaffG6xlKfbCH
	 UBFnem79roc2SIy2ijk0BITnThmA/Dwh5ieXTxDjIgtal0t9thFqKsTQkrRM4wilNE
	 Jz9/DAG5vefvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBD7C36010;
	Mon,  7 Apr 2025 11:22:01 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v9 0/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Date: Mon, 07 Apr 2025 13:21:50 +0200
Message-Id: <20250407-mc33xs2410-v9-0-57adcb56a6e4@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6182cC/0XMTQrCMBBA4auUWZuSX2pceQ9xMSbTdsA0JVEpl
 N7d4Mblt3hvh0qFqcKl26HQhyvnpcGfOggzLhMJjs2gpXbSaClSMGar2iopYlQ+2vMDPTpowVp
 o5O03u92bx5KTeM2F8L9QSsrBDM712jurhBKRE/YjxYLv65SQn33ICY7jC1nWGHqbAAAA
X-Change-ID: 20250320-mc33xs2410-dd19d48ba9a5
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744024920; l=6622;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=THVYVAji2RQH4cDQsWSjJnLysay6oDzbDCqWSmvOAT8=;
 b=/LYfF1rXTJboEB4Cx8caI4VuqSX00mlm2Dtuap+celdIWHmiG6/kLhKPXaX6PNxKUFXq8wU/N
 bS4MMQYBBRICrt8DkQ2w6VOX2u3vnwcw4b+tZCshX2geID7qHHJYOVu
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

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

Changes in V9:
  - Change to corporate e-mail
  - Fixed comments of defines ("s/x/chan/"):
    - MC33XS2410_PWM_CTRL1_POL_INV
    - MC33XS2410_PWM_CTRL3_EN
    - MC33XS2410_PWM_FREQ
    - MC33XS2410_PWM_DC
  - Fixed comment MC33XS2410_PWM_MAX_PERIOD "s/x/step/"
  - Replace comment in mc33xs2410_pwm_get_freq with comment suggested by Uwe
  - Rename variable freq to doubled_freq in mc33xs2410_pwm_get_period
  - Add proper handling for two cases where relative duty cyle is 0% and
    comment them in mc33xs2410_pwm_apply
  - Add comment for the reset handling

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

---
Dimitri Fedrau (2):
      dt-bindings: pwm: add support for MC33XS2410
      pwm: add support for NXPs high-side switch MC33XS2410

 .../devicetree/bindings/pwm/nxp,mc33xs2410.yaml    | 118 +++++++
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mc33xs2410.c                       | 391 +++++++++++++++++++++
 4 files changed, 522 insertions(+)
---
base-commit: f09762d6f6d6e81eddded89c4ae77a8b3897ab77
change-id: 20250320-mc33xs2410-dd19d48ba9a5

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



