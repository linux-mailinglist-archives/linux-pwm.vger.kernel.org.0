Return-Path: <linux-pwm+bounces-8299-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH7bJlM9vWmJ8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8299-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:03 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF142DA33F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044D73036604
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8DC3AC0D9;
	Fri, 20 Mar 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="OfIMbLHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnXeVY3Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125C397E87;
	Fri, 20 Mar 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009422; cv=none; b=N8yP1wgDcFrqoJgYEysVsUqH1TlCeMOuGLTb8AzmzYGD1ma8rpG+R4US+ZdEDJMncC4sR0mhju92cyHpI9K7gyUGKE7+8DMOdvWWWm4SrcYR+jRN5kWdEoElINmQtXKfmpHbYuj6DKJETGI9njmliUsthwyFiAS0OH9/dVykqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009422; c=relaxed/simple;
	bh=JxhD5pyU9TlybIWgDe9thdmFXajEwZfzNZlK9i5a+8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZaDsRiMHIbOR0Awqk8DZrhG4oHIt9Co3yDrIXlM/jJ64URBi3kk0Yu5XMTVWV5oHYm6yQEnAq09xLK0WM59nl6B/1UNwdZhbycxNx1AJLcl8PY6+vXjgOoII2Ca1A/Afg6pIb9lRK0QgNJKN31C4un8avv6Khf25X9Gx6D+4joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=OfIMbLHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnXeVY3Z; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id E4AC813800D7;
	Fri, 20 Mar 2026 08:23:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 08:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1774009418; x=1774016618; bh=vp
	5vpsrgGynCEXTWY7d25hwmYtHsPR9BeSeV6eOnFM4=; b=OfIMbLHCeYetfjS2QD
	iaIyk7LGNtMja47diILroL4QAuTGt0XSKK296m0pGA1z+Vs+MDodV6aeY5+Y6Bna
	d9o/s3tMQopb1NLuZ4Clb5HSDPQ5GBevrNnPC8PZYWvhID9KGpHsXGpaNSUjgLP5
	a1HfP1gDaS9rvQHuDzQ4lBy7ukEBT0rKvog6f4crHXrXdlFyHYro+A5oy9ladteH
	UmHP1LIWFQJBct4HBN77WsSz1BHzuWGMX/JjlKlak+s5Zj3qIrSEW9gglXXsWH9n
	WznRZWxSmEqlHQLz66GDquLkyka0xIIQULRjcpLsKkHLzxab98eoSRGBBgUlqToQ
	6sWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774009418; x=1774016618; bh=vp5vpsrgGynCEXTWY7d25hwmYtHs
	PR9BeSeV6eOnFM4=; b=HnXeVY3ZckUVA58JrrQLhRJeTnxfBNryuCqC7Lt/Qn6E
	lwFgqwIgG+Xq0ETzyJXn8d1OYkPdya3Sdc+qXecKmCtLnUMWhkiR5XYxF0cVYgjG
	5Kg1RdtDIPDLDO1ZwmOXcxw3SlPuKVJ/vjVLEOmXZL19tkRGwufODdmaOzc+vCDt
	JriQQrq2Nj2pzvVDKHLUIJ9UsystbeVnvyL0qJte9WYBgjdYzvCeVuQFaQWAoTDw
	aWX+HpzYlPkmA7u7QBvJygqIMHt0Mql5XsijHUVfsi1Iueqhoiw4Oq1YsaUZJM63
	vTnYiNTJEQXh60zDDO1zxMDY5d2z1kvY3gszkXyt1A==
X-ME-Sender: <xms:Sjy9ad1ItbEf2PWzpeW_p5wGjSRI-YCLDDw7_j3xGrYLSPL94ZumWA>
    <xme:Sjy9afGkPs2hA3yZGrRVbykayZRVBj8-CulTzs7tY2_x4bXn0gytA4mjPa9U73DeP
    YqjuSyMW35ZeTfWojqwk9oXO7cGvrm2URtq95v6s2MChxd3Me34jg>
X-ME-Received: <xmr:Sjy9aUgT0YZGkX4cCoBxxxvVc7A95sflkkZS9beMAGMldv2bsKKVDGhG4mdxQqXB2coRCTphXogpZjF6MP1a2VgOCxHkLJvdPVJNGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepueelgf
    fhfedvgeelfeduuefhfefhjeeihfffueefjeeihffhheeuteeuvdeuhffhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepvdef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrvghlrdhrvggvvhgvsh
    dtjeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhushifsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopegtoh
    hnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkh
    gvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvth
    htvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtoheplhhinhhugidqihdvtges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Sjy9aYf3AHRaW_UpygGmBVjs_4bpPiGUSCh6gZ3wcKgxDHTpcZXbLw>
    <xmx:Sjy9aazUMdXiXgf1Rw30tXR7WnWIbbtQGkdpDZacZrMetgNDQYDcIg>
    <xmx:Sjy9aSZEfBrcEf6tsUV6b2wIqatNN_8cmT5s8XQ6gwE1VvnlHtWPbQ>
    <xmx:Sjy9aYJ0ddtXxBSF1vv3LX9-wnOFAgWq6Fai_vVQwnlzyqxAz3G1Yw>
    <xmx:Sjy9aSZU8XUOM3grg6K5NBA8Uoyahp-UUIimdgVCtrFzskBMfYuaYDCs>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:23:37 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/9] Initial Apple silicon M3 device trees and dt-bindings
Date: Fri, 20 Mar 2026 13:23:18 +0100
Message-Id: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADY8vWkC/x3MSwqEMBBF0a1IjbtA4w97K42DInlqgaZDIiKIe
 zc4PIN7L0qIikTf4qKIQ5P+fUb1Kcgu4mewumwypenKuhpYQljBW83qdVdZ2eXKYo9A4ta2TSd
 u6HsxlBchYtLz3f/G+34AHnfH8G4AAAA=
X-Change-ID: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=JxhD5pyU9TlybIWgDe9thdmFXajEwZfzNZlK9i5a+8A=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsy9Nu6rPrWZBjtWxbX0vq5Q7L754tARZ53PcUICVrUqm
 u4pP1Z0lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmMjTX4wMTYU/n1QZ/s7OO6Xz
 ymSv4kSnp5O2LVVQmTmj3u2v2+FbBxj+O9dPjIl8ZWn2pFxz+71ONYfr0g9to1fGFsxan1Yk9+A
 yKwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8299-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,jannau.net,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:dkim,jannau.net:email,jannau.net:mid,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FF142DA33F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hej,

This series adds initial device trees for M3 Apple silicon devices. The
device trees contain only a minimal set of hardware not going much
beyond the minimum required for booting kernel and initramfs and
verify via serial console that the hardware and drivers work.
The hardware with the exception of the interrupt controller is
compatible with the M1 and M2 SoCs and the existing drivers.
Changes for the interrupt controller were sent separately in [1] and are
picked up and in linux-next. The device trees pass make dtbs_check with
the apple,aic2 dt-bindings change from that series.

Link: https://lore.kernel.org/asahi/20260223-irq-apple-aic3-v3-0-2b7328076b8d@jannau.net/ [1]

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (9):
      dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles
      dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
      dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
      dt-bindings: watchdog: apple,wdt: Add t8122 compatible
      dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
      dt-bindings: i2c: apple,i2c: Add t8122 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
      dt-bindings: arm: apple: Add M3 based devices
      arm64: dts: apple: Initial t8122 (M3) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    4 +-
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    4 +-
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
 18 files changed, 1859 insertions(+), 5 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2

Best regards,
-- 
Janne Grunau <j@jannau.net>


