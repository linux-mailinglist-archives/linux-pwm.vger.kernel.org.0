Return-Path: <linux-pwm+bounces-9730-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5a/TGPtPV2pRJAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9730-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:16:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A775C577
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm1 header.b=XXVAw80L;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=VeFmygsB;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9730-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9730-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 484B1301C184
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C343F0A85;
	Wed, 15 Jul 2026 09:12:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48443ED13F;
	Wed, 15 Jul 2026 09:11:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106724; cv=none; b=ikA3QrgRT/9ArlK38KGMZyW2Ft3fP2rYYryklJadsIKuwB/R23dXQkfkDmtbCIertou2TXt1v/fvQDc4tYutjA3AbHYGcoycPijgpIJhxAc4ascWxrXda//4jgj8rRmlx1SsntoZhtRIzhvBPqrNosfNeBE/SaoPu1lddqYww6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106724; c=relaxed/simple;
	bh=WGdCRD8olgTcTbOwMTJIpRtuqgL1E83EbLrn0pZictg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ASc4bNevdUC7um3zkeYHMmghcKr4uRKZHkM774+oaTKxyhFWlTrbqKYo/uPUTuEiP6qeyas739PS62VBv9JstukTyIaWFOvFDa5Di7zMAGrkq972rENph04KHKrCeABARNxQ9sxAGrYegTxIMwUrj8z/gxm8jQ8IJ3S2N3+VDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=XXVAw80L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VeFmygsB; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53C30140005D;
	Wed, 15 Jul 2026 05:11:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 05:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1784106718; x=1784193118; bh=aV
	/hgiXVYoCu1+Cqb0P0yqXMulBX20+ZD1+O74lFupw=; b=XXVAw80Lga6BblLBHR
	CUTp456s4+uMBLB72ozt40TMPActrUa3hSDn/q3S+/ZY2aFMxx12YsXRxqKgyRRM
	UHobBVcK70wGQywH0J1FJ/44KYvAJar5BChrlxpmjIggHQZro4fb6N6PT/6ZK0nJ
	PwIxRUBnAI0rjJiTHFvAscJldC9Q4V3oLFulH3/agNU3rSIqbhHdgDXytn+Kds6v
	GvjalsqQmaBYPfBmHnfoUOqIumEtd4sVqSw8cT3p0mlKJvieTSma+YMSpLIjEzDP
	Ms++8QkDzWXkbhDMGohgRETU3aRTsokxCY40/VLiLmm64Hun/Dpwc23vgbPiw9C/
	Ev7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784106718; x=1784193118; bh=aV/hgiXVYoCu1+Cqb0P0yqXMulBX
	20+ZD1+O74lFupw=; b=VeFmygsBV9Yo02QetP5Ayxqdgid+2nUJCZYsfjFDnX7J
	s2luWHmRTzGZpYzxKqHmMguBmrkKuulmF8rNbPbNu+AWrXUU6vx2HWUDAhXSqrEE
	mXxOVNsnobI//glaumsXb6i6upFjDMW0VBra0M2eZaWfULeHU6yHmNgxEGaKNxQu
	QZ04XZ8CtWzqBaDV8jDi7meX7+bTN9UCipqVrSLeYjdl3ffY9/bzB1IKz1NvBi6d
	TIozqS/xLfvE+0jPuihJyk4cMMexywSfvKgERJCsHq9X4czdmntGU4L2jxBjQsK1
	aP/5s6h7lGYHmwW0EH/ioDvT/UQfIcA1oRcPf1UzyA==
X-ME-Sender: <xms:3U5XavpBlcVR9GdK9g8wVa0hJC--TXGP1IxQi_HFL4jWOxsXA-SM_g>
    <xme:3U5XaqBnWqLG0IaQy-Pr8EZz2iZc3I0fgxS_IxD55JoQG8qv6VTfXz8eAMRC3bYVl
    6G-wpQJK_haFs4NvwGAsDxwdfiQatHfvN3fIM0e0MHAoJllsG9tVVw>
X-ME-Received: <xmr:3U5XatXs0R_h8G3hzyrmMkxaFATapbNv7ez-kgKly2Oap3gshFceOmcdHAuccHvPpVPWh_YgKNJMlF-tbHLGoHKaAs6pNd0uSjHhoQ>
X-ME-Proxy-Cause: dmFkZTGaVIxi5m8iFPe70Q7AanPW/GghCFbudp+i8q/mEq0B8lDzcedxU92o9qOp2LdYI/
    C+0/HC1qVM5O99/2CjKID3ePKwnfCTlFnefuFZdzhKEd3gTOi/HBpq8hQapbdijYDy3eMt
    CYgmxETx0x9FmptXanVvITwTNPDOYvSMIxSoePiQm54ixLKUNzquhaW8wrTrt3lsAEKhoL
    6OzNAxIV0a8Aok6y42cbXjn8yEA/5NsJKD/JNheMaPHzlDZbQPy6z3hbto282yPH5Ex33C
    o+Xp0aGoSCQcsFKGREfnVbAC5yZCRa6OIbHnt4G69vL4xKCZcVHO38gsZbY/9dS1FIS9hW
    d4Xm/4tcOML65evMPaEyZBCm4DrlGmZk6kNptXa5O06Zl1H4pdWvP7wI+38MdrH+6/7MRI
    CMVPvl9SWabULplb9hEB9A2/hWwn+SEFjB5RewzQYtJVwsBws32U2T2ct1TqoCX65MWwF7
    ra+k5i275aXye05pVfsu57Xm/030FmM/rjZy4+LnhytPNis5uOHsznR0YuWFHdd80ZFcyc
    segBwgXZN7lKWoxioOMNebBw0CRXZhLuz50MOlNDlsIOZ310dx6GfdCUooXUxi7rqeg9Z6
    2g7+MyndWo4/Z+RZleXKfGfygkWUB9sHXs6SspatzAlJBFZnS9fBmz3M2yNA
X-ME-Proxy: <xmx:3U5Xau7lVs8PI5EDQ3oafnWg3vm_Ugc_GizRQJavWiFz_RCEfmZjag>
    <xmx:3U5XauC-KlEUgOJMKRw1xMYsJAOatoMZJ80G_JWBI0x_0HSsv3RaSw>
    <xmx:3U5XajAt7NdYxaEiSyakXyo5aDNmVsV7FlDA5aozBecF0Xe6A3BYkQ>
    <xmx:3U5Xauj6ja6OzUx8K87BA0h9gY1D4_BR8cWL3RmUfCmWVuDyLxmglQ>
    <xmx:3k5Xas4G4Sn5UDPCurviba3hspfBAkMhr3JUBiSFcHt9vnp52Et0YQc->
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:11:56 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 00/10] Initial Apple M3 Pro, Max and Ultra device trees
Date: Wed, 15 Jul 2026 11:11:47 +0200
Message-Id: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBAFf4X07JrSpiie/A/DobSrLCGlaQvBE
 P7dgvHqcZL3ZlYWMRBGditWFnCmSKPLIE4FM512LwSymZngouIXrkB7PyCkissFyFEiPYDNR4M
 RBKLRwtZWKM2ywQd80nLYH82X49T2aNKu3BcdxTSG95Gfy333K9V/S3MJHJRqJVdXKUsh7712T
 k9nh4k127Z9AK0EO23ZAAAA
X-Change-ID: 20260705-apple-t603x-initial-devices-2eeca2d9d25a
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5679; i=j@jannau.net;
 h=from:subject:message-id; bh=WGdCRD8olgTcTbOwMTJIpRtuqgL1E83EbLrn0pZictg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwv2u8DBmOSW9zPbn+NUkyG3lfWPzq/tXiLHa14klZ7
 Q8OVnV0TGRhEONisBRTZEnSftnBsLpGMab2QRjMHFYmkCHSIg0MQMDCwJebmFdqpGOkZ6ptqGdo
 pGOsY8TAxSkAU/1tM8M/G/8lIZsNHZR3xi9gSanW+sN+I652JqOIkQxb75xu128WDP/shMMrXfX
 5pA8IH57731e7juXdvmcRyf07pX4t1NtVLMUPAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9730-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url,jannau.net:from_mime,jannau.net:mid,jannau.net:email,jannau.net:dkim,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 560A775C577

This series adds device trees for Apple silicon devices with M3 Pro, Max
and Ultra SoCs. The M3 generation has fewer devices than their M1 and M2
predecessors. The only non-laptop device is the M3 Ultra Mac Studio. The
Laptops are the known 14 and 16-inch Macbook Pros now with M3 Pro and
M3 Max SoCs. The M3 Max variant with fewer CPU and GPU cores has
additionally only a 384-bit wide memory bus instead of 512-bit of the
full M3 Max. It has a separate identifier (T6034) and so there are six
laptop device trees.
Another difference to M1 and M2 Pro/Max/Ultra is that the M3 Pro is
distinct SoC design and not a smaller M3 Max. For this reason both M3
Max variants and the M3 Ultra will use "apple,t6030" as compatible
prefix. In the M1 and M2 generations Pro, Max and Ultra SoCs shared
"apple,t6000" / "apple,t6020" as common prefix. There is currently no
known difference but M3 Pro and M3 Max are not as closely related as
previously.

This series adds the same level of hardware as the base M3 (T8122) has
in v7.2-rc1. This includes CPU cores, interrupt controller, power
states, watchdog, serial, pin controller, i2c and the boot framebuffer.
This is intended as base so that support for additional hardware can be
added to all M3 based devices at the same time.

Merge strategy:
Since the dt-binding add new compatible strings without driver changes
it would be preferred if the whole [1] series would be merged through
apple-soc/arm-soc. This will help ensuring a warning free
`make dtbs_check` for followup series with additional M3* hardware
support I hope to send for this cycle.

This series will conflict with the M4 series [3] sent A couple of days
ago. I would prefer if this could be merged first (in order of SoC
release).

[1]: I see that the M4 watchdog change was already picked up by Guenter
     in [2]

Link: https://lore.kernel.org/asahi/a03c19ee-cf74-4f26-826d-f2bfb816fb3f@roeck-us.net/ [2]
Link: https://lore.kernel.org/asahi/20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev/ [3]

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- fix serial0 unit address in t6030.dtsi, drop erroneously added 0
- Fix device node reference in pinctrl_{nub,aop} gpio-ranges in t6030.dtsi
- fix i2c6 unit address in t6031-die0.dtsi
- fix cpu_p25 reg value in t6032.dtsi
- drop unnecessary aic interrupt-controller from t6032.dtsi
- drop "label" from keyboard pwm led node
- fix copy-n-pasted pinctrl in compatible strings in the apple,s5l-fpwm
  dt-binding commit message
- fix yamllint errors in apple.yaml and fix warnings in newly added
  lines
- fix typo in i2c commit message
- whitespace fixes in t6032.dtsi
- add missing Signed-off-by: for pmgr and pmgr-powerstates dt-bindings
  patches
- drop already picked-up "[PATCH 07/11] dt-bindings: pinctrl: apple,pinctrl: ..."
- add Conor's Accked-by: tags
- Link to v1: https://patch.msgid.link/20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net

---
Janne Grunau (10):
      dt-bindings: arm: apple: Add M3 Pro/Max/Ultra devices (T603x)
      dt-bindings: interrupt-controller: apple,aic2: Invert #interrupt-cells condition
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t6031-aic3 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t6030 and t6031 compatibles
      dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles
      dt-bindings: watchdog: apple,wdt: Add t6030 and t6031 compatibles
      dt-bindings: i2c: apple,i2c: Add t6030 and t6031 compatibles
      dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and t6031 compatibles
      arm64: dts: apple: Initial T603[124] (M3 Max and Ultra) device trees
      arm64: dts: apple: Initial T6030 (M3 Pro) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   37 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    2 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   10 +-
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    2 +
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    2 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    2 +
 arch/arm64/boot/dts/apple/Makefile                 |    7 +
 arch/arm64/boot/dts/apple/t6030-j514s.dts          |   22 +
 arch/arm64/boot/dts/apple/t6030-j516s.dts          |   22 +
 arch/arm64/boot/dts/apple/t6030-pmgr.dtsi          | 1437 ++++++++++++
 arch/arm64/boot/dts/apple/t6030.dtsi               |  524 +++++
 arch/arm64/boot/dts/apple/t6031-base.dtsi          |  297 +++
 arch/arm64/boot/dts/apple/t6031-die0.dtsi          |  197 ++
 arch/arm64/boot/dts/apple/t6031-dieX.dtsi          |  107 +
 arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi     |   53 +
 arch/arm64/boot/dts/apple/t6031-j514c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6031-j516c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6031-pmgr.dtsi          | 2400 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031.dtsi               |   48 +
 arch/arm64/boot/dts/apple/t6032-j575d.dts          |   46 +
 arch/arm64/boot/dts/apple/t6032.dtsi               |  416 ++++
 arch/arm64/boot/dts/apple/t6034-j514m.dts          |   18 +
 arch/arm64/boot/dts/apple/t6034-j516m.dts          |   18 +
 arch/arm64/boot/dts/apple/t6034.dtsi               |   12 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |   66 +
 26 files changed, 5779 insertions(+), 4 deletions(-)
---
base-commit: 5f883c28f3980af462a6332fd72ff184e6985711
change-id: 20260705-apple-t603x-initial-devices-2eeca2d9d25a

Best regards,
--  
Janne Grunau <j@jannau.net>


