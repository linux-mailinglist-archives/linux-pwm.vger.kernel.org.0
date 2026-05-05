Return-Path: <linux-pwm+bounces-8771-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNN2CAHS+WlHEQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8771-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:18:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 231744CC684
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40B6A307F9CB
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069C407585;
	Tue,  5 May 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="B+48+5Ay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eq2RX346"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5D3BE168;
	Tue,  5 May 2026 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978984; cv=none; b=EFexwQoMvW9XiYHk6EPYOks6ILVN9jBIJE/lPyfYgwbWdcrnkqMFFYr6J86BK3yH1YY2Hvx/N0Ap0p/30FfQ0kf6SkpO+wyG1BjDPop6ztBXh13JYY4MmgFq8pm5DCzfBiwoDRV6qW3a4ZATpQ/1jgL8r2zpDt7GJ6DeYfih1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978984; c=relaxed/simple;
	bh=kw/jqPJJLRV39vNPy5OhUOfHnyxSY0o6edzYEkXoIOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JGP5ou0axM/ettqwsyiT2Hqn2LYMXLFctLugeZXzBP24aHI3vMZpW3/Eg6gowukLnxDk2hXTN0pvWSTIeJXWG6eIHJP+svrYeFP11m+QbwYjKYy5P3BIKHa3sTN4gOn+z9FZHQ/+IeTSMZGIvRd4q7wRQ+msOcrjouL1ARgFJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=B+48+5Ay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eq2RX346; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77FC57A0052;
	Tue,  5 May 2026 07:03:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 05 May 2026 07:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1777978980; x=1778065380; bh=Ef
	lh4sYkW/Ot30zqHUk4wwtQLyml0QQwfhJwCwbZgUY=; b=B+48+5AyOaquNHeA/F
	2RkTfGj+QIucB+XJw8Cv5UCaPjukfMgK8GXrH6XIq/Ymdjer2c28cob5pIZPocJA
	jiYvL6l+/7AjpGcsE0+BJdGxwDf+Kshx4aGpCwcLcEgI5jn8OSZK9+Xw2/J0TlAq
	9ebGIHPjSZ5g2j2kA9m2XIScYievR8fOZiue38CBk5pViYdfH+2r3Uvm4qYnZEoV
	V3CUGX+/5XTKM2t2oNS5ieElm3AyTjVjBbrVqxswrsReL0Y/DqnyZXnHi3P4UzRy
	zad0UDZIunhK0PSN8RHuZx6EzryU4rVOUPOSBzoh/e/6d0NS0VQ9ThMG07nj4sm6
	GQsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1777978980; x=1778065380; bh=Eflh4sYkW/Ot30zqHUk4wwtQLyml
	0QQwfhJwCwbZgUY=; b=Eq2RX346eYIFmeEKt3SuMnIBXvf6BtEfnXfrfK+pLEya
	vBq7b8VqYic8KwtlbPStZGz4mKuPl0lIG/EIRNBdEOek8s8303Tkptc3gjZHiE01
	Uwlh/ArBeWW/2NZcFQ0fwW0/kemedi6+7hdBkwfDxHHu076NXO9OxUlpitb8+mqx
	y44oZMPjhQ1ezFawfhB39WXVk+x7FluTelqVdOA3BoSoKJ0Q8tO/rViCLJ+k9JzZ
	kP1dwX6gXY0NIZu1sInY4TQq3B+Ge3aZq2D/xtE1P8e0eYsFeU58kadaz4+FU3xN
	1qx6qpUk4rsTkw70cVPlvyFFr5vubfkqr0KWptKbLw==
X-ME-Sender: <xms:Ys75adh-96U-DAkkzXHBZbE9AHXJ10dJSwbkL0_MbL-0zac7LjYdKw>
    <xme:Ys75aYczQU8hoT_dGNeIKzNCofIjJ8-_8wjGZZ7exs0aUnuEZWqZk21yR_WnF6WED
    YzLvhDQtnLL7oi-63lf2_xyQps2hY1Te-85xcAJjb-BNKoo79YQUA>
X-ME-Received: <xmr:Ys75aanukK-20eSjAvMMqgofLWtT_wTEfpgbwRZ1GxSFQd8z7Rl361lWSoZkNAgwN2xd1N_J1aDOrcyGF_K9yoyQ1uIltrQcfcQgsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepueelgf
    fhfedvgeelfeduuefhfefhjeeihfffueefjeeihffhheeuteeuvdeuhffhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtohepfihimheslhhinhhugidqfigrthgthhguohhgrd
    horhhgpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdifrghttghhughoghesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjphgvihhsrggthhesuhgsuhhnthhurdgtohhmpdhrtghpthhtoheptgho
    nhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtg
    hkqdhushdrnhgvthdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ys75aaqBpwf_P3ZKXU9352ixQRazI5PwEJnYsQtHcdAEWZNbZpwu8w>
    <xmx:Ys75aZ-iWlNniXOGEQ2oQPMn-N2Ec2TtPhEtbacvstsEC-IqgLGF_Q>
    <xmx:Ys75aT0cdVPOxpz9CqQzjX7kj3fJVZ-ivFNpm-XglGp90bcFpiHonQ>
    <xmx:Ys75acl7M1l4rYXBPsPerkWkiFoKTZh1t7lm8Y1tKxTQ_-ubgjHiug>
    <xmx:ZM75ackIoD5S8dHN-iDmSUX65u9bp4iottCE4BvLcFGv6O7vV0NXoiPn>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 07:02:58 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/6] Initial Apple silicon M3 device trees and
 dt-bindings
Date: Tue, 05 May 2026 13:02:38 +0200
Message-Id: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Pyw6CMBBFf4V07Zg+eLryPwyLCYwyBgu2hWgI/
 25F1i7PTeaczCI8OSYvTskiHM3sebAR9CERTYf2RsBtZKGlzqVRFeA49gQPA2w5MPbQxquGgiP
 ykDVZmmNbFQVqERWjoyu/Nv2ljtyxD4N7b7VZfdddrOV/8axAQlammhSZymB5vqO1OB0tBVGvv
 5Sj5xQfCHtvXT/l9Qdj3gAAAA==
X-Change-ID: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Kettenis <kettenis@openbsd.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Joshua Peisach <jpeisach@ubuntu.com>, 
 Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=kw/jqPJJLRV39vNPy5OhUOfHnyxSY0o6edzYEkXoIOo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyf5+K3XWB+ZR/rXmml9lFGe69Ybeftc0EffEoZuUTmN
 F3fkje7o5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwER0XzEyPHvxe9vTVZpvGU/X
 n7etN/2elfsiK6Y35OWkhbtuOISGRjEyfLl1vNhr8T7vzQ9Zpt7Ywuvz6eq0/07H1+6cEaL8/E1
 OFBcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 231744CC684
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8771-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,jannau.net,ubuntu.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jannau.net:email,jannau.net:dkim,jannau.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hej,

This series adds initial device trees for M3 Apple silicon devices. The
device trees contain only a minimal set of hardware not going much
beyond the minimum required for booting kernel and initramfs and
verify via serial console that the hardware and drivers work.
The hardware with the exception of the interrupt controller is
compatible with the M1 and M2 SoCs and the existing drivers.
`make dtbs_check` fails due to already applied and dropped apple,i2c
dt-bindings change (commit c5f25f5800f5 ("dt-bindings: i2c: apple,i2c:
Add t8122 compatible") in
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
i2c/for-next).

Merge strategy:
Apply whole series ivia apple-soc / arm-soc to keep `make dtbs_check`
errors minimal. Otherwise no dependencies between the patches.
I might want to send another series which depends on this later in this
cycle.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- specify merge strategy
- rebased onto v7.1-rc1 and thus dropping the aic3 comment
- collect Acked-by and Reviewed-by: tags
- drop already picked up changes:
  - [PATCH 1/9] dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles (in v7.1-rc1)
  - [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible (in v7.1-rc1)
  - [PATCH 6/9] dt-bindings: i2c: apple,i2c: Add t8122 compatible (for v7.2-rc1)
- Link to v1: https://lore.kernel.org/r/20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net

---
Janne Grunau (6):
      dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
      dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
      dt-bindings: watchdog: apple,wdt: Add t8122 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
      dt-bindings: arm: apple: Add M3 based devices
      arm64: dts: apple: Initial t8122 (M3) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    4 +-
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    4 +-
 arch/arm64/boot/dts/apple/Makefile                 |    5 +
 arch/arm64/boot/dts/apple/t8122-j433.dts           |   19 +
 arch/arm64/boot/dts/apple/t8122-j434.dts           |   19 +
 arch/arm64/boot/dts/apple/t8122-j504.dts           |   37 +
 arch/arm64/boot/dts/apple/t8122-j613.dts           |   35 +
 arch/arm64/boot/dts/apple/t8122-j615.dts           |   35 +
 arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |   48 +
 arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          | 1149 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi     |   32 +
 arch/arm64/boot/dts/apple/t8122.dtsi               |  444 ++++++++
 15 files changed, 1851 insertions(+), 3 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2

Best regards,
-- 
Janne Grunau <j@jannau.net>


