Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07801DEBAB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgEVPVi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgEVPVh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 11:21:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379EC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 08:21:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g9so9514367edr.8
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CzIqmdhWU3sRWqO6GMR4uO7ZHP9Wj3x950VXwyT3Rd4=;
        b=g6R6NfDV+yAFljlVrV4lY5FvmwIq5TBiZ1bXQ2PP9bUPxi2s9YU3/b5bdMR948gASw
         +kcEUpg6fah+54S2ukRrueY6XzFZeOWv2sVj+B3Gu0v1TCyWGESHoMPie7lvn7bFloBN
         i8l2hyuMWtcOW9z41Ixz9B/sc+j22vB0fgCmzhhFt1csX4Wj8CLFgOtMxnsdjRT31aqQ
         m/d/6ai2BDxdR5JD4ID5eIbhydlT4CLWIpmdHCt3ga4o7LbkriobMvY78smWupzPYZ7x
         /9neVXgplmg7MAw1w/dGpnTnYePhhJfKumERC4wJh+CDVB6nieE1QD8Biscvrjd11c1W
         23cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzIqmdhWU3sRWqO6GMR4uO7ZHP9Wj3x950VXwyT3Rd4=;
        b=g9UoHXGTeAZ7dAjfbpdF6SHNvv/AB5ezwQiu/AU6UbDGGTgYXbS9KmrOdinl0c4VUo
         gXxn93t3cerkE2kf8sFSWXGF5b+C+AARVr/71uwrk2ULpPMH04ro13unfOo+IDQWBq9u
         27j5gAi61LyzmyPMUNiV0BqLcmuN1ar5BtG1d67BxjiJ7Apn4R6K+J1YDaqwwMxhGvoe
         CUsepsl345XxWHtLevHvibxxS8mzkcEKIMvv4UlfBglF519wartwF31CtnBydm4VhfQK
         1o7LtWhCOYHDy9AAu24POIGXViheftVbqhYuwcyT6TxI7bxGUMMzkQCE3GXdJkDf7OkC
         oQwg==
X-Gm-Message-State: AOAM530gIcfHixmzQn42M3Q0xESAitlqXu2+dx5FeEp4kH92JPp61Hmi
        zJf7lWzgRdiyWxzObC7gb14=
X-Google-Smtp-Source: ABdhPJxSguYKcFz5tfgPXVz4oO4LJMqK31nCqtIs95mmi3nbYbnaS7TX9ZsxAUGP3Hipej8ra11eBQ==
X-Received: by 2002:a50:cf4c:: with SMTP id d12mr3328840edk.121.1590160895909;
        Fri, 22 May 2020 08:21:35 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id k90sm7101806edc.2.2020.05.22.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 08:21:34 -0700 (PDT)
Date:   Fri, 22 May 2020 17:21:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Missing feedback
Message-ID: <20200522152133.GA2377357@ulmo>
References: <20200522101355.x4td3ehkfhp636ft@pengutronix.de>
 <20200522114635.GB2163848@ulmo>
 <20200522131512.44pzss7ujsp2wbgw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20200522131512.44pzss7ujsp2wbgw@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 03:15:12PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, May 22, 2020 at 01:46:35PM +0200, Thierry Reding wrote:
> > Like I said, I'm open to let you take on a more central role eventually,
> > but I'm going to need a bit more time to convince myself that you will
> > be doing a better job than I.
>=20
> I'm also unsure that I can do better than you (and additionally that I
> can be better in your subjective view given that we don't agree on every
> aspect). Also note I don't want to replace you, for some questions I
> don't feel competent to judge. My goal is just to widen the bottle neck.
>=20
> As a sensible step I think getting my hands on patchwork and cleanup up
> there would be a good thing. This would help me seeing what is actually
> still open and also help other interested parties to see the current
> situation.
>=20
> I agree that working with patchwork is tedious, but as soon as there is
> not only a single person who can keep everything in main memory some
> form of such a coordination is useful and important.

Okay, let's start there then. Do you have an account on
patchwork.ozlabs.org? If so, let me know and I can get the admins to add
you as maintainer to the project.

I do also have half-finished scripts somewhere to help with patchwork
maintenance. It might be worth resurrecting them and see if they can be
made more useful. One thing I've been meaning to add is some semi-
automated way of marking patches as superseeded/changes-requested. Or
automatically sending "Applied" replies and marking the patches
"accepted". I think that would go a long way of removing the tediousness
because you only have to work with patches and not worry about keeping
both the maintainer tree and patchwork in sync, and it avoids the need
to send out automatic emails.

Thierry

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7H7f0ACgkQ3SOs138+
s6GSpA/7BHr8CyFbjUooPaYy6W3twQzQleGa+82hQebOgdA3SDOuneVLNnxlcKAS
so3MZIBUEOf7CA8NHy5MZ/ubMxPWSFKmcGA5PDaa7g5JrOBdcZBQWVo7ZYDE+pYy
Pl/Uw1xZJWWlnfA2tNLq/QFjvcjZlyiv0xOkeo+PZeo79vziXW0MjskEJ0qJArN2
KchZtKXLwZDnLxjxMOd0TlN4aDeo11IdL2Q/qg9jEHubd1js/1Lwy7UT5HV+9sir
fdbkNo5GRHBEstQc4Ib+17cFHZI9SAmis63TBHSto26VSho7YVVxK1BctgOfebij
mWz3ZjzWSTPVAgea+UAeTSNfkERIX1qQb7VCcR/MVPimqc80CHcWF+1zbuhOIWBH
4LcAeHwsV3GhDABQRtfkVhL20Erz9ODVIJPoq5PW2alMGxlx/6nLM2AwP6tOwjIb
OwtmmyjM50waYEU6OlXMi3sAAsODZh4T+AJ3YWByARLoVog64XGud2bBv9Q/xo75
sFSy7X1IPXKg0d9uAsCZfOPGgAlNt3YRrUJ9L0UNNo+L0fwxExFEHRwVAWnbfK/k
XAZGLOXhTfnojc+6YY+ob+8kPGDH4+IGTUeMdqxHoktpHPkBxJBI3W+j1xScow/u
6yCK55JgBoB63/N/EfMuAlBtVIQGX2X8d4mCbA6B3YrNdggPV+s=
=mRtg
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
