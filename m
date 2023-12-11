Return-Path: <linux-pwm+bounces-501-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06E80C792
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 12:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C251C209AB
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F792D60C;
	Mon, 11 Dec 2023 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtJfLoZP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EA6B0
	for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 03:01:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso54577621fa.2
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702292496; x=1702897296; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yoNUyDc7crveEMwlT2FZNhS4oJafuWVz60O2pzpfD4=;
        b=MtJfLoZPa29gDc1PrIwvUCYSwlodsPSTWZ64Vpylg55ea+sNNHWDlh8L6cfrt/wmnL
         QoxMwZiuJadM5recafYbfvJv6rDZJPFEBHSeFK39++NzjhKhtK2TS7drCI5uzFje+E/I
         HWm/F1kU6Y9GvAo/3mzvMNdGRd0IY4T5hmARm6YfJTNkXFx3Af1mpCD3aib0yVP0Y1e9
         cr9QTN+V5XBqaPCs5i8RXf5SU6hfaL4Gc7gMy9alQiPETvLtVFX1LUMqrm04nWRXIz13
         UDkeSiSvRSddZWdfqGi/F4zf7rdHK+R/Jjl1GjtMss23/BmIeuh4RueBJXRJgbewbSBT
         SF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702292496; x=1702897296;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yoNUyDc7crveEMwlT2FZNhS4oJafuWVz60O2pzpfD4=;
        b=FH9PaUWKn9zhecd+OvtxnOXw6JdTnrdaavC+XT4CxT7nsxLy9IIqRq3ynzwn0n1euR
         l95DFbJyEEKmQ/AJtlMcLX+s60IDhSe76rfHjKuZvwJqxdoOTZTaOV5IhZn3em9zH/Ib
         bWCg/9CiVhs97rEDhQ9+jQXjiKO8fk/hSkHtYKyLjDzTfJqHAipckYC/ZvaF/BQyfPz+
         CDwcIcwZvNT3njM/Z/r7eGq9sn9GFDN+GwShrhSDKIewoQJcc3todv86vfryPVEo1usl
         UmeXQirAwHTSDSaka803QasgGukw+ql8CbWogUj1r6uA6oU3VuihEbh0+rq1W/gj0A4u
         eC4A==
X-Gm-Message-State: AOJu0Yy+zVZmH3jHR7ETtVKVy3BCMZ1DWuxeZvphNquW/oe4pQMWrPMv
	PV6Awu4Osh0qvKoHix7S1nw=
X-Google-Smtp-Source: AGHT+IHGf0deBy1kz+L9fNu2VeKiVKe8qdt8XFpmGRHh7XmpI4WZnb9TvttVPcmhvXHyv33Lh4JIBg==
X-Received: by 2002:a2e:ab09:0:b0:2cc:208b:98c5 with SMTP id ce9-20020a2eab09000000b002cc208b98c5mr1151013ljb.44.1702292495785;
        Mon, 11 Dec 2023 03:01:35 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1ca6f5f189sm4698236ejc.179.2023.12.11.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:01:35 -0800 (PST)
Date: Mon, 11 Dec 2023 12:01:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Simplify using dev_err_probe()
Message-ID: <ZXbsDRslZNKCeJF9@orome.fritz.box>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pjs2fT3iSG2v3iJj"
Content-Disposition: inline
In-Reply-To: <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Pjs2fT3iSG2v3iJj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 08:06:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Dec 08, 2023 at 04:52:57PM +0100, Thierry Reding wrote:
> > This is a lot of churn for very little gain.
>=20
> We seem to have different conceptions of churn. Each hunk here is an
> improvement for both SLOC count and usefulness of the generated error
> message.
>=20
> 	failed to register somename: -5
>=20
> is worse than
>=20
> 	error EIO: failed to register somename
>=20
> , isn't it?

That's entirely subjective. I think the first version is just fine. I,
and I suspect most developers will, know what to do with either of those
error messages.

> > None of these functions are ever going to return -EPROBE_DEFER. And
> > yes, I know that function's doc says that it is "deemed acceptable to
> > use" elsewhere. However, the existing error messages are just fine, no
> > need to churn just for the sake of it.
>=20
> We had this disagreement already before. Yes dev_err_probe() is useful
> for three reasons and this driver only benefits from two of these.
> That's IMHO still one reason more than needed to justify such a change.

I disagree. There are certainly cases where dev_err_probe() can be a
significant improvement, but there are others where the improvement is
very minor (if there's any at all) and in my opinion the churn isn't
justified. Otherwise we'll just forever keep rewriting the same code
over and over again because somebody comes up with yet another variant
of mostly the same code.

> And if you think that a function should only be used if all advantages
> are useful for the caller, let us reconsider if we really need capture
> support in the pwm framework as only two of the 68 drivers make use of
> it.

That's a ridiculous argument and you know it. You are comparing apples
to oranges.

Thierry

--Pjs2fT3iSG2v3iJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV27A0ACgkQ3SOs138+
s6EQgxAAkVhxQElwpdJ5LLraBhrPHb0memFPXZvwsLSeq6skTKYwpO8l7HKPl/qX
qpFMwqfyVz1NiEnstvgPgcmW0VWA+UZUUdrvmrdLmgkLy9tJ4K6T2Fo9TTOsLUhK
YRG+NXungaHNZO8rL2H4vEEyhaSw6120uZbU2oCVqewX9tdH+yPZAhcpwFlG6Hcx
RayaAS5BFPKt7yk2PZf3uVPFHcM6dyJ6YOUBUTipWgcspryg3E9aF3ygzn3+XeOg
pocrBPM74kDEnUbWtVh34sOjigLhbSLyTnWMhHRjSGzWGDngRrIaVkWMw5OePH0o
c+Rc9dlAPftHa2ug1TF9IsiMWe8Uo8qGJWSTJ9nh3R/DZHN5lwY2+LalugqN3GWJ
Sj+CP57YUfjw7VurMYjH182VfsTrjhbxjCUlL2CClzInWpoKZm784IEqfdCADPX6
G7vpidscTOReyV96PmDGizGCdMnDAe2kH5y6eRfFrijQCRHoY59xerPK7pLqtyKE
fRQBvyMYnWNnfEG7LR6ZxZVnD42Pzu8R04opuoMmuXFQjkOl47VdjLHYOuyozJRG
/wV8n/M6PLT3yDGEVacXHQGbbpnyRYrE7EX7/BtXH0gMnpLmzThVEVWHvndQDDGU
SxfQV/yEIcrYxGZgkf7In7t4lNWF0VQtbT0RksVbQiKAHV7yunM=
=lGOp
-----END PGP SIGNATURE-----

--Pjs2fT3iSG2v3iJj--

