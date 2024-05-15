Return-Path: <linux-pwm+bounces-2173-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E658C656B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 May 2024 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B681283049
	for <lists+linux-pwm@lfdr.de>; Wed, 15 May 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C9679E5;
	Wed, 15 May 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQOPIcl6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0157CA1;
	Wed, 15 May 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772043; cv=none; b=Od/GvrAPLE1sZ7BETtjHe/G2ylHZFvHGzx3d+zuxWJnT9WSyMYQzozBp8sZh1i7CKyu4/30qNTur06zX0vzrmJa2AWtd3iEFnnQaw8CEXjcDbT7BGQAHmJSxEp1Awq5f3JBVe6cehbP8MUy1N43WgPPtWKlE/dQQPQ5p0PGGO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772043; c=relaxed/simple;
	bh=qQ6ByqmsI87UJ6a1/Qsz0KjSGLTYGPe8kDGDKnT6Wsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jE4t7P7E4lhyMuXrfqdVPtaeNCDEYVeAm8ULd646pztKOlYnD6lC/gVVbYPuIgbJDGr0IGY82Ba3WAAIxuhNfRl19qGzR8MAL25jv3xRMH05MAEb7HNGa2qCU+RVjEHGB77VkYjST5MbI8ssvlZMrXO5q83X+7PS++r1Pq1+AiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQOPIcl6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so3509437a12.0;
        Wed, 15 May 2024 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715772040; x=1716376840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+m06lZ+9mZ5s12obwPdLvKcWcqk/GTf8FG1sxmRcMtU=;
        b=RQOPIcl6JtusjSyaxRHYDlIRB5zMuxSf7v2gL/iNoGWo/kEaH1FgXNXRmYfzwMJdrr
         XCkUnRtoPvouheL3gE6sBHBO+pk4lCQeKTG0sKB2kGfFU8gDDaDsVZAjK4c2sNIufdAA
         BsVpPXE1EXP46j1kFuZGNWivAHtGVVm0pNTIYmSWZFD9dKAFhjwUoFppQlUEbSgURcdN
         eiqIiOaN/f6/c+KdLImCmzei4SFcuT94wMYd2OC+Hc42JXTwN+LSWZRedFYpo8pOBlzW
         S3AZ68/IlJ98Ie/8241if0uCmnx2O3ZL/lBTRAnBxxtO8NtS2qQm7A/Jemquz/iOitX/
         2hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715772040; x=1716376840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+m06lZ+9mZ5s12obwPdLvKcWcqk/GTf8FG1sxmRcMtU=;
        b=xUpgovtTA45xD7IGHEt22U8zv81NwSvN+8iCO9xrORcsBgjatl/S2+MaVekBATvjWS
         PHSXljpPAH4JfjKixXGABt1808pucaAT9sFJgnCbNa36wILM+WPGNQg+x5Luyy1TzSfk
         nPAijnGBEcI06qM7juR5/NrwlkV18ZoHStKr3/m/fsORP96CNMG/ecedKQbMAWzNzAQy
         xZB1putC4PyJv4sJofXLPUZmLOIkYR5xYZr2rzRHZfrkmunUDFUUkq7b71CKZf3B0eKx
         Arur+YWJM0MwSOhHb/7CL/Iko+ZibYbaTuNsj4cxFUFakAhyqEWEpSufMudxmZxCc3An
         9FVg==
X-Forwarded-Encrypted: i=1; AJvYcCURNs2A5APR/5yix+Ta78FwtwouRd/WfsbpMyJTo/+fI52Sj34jZeCPI54BfEzu8DRqX0gllDcg4G/vJSIa6xAJlNUFlsfEy0iNlE1lKcYMdD/9t1r0NqUaoAnDLDjJp8z/Ht5/bH1TbD6zBZk/i/JWm3aNzG9T3lf4mROqG7eWsE250w==
X-Gm-Message-State: AOJu0YxM2MD3nioZlj9wrNmCK+X4mbqveunrd7ZnsNjDsWJ+yCH+Mg9j
	w3OkdsA7u1wmr6jEMj1ns15SqM78JsJltaTwzU8jJUBW4hcp3gpV
X-Google-Smtp-Source: AGHT+IGGrjPYUKCf6+BOtL9koMPG1xnm0qrc4o1TtWFemS/d4pZiF9rPdsuiukxqtZL+9UAS8m83Xw==
X-Received: by 2002:a05:6402:1803:b0:572:a4eb:6678 with SMTP id 4fb4d7f45d1cf-5733294a944mr15206998a12.19.1715772039815;
        Wed, 15 May 2024 04:20:39 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb331sm8847633a12.67.2024.05.15.04.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 04:20:39 -0700 (PDT)
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
Subject: [PATCH v3 0/2] pwm: add support for NXPs high-side switch MC33XS2410
Date: Wed, 15 May 2024 13:20:32 +0200
Message-Id: <20240515112034.298116-1-dima.fedrau@gmail.com>
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

Dimitri Fedrau (2):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 +++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 410 ++++++++++++++++++
 4 files changed, 541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.2


