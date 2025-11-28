Return-Path: <linux-pwm+bounces-7709-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F6C906FF
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10A73A9E70
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F61D5ABF;
	Fri, 28 Nov 2025 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5uYO8MY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F513C8E8
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290262; cv=none; b=k2iAScuUyisV1jTtsfq8wzwy+fYpusN5deQ6Mg7m0YvxqzNrxT+KHjyWbBv2vCryPEUdBKl+qPHbdvulROpp3Fhwk1OfliWSwIqmk6KNBrHUBD+6L3eXt6vhAUARtSO1txDoGaYYOjMPPK+7RD35erDFgsIlsoRBOQsrHuiLscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290262; c=relaxed/simple;
	bh=sUyq3T2oxKmWwFT4azP6dPaoBFAeNxdOs4IqxtPE7HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXbIoEAkIrzJi/GXGVXJEeOYoue78vbszOY3r5o13p7pZHjiWXoJz1S7q3WuIsTdkcJHZ8QiUJKr6XXanCz+yQJN/Hem45X9anFN0xaR2uaUoJn1DSBtDSHs5LO6yjIE9Y6BVArWPk/9BYcLYUZlNCE8Gn8Bno3Sb69AEg4xlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5uYO8MY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29568d93e87so12888945ad.2
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290260; x=1764895060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVDdlhjVYJNPtIMp/DdZWUPiFL+OKt5H8deS+WOtPgA=;
        b=J5uYO8MYUkh2aSzPA7dPCvb71OzVdrT5amAQSf1Jcz70gVGiT1g7Rf4Ze4PvA9mXto
         RYgiMR/7ZsgzecE4LunrXc0Oy39IBiIehnEDWarLYv/Rv1cDe1VYLpvfBOCrXU1PDaSN
         cEg6YbE+bfjOOsJOhFWy9+h8AJoJbvmjZnGXtKlcG3pSXEzvHY/DmE5G2RexUekHSAoP
         PwJJhZ3l6lh7MCKOEYoB2KFxxiF3+zASMM/hT8kTsYVISQ+TGBYIs7cGFLprB0Xo8A3s
         E6r58Qf6sCCDkCFo8vctp6v+Bols+tTuDpZ4Zp7zJwKoGBA2gQjCAhYvzHOppHKKb6T5
         Fg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290260; x=1764895060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVDdlhjVYJNPtIMp/DdZWUPiFL+OKt5H8deS+WOtPgA=;
        b=VUn7u2/U+eJDE1sNtGQD4GKHTeqCTAo7vw8fmDNvCDZFgUpDIXTkcIONYkYZBSoWcO
         ukDmA4/MX0NwcIa22IwcVJ+1ayxV9I20UO+OTq87eUnleo8iPWech30rD2DtHa0HiNKh
         uPpuMHfLNofduHeP9Afyqes0zkhZN9G7J8SOSlS69jfiyK1wb0tYo1/b9sZVhS1FzqUk
         JpBW6Q51LY71SQwfKgE8ANz90fx4/Cf7MSDZOYFKZCKMl2vVtDAUIvObitW9Y1jS/0Xk
         wfo6QiglmeSfGLi/XMEnpqAfYrkBz3uFbnFHUJHoOHz1p/6QiPVisBUsZWP1wq/8i13Y
         bRzA==
X-Forwarded-Encrypted: i=1; AJvYcCWipQNKuV0xon54G5pCjTwITXk4BaBSj0kAnTSF2SZwWbqDrTMtu/DObKc6axIiE6ziNv2NJmrL4s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0B8DsicuVi4OyAWZ1QGcwUspQ/JVgHO5+NUCscgnImbro57T
	W6sy8NiUT40Iz2PsKkLvUjX1ofu+etrEU/BX9NYPSvwIz7Q/gtCM32QC
X-Gm-Gg: ASbGncsh/awP5vNO8tTfW0DcBcBxaHm7YQS7nW/fkvHu596qt2wT3YevSwaoaNZDiSM
	IO2O1QB4kK+PdbjMvGaJ0JgaHiECwE9ZUc1T1QjAuPwvXeAAbfnSSlvoBCbagweR2MomPfeziVb
	MahsWppu+3QACMXZ62HVVcj83N00Ebi8rDjfMVWj0nUJqCdlPlyRGzhTLGm5q8CkouHZE7mH5Fd
	T9mcN/YLLf8B2aE1Q4sKHu9n5FSAnjb1ajNlCnfsM+TR+6kAi9LdivT43HPwgPDUT0qH6ROg5Fg
	0G/+YGzYcCB8U6ZClFqKMAn3jic+2yayBwVyCf2/bO7eUmPzm7WbtkWPHnl4Tc7Mi9guGtM/X8B
	ZalsMfLx3v2uF8xRxTQpj+z5UhDRtufdkfo61+m7FlQSymbio18LvGTa48ZHHW453Ad8MRvYW8Z
	+7aymEmVzn0Jgwep9HPQT2NjoUMLqK8Vs9s+aDuYA62vQ=
X-Google-Smtp-Source: AGHT+IHm/izwB+6cKA4dhoB2LcXI1o4qN6BPFz3fsoeLNxKGy8lurHbzbM9Q7uBqcdN6/pD0VgoehQ==
X-Received: by 2002:a05:7022:2201:b0:11b:c0db:a5ea with SMTP id a92af1059eb24-11cbba53024mr9827351c88.26.1764290260045;
        Thu, 27 Nov 2025 16:37:40 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:37:39 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 0/9] pwm: tiehrpwm: prepare for waveform callbacks
Date: Thu, 27 Nov 2025 21:36:25 -0300
Message-ID: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

in a previous discussion about pwm-tiehrpwm I agreed to rework the
driver towards the new waveform callbacks and eventually drop the
legacy .apply()/.get_state() ones. Before doing that larger conversion,
this v7 series focuses on two narrower goals:

  - clean up and regularise the register and bitfield handling so that
    the driver is easier to reason about and better suited for the
    upcoming waveform callbacks; and

  - fix a bug where the driver assumes both channels are
    disabled at probe time and does not correctly account for channels
    that are already running when Linux attaches to the eHRPWM block.

The series is based on v6.18-rc7.

The series is structured as follows:
-------

  - Patches 1-3 prefix the register and field definitions with
    TIEHRPWM_ and convert the TBCTL, AQCTL, AQSFRC and AQCSFRC fields
    to GENMASK()/FIELD_PREP()-based helpers.

  - Patch 4 derives the PERIOD_MAX limit from the TBPRD field using the
    new TIEHRPWM_TBPRD_TBPRD definition, instead of an open-coded
    constant.

  - Patch 5 refactors the TBCTL prescaler handling to use FIELD_PREP()
    for the CLKDIV and HSPCLKDIV fields and updates both in a single
    ehrpwm_modify() call.

  - Patches 6 and 7 factor out the Action-Qualifier force codes and
    polarity presets into named constants and then unify the AQCTL setup
    for channels A and B, including the compare-down configuration.

  - Patch 8 is a small style-only cleanup in the period conflict check.

  - Patch 9 fixes the probe-time handling of channels that were already
    enabled when the driver attaches and balances both tbclk and runtime
    PM references for them.

Patches 1-8 are intended to be no functional change and only improve the
structure and readability of pwm-tiehrpwm, providing a cleaner base for
the upcoming waveform callback conversion. Patch 9 is a functional fix
for the probe-time handling of already running channels.

Testing
-------

These patches have been tested on a TI AM623 EVM board.

For the probe-time behaviour, the scenario where a channel is configured
and enabled by firmware before the driver is probed was exercised using
U-Boot as the bootloader to pre-program and enable the eHRPWM channel
prior to handing control to Linux.

Follow-up
---------

As a follow-up to this series, I plan to send a separate set of patches
that converts pwm-tiehrpwm to the new PWM waveform callbacks and drops
the legacy .apply()/.get_state() callbacks, building directly on top of
the refactored code in this v7. Keeping the refactoring and the API
conversion separate should make both series easier to review.

-------------

Feedback on the structure of this series, or on further splitting /
squashing before the waveform callback work, is very welcome.

Thanks for your time and review.

Best regards,
Rafael V. Volkmer

Rafael V. Volkmer (9):
  pwm: tiehrpwm: prefix register and field definitions
  pwm: tiehrpwm: drop _MASK suffix from TBCTL PRDLD field
  pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for register fields
  pwm: tiehrpwm: derive PERIOD_MAX from TBPRD field
  pwm: tiehrpwm: use FIELD_PREP() for prescaler fields
  pwm: tiehrpwm: factor out AQ force codes and polarity presets
  pwm: tiehrpwm: unify AQ setup and cover compare-down events
  pwm: tiehrpwm: tidy period conflict check
  pwm: tiehrpwm: handle already-running channels at probe

 drivers/pwm/pwm-tiehrpwm.c | 428 ++++++++++++++++++++++++-------------
 1 file changed, 278 insertions(+), 150 deletions(-)

-- 
2.43.0


