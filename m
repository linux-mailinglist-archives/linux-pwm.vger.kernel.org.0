Return-Path: <linux-pwm+bounces-4874-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E3A33B5F
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 10:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF53A5449
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88C20DD52;
	Thu, 13 Feb 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkiEtYVe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DE20DD79;
	Thu, 13 Feb 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439654; cv=none; b=NT4Zsx/OvRc/UyyZPXYBDj+Izer32dfIKlYgCD1f8FImCe+RsqKI33/FOdMSV4GpxvCYPNUTE6JTi3UM/NOGyLdpw5GlNvnetv7bDjwgDfosGX35wAZ14X+a/DJO/s/izWyUrWORFy2eE5s9ycwRi9t5QBIRyuEyJC4Ue9rYvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439654; c=relaxed/simple;
	bh=3Ty3TZPngzI8ImKj+JMeHI8wX24fjwqqQ9y/aUKCUXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tztjl6MRVB+FVYyFUGuVr/gkbv9UZeqkUg6Rdjnaqc8d1kMH7twVKw8agK5iO7AiME8eGguG1j8Gz/UKHIQTdw8mYPSESJfaCEq1LVsgUSS8r8mfZHqyfWc3CJO8zAddoNiL8XmqsFrE86BhLT06q0efFmlvkreVsnfYNIhGZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkiEtYVe; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fa7so6798291fa.2;
        Thu, 13 Feb 2025 01:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739439650; x=1740044450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjlSL/XILbi3kwKJAgYk9svt+oaypPyLoMPUzXAfvac=;
        b=EkiEtYVenLNkaY48Yw1LquMh4AMUSfa9P27YEjP5oTNBCA4d3merll5U5/6eoMx5Ql
         a0WtsnFHIvBD0Km9K1q951Hw+yfI3R/n3s4zd4fvKUeD/PeIvy85i+OgGu1dJWh6A0j0
         9Puu6vm0uIt2GuoxBjymM7OQgrRHc8452DgmcUUgF/4xpbDgLlke9ki2Ua1ifTtPXLeN
         N8+Pwits9n9e062dyl/TtLyhFtoPzAph4GOhY6bHFZXdpSDpZHY7zDxFgOt/K76JvT+h
         thh3nSV/+zp5xcGcSp7ew1UvEKlQHoJcEP3uCLwY4IxDDJYfG095IblI5BBG8ouNITw2
         Cc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439650; x=1740044450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjlSL/XILbi3kwKJAgYk9svt+oaypPyLoMPUzXAfvac=;
        b=qn1MKj7md/GXDT0D+r4nI2OcsdbvLs2m2Bv1rjvtrQftZF1s4/q5aiF3FcZbG/sNwD
         khseq4XgNvrXQ2s27ZjMRmgqGMd8ryf3MKA/l8ZbB/YAaHT8R0UaRbeAx9PIO4JPHtzi
         lwY6e0dgUp7ntITGkf4mcikpxb9cZKv6AqYnqVX6wFDN/mDSnOL7Wmf/5xnm234JwvC7
         bqIDfxoE9nJSk1vJWihHyPpBv8WZwydrFkNatdNGBtneP4v7z6OTnhBtWWDX6FsvO3Bj
         Ij3JsA42FqtuDYYISi3mOy/aUf411JbtqN7H/Pj9JUrVjgoGUpAT6+VxQzrV+UR5c0uU
         7rzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsxI0+hHGs5MuAzDYStPM7D/aWGhK1SK6hQay7Ovd1kEtzMIszX67KT+bPssirKEffNA5HEzURUGSR@vger.kernel.org, AJvYcCWeXqS07r2rlqD0pYVOshrebdl0zi7PdM4da+zOD0+VsZ4Dr8rwNxtKwV6TrDjYiBfMr2vnOGvtnH45@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1KZr04RoIpeHuOB5PwAP/Lg+EKdkdwq36ILlu/orCytD/f9e
	2JoVO/zC4p8nLFgNvRnNPoC6v8Xv8G8joFURZ2K7cvE7tF4pLkeON5qoZLRmQbAq
X-Gm-Gg: ASbGncsHjX/mUiFyDgHDJrRioV8lbMyOROgXNwgB/AVevUmit7qFf139mPoSazFjobR
	5YLzRic1t48opdjMoXrJ8awxMIfnBREmK4D3qnfBH9AFN1PsKdv8NZopBhlE8OrbRTWs/ObFeWE
	hBOp9OEjzl3IKmRCd8wyHxyJXu7T7s1BlYsCZdAr/pOU+d8p8t8n87vmPRJYKEhVbH8bqJF4mmm
	FxL4cWkkPjNyWqTo0AO7k+IWk9/bjdq46qjV4LhNng6H+iSckwE9IfIgN/ZcWA9rlWo0GNbrkcg
	Z60vC610hAluoPb4rbfoT+57iywJcuc=
X-Google-Smtp-Source: AGHT+IHvr3T6WF3qrEPOE/ncpkXsxhpveENebSm/95rH45l46XCcOYPEGrJRKlNkH6Z2V9/FiQs2Ew==
X-Received: by 2002:a05:6512:3e14:b0:544:1093:ee3a with SMTP id 2adb3069b0e04-545181165a8mr2484582e87.24.1739439649595;
        Thu, 13 Feb 2025 01:40:49 -0800 (PST)
Received: from localhost.localdomain ([178.176.176.188])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cae7sm119518e87.183.2025.02.13.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:40:49 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Thu, 13 Feb 2025 12:40:11 +0300
Message-Id: <20250213094018.134081-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

v7:
 - fix a remark in the driver
 - add maintainer

v8:
 - fix compile driver for 6.8-rc

v9:
 - fix a remark in the driver
 - fix dt-bindings
 - rename apb0 -> apb

v10:
 - fix a remark in the driver
 - fix compile driver for 6.12-rc2

v11:
 - fix a remark in the driver
 - fix compile driver for 6.14.0-rc2

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 370 ++++++++++++++++++
 5 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1


