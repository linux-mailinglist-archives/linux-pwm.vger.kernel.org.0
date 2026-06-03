Return-Path: <linux-pwm+bounces-9237-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kBvC1pJIGrk0AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9237-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 17:33:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D58266393C8
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 17:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=AdLnftGE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9237-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9237-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EBE73075F62
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482183DD53E;
	Wed,  3 Jun 2026 15:24:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E923DD502
	for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2026 15:24:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500283; cv=none; b=FNmv+VCvDpi0JAvuYlyw8T7WZ7J11berUvjscQ5oiCYCiRTPpEjd65qEqKBDqJtPOw6lyd3mtEPOGg0hX4jw5sTWsi8Hyigw+Kffidu/f/GUjq6Q7GIhWAHC7xmnAYrmdwCjuM7IK3AAxofdmVYp/n0A2zMLO77GsPmEoqoHj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500283; c=relaxed/simple;
	bh=pwnLdAL7wp0rmLebUr1pKIcbrTLNSQRBMwWuio2DBUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OelS5tOaTmF7TiQ9AR7MLTLPoe//RPYAC7VFZAWiObDWAUoEL7c9JznCyPW55/QtR79AhP/Y8jItX5S+E6jleAhQnCw+qtUfFAv1tHmOWVqY6RbPb5Gq4ithK7FqDwIoPhmT8zxiSjr4wRmRJw6qjZp3u7jZraPxjBy055SoQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AdLnftGE; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef616daf6so5408948f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780500280; x=1781105080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1fMCVLbIKr90LXf3SjcImREe67/kY5zx03n0vnfB2Y=;
        b=AdLnftGEO1xCzY4HC3+jrsk73p/0uUDVJ7NTNiBA1Vp9+V503W7EyKWIjN25xrlzfz
         /Xz7BPqtQgAPjknPDQLfLB+Yt/qNajs2D6Wcfc4GwhhCWfjNy9+93tPnmzI+UMBVT0ri
         bAcvBfD+8bRKQzR4jZilG47d1fGWMUhWGkU3ev6OSZoPMq+q46M8qi+NRQxb3vukRyBe
         /rBfwIfK03INgM0imkJmuruS+S9CnWsxcGc9nSuN7sk4NBmZYyJOrrPHBc1A0JXBSxy7
         P9DTCwnhEXgflY7seyovCS5+qRn0OTl5eFg01Rs/2CKME8gO9Z9JTWWhbSe2Z/d4gIEw
         BFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500280; x=1781105080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1fMCVLbIKr90LXf3SjcImREe67/kY5zx03n0vnfB2Y=;
        b=YNDeeM6rUbtE0pENnXhkRGLMtotOmnebNNdE+t8mXvLburrIfnld3Dmii90sbVIcSb
         mRqfzKXfcvtUhrV2GSMbQw5KBVYa7yO2jNth+eDdnmQaQzkRmZd/3n7V1lfXPdZSaS8O
         MImg8/7PFgSVG0U0hdRRJhd+/isCtTFSHoKqCRNHOCPcLKxGlHWcsSyiZzhA9y2fim8M
         WTu9fCcoF1bd5Y2YsEXUfc3BGnJNPgogIhTFvO+PqpmdRlGsIRfl3vrCZY26zr0cBnJT
         SRwx4TT5gLINt3xvgaOERy9bidtBBmPJ2ryRYBLdNarxzjHpZNw9pw1Mo4RRG75z1AQQ
         DrwA==
X-Forwarded-Encrypted: i=1; AFNElJ8l4fP7Pm1lh5uZ+DO296Vcn8dxuJGRHE6sLt3cKdjV/ZuFEG8s7X3rjFTJW1eXzRTYeOcSbPFfAOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVWLXqVPVMjc8cjZt74yk51PyjdusBUZZBJ3Q1spTGK4KNr7x
	nTpda0aSkmRlBiieQt01fkoPiPcft36qaO58LwfclQk40Cz9atS+gq9VPIRMyM3rKzo=
X-Gm-Gg: Acq92OFa8105BwuorXvIA8xxITuDFOlC2RPzIfGJh2H1sdP43EdsPoPJ0M5bkpfSGrR
	PRx2K5HX/H6FkzPq8M+MlYhYIWhgahgXbfU0jlnrfJaBVU7T9nnkAWta2gykI1+5F0tb0o/byyV
	1nVperLcB5xkMY/wk6O3B8JwpDCdkOta3t9mTSVahgbAm4wt9KqekdKMzYIzlGZ+6GeQPeuLNZZ
	aU2H8t6uPCJnqIlAIrv1MeRTWv4eiQiDYWDTerHS9e+MNFD5YirWlDAiTQVbUb1wic5dFzuFsvF
	McEhkyYF8w7flSO01a3bR6FCtdtROK8jqCXHd/DsAjzij6udx6BxYLWBBHZrlOS61ifJGh9cHdm
	U1M4IBlkDeyWtg1e+Wu4BKv41VVH6yiB0ksD20YRbLX0AVE76PPP/t60obHPCYj2TgchFK9wcCj
	9w7irLmQrO15Fl/Hhlaqu7FvR7WjNvuNR3a71B2KbccZw=
X-Received: by 2002:a5d:5710:0:b0:453:e3a1:6580 with SMTP id ffacd0b85a97d-46021844ce7mr4341301f8f.25.1780500280187;
        Wed, 03 Jun 2026 08:24:40 -0700 (PDT)
Received: from localhost ([82.192.120.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm9185525f8f.20.2026.06.03.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:39 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com
Subject: [PATCH v4 0/3] Add RP1 PWM controller support
Date: Wed,  3 Jun 2026 17:27:43 +0200
Message-ID: <cover.1780498640.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9237-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrea.porta@suse.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:from_mime,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D58266393C8

This patchset adds support for the PWM controller found on the
Raspberry Pi RP1 southbridge. This is necessary to operate the
cooling fan connected to one of the PWM channels.

The tachometer pin for the fan speed is managed by the firmware 
running on the RP1's M-core. It uses the PHASE2 register
to report the RPM, which is then exported by this driver via
syscon registers. A subsequent patch will add a new device
and driver to read the RPM and export this value via hwmon.
 
Subsequent patches will also add the CPU thermal zone, which
acts as a consumer of the PWM device.

Best regards,
Andrea

CHANGES in V4:

- s/rp1_pwm/rp1_pwm1/ in the DTS, so adding rp1_pwm0 in the
  future will be unambiguous
- the driver can now be compiled as module. Since it cannot
  be unloaded (due to syscon registration), substitute
  builtin_platform_driver for module_platform_driver.
- preserved the polarity bit when setting up the channel on
  rp1_pwm_request()
- rp1_pwm_round_waveform_tohw(): capped duty_ticks to be no
  more than period_ticks, and adjusted offset_ticks
  accordingly (best effort)
- the syscon registration is moved at the end of the probe
  function, to avoid leaking if the probing bail out
  prematurely
- fixed the erroneous casting about pwm_chip/rp1_pwm struct
  in suspend/resume functions.

Naushir Patuck (2):
  dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
  pwm: rp1: Add RP1 PWM controller driver

Stanimir Varbanov (1):
  arm64: dts: broadcom: rpi-5: Add RP1 PWM node

 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  54 +++
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |   9 +
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rp1.c                         | 422 ++++++++++++++++++
 6 files changed, 507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c

-- 
2.35.3


