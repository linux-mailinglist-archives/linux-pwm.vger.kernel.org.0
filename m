Return-Path: <linux-pwm+bounces-9289-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MiNRFc6RL2rSCgUAu9opvQ
	(envelope-from <linux-pwm+bounces-9289-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 07:46:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FAA683910
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 07:46:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=POTrQh8Y;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9289-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9289-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C98B300398B
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20AA3AEB35;
	Mon, 15 Jun 2026 05:46:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DB36C9D9
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jun 2026 05:46:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781502407; cv=none; b=Ibwaj1zk0xXBVVxvN3OJ9LBQLlI8K5jJP1qLOwDxX3Zo5NJU/SCmQg0lkW5JJ6HPG8HfQdHO8bYGT0EAIDs5juAyzGYMac5Uig0yR00x8nYScGiOfF4/CtJU4mq6BsK7B0Kln2J88pXJr+N0jjiQqYZ7sJhD4DqhW3c44ebK1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781502407; c=relaxed/simple;
	bh=5zA8SgvcBlGZ0x3ALj4pWOU3y/GsVC+aLzfyQtzX4HE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WqnAtDsi6vToX/4IQ2DUd03RrauE0IWk/03EArW+gGqMumWaXme7tO6r8v3HQG13+zyYsDdu5K75yIrOqWB+/uUrP5GRlpp2Yq5vKpAksejKBtfiJgfPu5FYHgpTR0tYw1eznP2Wp1wNg1Pj8rApUpXl6xJI8xHSE3uR1GWwY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=POTrQh8Y; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490afc47455so11824235e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 14 Jun 2026 22:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781502403; x=1782107203; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oipocvriu0QVgg/2ohII0bRtyoCrcru68YYlYyqEgQY=;
        b=POTrQh8Y0w2w2vhEeuGMwVjowliqF2VvfITwkYUEyZ959FD/Fod3Ot28ioca+UAMw9
         b4PC87DfcN8LKifvOc3DE8Rb6p6/ep/vEq7SCtmZbvYj29kyjKv9g8DnB/AyQir2hjt+
         pY3R12w/YmIN91ePpyhutQ6UvDn5DeDjn9VyC7EEPdwBwD0++xaweshnDMlSm52ZRVN1
         /tGZ9fR7kX73LVegAaPL/S0U55XrpOOL6Y+LhbMiIRiwORMfcLxip4X+5cjrdKcUsxxQ
         UiRbjiUqiDSWhJVukqyLroH5+EVRFNsuiIkPg/NmGpyOp7jPQGrMQXg3s6VZrm5JtBYA
         Y1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781502403; x=1782107203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oipocvriu0QVgg/2ohII0bRtyoCrcru68YYlYyqEgQY=;
        b=NuggQ5quNf5HpKzB79ofRqWg31d52SGGylI71+3hMWfgVf3RCnZvn5kCPdxFNivhwX
         BCV42iSi8Y9j3GVFYKROGLzAvY2dCmSnDW7xWVz3wIIW3TsV7l9btmjfXSs0apj2Xgc2
         jkDIr51ue/qHYN6QEXvRUQ/B7YyxYs7MyMsLPKPz+8F9o4Wz7Anh97Jb/SU4xIZyBPRD
         KzIo0jBQGzE9vJ2SE/f/WraUJ7iT2n24cIBGwujDU0qVLsrDTGLPeya4j52ZsEC6j7po
         7n+a/ZYPcoQgTEz0jxH1+AtvPxOiItaomxFxEkczaufHIMeP0gSlud3NK1ODUi0TfMY6
         b7fA==
X-Gm-Message-State: AOJu0YyOmfupjbnP0nYW+EjqMr8Q4a8ECtRMoSe/MoHLVmrNuOLXjNgC
	4qFW3Bu9x1vrAgCYt0iNNTf3I7E7YmUbAfp1xEUK35EiB+WVN+kgdkVM0c9QJ9lZkoA=
X-Gm-Gg: Acq92OE7xlT8NIknxSlqYXdhkZa96I58NIRUaey4Bfg/+ukTMaq86/xhVYVlJldnQu9
	97lKuzT6E5ioijDGwXqQRqlRRdOcw8q7t3c4DAEifamRjF7OMo6G4B7TToTW+AgyDrWcXW/iJNs
	gZoIV022otYT2rAUC4t8Bx09riTYvjolmUlXKX6Y8vseVeC6BvOsspc/htzmEDWePFo/Axkvy08
	4iuI5mHgIPs8Y7WprUfO6VJ23hg1Qggcw223B5vwD4/wvbRVzvAUDAafHc8z4g2LSKbj4fEX5Vy
	VrrX7FnkgKtif+MWIxJXmrAbWj3T9Za/iRUNShQ/8qQQi43movLaZCzUY/6+jylmqQZXyX85Xlj
	oPmH9vAhC3Y86ee34G1KxvJyA7UX30qLIaDLWIkvKasTiXc+HcZ1p/fn1xt2LK03jFIe9DTZ8BB
	GYBp8F3xgcD4z0vljQ9qTfXun1kjyC
X-Received: by 2002:a05:6000:29dc:b0:460:7300:e91a with SMTP id ffacd0b85a97d-4607300ea68mr8861470f8f.39.1781502402962;
        Sun, 14 Jun 2026 22:46:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f26f309sm30040261f8f.14.2026.06.14.22.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 22:46:41 -0700 (PDT)
Date: Mon, 15 Jun 2026 07:46:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 7.2-rc1
Message-ID: <ai-PyEf2c2Ce63FQ@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ta47lymotlddx2i4"
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-9289-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5FAA683910


--ta47lymotlddx2i4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 7.2-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-7.2-rc1

for you to fetch changes up to 6f9b73071c15001530e6697491b6db1bf639f4c7:

  pwm: th1520: Remove requirement for mul_u64_u64_div_u64_roundup (2026-06-=
05 14:03:00 +0200)

Apart from the topmost patch the changes were in next since end of May,
the last patch only for a week without reported issues. The patch stack
starts with a few fixes that I considered sending for the last cycle
already, but then didn't deem them important enough.

Thanks for pulling this tag for 7.2-rc1.

Best regards
Uwe

----------------------------------------------------------------
pwm: Changes for v7.2-rc1

The usual mixture of minor fixes, a few cleanups, a new driver and dt
updates for the pwm subsystem.

Thanks to Chen Ni, Devi Priya, Manish Baing, Maurice Hieronymus, Ronaldo
Nunez, Rosen Penev, Shiji Yang and Yixun Lan for the actual changes and
Bjorn Andersson, Conor Dooley, Frank Li, Michal Wilczynski and Rob
Herring for reviews and acks.

----------------------------------------------------------------
Chen Ni (1):
      pwm: atmel-tcb: Remove unneeded semicolon

Devi Priya (1):
      pwm: Driver for qualcomm ipq6018 pwm block

Manish Baing (1):
      dt-bindings: pwm: stmpe: Drop legacy binding

Maurice Hieronymus (1):
      pwm: th1520: Remove requirement for mul_u64_u64_div_u64_roundup

Ronaldo Nunez (1):
      pwm: imx27: Fix variable truncation in .apply()

Rosen Penev (1):
      pwm: ipq: Add missing module description

Shiji Yang (2):
      pwm: mediatek: set mt7628 pwm45_fixup flag to false
      pwm: mediatek: correct mt7628 clock source setting

Uwe Kleine-K=F6nig (1):
      pwm: stm32: Make use of mul_u64_u64_div_u64_roundup()

Uwe Kleine-K=F6nig (The Capable Hub) (2):
      pwm: Consistently define pci_device_ids using named initializers
      pwm: pca9685: Use named initializers for struct i2c_device_id

Yixun Lan (2):
      dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3 PWM support
      pwm: pxa: Add optional bus clock

 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   |  41 +++-
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt       |  18 --
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-atmel-tcb.c                        |   2 +-
 drivers/pwm/pwm-dwc.c                              |   4 +-
 drivers/pwm/pwm-imx27.c                            |   8 +-
 drivers/pwm/pwm-ipq.c                              | 264 +++++++++++++++++=
++++
 drivers/pwm/pwm-lpss-pci.c                         |  18 +-
 drivers/pwm/pwm-mediatek.c                         |  25 +-
 drivers/pwm/pwm-pca9685.c                          |   2 +-
 drivers/pwm/pwm-pxa.c                              |   8 +-
 drivers/pwm/pwm-stm32.c                            |  27 +--
 drivers/pwm/pwm_th1520.rs                          |  16 +-
 14 files changed, 375 insertions(+), 71 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
 create mode 100644 drivers/pwm/pwm-ipq.c

--ta47lymotlddx2i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmovkb4ACgkQj4D7WH0S
/k5c2Af/ZrV35sIAjnyDc8WM5jnol4LLKh6NPM1tv9qvmTMGN416Ilj9sDGOgdbu
HJSOMN0dkdgkNCBrouapSGdb8F+fJwTbfqFoYw0NQcNNDg9RTBG/a3exxgGP1QIK
a0vzVirFviGzqJaFlFubCcPk2p0q4wWYyikCk+LGXC4vK0Nr/ZsXx99suJPEhISx
i2yLPahQf9K3ngjYZPLk/nRX9Z+kmPxtjwxsQAXmykoEK4QMmUuhLJfrFvfixB+k
Y3ajH0x3VQNczkIXUfE4z/4+3GEswgvluoUi5ZwO+sDJyz/0aLIkkJPf4R7W2LeP
dEd5D7I6/ij7uBbPk8+TihvZApUCIQ==
=wM+u
-----END PGP SIGNATURE-----

--ta47lymotlddx2i4--

