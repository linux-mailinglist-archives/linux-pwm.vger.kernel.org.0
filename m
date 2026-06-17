Return-Path: <linux-pwm+bounces-9302-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m98ALpkNMmpfuAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9302-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 04:59:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051669633A
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 04:59:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hNudawiI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9302-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9302-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C73BA3035F18
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B530C153;
	Wed, 17 Jun 2026 02:59:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E062F90C9
	for <linux-pwm@vger.kernel.org>; Wed, 17 Jun 2026 02:59:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665174; cv=none; b=pWoxz9AQxYDC/wp6xZA+SUFWLywrA11ty6xhN7MN9F1MONYEZDc3V5cgVoS0FIAFn579XU4o7xAwDqkI9JJUqQeU0sR+sxuoihVUogxTvpqHGzv7prJ8MU7iPTcu51xqkFQkjVskZDOpB5+rLmTkir1Oh1JeRhMZYepxeS4PctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665174; c=relaxed/simple;
	bh=mkBhvigEenoV7hVsKrScF2k37dBKNOTTn+0E9rJ/vAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F8YeVrrfEfr9SVdx5qcIaBxbnR2MG+zPCoOBZiLgqLcB8w48CEA21FsCLIY94hWFHgSYBeJQ1BeX5uSFV9E6JUY/PWhpWDT0zsAwJJ/knbFg+oF227rVl9ct9yXMwJLC9s/l848vcA0kvOXpt0ttqYu/10qN0qfiI5rRyLoZJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNudawiI; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842848fd613so4527987b3a.3
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2026 19:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665172; x=1782269972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBin7H0Wt7Oi8P0z8wsZgQQjqhBwvW2vxMHjxdsEcyI=;
        b=hNudawiICVnvIJbq7BFPLhcs2D6VhH0mROmU56PWBB4gUjIg3/1cluK7wFZPmGQRAK
         jGRfq1tY+tPaBSw4s3ZTA6Oor3yjsMvtmpMdPiFRYW5jm2ZHx2ncGB1AhPaj2eAuy4aD
         M0YRGV0A/d6AKwWgEjp+HeduDSUCFsXfJFxQ7P+0/2YlfB2IjsZFX1BPBlhkwPB2A4dH
         e8hbybM0cHps52NsoDXs57jyFSQ6/bVjjSy9EJLMbTNsc7V4OOL14yaPN+ZmUYcPqhpL
         LiuGiv34FnQ9VTt8iPstP9kHMK9uRJAwEA7VJRrnVHb53RBZ1uSF2imQAwznLdfyAFSp
         m84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665172; x=1782269972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBin7H0Wt7Oi8P0z8wsZgQQjqhBwvW2vxMHjxdsEcyI=;
        b=UCm38DbM9EY8GD+UfrGfadxTDYFBH1NhDA+MA1EHuwHRfamcWZXae1lhCyzlmWx9Zt
         NNdn8ZJ6q/tPQB8BpEXOm9ISu85bNxQy0+Py5biNf+bbN9NmjA4GJiPN9HQEOQHkf3Wh
         nsTxwZk2ucLuhDFODoTVylsQNMkQmN0Um1Gy1Vq6MoH7KKslSL6xlinb9K8mo/PlcUfi
         63N7OPJZ2r8DC+41FAuE0ZsoieSijgnU/4d6+VB2GuS6i9NRjePPbobcKgtXpjHc3mni
         eGOgSvsVQn5vp2kr27xiYsjY/fmW6nva2z/kktHY7rLxek6NDL7AfU84it0A+V4jL0NW
         +5cA==
X-Forwarded-Encrypted: i=1; AFNElJ+5+MjVGJTNbx7pcpq8/bOFlZOPrbZj41yzwQ5rWX1kWs3Gf0XRbrVg05Yxxn9AHbRkzVgNA/A++E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzx5rlM15ikv/0vOxHYVWHPKVRhywdC/5NK0yb8jl1fNOCq0R
	Ik8LXvPWuu7ZZQeTcATKvZ8Np6WZamzVoHotpgIx/7zwbkfsDFU2E5xk
X-Gm-Gg: Acq92OFOYaA6aMUR0eiLgNctKl6damAYimi2SfnyTku6LGyGtkS5hKSO8+eF1pEc5CN
	25C8RXZl/fzC5PYltF41yo4ZxbgwJnY09Spz15F9jUpyteYo2TzCAxN+POQmax3dn3Ea+wbQuYW
	LNCIOA16a+7TRQmc5XDIi6ZYY2OvgHD6bY6OGT3rfCr2HDTf29/R1NjPJoK7zigJnyZXqVi5O3f
	LpjxzPu9TT2IuwZa11MhYj4ez9RI0/2sl/ZL4S9iRiKk6cc9jmWP7IJrPe6bC6UEfCSpO88XAHt
	r9C14q5YGWFf9kLyLuL10RvX4CH2iTplKHKbuisXJpJ3Hcxx3vUWqkXVzqkbCL8JdpIZaLea5rH
	XI8NLeibMlNFycAdWqfkqHR1Q0qOnRs6HhOuqheuVQ7A/eQSF1ShyNvceD2wpoPR3noN2L/hB/J
	Ff2OVvkAOI7OwZYj9KJAaec4UDOcMOHnAtsbl1zApwpC2raKfS7prbYccQ68C9CsR1lrizOyUJB
	mo=
X-Received: by 2002:a05:6a00:2987:b0:836:3f6a:3e7a with SMTP id d2e1a72fcca58-8452454cd35mr1655165b3a.26.1781665171696;
        Tue, 16 Jun 2026 19:59:31 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc825csm14212821b3a.36.2026.06.16.19.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:59:31 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v4 0/2] pwm: Add Nuvoton MA35D1 PWM controller support
Date: Wed, 17 Jun 2026 10:59:23 +0800
Message-Id: <20260617025925.2539334-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,nuvoton.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-9302-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cwweng@nuvoton.com,m:cwweng.linux@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:cwwenglinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cwwenglinux@gmail.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cwwenglinux@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nuvoton.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6051669633A

From: Chi-Wen Weng <cwweng@nuvoton.com>

This series adds support for the Nuvoton MA35D1 PWM controller.

The MA35D1 PWM controller provides 6 PWM channels. The hardware supports
several counter types and output modes. This driver configures the controller
to use up-counting mode, auto-reload mode and independent output mode. The
waveform generator is configured to drive the output high at the zero point
and low at the compare-up point.

For the up-counting mode used by this driver, the counter counts from 0 to
PERIOD inclusive. Therefore, the programmed period is PERIOD + 1 cycles. The
hardware can generate 0% duty cycle with CMPDAT = 0 and 100% duty cycle with
CMPDAT > PERIOD. To keep 100% duty cycle representable, the driver limits the
maximum PERIOD value to 0xfffe and reserves CMPDAT = 0xffff for the full-duty
case.

The hardware buffers PERIOD and CMPDAT updates when IMMLDENn is disabled. The
driver keeps IMMLDENn disabled, so period and duty cycle updates take effect
at the end of the current period. Polarity and waveform-control changes are
applied directly and may cause transient output changes if the PWM is running.

When the PWM output is disabled by clearing POENn, the output pin is put into
tri-state according to the MA35D1 reference manual.

Changes in v4:
- Add a Limitations section to describe the hardware capabilities and driver
  limitations.
- Add a link to the MA35D1 reference manual.
- Replace register address macros containing the base pointer with register
  offset macros.
- Add readl/writel/rmw helper functions.
- Rename TOTAL_CHANNELS to NUM_CHANNELS.
- Use unsigned long for the cached clock rate.
- Use devm_clk_rate_exclusive_get().
- Configure polarity before enabling the counter and output.
- Add controller initialization for up-counting, auto-reload and independent
  output mode.
- Configure the waveform generator for zero-point-high and compare-up-low
  output.
- Fix the period conversion because the hardware period is PERIOD + 1 cycles.
- Limit the maximum PERIOD value to 0xfffe so that CMPDAT = 0xffff can be used
  to generate 100% duty cycle.
- Use CNTEN and POEN bits to report the enabled state in .get_state().
- Disable the PWM by clearing POENn and CNTENn.
- Fix error message capitalization and trailing newlines.
- Fix coding style issues reported by review/checkpatch-style tools.

Changes in v3:
  - Update nuvoton,ma35d1-pwm.yaml
    - Add maintainers entry
    - Increse "#pwm-cells" to 3
  - Update ma35d1 pwm driver
    - Make include header and macros definitions organized alphabetically
    - Rename macros REG_PWM_XXXX to MA35D1_REG_PWM_XXXX
    - Add macros for register address

v2 resend:
  - Remove wrong 'Reviewed-by' tags.

Changes in v2:
  - Update nuvoton,ma35d1-pwm.yaml
    - Fix 'maxItems' of 'reg' to 1.
    - Remove unused label
  - Update ma35d1 pwm driver
    - Remove MODULE_ALIAS()
    - Add chip->atomic = true


Chi-Wen Weng (2):
  dt-bindings: pwm: Add Nuvoton MA35D1 PWM controller
  pwm: Add Nuvoton MA35D1 PWM controller support

 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      |  45 +++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ma35d1.c                      | 344 ++++++++++++++++++
 4 files changed, 399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ma35d1.c

-- 
2.25.1


