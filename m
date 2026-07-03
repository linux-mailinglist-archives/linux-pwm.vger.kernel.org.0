Return-Path: <linux-pwm+bounces-9545-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7JuXOxPrR2pAhgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9545-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 19:02:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4661070478F
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 19:02:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="JtqtdeH/";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9545-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9545-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0673E3010D9C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB431DE4E0;
	Fri,  3 Jul 2026 17:02:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAF145B27
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 17:02:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098128; cv=none; b=SjfV7GDgK/1Mgcsl4mWNXDW3bLADlis7tabS5gwqGEDmpV43E6hxr1AbfawXt0UjvagQYSa4Fsk4TmedCxIbMw28qK9wWmp+wQ9cK26+NFikpJ6J1s8yYDdt/crhf4E8vzZ7g5J6wWJvuni3U4GksVkK2ONsbdcunPwxGWPdReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098128; c=relaxed/simple;
	bh=JJntkUC9rBut4Ox3VlLSu6avviUJ1OqJzK+qpFIyVRg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iTnhV2dSQ/RfseUrNgjZtvYzO8GMdxPNbhNwDCK+44NkSm5gPLsq8tphSQESDUL+rWYaVq2AT/bfu7Y6m66UVMl8BdCp96neh9lUw1kIZM3sEFLNsbg9P5VWSxAeymDZNquB8tkykKzH6wuXhfT3XUEF3KDenvhRgPtx5Bvdo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JtqtdeH/; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c1950518so9825285e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783098125; x=1783702925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/1K0BV/G7Gec3azOultr+oMUL4gfypJwfwS0OJxpVY=;
        b=JtqtdeH/3/Zw1T9WgVatOVDLfv5RmS4eyNm2nTweAFP3qH63Rykzd5Ips/R+JcoVDg
         cBl1BjmJlOSCwLwYAS3VvteW0q8qVfSNYyY6f4NzyXszgP8JMoQjhm/LsNhbBc8+8/4A
         zAix9djFdduiaDoN5LVb9J3M6F7nb42xOR1abnHwQYq6s+vWdsLfHrL0TljpBN5I+2xp
         Xn6dQyxhOvjkpum60g3YE40hQNJcn7uag7uT+2mEEYxqUVFBCkWDPnX5BaPXkXCMzHhP
         lWQ/J4jpH0cMW+FARYddzOk74w9QwMz6Z7e9nH8sFyGsxnQuKGlEEa+JrPyPlyh+eNaU
         Q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098125; x=1783702925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/1K0BV/G7Gec3azOultr+oMUL4gfypJwfwS0OJxpVY=;
        b=jbFVitgfrdE13qUVHV7d/g+ycewcMjky9yBXzxI3NrvPHne4+/FBpDoXG3+Uoiq5F9
         PT4JpurY0CLx2+GY6L+++qSp5YvJtlsnm+9Zgbf+uN84UXX4N46oQ1fiymfNbZ+C8ZKL
         eXUuYl/83XV65FxayoVPg/cN/7lZ62AXxyToGS+HPYRRJIPKLGEaLXkKeA8YdwwD8mBJ
         kIszavX8W0xt7qmkPeLcL5T72RZKIaY+T5ZJ2hrVnawD8Mz4jNUzAikVKvQ+6Hj27fdD
         BTdrmI0gDKyFahI9LQPM/jrWYNSBc90pLPWk4xbsoTlOkR7iceGl4OcD0pUyVP+ulPIU
         GD8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/1T8QMUf4MMUEJI33bG4yNiW+52N0E+Tjc5eyEnHaZ9e4FmLekd5d3mdWzbjD2EnpAuc8ZQYeg2Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oM8dmUjCKYpewcrDpXP056zmoTiEjZGa43NBUrite0gEU7q5
	5oOTMtvYC/VcF6gOcd1EFdjcNUNdiyagFUXi3pYKqFuff056FhOsqoKFPkgse94Ygi8=
X-Gm-Gg: AfdE7cmcD+GCH9mZHZUE1J9NzLK6ji9OKtHw7RKe5/FFZ4t1/c0aX3LVUxM2E1V5/PV
	xN1hfYQBZk711fzKqVJ4DAbLU29Ubo0T25sw/dfurBwu6VjAhnL9QLL0QW2t3jv5CvFU3y+tMxL
	BHuxqJQHAYFfszK0HycW2T/kkUhZV86A09u0fQ+DnQfxnSxQQryHGY1yh7FBEy1S6XbbKOP4PM0
	vpQQzytJQzozOhmElMv0auzuXRUZmCAiP2QBz6yQNUsnMUgU9iebPWasDCGB+aqBvmvinL8OBbC
	Q/Ly/8gu7IYRjiRAP0M7M5ifMQUknT5NDCdXDNYskh5zmHMSbbBSdBWfcNJRQr242o+jJq48iwp
	aQGPrd5m0IiN2tXxBmQYBZl6UnJcfHjHhIts4urmVfBxnrYj4Pzb5I+x5+b8lW28W0hgvSFhzv0
	bmwxX3QVlKhlQ=
X-Received: by 2002:a05:600c:6287:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-493d128b6e3mr24185e9.7.1783098125539;
        Fri, 03 Jul 2026 10:02:05 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm252158015e9.0.2026.07.03.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:02:05 -0700 (PDT)
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
	mbrugger@suse.com,
	Sean Young <sean@mess.org>,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v6 0/3] Add RP1 PWM controller support
Date: Fri,  3 Jul 2026 19:05:23 +0200
Message-ID: <cover.1783097764.git.andrea.porta@suse.com>
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
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9545-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,broadcom.com,suse.com,lists.infradead.org,raspberrypi.com,suse.de,mess.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrea.porta@suse.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:sean@mess.org,m:julianbraha@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:from_mime,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4661070478F

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

CHANGES in V6:

- dt-bindings: added Andrea and Stanimir as maintiners, Naushir if
  you want to be dropped from the maintainer list, please just give
  me a shout
- dt-bindings: added dmas properties in case the driver will support
  that in the future
- _tohw(): fetch the actual polarity in the disable case to avoid
  potential glitch due to garbage data in the passed-in param
- _tohw(): fixed a compilation error on 32 bit target due to missing
  64 bit divider helper function
- _fromhw(): division by clk_rate explicitly cast to 32 bit for the
  divisor
- _fromhw(): fixed an unsigned underflow in ticks calculation
- set the atomic flag to allow calling from atomic context


Naushir Patuck (2):
  dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
  pwm: rp1: Add RP1 PWM controller driver

Stanimir Varbanov (1):
  arm64: dts: broadcom: rpi-5: Add RP1 PWM node

 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  66 +++
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |   9 +
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rp1.c                         | 435 ++++++++++++++++++
 6 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c

-- 
2.35.3


