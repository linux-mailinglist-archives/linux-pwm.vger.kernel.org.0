Return-Path: <linux-pwm+bounces-592-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6985181A3FF
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA27B22927
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AD4184A;
	Wed, 20 Dec 2023 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu2emPXH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBF41841;
	Wed, 20 Dec 2023 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c31f18274so73719675e9.0;
        Wed, 20 Dec 2023 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703088588; x=1703693388; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi4SSFS/pkip1EujL1j1QVICNPG8BT6ifl4ahjX/2tk=;
        b=iu2emPXHGvQ9xF/zhQUXOIQQmecNdIZqZgDsNyo3mWRvAI/sfYe35ncBBZnsORIslD
         qmpXT4rzrxulLHp3FQZAcFIKiVW3WTDNeHQZacyjl9ziCZ1kbvO4OhLdvuFnOlULjsG7
         /5nxCDIt+NwTxtFKL3atwbHhZlgH425CUnMgnaXhd/zuIpBr1zT7nW7Fs9UJB/h0GYTt
         4UKbbcSwbA9X7AKJoVCSRkV3d+ePwefDs4p6ARaX6WQyhhRGpfMD0qDjOVLm9dunK1zU
         w1jG2UGQVnntf6ICNkDlL4eo6nv2sco4I65g+nyRWJQWhRdr3//PgMWppzWZIbU0AwV4
         Xurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088588; x=1703693388;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi4SSFS/pkip1EujL1j1QVICNPG8BT6ifl4ahjX/2tk=;
        b=e6Iy6mCL3zXCb8beyF0HQ+vfEVHivAEjipD1Up3AZso1pIZZV7vf3HVPpQm/4wNSDK
         bbRBICnN8Ngl+cnoSOuy9ueQgVwcA/0XvLgxx88Lo4tDGNiw1HIo65IXNK9cwh4iNHlC
         r5pOiAA6vz/P4ett/TgXaMPe7Ro6siHsEjJPXzSsE7eSZzmZQGDZyzW13bN/XcyY3L+a
         d6aV8wsQWpbB1AuTGyCwmURcthA+BnU5di7eRxWgB0seGA5dHFSg5gZ11fSVCWu8QMif
         7eBa/qju/cGxPsVe0oySAEzd6AaKWABZgH4jKThUIKzNnZI468L2Q20KkeqWZpcetCmp
         19CA==
X-Gm-Message-State: AOJu0YwSJtGTJLbsAqmR6qYFXaKk3MXkUXlppeTyteoPPOG4CvNUu1mZ
	3jH5w2OtsS1QO+8TiAbK6AI=
X-Google-Smtp-Source: AGHT+IEjzw1d9DnmQo541Z+i7BmuJDKzCpRtaGcQqlMqWCZ8OgnEDfpp6/vr2GIFJnBzIpVETaTEQQ==
X-Received: by 2002:a05:600c:4587:b0:40d:3adb:7f9d with SMTP id r7-20020a05600c458700b0040d3adb7f9dmr176086wmo.126.1703088588307;
        Wed, 20 Dec 2023 08:09:48 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b0040b632f31d2sm119786wmq.5.2023.12.20.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:09:47 -0800 (PST)
Date: Wed, 20 Dec 2023 17:09:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH v10 0/6] Improve pwm-ir-tx precision
Message-ID: <ZYMRyijtS4mUXia1@orome.fritz.box>
References: <cover.1703003288.git.sean@mess.org>
 <170308520277.565566.3116568532099401071.b4-ty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nIOSuZwUJM/h/4Pl"
Content-Disposition: inline
In-Reply-To: <170308520277.565566.3116568532099401071.b4-ty@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--nIOSuZwUJM/h/4Pl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 05:06:06PM +0100, Thierry Reding wrote:
>=20
> On Tue, 19 Dec 2023 16:30:23 +0000, Sean Young wrote:
> > The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> > from delays as this is done in process context. Make this work in atomic
> > context.
> >=20
> > changes:
> >=20
> > v10:
> >  - Uwe Kleine-K=C3=B6nig review comments/fixes
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [6/6] media: pwm-ir-tx: Trigger edges from hrtimer interrupt context
>       commit: 363d0e56285e80cda997d41d94c22313b673557d

Hi Sean,

I actually applied all of them (except I took patch 5 from v11), not
sure why b4 only kept track of patch 6. Mauro didn't reply when I asked
whether he's okay with me picking this up into the PWM tree, but given
that you're the pwm-ir-tx maintainer I think that'll be fine. If not I
can back this out again.

Thierry

--nIOSuZwUJM/h/4Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWDEcoACgkQ3SOs138+
s6HpABAApEA2t6pGWsgRtZX/ksk9P+q8GoNlrRjowyla6g3XoFHvUtXPv22F59Yl
FmzebLOoYgqxgfEVSROIX5OBx+cDwPU98B3SBTY/m+WNGQ8e88btSViImAfF3CoF
5Eo6Inwxrc/xbq0unsc7QqxzeLuTpAzdYi9JwQKrZamMksAz4HbwKJO1Us563/ai
yOE/use4GuxB/eewSPuEd9IBWDSONhHz2QmqQQr/drc2Xfp58PwsNP5r8lKk35Oh
oLrRmo2hM9Nvc9MO5qMhAGSFDkIyIgaeVX+DB8j7KsN13oCNcl0UJmBj+zD4J3oa
nMVVMXqteNLSFAAZ6u3xRoFRsYKdxVXi6xxXP7QgH1eqkzEoGHNL0eoJsH0vbMLa
1bBnMYmKOtFyqAFWpM2rzUqU8VDhlBJalUuHsFqkm7XMvY4yy7aK4KFuINL1ANf2
rICgW1RT+z3xXSJPu9fkPUIKw0yDvXOVe7v/o4ooR6xDF6cVYY4hGmqo8XVrPHga
GY3MCu/1wS92d8aXh93ESEY5dquM74gP+ewYnczVHG+uewPr2qo4D9Pppt3NIhQP
RA4fUgXjwks9zYLhrEpgbjbb/esBSVq7+3h+z4VmiVWunUlIInCGlkmxWJP/dZVr
iDI9GGwn6To61G9it5xG+vf5GsnuEInPUUP94BxXjqb3iqF0PN0=
=7W7K
-----END PGP SIGNATURE-----

--nIOSuZwUJM/h/4Pl--

