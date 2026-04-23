Return-Path: <linux-pwm+bounces-8671-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKE3K/XL6WkKkgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8671-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 09:36:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F57344E067
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4A430AFC48
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9302F90E0;
	Thu, 23 Apr 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvR77lDx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF52ED870;
	Thu, 23 Apr 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929567; cv=none; b=t8Oevt4G7JrLXUG37ASdxrUb9VBtBWKu/OawHlKxwMy/pv8VgIcEF6R42ckVkna+j+2N9m0OrPa04+pgCEwf+ASvUAxID10CIJkrRChlE+Ka7VDP01NL0CTACsod+Cn9L9sCczo7WPXgZoNaKS4YcGXyjVSbIM9d6FccVSPmqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929567; c=relaxed/simple;
	bh=i2dFnWaQDUa8+H+ls/+JnCp+f8fKAA/54Q7QJ5MyObc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZYLIuH0heb7dTmlzYW+QGenyP3EsLtVkD/1qJuU9kMuB0eTGcbyCYRGnRXX0fHYJtjTQD9Bz3g73+m8NM8OLEZc8p9KSuwws2Rug2fwttWMt89FugjK5FlAyr+MYdHG1Utehq7Ho9VUjvefABmp+8ePqQivclUiaSo2hbwhP6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvR77lDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3573DC2BCAF;
	Thu, 23 Apr 2026 07:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776929566;
	bh=i2dFnWaQDUa8+H+ls/+JnCp+f8fKAA/54Q7QJ5MyObc=;
	h=Date:From:To:Cc:Subject:From;
	b=XvR77lDxSEOKeXDS3SJOl4vDwYf+Dle/rXSbxPtLt2iz5dtUkozcYULa6fEIeAau5
	 o17lWELkEjkGMnknPcMsNYvu6miZtWTbwTXOIGqPerL2dQvztnqMLdzUrM229cLlSk
	 0fmnV9mmzSn+s/YeuvV5sc6nAgYYfARpDIe85EOWEnICwtzzZLJNBAnrkSUWkjBWV8
	 DOUwke2/tydfEMWduUVwXQqMi2Iv4XUEgLcukLbH6CYQLJKjTzgVxx2IHE/4WtL/b5
	 Pmkw6tbe6z6gcYXx33krjiFKt8bSIxcSByfcaSleqRdsS98p0+hQCdQRh5fSvd/PTT
	 7OqLnjMbVQLmQ==
Date: Thu, 23 Apr 2026 09:32:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sangyun Kim <sangyun.kim@snu.ac.kr>
Subject: [GIT PULL] pwm: Changes for 7.1-rc1
Message-ID: <aenGN5inmayPlloE@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hsr2ec3ahi6a4lyu"
Content-Disposition: inline
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8671-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F57344E067
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hsr2ec3ahi6a4lyu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 7.1-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit aa8f35172ab66c57d4355a8c4e28d05b44c938e3:

  pwm: th1520: fix `CLIPPY=3D1` warning (2026-03-29 09:37:13 +0200)

(=3D pwm/for-7.1-rc1) are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/fixes-7.1-rc1

for you to fetch changes up to 68637b68afcc3cb4d56aca14a3a1d1b47b879369:

  pwm: atmel-tcb: Cache clock rates and mark chip as atomic (2026-04-22 07:=
24:33 +0200)

While writing the tag text I thought about splitting the "mark chip as
atomic" part of Sangyun's fix into a separate change for the next merge
window. But it's still early in the development cycle and I don't expect
problems here, so I kept the change as it was tested. Also the patch is
a bit unelegant as it results in keeping a clock on during the lifetime
of the driver; I expect this to be addressed in one of the next
development cycles. Compared to the sleep-in-atomic this is a very minor
annoyance and I don't want to delay the fix because of that.

The pwm-stm fix is in next for a week already, the atmel-tcb fix is only
contained since next-20260422 with no problem reports.

Thanks for pulling this into your tree at your convenience,
Uwe

----------------------------------------------------------------
pwm: Two driver fixes

After having added some more code to libpwm checking the pwm rounding
rules for the userspace interface I spotted an issue in the pwm-stm32
driver where in some cases involving inverted polarity the wrong
hardware settings for the duty offset are chosen. I think it has little
practical effect because the duty offset is in most cases an artificial
property of the output waveform. Still it's relevant to get this fixed
because this driver serves as a reference implementation for the still
young waveform API.

The second fix addresses a sleep-in-atomic issue in the pwm-atmel-tcb
driver.

----------------------------------------------------------------
Sangyun Kim (1):
      pwm: atmel-tcb: Cache clock rates and mark chip as atomic

Uwe Kleine-K=F6nig (1):
      pwm: stm32: Fix rounding issue for requests with inverted polarity

 drivers/pwm/pwm-atmel-tcb.c | 38 ++++++++++++++++++++++++++++++++++----
 drivers/pwm/pwm-stm32.c     | 22 ++++++++++++----------
 2 files changed, 46 insertions(+), 14 deletions(-)

--hsr2ec3ahi6a4lyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnpyxkACgkQj4D7WH0S
/k6FqQgAuoOqDGhFaX3D2nTUO74/E/fPGsDatgbdj1hges9bWCEXjCWHvKeu0r3c
8dh0yRT1fQpAPDQXOfbYPIyT5uz4BFqDq5BR5RG+edi++V+oYFm4D83Cws1U77NS
PRGvdUDRdOfj6pvbJ/9sCIo8vIPBKRozJGd94KjEoHFudy99csi0UmcR8ePJR882
CzGRFXBNkqn1pQTxmc3IU9Eo+9qmk6PchP24gq+lysNjMb2E9JDI4ShJXBjMXZTt
lprgC7/SwGm7n6KoTsdd69ppBqhlIqhkHCjJ5bSerq7tVZV9sZa0qun9kHFmHPrz
o275I/dGz3BbIStG/hkrAQ1qiTyEyQ==
=1Lxq
-----END PGP SIGNATURE-----

--hsr2ec3ahi6a4lyu--

