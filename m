Return-Path: <linux-pwm+bounces-8495-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCkDO23W02kHnQcAu9opvQ
	(envelope-from <linux-pwm+bounces-8495-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:51:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A163A4E37
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB27730131FA
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69F2D594F;
	Mon,  6 Apr 2026 15:51:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD426CE2D;
	Mon,  6 Apr 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490666; cv=none; b=ktnRtE4bT3TiNjUYh/KO9q3R4URFdKplM+9HWAIIroJ6hrFQZxGF0x1OoKJHe4lG2IPYOTahmUcB+UPHoOWvGxFW2VMJ+O+CvNgBHkuX6d62A89pBZtvr3ycuEha9vv4Zjc/7IHAnNMAwaOu/VY+OMsTLziMAKYicAE4UuMhylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490666; c=relaxed/simple;
	bh=UA1pIDqZTcN0wblz4FqWp/DqMz+poNs9kVactYjBrxo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rNwWUzdWLWrfEh1DZLLfZBC4NruXrPxXVSJ5ox1lSA1aToLtns/9HzZwjgYoy3y2tqv0Kb4BUHsGOwoumi1YQwdcpmeg+pJmkWQmXQm4WmhGQipZDmUPo3weLWUkBbdm82eP3N4o45spZWg8ctQsg5ntuYw98pI5WUSqu3526IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz5t1775490607t015ef3cd
X-QQ-Originating-IP: 6hbAr8UySjcB8zecLV1wQa7GbFzaP8lEedladUubDsI=
Received: from [192.168.30.32] ( [116.234.14.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Apr 2026 23:50:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9436570935921105278
EX-QQ-RecipientCnt: 10
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH 0/2] pwm: clk-pwm: Add GPIO support for constant output
 levels
Date: Mon, 06 Apr 2026 23:50:00 +0800
Message-Id: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMz3eScbN2C8lzd9ILMfF3zNDPjJGMLSwOLRFMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAFH4y/nAAAAA=
X-Change-ID: 20260406-clk-pwm-gpio-7f63b38908a5
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=sophon@radxa.com;
 h=from:subject:message-id; bh=UA1pIDqZTcN0wblz4FqWp/DqMz+poNs9kVactYjBrxo=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJmXr+n+OtZd4r/p2/L8D1raZxbr3ghIMH3m2u10rNJYs
 5J/e+nsjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABNxsWL47yRtoz/ndvOLORlG
 2YW21hvnvJAQd1RVO6bKajhn+VV5W4b/pbd2xed5OFmfSbDyWBMj4nfrf8KkqvgqUe5tnf0MXVd
 ZAA==
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OHFB8ysKYMMnNYH5jddxhIytVYIU95tLqO7r6r0BENkgD4GHYt2aLQRE
	yW6V1R52xmdCE3OxJdk6OLe7LdZs3HCX+EFHcaAdDHifNmaSvKw+QJTHIk+0104P3/7MEJA
	pNvZgHx1+f8x29fChg0gduxZtF1QWW95Yy700JCf6IiFca8uRKdcASy6ooB3G76Kz76aAFJ
	rd56GKqj+SNWN87OgWMf3G2HxDJz0jtRL0Un0B8AvmLbfYeD17CkU+fIdjkblHjIJ3B0gx9
	Vcz7skx6mtpxdvKNVdJdTg4LP5PSlcETk9NcbHIAzRt6SbZ1Cqz/+qzDle3R2OyUhDhoL+0
	btaWr75QPpzZ59kiBam+jHZ5PTyrqFjtccgq1H43t8hBk58w4e6i0GaGs3iK9h7Q3v0tNyG
	f/x83KyHSa3OV0VkaUbdRs8nQjSjpV12pikYB1NapT9XbsFGuPWr7oXwyjHHt/XnUexG8v6
	M5js/Q4T7NJTvyxBjaKeg0RwU6jTUFGtTh4jJ+6yJDaF5KblgdRtzMrWu6aQOCgD0kphgvU
	9HkPN5Yot8nJWYY/x6aW//R8LX/9Rrrw3D56WKvlJmEQc8ijmNlm2OMoJ6kF4R/E4WJf38O
	8tmVJ90Q/8931MC8MsoEd5K3oYeYrClpWiHKe0HlV9uMe8snYwfWrpCqulI27HeYPmKxxBp
	MZxho9dozxo/b9wELRzf8KTrDlgxsFV0APzjexc3/+j7nVbo2bNu1b8GB6eoCEeMI/Blcim
	OvxVM/dLq7RCzvveAMqb2TkRiuIh//H930a2MorU6BYWJZYqAqiXbQNqGxmJLHhZJYnJSuh
	X4uUu58r7+eLOSkJOr37k6j5/7agOOj37RJfesK9NUQHMXFZq/T6uq7K5rC9Hbj3WtdF1m5
	zN457efkR10lVZyYUjjq33wFAr0+rwKXER5qRwOFKYSPZLWgak9qMCO+X1FBJg2tTQEnUJJ
	JJcKMtkdWad9fQguiP9x5ZoETKXaaY1u+svGBcaQUXc/dLQJfx9uT3zEvh0g1RjzeBn/zMf
	D12XJDSCD/Y5pGqh5l71+Ey0qgAKNz8Rn9w5nBfxyUJj6/BgqVpTwA9Vmpsvl+4c7AFWMvE
	RX8PfuMDI7w
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8495-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.828];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93A163A4E37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The clk-pwm driver uses a clock with duty cycle control to generate
PWM output. However, when the PWM is disabled or a 0%/100% duty cycle
is requested, the clock must be stopped, and the resulting pin level
is undefined and hardware-dependent.

This series adds optional GPIO and pinctrl support to the clk-pwm
driver. When a GPIO and pinctrl states ("default" for clock mux,
"gpio" for GPIO mode) are provided in the device tree, the driver
switches the pin to GPIO mode and drives a deterministic output level
for disabled/0%/100% states. For normal PWM output the pin is switched
back to its clock function mux. If no GPIO is provided, the driver
falls back to the original clock-only behavior.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (2):
      dt-bindings: pwm: clk-pwm: add optional GPIO and pinctrl properties
      pwm: clk-pwm: add GPIO and pinctrl support for constant output levels

 Documentation/devicetree/bindings/pwm/clk-pwm.yaml | 36 ++++++++++-
 drivers/pwm/pwm-clk.c                              | 72 ++++++++++++++++++++--
 2 files changed, 101 insertions(+), 7 deletions(-)
---
base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
change-id: 20260406-clk-pwm-gpio-7f63b38908a5

Best regards,
--  
Xilin Wu <sophon@radxa.com>


