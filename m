Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99EFD91FD
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391721AbfJPNHV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 09:07:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391656AbfJPNHV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 09:07:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so27966731wrq.10
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhQVpKcP1fqUFzp3EtznbJGPVIhD5oC4tPLSkRmqPIQ=;
        b=B8S20JJ7vEIK1rwbuMmLox2+nxaiUHMkcbk52Q1lN+ynBw81yKQQ3QlDLL6GS9Occq
         8GoBKleAMpUFSO/WuaLjVSJvuJ31pc5TmgRAEKoH3dE3NVKebNJ4rVTlr1e28TnmLdhb
         5vpVkYy72J30h5rzFdj8K9hZ/yNWsonNIG+hk6GLgVSDR8NfYcTP5G272EQ6IRNNG5+H
         8ngW8thlqspRS5CZAfoBjRxb93NqdZ8pazI1E658dmx9M0n1h98SxADh9iCa+sG+C2be
         c4Rek4ZrR0M9mK+fxm9oyGz0kWvybCWtYOSfSPRjCOkNZ3iN+UiXqg+IJ64DexmYS0cT
         VdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhQVpKcP1fqUFzp3EtznbJGPVIhD5oC4tPLSkRmqPIQ=;
        b=beqQFqkmv9LJI1Pxm79Q9icp1SqWsXCiivNdrVn3LN0W70HFkoZ88BaKNGOL6T8SML
         Uxqccl5QTVOIwC/pl0VPzQbY0W3LL4ehOFCnx16UCK+RZyyJHZKLlGYSCx9W3UuVvdSn
         VV852uK7I6qqB59OyKVXjmih8KexMOlSe3yNG2qsKnoFSWGCUD66T9Q2KnBF98wbD3Zg
         7Dc5g+bJHaBBI5N4cwdrQgR1kOpEfI4qdwqI5C1hIM2/SZd/MRTNYMEOfzSx0/0meyEV
         kOOQukcoKvXInptUHtG8OwuletRrXwk+1cyQnJ9LvKLIo16p2wz8SihTQ0ak6QG7PPKw
         vLdg==
X-Gm-Message-State: APjAAAWcAOIJnHv7N+QyLdDb+BHqyDPxto8vWLh4ePWxXh0jCGTiw46e
        UzwVLWcj+X9YU9U0qlwPkUc=
X-Google-Smtp-Source: APXvYqyY3WR8aR/zRu7Lp3dTjxZWcL14O7MHEiW8A9StjWAsvpgPyrpXxBZ4G5XP06RaZF1AsCsWQw==
X-Received: by 2002:a5d:6683:: with SMTP id l3mr2651773wru.272.1571231239011;
        Wed, 16 Oct 2019 06:07:19 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id t4sm19597374wrm.13.2019.10.16.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:07:17 -0700 (PDT)
Date:   Wed, 16 Oct 2019 15:07:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pwm: stm32: Validate breakinput data from DT
Message-ID: <20191016130716.GC1772382@ulmo>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-4-thierry.reding@gmail.com>
 <20191016111522.vzsipskmt66q27bq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20191016111522.vzsipskmt66q27bq@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 01:15:22PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 01:06:01PM +0200, Thierry Reding wrote:
> > Both index and level can only be either 0 or 1 and the filter value is
> > limited to values between (and including) 0 and 15. Validate that the
> > device tree node contains values that are within these ranges.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index db1d675b45fb..7ff48c14fae8 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -530,6 +530,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32=
_pwm *priv,
> >  				       struct device_node *np)
> >  {
> >  	int nb, ret, array_size;
> > +	unsigned int i;
> > =20
> >  	nb =3D of_property_count_elems_of_size(np, "st,breakinput",
> >  					     sizeof(struct stm32_breakinput));
> > @@ -551,6 +552,13 @@ static int stm32_pwm_probe_breakinputs(struct stm3=
2_pwm *priv,
> >  	if (ret)
> >  		return ret;
> > =20
> > +	for (i =3D 0; i < priv->num_breakinputs; i++) {
> > +		if (priv->breakinputs[i].index > 1 ||
> > +		    priv->breakinputs[i].level > 1 ||
> > +		    priv->breakinputs[i].filter > 15)
> > +			return -EINVAL;
> > +	}
> > +
>=20
> maybe put this patch before patch 1 that relies on index not being
> bigger than 1?

Yeah, that's a good idea. Does that resolve the concerns you had on
patch 1?

Thierry

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nFgMACgkQ3SOs138+
s6GoXhAAjM9CLPbTtmBWccz2KqxoEz5fs2Ztss4ayn1mUX7tGd0oAXkFb/gil+a5
1jy5cXNsjzSAmCHbFsGpW+7UyJeAZmpBIcSmnP360Kk3iODTUhSnRw/Z605slf+y
+jqeuJ/p7tSrPJBSXCNyUNquGkMg9uIKzP02kHtt+1Y5qHpCoPnaxR/M+03c7jI7
QkLF0hTZCTd+2sZLy3F1Dhykw4Ylm5MCJaEftcPkZcBLjUrneSwnASDomItmaUxf
Ng/NZ0mtvnlBQPwz+eKD98bOr5fYwmMchuHDuY9CbwJxXTExeluukofIxV/DvH2p
dOKC8WobR4Fhji6nMLiXpgaW94eo6UfP4UlPV044DUPIkfBK+qMDY4uNDpNbWpcs
QlhLuIW9dH9WBEl8bOO72rf47jSAWWo08SzPS4qAN4wPVJKrgdVVnOtIsX4CCO8W
ZXnyyuklRBXh+fH8VDinLAjeyJLUw/jAKoHQ+qa5p67azcS7/VHaOgG4EKqWFVcB
+MPSLImJ60xNkaBA2S9PyWTTtElXXQmjJz/ji22MJQZ6XjE9fYPkljLpI2Au838Z
dzKK0ace/qcrH3EjrthH/dhLzeEgs6PZjI/uwkRq74T53US4Pa+m5YvrGOFWvp9C
NSIrulFPkmRFAIVKeZQ+8FlTcSatGejmUdE35VVib9Bd5ELYpcM=
=TDCT
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
