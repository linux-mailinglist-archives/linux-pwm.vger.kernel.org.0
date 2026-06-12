Return-Path: <linux-pwm+bounces-9281-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7GIfHDURLGo2KwQAu9opvQ
	(envelope-from <linux-pwm+bounces-9281-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 16:01:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2A67A093
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 16:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=gE1sjFe3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9281-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9281-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D3B30B6CED
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56840364047;
	Fri, 12 Jun 2026 13:58:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F4374745
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2026 13:58:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272698; cv=none; b=lW25aMIBXV1HwZ4Y3yOlB4VtYuZ8In+4nA+bXCllF5fyphVYcqfjRdFHiO/QsCxA2TaKjZJpub78Yx8yXdzhN+NBhyyM0Nh3oabpeSDA1ccSHwZIpm12CBsd5zq5breTvIvNHD8gbULIXVYnkidqxpJShS3FsYHVmLII9A9VB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272698; c=relaxed/simple;
	bh=7RAWRz8lfOfarixxNlkFfs+YNhLZePGK79/sjOHb0aM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xo9PLZv5hKT6GXTHHUwPkeYZOE8aw3K9RU+8+XrSmOWhtuImkC3RatEvII5uP2OG7TbXndTm7Ebj6HbSE3cfTfNFyS7eNlTPceFPaRJ4/AqV8GEAYld0AlK8V0pR3FAhwlW2it4oR4/51unZ+MJpKo61jZlVYq7BEeDPZLSWjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gE1sjFe3; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b915ded5so10157835e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2026 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781272693; x=1781877493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqg7EuxMIGmSumS+tdgRe8gbezZdZWcHGXgl7mw39zw=;
        b=gE1sjFe3wDeow1UANpXJowHeT8qe/uwAhvvEzt5VPJybnWZBn7QtGJiyQdhuCL52wS
         O5ZZb30mEVmthfXKlmIaBfDjCBk+mPjfCvELC3cYT4Zk1s73/+w6jZa/1wwIqjvNlTRq
         bavVIvEGbPprnOVSeWJ9rU6qKTeIhBw/KzmyT2BTGtw+njq6WRvFeduwTTQYb5/VLOea
         gkHIY0cWJ4kbU/C/da7L/s48dOhhAbDTW9Zbp9kYl8sLw4GHyX/zC4E+sUJ8jQPMK4ml
         JIOD9paiWNSjgXr5Pcv969nuyT53eSb33RD0IS1Q9/GsCpuiJ4w0EYUHy/P5yqB4BKL+
         Q0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272693; x=1781877493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqg7EuxMIGmSumS+tdgRe8gbezZdZWcHGXgl7mw39zw=;
        b=QCUobGutCJNxQfRm42mWMcZetOQS89haeZXpX3vOBjYnmTI0oXso2UfumkJGiOFEJ+
         2201DcpSYtxe+z/VPteao1gnaywMVw2KVEUL6rqYG8spushm0bmqRkvs79U49usvh3oG
         QSUAjuAi49ioP4xusMaulFUEN01clFMaTfHTrNCDhx2pNG5ELhnHHYC9f5GwIIVcvPyE
         Ku7vWVK5YaV6wss3VCLx2h+JvJARBKRsekDzrVz7jCeT0uHiVkvzLCfyJEuvJb35d+nT
         b7cgU/MkUAFRByP6bptJwX9rrZVsQNajBNAty3JCwoqedPzWi+vlh+ORakGg3ZyxOjCw
         3fxA==
X-Forwarded-Encrypted: i=1; AFNElJ9x+vdpqq3bteurDNHJOqqr+qhbJcttrn4zEAXgU5Rd7eXauFZEvBDCEVgsZiX1Ic9hPYDR21IMaMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKp/QVpDGSu8VYEg6t6Q75MpMnfGzgZNwGQZHCvBhk2X38G5Tu
	V+WHx4MbH/bXYVybjlx8bTGDBWvJ+9K4SRjz/L4SXfyULrf2gUuObtVSiTKF0ZcwZq8=
X-Gm-Gg: Acq92OEyV7qc9ZV7/LLTZfiuJIg472hiu09h8ty0YEa6O33kqDbYg8a0KBkGQyRKEsJ
	5MSep03sTgdkcp1ty8YcXuIhaNzH4XUx/soFRUJK2GdPSbrqJwfPIJdSnM9n2nNZB6SFxsXVoV+
	n2XdO7zgB3wK6Gb5UKe9Hg2NU6zFrGHzGK5sIR3KZWf56o9AkuTNjWKx8KsO+O4keqI+JC7ikHT
	jHlTw63/X6Omu96Lt4vlempiXulx0yC2KExR00ycA6WSY0mDixHoS1wBQx1VdEFSucDwFi98EXF
	QPceMgpLCocbovE/Ld9H+6jXSC1jOL4Bi1Pd65iGWJlWkZds0PazRPPEx+2PSN+aqmq2To9RfnC
	osZ7xlPr8/wS4NVULed+nXG6ScHxQFV86iwQa9sadorvU5mlS6gzN3Hq9KoyRqNNIebIaMTqIOn
	ddDgaV68+27M6PNX2I0VUVn/bIqHHWIV4=
X-Received: by 2002:a7b:cc8e:0:b0:490:b0e1:2161 with SMTP id 5b1f17b1804b1-490ec4c1396mr28431285e9.2.1781272693533;
        Fri, 12 Jun 2026 06:58:13 -0700 (PDT)
Received: from localhost ([195.94.146.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ea21sm157969205e9.1.2026.06.12.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:58:13 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add RP1 PWM controller support
Date: Fri, 12 Jun 2026 16:01:25 +0200
Message-ID: <cover.1780670224.git.andrea.porta@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9281-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:dkim,suse.com:mid,suse.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E2A67A093

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

CHANGES in V5:

- period_tick is now capped to U32_MAX to avoid breaking
  monotonicity
- period_ticks less than 2 are set to 2
- fixed two casts in fromhw() that could led to an incorrect
  truncation/underflow
- when disabling a pwm channel, first set the polarity to
  avoid unintended quiescent level
- in probe function, fixed and error path that could leak
  an invalid pwm_chip struct


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
 drivers/pwm/pwm-rp1.c                         | 424 ++++++++++++++++++
 6 files changed, 509 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c

-- 
2.35.3


