Return-Path: <linux-pwm+bounces-1106-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADF83F839
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 17:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E1728AF9C
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85C1E508;
	Sun, 28 Jan 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GLcfozVL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D122D058;
	Sun, 28 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706459834; cv=none; b=gjbJz2gj6p974oohde1jLy6C9l69pR5o7HCgPzd2EC3pl+50wr1c1+qxW/Z8m06DGhMsTdm48oZr6MHTRarOs9RV819d+LMlrCVckSrH9JcFtol+QD7llf4b0t/b264urI2vcNkU79ll2Lzafu1+0NMBHSHqF9TMSpi51XaXGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706459834; c=relaxed/simple;
	bh=vId3B+QvfngqoZ+2btJiUDpbq0U3lHTXMGcNkXBYDu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lV1oPIV1OCF9dk186R40fcinBEdCrDQBFM+i3zBEZVHiQaCS/J/M1sJwlxBgCvJLVQFfwEJ7jlmPeU8VrtXD/+Avotm0oUUyHW3/Ae9VOiNXkJUYR0BHoMIQTamB3x5k5rsa48pn5+noGIAn5pOhWwtIDTGX/Z75PO64/2D4bB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GLcfozVL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706459822; x=1707064622; i=wahrenst@gmx.net;
	bh=vId3B+QvfngqoZ+2btJiUDpbq0U3lHTXMGcNkXBYDu4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=GLcfozVLoFgQ/bvWQnvq9KCM1ZT7MxaMkvZ397B5zYwrXXyVSFikgQdh9gzMW6iI
	 6DUWq33GXY+y3lq9xOvV2rDCL6KhDQq7ZdjfHGPZCtA1Y2JNkTyR0gHkgcVsViD0v
	 ieoFa/bfhWpTa1zmzDjQ5hxr74fSnoHuoBcYABuchAxjZsydibJRiXf10NQPJa4U0
	 dk5IC1TR3xdsQuxlFl/Wz173ZvANZDS+ggNAAWg4zLhAfZqq2rReiJ5uTGZBN3a8V
	 KqU1tQ7Ms++0P+h0VzRxYuQB0SrVMSCVU4KJuqbABOgxQdSt7K5adR40B47/7cwiX
	 K92okKbWQnoVnG4MxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1qpao70kBp-00fDN7; Sun, 28
 Jan 2024 17:37:02 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 0/2] pwm: Add GPIO PWM driver
Date: Sun, 28 Jan 2024 17:36:28 +0100
Message-Id: <20240128163630.104725-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PYEzXqihChMvToHzO80yaxYNH9PrYgE5vfDVXNQTHNcFH6RJBr0
 HXKrs6wZKYdIaH40vbepjgId7GDKBLDOjfBOORDJFt4cKlR85vPhuXZpZfW7SXrIturNa8e
 asnHZMUtklKhqb2bI0LYAuBwocuLMGP3CouMDgSrRFFASmeuQFRGIqL9730sjEO+5KZYwK4
 dPLcjVhpFpZWCGzB5KOpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W1I+2xf9EnQ=;WN/f+CwUjnQeq37W1DuuUe7tJa6
 07YiLJBgbzQVH+AwFDwzutyU36tvyfCiEtFEOQIAM9oO3llETu61ZGu8oXm+PiVa69XRU8VGB
 PwAoidAI6W0gDQj78aTVndxmbgxclSeEoDfweptDkLEiDxYtTeTDaLUZDKoXykl7j0w2NtBS2
 rolIb+3sEfA9TAiykrpf8G+tjcJgKhmegNhhoOcYXLSTsbYMqOkmk4hgh/KeDfZtBAjxDICAR
 RVL1p8VbrLNjQAlByRXRtmaFVEf+TuJJEtHxzxEx0sUmqUtIaOJ4GUK0Nwv718fw6DcktS5eb
 FpvdyL6oHGP67LotUOTxt9q2AjzUrESmf0qR5wwFq+24ReGa6VKZDEAfyWcnG5LnqgW0JTJdY
 25qbNNOWY3DG7vpjiz0xAWGNkPm+8r8dhBRR9dwguBICF7OZpfSXe/0qBJZwQF+Zxwq5IBfWq
 qnq4awpzwQ9QIhFgqEPAJjwBJKsaUvghOl+2bwMM/oCQthgaEmvTYdAIKu/qI4SMZEhJnzM/X
 LzA4149W18yr4S/Iy5ydJXgdzBl70HLc7+FTQj93yXQK3VQSkpqZR2lJ83FRHwwZBV4wxcTwF
 fZDrgAqOZPPy0v0Sj3Q1nfycjgfhGS795+LapqDb2YIZI9rWI/x9PjPHZlith9ThvxU9BeTcq
 AwQbspHZFqGvoVoifteJwrOAdScocoa5UVmDTRJDHxVdBK7ge1cYwQQDT5DCcQuiDBt+amST2
 5xmjAsXKbbzNj5C+E4PmpB1YEnFEKC5ZCVYtqLUldNgSzTpSos66OcDUJsVmf4OXRuDrl/Swe
 TXhBoY8/uB+9X6X9y0GMaulSQU1hZLhRERfJ7Oa0VkKYZwDVJOojr3Mp7g58PhomRzZA4H/3P
 B/QH4mpWHvcXyU3sanjqqLBYIIl0gmsDPwQ1EldM7HoJL+K6+uw6sSxlrpQrBTYSsBpUL02PD
 2vTZyZqivtK3xA395G4QTxOHNmA=

Add a software PWM which toggles a GPIO from a high-resolution timer.

Recent discussions in the Raspberry Pi community revealt that a lot
of users still use MMIO userspace tools for GPIO access. One argument
for this approach is the lack of a GPIO PWM kernel driver. So this
series tries to fill this gap.

This continues the work of Vincent Whitchurch [1], which is easier
to read and more consequent by rejecting sleeping GPIOs than Nicola's
approach [2].

The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
analyzer.

V3:
 - rebase on top of v6.8-pwm-next
 - cherry-pick improvements from Nicola's series
 - try to address Uwe's, Linus' and Andy's comments
 - try to avoid GPIO glitches during probe
 - fix pwm_gpio_remove()
 - some code clean up's and comments

V2:
 - Rename gpio to gpios in binding
 - Calculate next expiry from expected current expiry rather than "now"
 - Only change configuration after current period ends
 - Implement get_state()
 - Add error message for probe failures
 - Stop PWM before unregister

[1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com=
/T/
[2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einstein=
.dilieto.eu/

Nicola Di Lieto (1):
  dt-bindings: pwm: Add pwm-gpio

Vincent Whitchurch (1):
  pwm: Add GPIO PWM driver

 .../devicetree/bindings/pwm/pwm-gpio.yaml     |  42 ++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-gpio.c                        | 221 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
 create mode 100644 drivers/pwm/pwm-gpio.c

=2D-
2.34.1


