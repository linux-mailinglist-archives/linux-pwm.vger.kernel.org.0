Return-Path: <linux-pwm+bounces-8546-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C5NLQsE2WnolAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8546-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:07:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE53D8722
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABB0B301E015
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2393CBE6E;
	Fri, 10 Apr 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dfpZ2L9s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A161E7C12
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830024; cv=none; b=mG24INBI3cYJotFEt6encFL99PDpYdQy0/HfjwlWVbcltNmYj2kDVWewLj1RKH0TMneiQTBS5/BWMHHcVoQZJoYbVEfAKhi37ZXL0OcBtfQa34tRRl28qSwsWFa/aUfciKARlAYDTUQIvdgaRY48E5I6nZEmDK0a7vK56L/TvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830024; c=relaxed/simple;
	bh=FvZG1pUZPT0gg2fu1jQuMRQEO44rTILWevO0vYX6yYs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FOP/CQc14roT59RqbD1vLQoxJaINHPht1X1wXKZGCmJPsUeB2YJ6hCAKPGwu2ycd8Ag3eN1nqUU/7k5KOoIIoexJuMbBoy2iiFFQaz3B8+f8Z29T3OMGEUdLekC0Svhttx3fQEK17sLUtKGXia9mnm5kfJofBalQsAFuZtDLebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dfpZ2L9s; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso30830045e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775830021; x=1776434821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JW107L/IStc303NYPPlArrLCZGog0RXg1/LldkbGac4=;
        b=dfpZ2L9samQyLf/3c1FEFXMm0gQXGfclu8X6X7kDsbQX088y8e2qkcuOA64WsSiZjb
         sCIj1ATYs03hajMnMXlhahsuE3mOa5PPi1y2j1vQrobYIgbynIlahohAQswLOyg3WSlQ
         jBTle9e5tHQczQnqpdgR3tS4GEKHybGqXfo08BdB4BGWfCnbqRbYzS2r0xKRtezrBrme
         A6/yfpCDl5oKkkfsrSRmWVGSTckXGcsFZ56SdLJ+jljuFJftwhYRAro4XhZr9cP50lKk
         xNxWYhwOV1/sohKsPDbwy3BrvM3gQztNnbq9EdeYA//Pxdjux6UZJRqGKU+RGxfXBNsF
         4vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830021; x=1776434821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JW107L/IStc303NYPPlArrLCZGog0RXg1/LldkbGac4=;
        b=BWjDqy911rirIYzwuVz6MUcq3CX02XiB9eujUv/euI9PbW3ufDS9kDBmGIixWIt+pQ
         JkXuPTV+Ib2zAFuRBwraeiuIxuN5Pl6Wf5S24N+kwgdZp7P3e7F4MK7nML9giD7ZHJA6
         QNOSbLuJEpicbC9V+3rmckO0NDTgotAhtCJLBpUwhRmM6fJlVfNgtDWCX5faBd3T5eU1
         3PHK7VT7SLwHFqR40JXil3CTigzJ0cMerzFKwPHblnRJqG1HBvR5clVwnYhoCjNyvchk
         s4v1hjT7DHz3XNtHoC05/ni4sDyfQbbm9UNHh+s5EJaPZy8WH0G4eGkzizjn7+m0SQIa
         J6+g==
X-Forwarded-Encrypted: i=1; AJvYcCXsGFJr7faknmVNdpdR9gJF0Bc3ViWu3t/qp8gW4V6sRhhpRX8RrkNPpGV7FMpA7jFpWPyKwwbBWFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExVE2TLoNfOWi/0BCmTxUFP/GopnTAvxclXSdU42wfqZCVyEV
	hPIPhHH49SH9ysMYpCwuvS5q+WiiYZvGPRvUtDeS3WTNpPjFjMAGhf+fEKXgwbfMyyY=
X-Gm-Gg: AeBDiesis0/rIpA5AItUMriTZBkS7LBERSeZZJ5VqWxtA5VgLsrQlHujvC/HAnx98lP
	lvSSUW08jwRX72Y1wqjufpMAi1bMYuj+e760i/bZ+KMBcnEfONg1sQxScuWJs6p9k2hmaQdE7W1
	A7I+Pd2OHc/FZY+bz5CWYIzrFTbqgpxphmU8dF+vX6ejKqRJnBZHnRh9CYsFjSPgmCcWF8XELC/
	tivu7DNMZMIMqkpwIw8ZXwocR20gSDNkyZ92GuneWmN1esee1wfzAKfwy7w/iDYGM8RVn9lX2Ev
	YzTrmIMd8q2cdzx+GP/fOBluqdQKCJFs6hOisSi87S8as+9tWLSlZ2+m9FHFuMNUQmpyf140njq
	r4SzXPnNM/+mBk/VXXlGb3NP5uEnh83nC0g/2b+dE8JbMyEs7tG72sdZT1P4cnsG7+h1n++WVDZ
	YYNj3x81ocCd9ZJUPPuGXTQE3uoyDAx5gHULGuXvzfUS+TStDcjg==
X-Received: by 2002:a05:600d:1:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488d67c720emr38283325e9.3.1775830020792;
        Fri, 10 Apr 2026 07:07:00 -0700 (PDT)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46713sm8549422f8f.21.2026.04.10.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:07:00 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add RP1 PWM controller support
Date: Fri, 10 Apr 2026 16:09:56 +0200
Message-ID: <cover.1775829499.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8546-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 54FE53D8722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

CHANGES in V2:

- bindings: added syscon to the description
- bindings: changed additionalProperties to unevaluatedProperties
- dts: reordered pwm node to follow the unit address ordering
- Kconfig/Makefile: renamed config option to PWM_RASPBERRYPI_RP1
- Kconfig: added dependency for syscon/regmap
- driver: added 'Limitations' and 'Datasheet' paragraphs in top comment
- driver: all macros are now prefixed by RP1_PWM_
- driver: implemented waveform callbacks instead of legacy ones
- driver: dropped hwmon device registration for fan speed (this will be
  handled in a separate patch with its own driver reading the value via
  syscon)
- driver: added new regmap/syscon to export the registers.
- driver: added a comment in rp1_pwm_apply_config() to describe what it does
- driver: added a comment to rp1_pwm_request() to define the purpose of the
  last write
- driver: new clk_enabled flag to deal with the clock on suspend/resume path
- driver: clk_rate is now obtained during probe right after exclusive_get()
- driver/Kconfig: module is now static only and has suppress_bind_attr to
  avoid racing with syscon consumer drivers and with syscon unload issue

Naushir Patuck (2):
  dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
  pwm: rp1: Add RP1 PWM controller driver

Stanimir Varbanov (1):
  arm64: dts: broadcom: rpi-5: Add RP1 PWM node

 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  54 +++
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |  10 +
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rp1.c                         | 344 ++++++++++++++++++
 6 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c

-- 
2.35.3


