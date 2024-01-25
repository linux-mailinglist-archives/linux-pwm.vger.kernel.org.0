Return-Path: <linux-pwm+bounces-1073-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8683CD7F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 21:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B36C1F21BAB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991D135A53;
	Thu, 25 Jan 2024 20:36:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A601745F9
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214966; cv=none; b=tCYg13RQbwOkw7jlM5YV6cfz9BrSwxNfjsUW7CvvoUBCehGqEfux3rYywXOde2AWb6LJUPT1XOkFj7HxHGvzsbrOOj4yXUt9HJeik6YwqBb5fu+tTxooe7G7Bd3dZHQMVxG2oXgTNqTr8ozM3NbpLnSGd12O06Vz+rS706bO+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214966; c=relaxed/simple;
	bh=r0r/+rbC4fkfo1V+u6lmNTAzFj+6SlQdrNeiYDSCElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QApQFw4ZqU//AcAljjJfaHBJozblCNu0xq7wtjRbMYc22FYGn+jOS0ZoqDmGPJCejonG15gAVnOaowewG33b9BD6dQqvgt7Olq67zZ/u5T+N79PhNFLqwGDZT+kjDtJ6G7peHFZTv/8Z8BTG8WPh6Q0P7K5pGq3D54i0GYKkMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6SA-0008Lm-CV; Thu, 25 Jan 2024 21:36:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6S9-002MZd-0M; Thu, 25 Jan 2024 21:36:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6S8-0087kk-2x;
	Thu, 25 Jan 2024 21:36:00 +0100
Date: Thu, 25 Jan 2024 21:36:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Robert Foss <rfoss@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jonas Karlman <jonas@kwiboo.se>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v5 104/111] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
Message-ID: <usyijt4ljaup3q3nfaycabiply63pratgfzaqmiekxkgpt7epi@dxgcgpovh7cb>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <0316aaec9dbfc0c73788bcd3ee532ae7ecadb180.1706182805.git.u.kleine-koenig@pengutronix.de>
 <CAD=FV=Xscb2kv6drrqBBT2MOA0cSO3=oVZ4Hw3sKTo-uUuqQ-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymtarg5ua2vmiokz"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xscb2kv6drrqBBT2MOA0cSO3=oVZ4Hw3sKTo-uUuqQ-w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ymtarg5ua2vmiokz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Doug,

On Thu, Jan 25, 2024 at 09:48:04AM -0800, Doug Anderson wrote:
> On Thu, Jan 25, 2024 at 4:11=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > @@ -1374,7 +1374,7 @@ static void ti_sn_pwm_pin_release(struct ti_sn65d=
si86 *pdata)
> >
> >  static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *=
chip)
> >  {
> > -       return container_of(chip, struct ti_sn65dsi86, pchip);
> > +       return pwmchip_get_drvdata(chip);
> >  }
>=20
> nit: given Linux conventions that I'm aware of, a reader of the code
> would see the name "pwm_chip_to_ti_sn_bridge" and assume it's doing a
> container_of operation. It no longer is, so the name doesn't make as
> much sense. ...and, in fact, the function itself doesn't make as much
> sense. Maybe just have all callers call pwmchip_get_drvdata()
> directly?

The upside of keeping the thin wrapper is that it returns the right
type, so I tend to keep it. Probably subjective, but even if it the
function should be dropped, I'd suggest to do that in a separate change
to keep the changes easier to review.

> In any case, this seems fine to me. I haven't done lots to analyze
> your full plans to fix lifetime issues, but this patch itself looks
> benign and I wouldn't object to it landing. Thus I'm OK with:
>=20
> Acked-by: Douglas Anderson <dianders@chromium.org>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ymtarg5ua2vmiokz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWyxi8ACgkQj4D7WH0S
/k62RAf+PSko60t1q9U2MN7yPyyXemjUk3sqeQNrJKVDUN98SlBIK1on50lPQbgl
GRmrYm7zrxLPLH+++EolvmiFNMWo6jT8Hh1rvYt95bHXHT93/qn2q8DYM8m/17nf
0v41vSIi1sDDiFD+txxgJiLR6428+0HigPkUT9diLDuvg0MSHpQFUg3kdhSHqCIP
D+TGqc5+VABNN4oHtUEhdhjQb+tM+xMQhHE6eRNos9j+a6wh07Y7t4ohyG7skOSH
kiwZ1Zh03xUw1/odVTt0ET1pym/OJK2zsDn1WKmkBkxF3bjtHDfLrfJv0n8jGB/w
TlDlZ43CO0Ii0m0KBBhZKMYZ2a99Uw==
=r7Cj
-----END PGP SIGNATURE-----

--ymtarg5ua2vmiokz--

