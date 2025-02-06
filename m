Return-Path: <linux-pwm+bounces-4802-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C6BA2A815
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC06161A1F
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7422B597;
	Thu,  6 Feb 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MfvZ3Tlo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257018B477
	for <linux-pwm@vger.kernel.org>; Thu,  6 Feb 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843608; cv=none; b=Qf/DFrQuyuBlhHdXdPXwkOWe5vSlIdRXnUjMCjRgKHPWb5CYewox2v7d8S0sQx899kud2ZUUDLq82bI0KO9VcTUK2Bf9q38Qcyr1Dm03sr5/2ZBUsNG3Qhtkbp6d7JQ+nerdoE4THo35WDqMuN1ZHImHpddFCYbmAcLoeV6uS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843608; c=relaxed/simple;
	bh=P+DmhZ5fsqW2fWssaaB0vb1pG+aNe17OBNu8J4YPM98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AlgZeJ88ZKIZfwchI/9OwtGR65ROFYPxkvwJsVYR8SmV46HAmpQyVvpv6yEhyY0XxoYWp22yP3pMUAJKt8/emw2aGavOtrW9BcU2emeVrrbZYc/U1qn6ascArrU/Mt7TRgVswjz6DiETVUOo3odoc3O56ceM+4bdAZM1I4WDV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MfvZ3Tlo; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab737e5674bso161692766b.1
        for <linux-pwm@vger.kernel.org>; Thu, 06 Feb 2025 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738843605; x=1739448405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGdBF5amQn6183NcAyaMY643bdra7yDi7L3ZDBI8C9M=;
        b=MfvZ3Tlo9CK8rY1sHUtSgNL45kqRdrm4et2R4BVIoeBhVNwBuR4YUnmiYVqiTAw0QE
         n2KN2RNq8Z4XSH5NqoUJorEXQUXuAFt8TwNF7eHZXbPAiLi0c0p8NLWP6B8VIxKU9Bac
         ukzkWq+u6A5JSppKh8uon2vccWwMx/KQJLcso/QRtK81zW9tDimTo2FV1mFwjlnGW+am
         cstdraKmuf+u1DJmJxzFPVCzE5H0LhDa27NXxYQ87nxVJ8YBDifv4/juvq31nUehJ0LR
         H8TGj8r110jbKFseAqRAqfBC6C/rvYMapu/AhpBLQ5AhAzccpCZohe79kMpryda9Il7p
         zXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738843605; x=1739448405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGdBF5amQn6183NcAyaMY643bdra7yDi7L3ZDBI8C9M=;
        b=NYrZVWZ6588F0L5HBt8+073Y//V2GarptfFxW/KRN+n+X2iN2WDnI66y87zeezxY7+
         Ny6iiYLHHrgtpAGMvCO+yWft6jGHgu6CGtllTFeTEbmv19/MVOhetETh0a34mkxVroIS
         BKRtI/HP9kqBP9qNomNRZZjbigZXUcAlEIhgS4+poDEGXkDso85Tuty3h7qRz0WC85P8
         4SRIQEN86nSf+PDZ9+l7MppmunkRst4/FdzNSJJ5Akcgrx1ip9B0a/lPrwDLW95JZ9Qq
         8s6kBTeXl8qhnPmvF8IEqsmj2dSAXGyhbVZ1go1Wqo37orkIRWQ4ntQFzIj5iA/nLnTo
         4L7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc6Vp2B/JAIpWCheoYFrQEWGkBtmAVF8H0ZoUJQRFUN9O2wuUDfCo5NWBjtSIjNWBHkwkkYcvSjHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmVT3vE/HvfJlAsgs1U8+GMCE1uTcJjw+b6A+bClS8KyZefOR
	NEog4yvkf/29DmZvRK0wy8NcogBXo6kti9KGeMqyVaEZySCrx7Idx6fGT9lY7KM=
X-Gm-Gg: ASbGncukzDjlCZmzzJBVc0G5ii5uTYfwemB1on2sN47NBDj1YdJoux4AOO8H3bISVyB
	NKhMm1F1PdH5rZA6qRu9Kbo/nIEKbN+vjW0rnhUHprC7PFhKzbk1RPtyRFElDor/f+aWyOQz33C
	MXz/h7+C/uuaXvVaua8pf4EG39HliQ9I5SmUz5bcAfdrTrWK6u4ao43eH8X+G5G0yuYbbXp40Pm
	wo+mX8WJ3OCQCqRzzLUh9lvOluqGHhZslK2Wee4UxX95vXS8ZE0zy1iId6rrABvc53D4uwJsFnv
	Cm8SDS3iw1Y1q8NxbmxHeN0Lfq/rCf/2/M4s11BWkLn8TlaY43tvlcoc8w==
X-Google-Smtp-Source: AGHT+IHr/BfZzmlAYdHkONK5DIkNc2MOki3sCNB0+BjvRciFMqB5iZ1wTz2F8JJQatrKAPl5mZWCuw==
X-Received: by 2002:a17:907:6d05:b0:aa6:6e10:61f6 with SMTP id a640c23a62f3a-ab75e322b40mr566158166b.52.1738843604642;
        Thu, 06 Feb 2025 04:06:44 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7089sm90262266b.95.2025.02.06.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 04:06:44 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: pxa: Use #pwm-cells = <3>
Date: Thu,  6 Feb 2025 13:06:24 +0100
Message-ID: <cover.1738842938.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=P+DmhZ5fsqW2fWssaaB0vb1pG+aNe17OBNu8J4YPM98=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnpKXAtvNUKlDIiKRsWNc4oyxCFo6Grjdo842L2 udPu4gsGnmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6SlwAAKCRCPgPtYfRL+ Tp+9B/0R1HkHEHRU6lkinzAWJleWmmSCWIyIEVGQG4zUoQtf/j5DA0sacW/x5ONM9h62C/Kw2+y +0qbisvUZZia5cZwrm6U7p8g5rXBzXUrIRRz4fdXbKoLRa8mPOAtbrzAx0O4DPVvmfDjv/ezG9O KyJ/u7oU/x1Zl1DoIdSJ7mXZ1p5jczi1/1I5d7cy1C7NNdgQn2290PTgXIoq6N+aSBOcgQ1hxRR PPLThy7HagPJmewucOC9xEL3EQWvsVKO7vo+OLfFkvujO6IgdZJ5bpxYvIP5iIFUsF497yNWOKk BbpVuEQ5Ep9aEgIzUvWwN5n+ZtqJLzLT3Vfl8E+YQtezJviW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series' goal is to soften the special device-tree binding of
marvel,pxa-pwm devices. This is the only binding that doesn't pass the
line index as first parameter.

Here the #pwm-cells value is bumped from 1 to 3, keeping compatibility
with the old binding.

The motivation for this was that Hervé sent a patch introducing pwm
nexus nodes which don't work nicely with the marvel,pxa-pwm
particularities.

Changes since (implicit) v1, available at
https://lore.kernel.org/linux-pwm/cover.1738777221.git.u.kleine-koenig@baylibre.com:

 - Use #pwm-cells = <3> also in the binding example (*sigh*), pointed
   out by Rob
 - Add review, ack and test tags by Hervé Codina, Conor Dooley, Duje
   Mihanović and Daniel Mack. Thanks!

I intend to take the first patch via my pwm tree. Assuming the pxa and
device tree maintainers and bots are happy now: Dear pxa maintainers,
please tell if I should take the whole series via pwm, or if you want to
take patches #2 and #3. If the latter: Do you want to delay application
or should I provide an immutable branch for patch #1?

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: Add upgrade path to #pwm-cells = <3> for users of
    of_pwm_single_xlate()
  dt-bindings: pwm: marvell,pxa-pwm: Update to use #pwm-cells = <3>
  ARM: dts: pxa: Use #pwm-cells = <3> for marvell,pxa-pwm devices

 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml |  5 ++---
 arch/arm/boot/dts/intel/pxa/pxa25x.dtsi          |  4 ++--
 arch/arm/boot/dts/intel/pxa/pxa27x.dtsi          |  8 ++++----
 .../dts/intel/pxa/pxa300-raumfeld-controller.dts |  2 +-
 arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi          |  8 ++++----
 drivers/pwm/core.c                               | 16 ++++++++++++++++
 6 files changed, 29 insertions(+), 14 deletions(-)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.47.1


