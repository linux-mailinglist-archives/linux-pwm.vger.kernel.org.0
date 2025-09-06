Return-Path: <linux-pwm+bounces-7257-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85FB4719F
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02735811AD
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383220E328;
	Sat,  6 Sep 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOr2KTzj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356151E5701;
	Sat,  6 Sep 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170801; cv=none; b=iENe4ptfEfv9MeLPVwIsbij1GYjvSRuthVpuRkofdSCK0f1INe9AxvudoQDKxX9gJqP/18+Ju1kz4I2sEyJtN4spTMBpocrl3q/JBRfwRp9mmC3/WtEEk4/TWx/PfFQFFQYg/srqgO1QUyM3ftrbYyfm/bm+hPBdf9QZn6l9Nbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170801; c=relaxed/simple;
	bh=XncNrK5kT8meDtQO8JNmHnftDmoaeTD0I+F9yFes8lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PwBmctSJhOT9ZvtdV94JYTHdBjLcbr68h6DqrlztBPfqA0502M3hDQsmAnRCXFNYAFaKrV8U6/h5B0V0Qa+K1H/RZfoKzeMPWa/nuPVP9uoJ20ebPgY/L8fGrGxPfV3wXp1Wm3FFN1BrZL4Ik0YGhHLw3TqvysWc55oQ+BggXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOr2KTzj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so2838859f8f.1;
        Sat, 06 Sep 2025 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757170797; x=1757775597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQtur+J2AJTC1Awcz7aDVAZ/e2OJSwAAO1Rdfay5zx4=;
        b=OOr2KTzjRESV2ahH3Xdl8DpV/Jik3f8pTLCO/Gf9U57ZOx4YVz9TJfFvMzG5Hq9Dw/
         FUWIgkeRsvmPbnme1gpxPlnBzw81tyTW+kA0HiG4bVqlusRmuHUnMxiQOFccNGP5EAWr
         YYf6hh5MmN6SJKY8HO5zCoBOGNyy3RXIqUgzFII5xvfNM4l4mvH3NaCe3R8wIcncoXnM
         UMKHSd7g7f8MyuWhob2Bn1w1cY7nX4r9UJctH4H+ILhCrhM32Qdy3q0RM1iFlLAhPiSC
         IvxvBoExK4LaFfdza9L4pBZ6a6S+7RrEVFOSKPNuxxwsxOOYoyWaodwwTe7FUw2dVcEp
         A0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757170797; x=1757775597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQtur+J2AJTC1Awcz7aDVAZ/e2OJSwAAO1Rdfay5zx4=;
        b=mtPg7beWPb9X5m+0WNNpeTpMPt06Yki2fNMHKHcoiarLTldh+XN+aooC8juH8/Eev1
         sOPQ5BAshrNYGSzYej+mNlQX/LQB4y0wtVFpTKA5Y+8Eh/rFoffwUWjdBfIciqjb/8uG
         tkTQgsIt44OSBNEYkRdBL3PIVUnX6xMjvVo9cf5EmRx6LbgjOLt9+gDQEUc7kFeOjnqR
         HwwuLe6JRCSm6kebtQcL1siGBC5wy6cb9IAyik4+5qlRSf+5R72hczz1ABXXNHxCXaV1
         WgEegnowEskYjb5c/dgEgTbvF6uRFiGQ0H/vYUS2hmtviWvwm5WiVGdQgvgnTuYfK2yq
         pDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUsgB+7oJDRbSHMj7is0708pJkH/WtD8ZKaX1TcOlH3GIOb2edvNdnGU+gt6++t1zGlOjKRkGPHE8EIw==@vger.kernel.org, AJvYcCUaut+yhuhw73w48LMknRxY07TXidn7/WRPRgx9pYtaNcSvIUk5ByT4F8ZxU++ey5WkMc+SWGX1dMq6buEM@vger.kernel.org, AJvYcCVgiCv8cqvka5zzfTp5aQOJh/bFN4V4/GCml5ihAbpzspINzHkniHXCR4X67olMcjIYTjS9e514/x5q@vger.kernel.org, AJvYcCWSpNiA53E9kguApI1wNmCDiGVc7QwfrQpIuBhliiqlCbAeUVx0CUQimECVo/Jy/2OG+78d6GYkcCeM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5XMaIskqOEBtxDq9LbmKBrI0JfGdbNbu6JO002SN+4ZFBkn0W
	ebbCM8hHnDjjXpHCzfO/cfb/blBUGoS9fo92s8W5g+jT6c1ES4rqXw4=
X-Gm-Gg: ASbGnctQOQXVxpRKrPHbsE/5+TLX+9wRBDd9IQj9+yrvXKJ6NDpXExwTBJTpd7yVzUL
	IDAh0rCPuxfumQ40cjKAORWy8vu1DC67gGQNmkh9e4uB5qZ20IpphVXv3yrD8pJ3QwXn6gIjiDM
	XgthR3Zk8bdwdsi4X57gSxvGpMrfGd48mkWMDpVO4zLze0CVgrBEUZPdeO01LcuuY5MwifVOJm2
	UKO0Wk/A4SfylghhGkkLHuVVxxOe/ux1agBUSeNUHN652ijgPHcpGu2Rj0YpXgpUw98EmPG/ofD
	NGqYE5slJSNoeci9DLkRzcTenF/z54qsg7v135JZ99dPCUMEKJPXbVb8C4r1XpNaQ0OqEocuNHM
	PYkmH8wBNYZRMnmchpHPpcELNfdYJjR6kMze5R9Oe7Gd7i/g=
X-Google-Smtp-Source: AGHT+IEs9RATz2qgLuJA5chn4JXaeYgqNLc630vWFgxHwxIDhFUvnnJzs/h1dP2JZIxOXl5NODbOIQ==
X-Received: by 2002:a05:6000:2907:b0:3d8:e1de:7e77 with SMTP id ffacd0b85a97d-3e641d46744mr1684604f8f.1.1757170797178;
        Sat, 06 Sep 2025 07:59:57 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:143f:cf9:d8da:f38a:fb6d:ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm35106544f8f.50.2025.09.06.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:59:56 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org,
	andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v6 0/3] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Sat,  6 Sep 2025 16:59:02 +0200
Message-Id: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the main TI TWL-family binding to be self-contained and to fix
pre-existing validation errors.

v6 key changes:
  - (1/3) The binding file is updated with stricter rules for the
    twl4030-power node.
  - Added two new patches, (2/3) & (3/3); The beagleboard-xm & n900 DTS
    files are respectively corrected to comply with the new binding.

The complete dtbs_check for this binding is clean except for two
warnings originating from pre-existing bugs in the OMAP DTS files,
for which fixes have already been submitted separately [1][2].

---
Changes in v6:
  - Refactored the ti,twl4030-power compatible schema to be much stricter,
    removing obsolete board-specific compatibles (-n900, -beagleboard-xm),
    that were added in v5. The schema now only permits specific, valid
    fallback combinations.
  - This series presents two new patches (2/3) & (3/3), which update the
    affected DTS files by removing obsolete entries.
  - Enforced the presence of the compatible property on all relevant
    sub-nodes by adding 'required: - compatible', closing a key validation
    loophole.
  - Applied various formatting cleanups for readability and correctness.

Changes in v5:
  - Restructured the entire binding to define properties at the top
    level instead of if/then blocks, per maintainer feedback.
  - Added specific compatible enums for new child nodes instead of a
    generic 'compatible: true'.
  - Set 'unevaluatedProperties: false' for 'pwm' and 'pwmled' nodes to
    enforce strict validation.
  - Expanded 'power' node compatible enum to include all board-specific
    compatible strings (used in existing device trees, e.g. OMAP3-based
    boards) for more complete coverage.
  - Corrected the schema for the 'power' node compatible to properly
    handle single and fallback entries.

Changes in v4:
  - Reworked binding to be independent and bisectable per maintainer
    feedback by using 'additionalProperties: true' for child nodes.
  - Added board-specific compatibles to the 'power' node enum.
  - Added definitions for 'clocks' and 'clock-names' properties.
  - Renamed 'twl6030-usb' child node to 'usb-comparator' to match
    existing Device Tree usage (twl6030.dtsi).
  - Fixed some spelling/grammar erros in the description.

Changes in v3:
  - New patch to consolidate simple bindings (power, pwm) and add
    definitions for all child nodes to fix dtbs_check validation
    errors found in v2.

Changes in v2:
  - This patch is split from larger series [3] per maintainer feedback.
  - Added missing sub-node definitions, resolving dtbs_check errors.

[1] https://lore.kernel.org/all/20250822222530.113520-1-jihed.chaibi.dev@gmail.com/
[2] https://lore.kernel.org/all/20250822225052.136919-1-jihed.chaibi.dev@gmail.com/
[3] https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/

Jihed Chaibi (3):
  dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
  ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
  ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible

 .../devicetree/bindings/mfd/ti,twl.yaml       | 221 +++++++++++++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-n900.dts      |   2 +-
 6 files changed, 212 insertions(+), 95 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

-- 
2.39.5


