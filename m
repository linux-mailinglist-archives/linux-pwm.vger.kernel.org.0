Return-Path: <linux-pwm+bounces-8103-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHuJEiGfiWlU/wQAu9opvQ
	(envelope-from <linux-pwm+bounces-8103-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 09:47:29 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F110D2B5
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B0A8301C14B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Feb 2026 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C2321420;
	Mon,  9 Feb 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0GfbMnpP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564A318B89
	for <linux-pwm@vger.kernel.org>; Mon,  9 Feb 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626805; cv=none; b=V7JKBFLKFW/q4V432FHo2sUqDt31REEqCTwbEuU0HpVJGhUOJ/p3wqiYaOBdy7bYTuQA4x44Xux7RbuyVjhYnPibWaOo0ApKk4Rrt0iJRWvX96igbVppZgBvV0Ahw4gqKGF8lXHJn/WCUohD0X4rPn4tDZ7LmLXhdyQjXucVQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626805; c=relaxed/simple;
	bh=BJ5lOZ4449pXP0CvvJ9j4wRTvu+h9/p+JYUfcdQ5H0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ui+vNbcTt45YgcSZ0ZSPBapojn/iTFevirRglIcR75ZKB6d1EQ3vzXOoNgQZN0cA8rFrEJeHFQq3MFfwbVVKCjpmOD0KDZcz0pY5yIsjPmVbgaxGdJgSk26L9uGzshlRfdUJB/OJwCVNd1ae3HGGYjJJjP5/YZ8/1khNDJFLRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0GfbMnpP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4376acce52eso592787f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 09 Feb 2026 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770626803; x=1771231603; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMGEvArFzYc9IAU5zSCaUWalfH2gkP1Bn2uE6M49ikk=;
        b=0GfbMnpPkDS1a10pV+/SGe/i7QtCFRnHCzRR4ajhO1arPbnSZbFgxQrXD4D8R5HSbR
         tEIVu1j10mp/JRHZBCTKo9KUua29MuOBgNKYN09sPjdYRxOkyk7H0LxQ7AK4tSjgF+0n
         jAV4KCC2zcwixSlhlyNHpoVj1TS/4QaJVfNUSBHbaq7/vM0Q5c0U1YU7tz4dA7Gi6lc5
         HMHwvOCT5XO9fOBlhNgX99EDeO+9FPWdy/AB3c6RExPC17my7ULmDlRaJNylNzoEO+L3
         v0pb7zQ0WlsPynVdMdIF89YfV6pmYYLAgSlLoJ3GRvPSEKsCj9CEYBiOdr0GOOT1YYy8
         p3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770626803; x=1771231603;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMGEvArFzYc9IAU5zSCaUWalfH2gkP1Bn2uE6M49ikk=;
        b=o+AmpWv94uOMYYD+9gbzeKGfAowaLkReDyD/4rdUYLgX34Lc7vjuR6wJtZnqOgDx2S
         LinzZhRoGN8zt0YmRTUNXKP1GAyLxpetRMc1DZxeZqAQ3DF0eXzAmKUdfjt2+AGm+LaA
         tNMqxICPgX8jviZJ8H9P8p9s2/Alf6JQMr1U75dsKkfOAQ8a9za2AdGYipvSKXA3Lqm/
         uTxCzrU3CHmy9zQJPC0aBmy+Sd/kooRagtYc7CTeEBXHsqgIF6gz5v9J+cIxwP5naXcz
         bYFGuUBeEBXFaVaeemo5eCydcUxlvOVC8lXDHybL0tkn4bEuSxJGIqouvafqvd0RlXq/
         FZRQ==
X-Gm-Message-State: AOJu0Yx2ur/JY6bS6+N8A6u8KeMTzKPoTIAIX7wjy8YM4tEHo4q12yr+
	A8IHViNO2j/n4mykklWoCQTU9+NvNqj4vmIlloplzsnIsYUKJ+iK+nny3CXuQSRJ4r4=
X-Gm-Gg: AZuq6aKJmXZALSqbgy7y4qUVwxoQSDzglgT+z+Xom+/eS5TWJdpVic4EkfqTfVILpUW
	9sj35eOz0BpC4Minu5qw/wO57gC7w8+LynWpC+MXyh9eQwCao5W71vX1sPkOU3fRliCmMpJB9m7
	gXDZL9XVeLE3+KXF7kDN11+EF1Yi/C74avyqUsMcz7nucHWnqfnJ/lRvi+U9D27DEd7iG/PiN1q
	otC6QKjKqPLaW8ut9A1zptic0bENuykvV7DUGxuyd8ecx7UBe9ChhRwDd3ZD4JFXOn+tf9+Mlel
	uZkVnQqsp2t2vTUdnNqJsSgnpk4HdGhUqs/5OTOVdd1WyDLBLT8qJnPHFmM+gcq313MUiB1uAvC
	MRgxxMaB5cVUzGdtqDGDNoVLop9zzaNB9fJQfplP4YxI7lSAKiPL2FYMBwetZXbpMNltB9kxuqk
	LAFuUK9OFAABSXTZ4bmsosiilRwOhX4XsndBVxG7Dfp1TdgkYqwMy2NJqYtF5oh802tDlv31osy
	Us=
X-Received: by 2002:a5d:5f42:0:b0:435:94aa:df3c with SMTP id ffacd0b85a97d-4362938629emr16898572f8f.61.1770626803235;
        Mon, 09 Feb 2026 00:46:43 -0800 (PST)
Received: from localhost (p200300f65f20eb04869299441cec46c1.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:8692:9944:1cec:46c1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-436296b2ed9sm25985536f8f.5.2026.02.09.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 00:46:42 -0800 (PST)
Date: Mon, 9 Feb 2026 09:46:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 7.0-rc1
Message-ID: <aYmcqN2aAqhqqwxX@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqtnhkvka4o7egfs"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8103-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A14F110D2B5
X-Rspamd-Action: no action


--gqtnhkvka4o7egfs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 7.0-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 0a155a8a24ddc647aaf28ce7cdb14af7270c158f:

  MAINTAINERS: Add myself as reviewer for PWM rust drivers (2026-01-20 09:5=
3:18 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-7.0-rc1

for you to fetch changes up to 9321f9d27fbaf6c4f32772fc2620961a0c492135:

  pwm: Remove redundant check in pwm_ops_check() (2026-01-30 11:04:44 +0100)

The commits are all in next since next-20260130, all but the top commit
are already in next-20260122. There is a change to MAINTAINERS, but
I didn't hear any complaints from Stephen and Mark about conflicts in
next, and there are no changes touching non-pwm files this time around,
so I expect everything will be smooth for you.

Thanks for pulling this into 7.20-rc1.

Best regards
Uwe

----------------------------------------------------------------
pwm: Changes for v7.0-rc1

There are a few patches adapting to changes in Rust land which seems to
be the norm since there is a pwm driver written in Rust. Other than that
just a few cleanups and a single fix for the tiehrpwm driver that came
in too late for making it into v6.19.

Thanks to Andy Shevchenko, Bartosz Golaszewski, Daniel Almeida and
Michal Wilczynski for reviews in this cycle, and to Alice Ryhl, Ben
Zong-You Xie, Gokul Praveen, Kari Argillander, Markus Probst, Raag
Jadav, Shankari Anand, Tamir Duberstein and Vladimir Zapolskiy for code
contributions.

----------------------------------------------------------------

Alice Ryhl (1):
      rust: pwm: Add __rust_helper to helpers

Ben Zong-You Xie (1):
      pwm: Remove redundant check in pwm_ops_check()

Gokul Praveen (1):
      pwm: tiehrpwm: Enable pwmchip's parent device before setting configur=
ation

Kari Argillander (2):
      rust: pwm: Fix potential memory leak on init error
      rust: pwm: Simplify to_result call sites and unsafe blocks

Markus Probst (1):
      rust: pwm: Add UnregisteredChip wrapper around Chip

Raag Jadav (1):
      pwm: dwc: Use size macro

Shankari Anand (1):
      rust: pwm: Update ARef and AlwaysRefCounted imports to use sync::aref

Tamir Duberstein (1):
      pwm: th1520: Replace `kernel::c_str!` with C-Strings

Uwe Kleine-K=F6nig (2):
      pwm: Emit native configuration in /sys/kernel/debug/pwm
      pwm: Update MAINTAINER entry

Vladimir Zapolskiy (1):
      dt-bindings: pwm: nxp,lpc32xx-pwm: Specify clocks property as mandato=
ry

 .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml   |   4 +
 MAINTAINERS                                        |   6 +-
 drivers/pwm/core.c                                 |  30 +++--
 drivers/pwm/pwm-dwc.c                              |   3 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   6 +-
 drivers/pwm/pwm_th1520.rs                          |   5 +-
 rust/helpers/pwm.c                                 |   6 +-
 rust/kernel/pwm.rs                                 | 124 +++++++++++------=
----
 8 files changed, 103 insertions(+), 81 deletions(-)

--gqtnhkvka4o7egfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmJnu4ACgkQj4D7WH0S
/k4N1gf8ChhGZM85gBqthm4ZxVMnmO0J1OkU6RGU7GEGiidrxPvwujZnAZVyuRRB
RWqDDtUfzyycZYotXf8f2wfQ1Q2idTC2tvA8odWd8s+u3gUBGypTY+0o/jdJL9h5
xqWRpzhMHNq49VeswXzpTdSszxWAzdYfUZKj3b2gZYjhivGNJ3KjrJS3/9yGd1ii
Xiv/eXsKMXM/qXR0ZRJ+PvG8H4JB/viH6+cETiu3mbrSZzSvY+1GVrfPFUNxvSb0
mJh1OoKh/6+qKrGnr1lNgbSi/FsKiqF84L6HoKwOLT3bT1DTsN16VqPj/2PkCPh3
b0nwzLRlGNpn81feA06IWx39CNJ6ZA==
=8B/I
-----END PGP SIGNATURE-----

--gqtnhkvka4o7egfs--

