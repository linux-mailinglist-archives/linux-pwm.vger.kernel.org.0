Return-Path: <linux-pwm+bounces-5872-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C10DAB0F8A
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF600503342
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021728D8FD;
	Fri,  9 May 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n8ShsXQ5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F7266B44;
	Fri,  9 May 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784099; cv=none; b=Sz6H+p6DGEBPaM203oCSLVbOyLL0YLwz9ZUb0UGUaQcWgnUT0FeEBW+0qe80nafNa8zHmGc9gQHa9QC8KuXWtRT5aNr40rc6jwReZHEedgQ/3RBdhMkqpfvXgVLU3DgKJb6LZQcKfU6oAi8vXzvF5f0lbSW2zhtE35r6P+ap9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784099; c=relaxed/simple;
	bh=clXk6+TyzwGn7jst9KCUuBWidIZ/3lsFT8MeDrELOVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P1ZeR3NW7cO+aA1K+fF+SCytVtdiaJTcDPb7007JPQn2g3RAIGPIZLPAupuOVqg54L7DWU0KwdVThOyejLsWUpy0SmcQq1xQqXJs3j2PVo9YAwmqlScVLWsybRn9fNGHMvyKPmKEEhWLcbf67vuTJ7t1QR9F5dzWSwuOIuGDjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n8ShsXQ5; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5550341DF4;
	Fri,  9 May 2025 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746784089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8klRadoLwDsuugPRdfkTBI5fHbN2cc7BUxlcxRublVA=;
	b=n8ShsXQ5N9AfaM9I+nuF0nB7V0W6tS6DAeRJIakU8triwC/tjTW1B6rxifJZr5uVorXtQ0
	5pWOOa2VbZWc2F1/VVh+rMKN5w3I0PHP1iU7wNbuLqnpGfrrfaFa5v+/+PzJ0SvQIl/WE5
	RGwdUMSdZA0hClfo4RxxDfZGwFmewPPcUJeGuaxXeA0BFkRKwpYgjm+YihAP3OejX74+Yy
	bou2p+smtRxzT0gYQ98LBWj6WBW1FZyUh95Wfz0hwG5Yprs69Ol5yGee5JK/NX5Mt+jkzZ
	W65BTrPV87lHCx64xq76+bt3k9YzrApvCaH735sSjhq1a/PLPU07jZpdBqCHRA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Date: Fri, 09 May 2025 11:45:42 +0200
Message-Id: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMbOHWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHQUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNz3YLy3Pji/IKM9HxdUwNjoyRjC1OLZCNzJaCGgqLUtMwKsGHRsbW
 1AKgEj4lcAAAA
X-Change-ID: 20250407-pwm_sophgo-5032b3858c27
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepvfhhohhmrghsuceuohhnnhgvfhhilhhlvgcuoehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekvdeggfefheektdevtdeuleffiefhveduhefhheekgeeujeevkeelfedutedvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepvdgrtddumegtsgdugeemkeeflegtmeejtgdttdemrgegugejmeefvgelvgemvgekfedtmegsfegvtgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeekfeeltgemjegttddtmegrgegujeemfegvlegvmegvkeeftdemsgefvggtpdhhvghloheplgduledvrdduieekrddurddufegnpdhmrghilhhfrhhomhepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhor
 hhgpdhrtghpthhtohepihhnohgthhhirghmrgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehqihhujhhinhhgsggrohdrughlmhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: thomas.bonnefille@bootlin.com

The Sophgo CV1800 chip provides a set of four independent
PWM channel outputs.
This series adds PWM controller support for Sophgo cv1800.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
[Thomas since v8]
Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v8:
- Rewrote supported frequency
- Hardcoded HLPERIOD_BASE and PERIDO_BASE
- Change usage of update_bits to set/clear bits when needed
- Rewrote construct of enablement of PWM
- Fixed OE activation
- Fixed hw state modification in case where pwm value cannot be reached
- Renamed variables
- Errors out for new cases
- Reworded some comments

v7: https://lore.kernel.org/linux-pwm/20240501083242.773305-1-qiujingbao.dlmu@gmail.com/

Changes in v7:
- add detailed Limitations
- using BIT(n) instead BIT(0) << n
- use 0 instead of disable macro
- modify OE judgment criteria
- add devm_regmap_init_mmio error message
- delete unused variable

v6: https://lore.kernel.org/all/20240406063413.3334639-1-qiujingbao.dlmu@gmail.com/

Changes in v6:
- delete the OE function because we plan to use the counter subsystem
  instead of capture, so there is no need to reuse this code.
- fix set polarity reverse error.

v5: https://lore.kernel.org/all/20240314100131.323540-1-qiujingbao.dlmu@gmail.com/

Changes in v5:
- drop filename
- fix macro
- optimize cv1800_pwm_set_polarity()
- optimize cv1800_pwm_set_oe()
- add comment for cv1800_pwm_set_oe()
- use ticks replace tem
- fix duty_cycle larger than period_val
- use devm_clk_rate_exclusive_get() replace
  clk_rate_exclusive_get()
- map linux polarity to register polarity 

v4: https://lore.kernel.org/all/20240304085933.1246964-1-qiujingbao.dlmu@gmail.com/

datasheet Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
page 614

Changes in v4:
- use macro instead of npwm number
- add support for polarity feature
- add support for Output-Enable/OE feature

v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu@gmail.com/

Changes in v3:
- use 0x08 instead of macro
- split if statements based on conditions
- in order to round up, first calculate the
  number of high-level cycles, then subtract
  it from the PERIOD to obtain the number of HLPERIOD
- use new pwmchip_alloc() API instead of old style

v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlmu@gmail.com/

Changes in v2:
- drop full stop from subject
- re-order maintainers and description
- pass checkpatch.pl --strict
- fix naming errors
- add "Limitations" section
- use a driver specific prefix for all defines
- using bool instead u32 in cv1800_pwm_enable
- check and set state->polarity
- use mul_u64_u64_div_u64
- use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
- using macro definitions instead of shift operations
- remove shift operation on 0
- use priv replace cv_pwm
- hardcode npwm
- set atomic to true
- remove MODULE_ALIAS

v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@gmail.com/

---
Jingbao Qiu (2):
      dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
      pwm: sophgo: add pwm support for Sophgo CV1800 SoC

 .../devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml |  45 ++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-cv1800.c                           | 294 +++++++++++++++++++++
 4 files changed, 350 insertions(+)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250407-pwm_sophgo-5032b3858c27

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


