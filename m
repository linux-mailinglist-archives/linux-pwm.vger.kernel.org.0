Return-Path: <linux-pwm+bounces-2375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE438900347
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 14:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506C21F23954
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745018F2E8;
	Fri,  7 Jun 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4La8C0x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005E6F065;
	Fri,  7 Jun 2024 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762700; cv=none; b=AeZtXSVlvhWYkwUE2UfAbx4W9CXQuripFXpyPJh1o9YzjboLWBRK+Mb8QaLe1N3EdAcjXemiBapeCzB+8lm160JHUAqN9FC8OHrVKgfq5UoDkSKckUlB6m9MXP1Tf7i9IXRuyezKzhc5DNjmNs7nQGZks1LNNYsGYVoIMxk4aKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762700; c=relaxed/simple;
	bh=obPk8s/WOecV00viHw35w4tSQ57vilIZNd2h2kZummk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbmpSJGdk8V8L9roBXDybLokeHx0qrJfVPA4/2JkJy+SwPgrvSglJ+cw0ljefG/+RUJ9CHpSR0J2hJM4B5nDJWsBBJGFosfyMWHTcvDtGrsyuTNCFlZkqJN5zDWyBA0E0LdLjhnWFgp6L2PJVMbWQw1lV10uT7ejRINsW4/JTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4La8C0x; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6e0a499687so53659466b.2;
        Fri, 07 Jun 2024 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717762697; x=1718367497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0voDTCjC9eIwW0sYE9elC6RUwezU3XiI6iGqIQrmKoU=;
        b=E4La8C0xnwWCENiG4kBCimW9sS8OfpM8UOCImCAtiz9FaWuSlhfm+AcwpvqfHwOEQ2
         a0sm1mzSGZP5rBbCQ8+6YO5PuuGc6A6jgGL8lPrkxSuxjCYHQLSUlSbZmtnzQ1awAZD/
         7ZmpOcRwWugFwkb4dHN/DgZ46PHJj1jYXhclR1iAIWDNkV+q5M7fi2S4/OXfZqGgg21L
         6MJ5HUJo/qKMwiXULNnMqme+/f0aB4qv1EqhqA4aU4unGckptVEDxfOjyOlKAQ/dnihH
         n8q2ErwaFSx5yUKHexzzb119eAJkQPG4G9xEWR6nPXK8TWuHA4AenNU1olOEZStZ+YcL
         1o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717762697; x=1718367497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0voDTCjC9eIwW0sYE9elC6RUwezU3XiI6iGqIQrmKoU=;
        b=DMShDnAb8r5x9Kk2LkdqxSXDjo/uG4qCTuANJr1GYsbFYOVMy5CTRGc7uVwpcXZMiR
         yw0u3C/hErlwzWvxAo/BVCgUNsTuJwaeE0HHCf6LDV0RDqbMsVPC/3zMk1YIgdEoUm3a
         Iv4xWtMlZFs6Z0r3vCKqyoneGN5v22J/zkSIjIDuOSPtKygdQvTImqiGuFtc+KtXYHlk
         uhYQmbcO0ok57GL5rKGpyPeFXWdRpsLInlDK+W/ij7lKWDxNd9afCUv/31mDI70G6bfM
         ERHr+ejRXQEDi0gHIKVPFjQHx55jgE2if8cvwEn2j9MGFLOCCie/ecXjD+UN1rXwX1K6
         i9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeILnRlbLDqfO+iNUex5MK0qqt7V60XA2zEhZOe1xF2Uer8NtMtKXmgsnCtCKsROgaSAVJqxNONWo3P8tpvd3DYL7WzvHQQMofZdFaaYdH7ei0VpUvH2MOt+EuxkU5lwq9QUJEFg9ZXG7+SWkWUaxbdnEehm/uYkIAmMgCQdWVO2d8TQ==
X-Gm-Message-State: AOJu0YyTdNG9QNTS2IKMh9usK3QYVcQChM34/R2MDuJwfWXD2n+8cXnQ
	Dcv+ix/Ii6HSwr/3+jkKun5gVLwQK6Gk5SY8OqK4AeoWxRrSeYWZ
X-Google-Smtp-Source: AGHT+IFivbgfnTdGkvBGcCud1n2KkeVAD4QhpfSKPRyf648mfDB7pCO2q3EXujm6rqDVa+qeGNRpDA==
X-Received: by 2002:a17:907:3f9d:b0:a69:24f:23e7 with SMTP id a640c23a62f3a-a6cd6d17d81mr173332666b.19.1717762696864;
        Fri, 07 Jun 2024 05:18:16 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm237785066b.110.2024.06.07.05.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:18:16 -0700 (PDT)
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
Subject: [PATCH v4 0/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Fri,  7 Jun 2024 14:18:08 +0200
Message-Id: <20240607121810.460154-1-dima.fedrau@gmail.com>
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

Dimitri Fedrau (2):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 +++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 408 ++++++++++++++++++
 4 files changed, 539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.2


