Return-Path: <linux-pwm+bounces-9653-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxaLFm1PT2qYeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9653-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:36:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01672DCA9
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:36:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=hrhXbskg;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=RFwp6tIW;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9653-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9653-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 418EF30E2446
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF813E4C9F;
	Thu,  9 Jul 2026 07:31:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515713E44EC;
	Thu,  9 Jul 2026 07:31:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582280; cv=none; b=l32JS8lCmmkehiyk4nJw5T8xXMX18dq6LFwDcXlN7hh+eEZa05xPhgGIDtL6snyza90CwOQDEv8MOOZaMtVu3/hx1BjBjWOeFjE9TFpxRn5sdBNh7szAF+mXS1t+l4DOIekSWGh0c3qJDfhnfjFeAz2Kvbzpb9H/vaO0HlrLzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582280; c=relaxed/simple;
	bh=XsJSiWwd2mbK2l11b/JXgHSqFuO9/PYl34cq33dd54o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ued3SddebgNiRLq2CCe/0oLD7/UZUCFgufVvDhV5/Q0Lyqe+Y/Xnf1dRTxhg39XhXAb3RlG20FO+0BVkveCUziaa27xBFKGZ3X3K5odADQnYU02J+CsPaBGDWaeVU5xOEVOGFSzYpWnCIPENLb9T9dr0+fOn46wQktYDoMrZLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=hrhXbskg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFwp6tIW; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 7BC79138006C;
	Thu,  9 Jul 2026 03:31:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 03:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1783582275; x=1783589475; bh=ty
	kZSdBbFVnoxsjT3yV+4MRoChTaLH6xBUntMi9i5W8=; b=hrhXbskg7JksXDuhBv
	pHSvTZd++o1Vmt7b3L4uOQO2/ACUBJDBMlVJXM0JcuJVERnncBNTzucq4b5my8yP
	XnNg1UXNWqMy+kmlieCZndfewzQtUFKNS2u/6rmZxEd6XM6h/mnPhzp7oS3PWGvX
	jI7c/OvWTQzUPwf/NwH357ABxZe/HRaeWjtPJcDUf2nj98XDARAH5YQw3rSV4DD1
	l747e1WbLXj2TMWJV7+gKSrzesjowFKYaHOeMXIeDfVHCWyF96CTNDyGs/VCU/SQ
	DtssinlyUUEREryjZ3AlneErCnqYdVATDS3UDqeaYOFOR3FZvW1jXPS+xhJCsJXX
	/Llg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783582275; x=1783589475; bh=tykZSdBbFVnoxsjT3yV+4MRoChTa
	LH6xBUntMi9i5W8=; b=RFwp6tIWojWBFLZDWC5WAYOMVlj4RM0q9CjscGm3Zlgh
	ATAhn8WHAaKRA8GItkeStdixzP6i4YM4h6KZM9EeRKjtsttiWQEiJjVqMwBk5gFh
	xxt4ThvagRrU7HGbgqq0u9tkOL/bQnX9YMeRG3Q+mU0EUIXdl4hYxH6ntIeGXLXF
	BVv7IzOq+v+AIbdnGVUKVIvsNBjmF7CUO4ElxcrnIuhkyKEvYqsy4cepYNW9JdwJ
	1ymbm+R/RmqfxwOjcLxFcBNQVgctvItbe/T4+GNJLsbZjmAehVn2hYRcAc83r1zz
	N8Ug1+delKrjwIG+EOxEWeOdZ0D69fTwtRgSZlrLVQ==
X-ME-Sender: <xms:Qk5PapHK1MCI5wSYHX4pCDhHSXnnNEItquukk4c3NTeDt2K84iM4Xw>
    <xme:Qk5PapGWcBzcsF2mORJhqFxs2crrE8itSAUN93Z-e0KrxQDwTFTfrqIVAg_BLA9zF
    W-TZ7X4WL1-6qmopyRS7NDvzWVWU_MKoG7CLJTDjkwpJ29DWKJARAE>
X-ME-Received: <xmr:Qk5PaqAxhdsSrf3gspn8Dwv3_-SKxUNex04JzmoNEAbQ1XKleg0cHUvC8a7J91HgLKJheCDJiC9CTvB16tzwCw_a3llcf-ehBbI>
X-ME-Proxy-Cause: dmFkZTFSjdEBfLERVP1KXx0Gpwc6pvTv5Wcp1YpThT70UXH1FfpqSJZOc0ISQHxtU+MxDh
    +67W+jKjcWO8Emjnwx9c2cPI4vcHYm1fIHunL9bsxD8PvVLg5zc3fwVzQnOE6XGe4mQMXh
    TSRu6QPliu32CCyJiDgidFV/7cS84vyzWqS9tOjtyj+mnlJB8CW0rhQxWJ8lM8jziJMgf7
    H2SI+DFO4cOB23YJrS8Fxa11AAGNyy9ItlV/2w5Gsa33KvxZDeGAZ4/eEPGffX9DTjsgJH
    rKsoYtROEtnhh1n33QQUze7uf45lNJYJ0FYDovQk5IIReAIcX4szV+xhyKuYFmiO7YGxN+
    daQL240SQMBC0r16xXUA08C+cDICvlWtBgD9i+daAwsYUlMg0G22prlM8K/0VTpgt4BtDh
    V13zM8XQ9qHUdwWnGekOridrdTdY4oITDg/j3ifY1ZWOd4NQMc230YjEzrrafOQJtmZrrP
    BDbt8JdBQxbT/MwObfW8DgI/NK+HGdx33+ceu1NA2bHslqU0LbJkmLq3dMvKXPAIKEJiR1
    uhzGa5MVoKK+gkCHHsMigTnA37v4VhiDaUelwJ+Ybe17Q19Vl0bqC/UU9CN6LJf6WA9Lql
    ftAqFgnYlnhnqp5bH4rZRZ5MRh5hbyyTsVtEcUC3cfINW4KQj5bLVuFq6MSg
X-ME-Proxy: <xmx:Qk5Pal06FD5BdD0PI-YxYR0xLFVuDllFzEnM8too4AaWQos66OnbVA>
    <xmx:Qk5PagCv8twDCim9dDzErvGkCFu-mJJyvDikCmD2QKowwBYshrCnBA>
    <xmx:Qk5PaubCS7lrU8__KEGzuPXGQDdKqR3DtshK3dWxCGZqblVjO7frUQ>
    <xmx:Qk5PasawQIjMxHYAEMWX5QoQF_ua2g0kxvSDS_Nz3A9fLZDdpYKxTA>
    <xmx:Q05Pas6ZstJ0dtMI1s7oIfw-7SmibGgDUFcOxtm-4l-AyTxEPiz8rQiG>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:14 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 00/11] Initial Apple M3 Pro, Max and Ultra device trees
Date: Thu, 09 Jul 2026 09:30:46 +0200
Message-Id: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTsQR1rRq4iLMfnVkRJDEqVQe
 vfGuvwW781UkA2Fzt1MGV8r9o4N+11H/qnxAbbQTOJkcEfXs6Y0guvgDhNbtGo6cmihR2EBvEo
 4BemV2iFl3G3a7pfr3+Vze8HX35KWZQViqfcWfwAAAA==
X-Change-ID: 20260705-apple-t603x-initial-devices-2eeca2d9d25a
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=j@jannau.net;
 h=from:subject:message-id; bh=XsJSiWwd2mbK2l11b/JXgHSqFuO9/PYl34cq33dd54o=;
 b=kA0DAAoWoRs8240vZWYByyZiAGpPTjuh9olovaOYNi3XzaP1uc61FQmexw9PBlpGAc/0hjYyu
 YiRBAAWCgA5FiEEYivpiACrfCFcfeBWoRs8240vZWYFAmpPTjsbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJEKEbPNuNL2Vm7AcA/iD+hDv9ElL1sz9sRA/SN6GrZQ2xJQ6sdUFXTTUym0s
 vAQDKbRQtKmQe72JfQHpxagdyyBgz7xwRrGYKMROSSPjACQ==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9653-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD01672DCA9

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
Janne Grunau (11):
      dt-bindings: arm: apple: Add M3 Pro/Max/Ultra devices (T603x)
      dt-bindings: interrupt-controller: apple,aic2: Invert #interrupt-cells condition
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t6031-aic3 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t6030 and t6031 compatibles
      dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles
      dt-bindings: watchdog: apple,wdt: Add t6030 and t6031 compatibles
      dt-bindings: pinctrl: apple,pinctrl: Add t6030 and t6031 compatibles
      dt-bindings: i2c: apple,i2c: Add t6030 and t6031 compatibles
      dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and t6031 compatibles
      arm64: dts: apple: Initial T603[124] (M3 Max and Ultra) device trees
      arm64: dts: apple: Initial T6030 (M3 Pro) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   37 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    2 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   10 +-
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    2 +
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
 arch/arm64/boot/dts/apple/t6032.dtsi               |  419 ++++
 arch/arm64/boot/dts/apple/t6034-j514m.dts          |   18 +
 arch/arm64/boot/dts/apple/t6034-j516m.dts          |   18 +
 arch/arm64/boot/dts/apple/t6034.dtsi               |   12 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |   67 +
 27 files changed, 5785 insertions(+), 4 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260705-apple-t603x-initial-devices-2eeca2d9d25a

Best regards,
--  
Janne Grunau <j@jannau.net>


