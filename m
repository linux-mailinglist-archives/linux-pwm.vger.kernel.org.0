Return-Path: <linux-pwm+bounces-3120-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A0696EE7E
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA26B22E43
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668FC1591E2;
	Fri,  6 Sep 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hGVoWrkR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FD158DDD
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612375; cv=none; b=Oxc4E4mdGo8tz7eg1ImKVqhOQewBeen+4RuwIFqhv+1TGpF3/rxd1BTkn4Pnqf3vkZ04sUETXto2FhEazsqguQdgdCLk7ajp5bs9lrfJUyaSNzDq0XICABmfZsshYWIPSVexsrKtyVCjsScLhykbDardOFEDWTx0tcPZotvEQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612375; c=relaxed/simple;
	bh=CRJ+948422gSmOkKKC6UAzas1zOJwwcbdHp4kT73wc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xm1JXTzFjtIcsrx65nqRjioWIkrj2PiPAj3RIr0OIhYECpLX9owc14Fu34papHDjTlNb1HCsR82CUAi2gjG1SulVqNanZb41nhaAUarPZjoJuAooVt1exBK6SRL2hVfHzgFTueKNUI0Z268vXKfMHqDn4bgOB7k0A0EMJRHgNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hGVoWrkR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so4980171fa.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725612369; x=1726217169; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fgt2a9Fpo8526ioTRsH9RdBLj1tKIs+IfpbrT2TF+Xg=;
        b=hGVoWrkRhgsfdIkojsbImhdN+07VC5dmpEY9Yc5zNGd8Hjpn1zzdjX/+01H8st41pP
         hZNVHnFBgpn7SfKeh0RJ8fFdNdMxV0HMYvIZBxicJNtoIe65GEZ/EzNnzHm4G8lq1fpC
         DDqqwRvRpKNitTL7IzcDNJArykux9nztUxXc81oqfgJxv3ozrmdB9qEkWPertqeshurt
         egMyv45tme7f54twAVAz/ZV/aKTA3JJ33zAJ8scXluOGswswZknVI7QJGd/h0SnAlBCf
         8YtROiFPo48uYFwoPBHwUC1ea3JDMQ6ivcpjHHeEUlRPRSw4pVhAkWshm5Z/lSEwk6zB
         4cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612369; x=1726217169;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgt2a9Fpo8526ioTRsH9RdBLj1tKIs+IfpbrT2TF+Xg=;
        b=ZEeqSHFyJHLvNpL9J2CUvym+3KRpBcLWUExu61NL3NebiSP9Y+T0iZ2+UvkS4kSoI0
         z20MXcMApnK5qGtGNxBqLIyAYAbMZlvmAI0tiMOrJuVmLLbnIVKq3yK7o+ufH6/FnRli
         9eABHoNi62IZlhH/lxe7Jn8EX9P3tfMI4HQ7uKazi9Jdishq/EZCimqowiAHaThOPJp5
         8i4In+kMzh36ZT+CujPiJvelamlU3cZp731v+dce/6/oIDulgHx0W8n/4uz/who7HjFZ
         iVIQyVPMzr/VfLB+FMpdeOvyCfPv2lF71yHIjF8siHHtXtnabOItKDVXEpOSX31IeXas
         lrBw==
X-Gm-Message-State: AOJu0YywBQHULJ8kHAqNcXCAFVB3jtzAI4vTeMA6EoHG1Co+WyBSnxBt
	uScQC0tdn4EATJUDaNeSBVwKOwVHVy0wyPd8pytacwMczgskWb86p71ZYEA6ceQ9NIY63Jk7FtH
	X
X-Google-Smtp-Source: AGHT+IH29lsA/EaNVs2aoMXeuKn6ISNGmQxGAiUZhuylkrdYTrKsuCzeyv3JVlWvIo9dxH4s1fcmgQ==
X-Received: by 2002:a05:651c:154b:b0:2f3:f256:aeec with SMTP id 38308e7fff4ca-2f6106d8e1dmr256112241fa.19.1725612368773;
        Fri, 06 Sep 2024 01:46:08 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d527sm244627866b.135.2024.09.06.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:46:08 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:46:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fix an off-by-one in the stm32 driver
Message-ID: <25x74hglxoyb33fphdrtxrpmvsqe5227d7vy6uo6ez77hjbrn6@dh637q6cvzax>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3eeqydzopyjpjod"
Content-Disposition: inline


--j3eeqydzopyjpjod
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.11-rc7-fixes

for you to fetch changes up to 10c48e9a8fd5e524d37559cf4a06039b4c25db48:

  pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable() (2024-09-05 11:=
12:01 +0200)

This gives you just a single fix for a commit from the last merge
window.

Please pull this for 6.11-rc7.

Thanks
Uwe

----------------------------------------------------------------
pwm: Fix an off-by-one in the stm32 driver

Hardware engineers tend to start counting at 1 while the software guys
usually start with 0. This isn't so nice because that results in drivers
where pwm device #2 needs to use the hardware registers with index 3.

With the commits

	796b942f6596 ("mfd: stm32-timers: Add some register definitions with a par=
ameter")
	7cea05ae1d4e ("pwm-stm32: Make use of parametrised register definitions")

(merged for v6.11-rc1) I tried to improve the situation and make this
counting mismatch more explicit and transparent. However in one instance
I failed to add the needed +1.

This was noticed by Fabrice Gasnier (however in a way that made me
hesitate to add a "Reported-by:" tag, see
https://lore.kernel.org/linux-pwm/3515a8f3-436e-4d14-9bac-dfe6aa869819@foss=
=2Est.com),
thanks to him for catching the issue.

A small patch fixing that mismatch is the only change included here.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (1):
      pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable()

 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--j3eeqydzopyjpjod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbawUwACgkQj4D7WH0S
/k7fFAgAjQwed2OMbq8y50Ms5vXUJzqqSH23sa6mkO3ZhMlVItE/DE1I7xIdG7PQ
QOw3dg1oBn8Js85FTCDrxrMcVCM7PqfElKJaU3NqTRru1ZCoYugJAibbEHjwdMDi
MlGrXCRX+F9s3X4duU8YP8mGeSexXge+RXFC/B4liwe/ZD8YEU8YL2zY8hm4XQ7m
SSbDeXKTJSOyNeILUqHYikO9cBH4Vf+twdhpB1Ar9NJDg3ij25GBrhkxz6rlGi7a
RRHjQNEKFMlZQLG2FtEeDNl89h98K1DQN8q8FI+hXjvaFwOpgoo4vcUbsCZAMXJq
Vyk9zOs3+gCR8Xb9W803y3nPMzGw9A==
=cYdF
-----END PGP SIGNATURE-----

--j3eeqydzopyjpjod--

