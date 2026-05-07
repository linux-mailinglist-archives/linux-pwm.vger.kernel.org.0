Return-Path: <linux-pwm+bounces-8825-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN9OBWxA/GlMNgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8825-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:34:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A354E4154
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 09:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABD913004C51
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7933D4EC;
	Thu,  7 May 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="BFoTC7sA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKxinEHS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706030AD00;
	Thu,  7 May 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139204; cv=none; b=i477oA8dcfgtjrZkLgvJR93TcYgutKG428OVUMIgp5xehdtIXFO0adnsLwYKVpot5mt9zM0OsVENRLFf/u5JT3M7e+ISo0Y3lnsEidm9Z3ljNIqq4oAobzbfs7BqjAr9NQlbVX+5gPO+Uu2DkagAYbgTCvbFefOR93u0tzBMrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139204; c=relaxed/simple;
	bh=oNNEw9bLdFvVnMGexbn1rELFpbY8zSMmrT7OEjZH3no=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eViZTFyK1t/icV+waFcFS06NkpdWK28znWka7cHQdC610cjaTjOu1ygZDM/D2c22dq5bVWwATgPzmrYKdg2Xl2LUi4Sbt/eEe9zmXl75XbyBxUiCx9tTZ8vsplpNsljw+tN4YT3ro+tLrnLui/nN5gjDC5+inboFPdbqAlhWuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=BFoTC7sA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKxinEHS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BD8014000A9;
	Thu,  7 May 2026 03:33:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 07 May 2026 03:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1778139202; x=1778225602; bh=ob
	aRYY9JzXNdH88KlhAeQWbZmg1Lx4Y8Y1HPVUVLH7s=; b=BFoTC7sApuZKlWxBx5
	+usWZD/Gro5rpeB2DD/9LUtgW+KwsZxfaQ0/hEeM5/JkStz37Fl2zbS23Le1aaJp
	Zz1+HG1t5HVneTcYLtkhmuM3xDMMWuo13VXYwXsEHXOgLqLWGSHtck7JdjWBlmYt
	sYhtNuyHlk2AcXIzf3Ts7THuqMPNyqwtF1qSg10iza/HhvQ3Ab0dJ9yPdeOcX2lf
	vdNf/jf7kuihd0T4WO5x6PldWkuiwNhmhoSjh3l9bEbtxCieXhzGOwPW4CB7dCcs
	pjl7a/0DWKBL2GSvV0IX1Zn03u8s7HNkqaC75UluD/Nuk7RhPr7XvNxrRywHKnQ8
	hvTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778139202; x=1778225602; bh=obaRYY9JzXNdH88KlhAeQWbZmg1L
	x4Y8Y1HPVUVLH7s=; b=QKxinEHSN6lIpgBWAmIp9TYQR0x6LOW/sXj0FjG2F4Qr
	cZ5QLNPTG53trqofjNvrcbxeaeLJnGRHbuzr36S0KLSariBNc7oCIKzcMHi7+jhd
	2OJdaL26SQFNExvk3Y3CiSrTk8VigH5TYILrzNDj0u1cFzKAjPVca1oP7lUYDvxb
	YPdJT+Lop6MYDKDRejtq24QgCu+iXWv7/jryc6oFNvRFneacKBqPLzIr28kme1KZ
	W3HZO3asghankiOOsILa7kF2GnEvQ7aLcHGXdYBp08Y1g2jsyxFGf3uy2LKcdzzi
	OwByPvNEgGnnBw4at27P0qiciRlnO3zd0V8uskF92Q==
X-ME-Sender: <xms:QUD8aXvoqNaInCsWo4L-piFTFezYVujEfLIGf0M3QmXT_sWrnGzE8w>
    <xme:QUD8afgUieJkm_l4y4t2SwlxpXBl41EQ1HMdDBo_q48niDr3yLfBq5bkg7_bQTNww
    UI3XEf9w1KGxk54KFeBlPsDKINMClaXTOlnfaz8uD3qXKPOCFsmVMo>
X-ME-Received: <xmr:QUD8aSffngvcYKyw-3RfI17UGDESGUI88OM7wcR1_yJNfInLigetknz_r1fVh6W0sdTK7pp4nTTT5fSj8TKdZLb1I2_8JmBvByqmsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepueelgf
    fhfedvgeelfeduuefhfefhjeeihfffueefjeeihffhheeuteeuvdeuhffhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepvddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdifrghttghhughoghesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesghhomhhp
    rgdruggvvhdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:QUD8acnBJAO8PYUMFX4rJwgoLKq3KdUfZbl_iPgz6ErxjHsmcYIMNQ>
    <xmx:QUD8aUomx87W9ppOpkibHg40btOx2hZ6deDS7rShW6wqnR6Q4pTaCg>
    <xmx:QUD8ab96Ow2VzIj2QbZvz3Ya25TobhNgac2rqSgzTlOjL8qBryOcFA>
    <xmx:QUD8ad3h3XdB9bmr6j0Q3T0xrTzlRF6dA64pbwjPEQvAWjEIYRd5CA>
    <xmx:QkD8aX85hs3TiruHTUdJOIhBjwBKGdqih7I50og5PORDdgOEqUJPJ3wv>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 03:33:20 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 0/5] Initial Apple silicon M3 device trees and
 dt-bindings
Date: Thu, 07 May 2026 09:33:06 +0200
Message-Id: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQyw6CMBAF0F8hXVvTB+Xhyv8wLioMOgYLtqXRE
 P7dgiTGjS7vJHPmZkbiwCI4sktGYiGgw87EIDcJqS7anIFiHTMRTGRM8pLqvm+B3iRFgx51S+u
 4VYG3AI6qSqWZrss814JEorfQ4GPhD8eYL+h8Z5/LtcDn6QoL9hsOnDKqilQAB1lKXeyv2hg9b
 A14MstBfDTF1B9NRO3EKtFIxUtg8KVN7+IW7kN8h1/bT9MLCtbuYSwBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3514; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=oNNEw9bLdFvVnMGexbn1rELFpbY8zSMmrT7OEjZH3no=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/DnYzjtukxMfXB8zd96D21HxNiyL3sqRNdZnLJ2c6b
 vHlY1zWUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCLu5owMp3pbr06rOVzYrv+b
 KdNdauXefeIKrZXnOiVXyF1cOk1+L8M/8yMfBdV3Wr3aLHzQv9a9cXdE0pr3LwWc7M+UTLui938
 tDwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Queue-Id: 68A354E4154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,jannau.net,ubuntu.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8825-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hej,

This series adds initial device trees for M3 Apple silicon devices. The
device trees contain only a minimal set of hardware not going much
beyond the minimum required for booting kernel and initramfs and
verify via serial console that the hardware and drivers work.
The hardware with the exception of the interrupt controller is
compatible with the M1 and M2 SoCs and the existing drivers.
`make dtbs_check` depends on the already applied and dropped apple,i2c
and apple,pmgr dt-binding changes.
The watchdog load depends on stalled and forgotten addition of the
"apple,t8103-wdt" compatible posted in [1]. I've replied to the thread
to get the change merged.

Merge strategy:
Apply whole series via apple-soc / arm-soc to keep `make dtbs_check`
errors minimal. Otherwise no dependencies between the patches.
I might want to send another series which depends on this later in this
cycle.

Link: https://lore.kernel.org/linux-watchdog/20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net/ [1]
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v3:
- adjust reg size of pmgr node to fit all its childrens' regs. Improper
  size was caused by a bug in the script used to convert Apple's
  power-states into DT nodes
- drop picked up changes from v2:
  - [PATCH v2 1/6] dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible" (for v7.2-rc1)
- Link to v2: https://lore.kernel.org/r/20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net

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
Janne Grunau (5):
      dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
      dt-bindings: watchdog: apple,wdt: Add t8122 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
      dt-bindings: arm: apple: Add M3 based devices
      arm64: dts: apple: Initial t8122 (M3) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
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
 14 files changed, 1848 insertions(+), 2 deletions(-)
---
base-commit: 37a578184d32b2e8110aa88c1c1fd10a23419e01
change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2

Best regards,
-- 
Janne Grunau <j@jannau.net>


