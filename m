Return-Path: <linux-pwm+bounces-7284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA0B51D07
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9025A7A8BC0
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2F32ED31;
	Wed, 10 Sep 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo94Pf0i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A932CF9D
	for <linux-pwm@vger.kernel.org>; Wed, 10 Sep 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520445; cv=none; b=Rp0lYTyfbADE6bGFoN930LGJhdYRP83VuhZnEM/jd22B7J7uIGwmnfgdN/sVDVZqbFbCdiAd8O/vNr9W3dnISOUyN7GIfmzzbPwB4VdZzl7FqP6/0ydH2zDb2hGFoe2NgqPa5wsOJ8ZR8lmHiZh2AhoxYy7pvHhdIUBU6+xIh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520445; c=relaxed/simple;
	bh=9JM8zXnpGCXjAshCsShUwOSUA0HzjprAbIs3oGMpa2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XUOgt8vjjFTHrdbVO+TqO5qcOMI8PQJ1uWVC3vu7rs/fCqlNIMzQBEd98Nc979EFzhlKUNSUVF5WOtHplLZ45FnDmsfZdPF8kOcal1xq48DlvQwWvqbkDt7Ib0GGyOSidkcrp0zkYMGErc8+nDmqt8qXmHrQCoGU6wEZLO+WFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo94Pf0i; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04770a25f2so978942766b.2
        for <linux-pwm@vger.kernel.org>; Wed, 10 Sep 2025 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520441; x=1758125241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIxXSxIMQ3326DXwyl7d19buZ73lRdljmi6FSs0+JJ0=;
        b=lo94Pf0ivpehjcbLmUd/EHc8VdIoX/egmiqUSTPqyn2St82q2ydV44OvJQ0KYDxMWx
         7H196cT8i8v+aL8Mrpz7F3yImVeKZ45rOH5WMTV+7F0yeZ4Lax0MCEVVTtCTd7mmQv75
         LP3xYedFas+tozpkVVuZ3YQOPm5g2vjT9b9Dh8dMohFrBXiV1MQPmAKAKpNe7Vc9S8j8
         rfwk31mnF1lkW+RXPGw23kk9NXe1Gyrm9G3AwAikwhEZizkitTBlnw3Qy/Wcq7sO9oev
         xEXDAr+3bAHJnGalsN10Yta9/UED/eBSk5Pw2EuwGje93eO9Oj0S3FPjz3TnudUhB7lF
         JT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520441; x=1758125241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIxXSxIMQ3326DXwyl7d19buZ73lRdljmi6FSs0+JJ0=;
        b=j3E/jaCefWOJHYLSazqkTSooUsm50DCeTvRLIBQ+LU4x0+1i/25quBOu7ObuKoBhQH
         A1wOf1Rt64+A4JylUjFQhT4CaJiOMy3v/a+3Z1Rx9tHmT4P1SqFP6mNstPtB4775+20o
         f2dNJ/A/FKf9YgdhyoemDPrIhbbvJ+MPDJaXK/i/shfdgH1/MZWXHNCYgEFt+1aWffQh
         hSG+vfeNsEazUq9wAGpkMWdUIM6hfwHeNJCrOfcNlylLmcsS5jMjJWXGHwwqpGizEvtm
         l37LfY6KyJgPHL9V03n8IIVXjSJxzZWDTOzTzOw9hKuV1CfGOWTskXFkH8nr4eM+eds5
         1RNw==
X-Forwarded-Encrypted: i=1; AJvYcCXDso1KOoDjM7dtaEHwuvUxB1y0bABGRa4rVcemGAwiFZdDDA1/IccxGRWbCYS9+3E6Gc9WZZODIqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAGCMvppTrJ1JwBN+QB1qTyKwFSqfv8fOaI8kcDE8+jBC5cZf
	605ql6HRjOHFjNN7WcpvH3CuAESUNOCttYrWATuiqRpQyMOa5z3GF4o=
X-Gm-Gg: ASbGnctWtzVroJVObqhC8kjMj+qlj4LJIGMN27u156piKrwXARbreHYLSbtqZaY3FzV
	GCr2H2CLE0UvHCRFmNKOoSEsMKUMMehp6EbkcJr7tKKOqc/hvoBBfinVxX8ywn7YQy1Daj+RkCi
	vXpSUZreeINC01gCjjCBMTsFgA7MvqpLA9gbZ585mJ2K1lCw3OE2BlwCNjPFghQluEFXcpbMvDb
	mGxJhpO2wedaooBrIEwAHXvxvWkjq4CfaNTf54V48FPkagBxST3hnf4E/PTWD1ZfflRDGlh4vhG
	KJg3z3Yq2KpyAbJYCpVV7zcSvPqH2afSpGma264YqQIuZEmcyCX1IqVjLN2Zima9mmZrk+Fe5QE
	qXoE2FzcaV4z7glVfsZdC/XNDr5FHhbHt6DAeF6Nt3fPqRgeeNhnO82ntuPRtYh6qO0E=
X-Google-Smtp-Source: AGHT+IHUnlYKS+LJGenEhgjXAoecAwaDL0J5OwJwpWMxJCRcFIpXNlW/vy+X963BIZzpFhsZr8LRZg==
X-Received: by 2002:a17:907:2d8e:b0:b04:563f:e120 with SMTP id a640c23a62f3a-b04b16d641emr1475440566b.53.1757520441048;
        Wed, 10 Sep 2025 09:07:21 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:229f:d114:32a:5671:8dbf:7357])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783047b9bsm189424766b.13.2025.09.10.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:07:20 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v7 0/3] dt-bindings: mfd: twl: Consolidate and fix TI TWL family bindings
Date: Wed, 10 Sep 2025 18:07:01 +0200
Message-Id: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This version addresses a final piece of feedback from Andreas to make
the twl4030/twl6030-specific child nodes (audio, usb, keypad etc.)
conditional by moving them out of the common block, which now only
contains common properties (rtc, charger, pwm, pwmled..) ensuring
the schema is fully accurate.

The complete dtbs_check for this binding is clean except for two
warnings originating from pre-existing bugs in the OMAP DTS files,
for which fixes have already been submitted separately [1][2].

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>

---
Changes in v7:
  - (1/3): Moved twl4030/twl6030-specific child node definitions (audio,
    usb etc.) into the conditional 'if/then' block to improve schema
    accuracy.
  - (2/3 & 3/3): No changes.

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

 .../devicetree/bindings/mfd/ti,twl.yaml       | 232 +++++++++++++++++-
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-n900.dts      |   2 +-
 6 files changed, 223 insertions(+), 95 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt

-- 
2.39.5


