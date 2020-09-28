Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3826A27A7C9
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgI1GpW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1GpV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 02:45:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F4C0613CE;
        Sun, 27 Sep 2020 23:45:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so10920838wrx.7;
        Sun, 27 Sep 2020 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=05iWIJYB2oDYyH9Jw0dcggBXad7SUALC3TiMsF+Azj8=;
        b=DyqRJdfm63h/KMo4QCnEFJL1M2GlQQm95ZOeccn/9kNWjGfRDaRfzvyLYDX3uaYj+z
         hIcMplZ+4XU/z0Wnu5QP5A8QcVISkLSL3jlONUkHjOASmAACf0ctZd0PKi8myCTGs6Q5
         nfy/LLrgkZssLSkwWrleHwS09SwDfU21Q5XquTU19V7JRoxCrfiDo00lYe1zzHbo7EHN
         gwhY7R8SuvYkvLUHJyVFS3JB1IzvKSrND1ZObSL2jCpvd8bTu8Iw1yUe0Lfk9+k5iv1z
         wfhEa7fNThovhs//VzZ/gLvb15nTB+T8LeL63ow1O/dV0ZRNM8+EY24UXrluSX16akQD
         r0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05iWIJYB2oDYyH9Jw0dcggBXad7SUALC3TiMsF+Azj8=;
        b=RWMiY5Uo1A0ijkcRhnhG/Zdz7FZymw5DJBdZZ9jhEoaCvMQrfiv3TjHsQ6CNfPV6/q
         5uPdzS1KLzcBlcBFi+10Hctf84TR7ZRgvusQYRRn3B6BGXwFMvWDZL6AE5OkkJiXYouN
         kqgsXNOM1xO7nCFQagkWfBqHq26gXfVSBQoa4WuxXps5fF4txUdVhhvfjMs9lUqoi1bv
         m6IEFHWn6hvRI98MWowIlUMNgsaNYC+GIzML9DgoaF5o5eXQ7nAbn6lG3StXkiOGpY1G
         OyFAPH634QpvcJvXL+B/v14X1PRzCl6GR4AK8n7xr4f36pHuSbCrRGaaTBb9tMJmWJC3
         x9eQ==
X-Gm-Message-State: AOAM530qgvw2xqTWKOMaARXVDtD631FpIjmcoDtVNxEHdOSYl4BVtVrw
        wl+d2pDHMPRtfM94s766bfw=
X-Google-Smtp-Source: ABdhPJxUmnoNK0Resy7N687L4omMhCRf+0hyyUxR25i0XfPeotFKDPjVtTTKDIUT/0aaVXHHjZiEbw==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr17093159wrw.199.1601275520072;
        Sun, 27 Sep 2020 23:45:20 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id f1sm11637062wrx.75.2020.09.27.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 23:45:18 -0700 (PDT)
Date:   Mon, 28 Sep 2020 08:45:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200928064517.GA2837573@ulmo>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
 <20200924132334.GT3956970@smile.fi.intel.com>
 <20200924141659.4wov7w2l2bllpre4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20200924141659.4wov7w2l2bllpre4@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:16:59PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Sep 24, 2020 at 04:23:34PM +0300, Andy Shevchenko wrote:
> > On Thu, Sep 24, 2020 at 08:55:34AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Sep 15, 2020 at 04:23:37PM +0800, Rahul Tanwar wrote:
> >=20
> > ...
> >=20
> > > > +	ret =3D lgm_clk_enable(dev, pc);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "failed to enable clock\n");
> > >=20
> > > You used dev_err_probe four times for six error paths. I wonder why y=
ou
> > > didn't use it here (and below for a failing pwmchip_add()).
> >=20
> > dev_err_probe() makes sense when we might experience deferred probe. In=
 neither
> > of mentioned function this can be the case.
> >=20
> > > > +		return ret;
> > > > +	}
> >=20
> > ...
> >=20
> > > > +	ret =3D lgm_reset_control_deassert(dev, pc);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "cannot deassert reset control\n"=
);
> > >=20
> > > After lgm_reset_control_deassert is called pc->rst is unused. So there
> > > is no need to have this member in struct lgm_pwm_chip. The same appli=
es
> > > to ->clk. (You have to pass rst (or clk) to devm_add_action_or_reset =
for
> > > that to work. Looks like a nice idea anyhow.)
> >=20
> > True. And above dev_err_probe() is not needed.
>=20
> You argue that dev_err_probe() gives no benefit as
> lgm_reset_control_deassert won't return -EPROBE_DEFER, right?
>=20
> Still I consider it a useful function because
>=20
>  a) I (as an author or as a reviewer) don't need to think if the
>     failing function might return -EPROBE_DEFER now or in the future.
>     dev_err_probe does the right thing even for functions that don't
>     return -EPROBE_DEFER.
>=20
>  b) With dev_err_probe() I can accomplish things in a single line that
>     need two lines when open coding it.
>=20
>  c) dev_err_probe() emits the symbolic error name without having to
>     resort to %pe + ERR_PTR.
>=20
>  d) Using dev_err_probe() for all error paths gives a consistency that I
>     like with a maintainer's hat on.

That would perhaps be true if all error paths did use dev_err_probe().
And even if that were the case, dev_err_probe() doesn't guarantee that
error messages will actually be consistent because developers can still
provide whatever format string they like.

Also, the format of the messages that dev_err_probe() prints is unlike
anything that I've seen, so introducing dev_err_probe() actually makes
things more inconsistent, in my opinion.

I have in fact been advocating for people to use error messages of the
form:

	"failed to ...: %d\n", err

or:

	"unable to ...: %d\n", err

Or some other similar form because that's the most common type that I
have come across in the kernel. I think it's also easier to read those
error messages because they contain the important data (i.e. the
description, which tells you what went wrong) first and then are
followed by the error code (which tells you how it failed).

Now I suspect the current format was chosen because we need to have the
constant part first, because otherwise the arbitrary format string could
be something that doesn't lend itself to have an error code appended.

The current format is arguably also something that's easier to parse
=66rom some script because the format is in a somewhat standard format. On
the other hand, I think this is a bit misguided because we already have
structured log messages, so I wonder if it might have been better to
make the error code part of structured log messages to make them truly
machine readable but leave the formatting up to developers so that they
can use whatever is consistent within the driver or whatever fits best
without actually adding a standard string to the log messages.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9xhnkACgkQ3SOs138+
s6FL3xAAi8SW4eZyqa3DzH2x8PIYh0nU4XdJiwu3FXjnpeZKFhpAw727Pf1Rwae7
PMFnDggq2Q0GJC8Pzo95H0yBYaaVuQa93TLNszX3ofW0GZoZAadGPtGUjQrfFWcZ
p7DySeukbO3BNIEDSIbMRYSUF+9cPq1sC4RAAQXP27Kdk62nbw2Tsr+AG7YXIBlj
Z5N4zdFTv6LQRIIv08vpNyj74FSAb41wb+MR5vQnZKwlGRLJ0ZpVuW77SjFtj3Q7
XMwrHljmSogGLIeqepX3I4McjzVfMXLWcF1sw6quBSX3zJo5DYybcvN6TUnWXQWe
2AKyE+PGBjwBZcUJg9RM90VvGNjCJ3zm2WUQqLvsYRKC0eGubF9p65b36y6j0IIa
A2gQNJQ5JiqW5q9Jm5I4RwTU0lZ/Mi+TwnKdZvPiPcC+YuRiqdUC5dHfXvWPfeCL
eMFhmd7pRI8H7HkRNPo8z/tVufr+zHbYjtQljv2iCCZLXDfBPioX8jeTh9iXbj8Y
wqR7F5vCC4pAWGLMw4o9jg0Zg5ywPRccXpNh8IbsrNONj0Y7MfXbo5lhxeqck10h
ZnQRB67wK7iRbV23oos+R5Run1fU/PD4TD+m+6noGDHcmiOmX3g/ZxecAU5iB9pg
e+V3/apZhQnJ3zwUssmZUfG501sECh3EqmZdUzDT6yrULhEiLtg=
=Td2r
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
