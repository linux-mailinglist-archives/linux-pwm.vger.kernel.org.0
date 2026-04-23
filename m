Return-Path: <linux-pwm+bounces-8672-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8He3JoLY6WmglQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8672-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 10:29:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4844E8C1
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644523032F63
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2E3C4551;
	Thu, 23 Apr 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ESfXel+i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DA3914ED
	for <linux-pwm@vger.kernel.org>; Thu, 23 Apr 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932852; cv=none; b=VDLtyUIGq85yqo9ZhtyOS9BW/oKDdC3iH7QI7o9UrMBfNHT5BBSgLFi5baGa/Cus1ayBuZZZVD8zI46tl8CpZKgjSJnqSsbHdK/ukjBX6RAfc3qkXZwhIL+2V4GQVvVXlWXWB97CrA+z3pvDCERUkIE0V+2B9IavjBKD2Tni9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932852; c=relaxed/simple;
	bh=Sw7pGrtm03rFb4w9v39tqqiV52NCp2AS9QRYBO9QZEI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cMeHAOZkxp7vDXCWn25r8LAyVXEV/wKfhk3EMFBRgv/mwBmuAlZse92SwpfsOa6fwsn6osVUBfNZ0op4tI2tPlG7/Ikanjlj/FPSvQr/AXxMeQrMvf183ido3GUXSgIvwlfalQ1EFGWuYWgBVNDKTN8E3/8T6LXMylRMlXm/YDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ESfXel+i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso5580379f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 23 Apr 2026 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776932847; x=1777537647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ9c/QPUCIYiqT/6G4zjKY9VFibIqgyzyOicvyBMlCE=;
        b=ESfXel+iXEhRu8or/8B/CHlG2qgtSM62kF7DGBx3hjExRqRl+WrXFfdZlPjzsaorKC
         JBfinXWjSlvnQGE2p7cC/YHkGoh7F08x1AwSkOq+hwRdkomRygM5qyp/H6m3Phcviyd4
         px0HMJKigULib8w7RAO+A/zgSylw7rPBM+Y5E+hnEAuYWU/xdVjkA1Dy6MacGQTdlIHL
         mj3B3wsrlu5gHf+puzWtwVioG7XmZ6KsWbLvwkQ33yCyionpR2ExWm/HDoCDgow81nDb
         VdxzRl7SscSMFVLHI+Wb5MbhCMiw5H7IISwH6elm6rbkvUQ0lm3Qg66amYNTeJ0ubPHz
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932847; x=1777537647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZ9c/QPUCIYiqT/6G4zjKY9VFibIqgyzyOicvyBMlCE=;
        b=DNEHuNcwDaKA5vpJ2eef8gNHKY+q94Pzh4Do9KjS5uGKHg0IkaYz13VBzicPDLVMgL
         ayJWOhrG1u6pQj5gPH2f0NYtPyEBcxEgcYyudq/eW6SZdXMPj0uT20mNjoAlgaB78nGn
         ifquJg++1Z1IdgLCuy3LeyzTmytYceF4QsBAULg8uYtGKXmnAdjeZoqgWIiysy3c3WxC
         IOds3QjTP7AlyxrxWQX51U7bO5C5eUK9Jhzkt/R6XBny6Db7n5uLPG63NmVOdHTShs7k
         kPNz2IHNHLZwzGpYGm5FdZ4l7RN8r0oNvY1UVhT7XR/iWymoFgFcC0fcUT2Sr58AtEVu
         1A6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+FQy5g7NwVYE8ZdFyr/Lg4xgykj3qS6knGoDn5tKojJar5RYjstMFpW8px0Ts0dr+BnG/WqwGyzqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Xrw63+eLjrakPpOeUnUJSNJ377oOihiUe4HXITjTJiA9kUFI
	OR0fnEcsTxrL4okrxcj4VgfCandOv3Y3tJwgwbP3L1+kxe9uAtwbbHSbJzMF1xlxCFU=
X-Gm-Gg: AeBDietoisQYS9O953lD7YwLSasBqpDtxSSaTNFEP/SiQOJk/9FuGWK+w373jODg5fi
	7xu3QWyAck1GuPi6dIMyYjGshSQHA6ahcDHP0eYbril4n8e8NI3XiaRotckUnNpE9tQAAkADMVK
	XztkLrLFVv8PHnuNkT/4v9Qkjbq2jBxrZqE19KFI3YhW6WodnYvdxIWJDZetqH316Uz3Ty/dV21
	ZxKy0bKlNaxoHEKeaetiAQ7ckxgpliAZQWXksAy5+rFTbxp9bR6AEkxQgLvyfbpb03Aps37a/O4
	/z70o6VpOGDoDTprrPJEdQCkguMDK54RY1IjEkiGNvW6p1GqormfyFQBih6GB3fesaBI9ygG5Vf
	YQKKodIURlNpxyU7qMg7JbMsrpnrQ4muASMqx4KuHsgO3BhRdJPlQkZA8FV0UgYye8oEcfVuL2x
	wNNXLf3GLzdt/UC2V1IyphoENUrCpntawjebMI/jXaS8gMOkGV8xekvgvLY1zha8S/G7QkG5T3T
	KAubCF/T1S06xJqpg==
X-Received: by 2002:a05:6000:4313:b0:441:2ba8:79f with SMTP id ffacd0b85a97d-4412ba807bamr4088356f8f.37.1776932846520;
        Thu, 23 Apr 2026 01:27:26 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm52641843f8f.3.2026.04.23.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:27:26 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add RP1 PWM controller support
Date: Thu, 23 Apr 2026 10:30:18 +0200
Message-ID: <cover.1776932336.git.andrea.porta@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8672-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: D8E4844E8C1
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

CHANGES in V3:

- Refactored all the register macros. They now have RP1_PWM_ prefix
  and follow the register name.
- Dropped the tab alignment in front of struct declarations (use a space
  instead).
- Added a check in tohw() to test (and bail out quickly) in case that
  period_length_ns is zero.
- Probing now returns an error if clk_rate > 1 GHz.
- Added a check on minimum period ticks. Return 1 to signal round-up.
- Fixed inverted polarity detection on edge cases.
- Fixed rounding errors (in both tohwi() and fromhw()) in inverted
  polarity calculations.
- Dropped a redundant check on period >= duty.
- Replaced memset by inline struct init.
- Disabling a channel now is faster, skipping the duty/period/polarity
  setup.
- Fixed an error string (s/Fail/Failed)
- Used %pe to signal error string instead of an integer.
- Added several new sections to the Limitations paragraph to better
  explain what will happen on edge cases.
- Maximum period is now U32_MAX-1 to allow 100% duty cycle on all
  selectable periods.
- The hw period register now takes into account for the extra tick at
  the end of the period (subtracted one to wfhw->period_ticks in tohw
  and added 1 in fromhw).
- Added .remove() callback to free resources even if the driver is
  not unbindable/unloadable, to avoid accumulating tech debt.


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
 drivers/pwm/pwm-rp1.c                         | 414 ++++++++++++++++++
 6 files changed, 500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c

-- 
2.35.3


