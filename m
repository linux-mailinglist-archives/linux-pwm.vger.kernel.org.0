Return-Path: <linux-pwm+bounces-2964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC59460B9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D772830EC
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DF136343;
	Fri,  2 Aug 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGFYel2g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B6175D35;
	Fri,  2 Aug 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613466; cv=none; b=ppj+TyNLN0ILPFfnOmjdpe6heJnrhfvPofNHtzx2VbK+ay/rozL+IiFmDrD6+264TImdPdQOWa693i++6JzhSx/WjqmLE3YueVjcnm7vwNDb/DYksSXUl0C9JVdEROhuUQvzXxYOyDfSGefLgGg1+I2W1VpO/WGM5QlW0ZB2NIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613466; c=relaxed/simple;
	bh=9Aq226PHuPDLT1dV8c4cdtIVxP/RHNsUdf/vBE1gFMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WYiwdCYlQ3T4F+8Yy3KCM5e5kayWBQ0FZudkLH7KGi7NRx7J/Iv2vGb4UDpsG5ONFx4Zq/BhIHupg0RG5IYGFKwkMxKLFna1RpbX+BuPDECnIN27ZBnipxMCRj7tW7ob8AwgaOpoX7U1nyQ1zA5wiATO2QZnTTpk77jceHE2Vi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGFYel2g; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so10693237a12.3;
        Fri, 02 Aug 2024 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722613463; x=1723218263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzr+lFhinuShkNh1JmyY9cP3JCDAOZuAPnZMLB0AEP4=;
        b=iGFYel2gO4BM4O6eflTbyTB2wD1VYhvMsGA9AkwjEWKLtU5wdLMHFnnQfhlgQJVsXT
         gMOqDU8drGDYGhtdNXaIhd5FAnA4AkAXvKwZsjR3D6LzJyKajnMFSuEwUFhIzj38e9HG
         0BP8Ol+S5Ec1jZ/S90+gJ7jm9xaQwU1VKMD0y6K8LaVJdHt03ANxZxyDNBwMWKl7ODzt
         wyhSk1Ph3BYVpLfv5UdP/g+ChjW4RKgPNrYZvlCygRzeNSlPYqNWs2IkYta6KkIPv9MU
         C17aIRZh3kgEVbypNkv3XQ0Rfz7KHn+wSIgKR0nI7Mc40c/IJ2WIHxDXkwiA2BD4rLKP
         hz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613463; x=1723218263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzr+lFhinuShkNh1JmyY9cP3JCDAOZuAPnZMLB0AEP4=;
        b=ZeUemMWN3o91lyyU3SURzFg4vnzOMdupI1+9TYmOxg3Ja+1h2d6xR8ZeCgZDZa7S5Q
         oIex1jAKW+MRySJeuhblUS2nG2v5CSYv8WZtyoqhjmzXklARBlko/5FH9mo97jynhw8i
         szBaB6Rmi2T8TBunIO7qzxlqIxYFVoQwFQiM5BQjwnOTOc82JlRXZhrwcLz9kgD3elVf
         nrnObY7nmv72LpNImPlepGXr60D5oLBgY0I4Rwp+XQRKfRj9WbEKMC630fsqgnp2gcz/
         WICqC1Pe5t/5HpqTGWxFupHrs3oS9cEng6ZT2LYAtqIR7qpeUbFQBSIbJSWtIPD3wQwm
         uN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPUbNEUopxJvRQI4ksSVkP+DXNg4t3mKoCehmruVpuf/nRKpyFwVE7qmzsp4eEZj3TmgIm+So1dpPtSRvbMTo2V3vYD1dkGs4qEVzRv/XmtCpjwcSXrhieS+rOmk5092scmQyHxPKEFwMTjZUYISoeUV3y3C3bnudO4u1rShWUEnvTbg==
X-Gm-Message-State: AOJu0Ywn8Ygr8QbP9ezcG3uqekY2vtDa2dAMzPGm7ejb9kD7l+NbDxFu
	wqO0PttLtVlBesrW1WF8i5V3fI7FCbnxQ/TtfwWsCt11wN64ECrtSWdpeA==
X-Google-Smtp-Source: AGHT+IGbJnUK9kdfwx9LVt7kvg8p1OGZjtqGfF4pC85I1nP08gK0C9PIgsLYI118LDj4ttM1dBvJjQ==
X-Received: by 2002:a17:906:f598:b0:a77:d52c:c42d with SMTP id a640c23a62f3a-a7dc4da6163mr260246766b.13.1722613462250;
        Fri, 02 Aug 2024 08:44:22 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:640:3a00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3d14sm112577566b.22.2024.08.02.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:44:21 -0700 (PDT)
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
Subject: [PATCH v5 0/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri,  2 Aug 2024 17:44:06 +0200
Message-Id: <20240802154408.135632-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Dimitri Fedrau (2):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 +++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 419 ++++++++++++++++++
 4 files changed, 550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.2


