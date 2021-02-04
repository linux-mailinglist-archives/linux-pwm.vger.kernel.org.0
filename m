Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B300730FFE0
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Feb 2021 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBDWGW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Feb 2021 17:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBDWGU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Feb 2021 17:06:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FCFC061786;
        Thu,  4 Feb 2021 14:05:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b3so5374358wrj.5;
        Thu, 04 Feb 2021 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=56KnJBwSfnG6kpXjFMHfjWJrXx2nsGISNcSRtvkICbk=;
        b=j0LJWJrEJZl/2L4lmFs/WK4VFs0R/IZYeUDqj+UC7DF/V82JPz8qeZGM/pBaUlW0Wr
         P6EaTSoGTRhjv/9WvQd4q/V4WFPOIxy0BZVKEB+QPf7nMvvm1jyiBSe8CfFIwb/bU+fu
         eJgSFiYGNUGFfsliaHNYkPe/amEvn0LVVuyEM1UVDmVCpP47l+aktMFWsD7siwP7TuUO
         0G48alBlF/g0UJ4Z7CrxYwS7POL904kYqcCehTkZQ9wtHyO2Q2FZphecyOD0iNbXXEzy
         Jetq92xlNhiSLkZ3piDX3gqEJ+0SYcTnCAZIqSEt/d13RR7SgucPH3D8Yy6Uf58f05ou
         Gf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=56KnJBwSfnG6kpXjFMHfjWJrXx2nsGISNcSRtvkICbk=;
        b=qk6ew+UNBMgxOI+lKI6X0uVOCCcROLWD2YV53EymUUjtdN9/Z7fD7kyGuu4IEiOdpj
         LvQUQYptGtrCNkOh97AVXgbh+glj2ibwHOHMKQZvynPT05G5YP4Jbw17skT/MdRT398T
         QtIEGagLst6d4fTzoEl4HmIDxj1fCnsPUD/r08JG+1+QNLBdtHnGbpzEOJpJsLlQD98W
         XHE2YwQ0drWgsXI//0yrVtT7KVxsZQi0MHqcPLHhXuqX8yTGz68Jr2kGR/Rfp4JpIiho
         YD8i7y/lfEPF/br59iHNrEBSl1KeK2FBGIU1L48swkbOw3O8EFt3W/9b7wHuKdEYZnkO
         KxHA==
X-Gm-Message-State: AOAM533sxBZtpLEX8/svTl76etEejOFaKsH9k13dH8xRpwbctxunce+Z
        VIRgKn8KSw6q8aqaCpF9agtCTV6a2GA=
X-Google-Smtp-Source: ABdhPJy15nkmlprftfAKohKK05Ozo9o6pS4CvgmFwCu1N7Nm/Ju/NtyLyD9IJ+uuVH9B4dMLJBCM/w==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr1425234wrv.417.1612476338544;
        Thu, 04 Feb 2021 14:05:38 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u142sm7561283wmu.3.2021.02.04.14.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:05:37 -0800 (PST)
Date:   Thu, 4 Feb 2021 23:05:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Ban Tao <fengzheng923@gmail.com>,
        linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <YBxvr9WFlZac8rlO@ulmo>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
 <YBrQTM5iADZgA2v1@ulmo>
 <20210203205913.dvmppahnkmcj2dac@pengutronix.de>
 <YBv44P71Z0cD1BSG@ulmo>
 <20210204135436.xkxkp6qxjpcnfxgg@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbXPBPsjyzoUiVCH"
Content-Disposition: inline
In-Reply-To: <20210204135436.xkxkp6qxjpcnfxgg@pengutronix.de>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zbXPBPsjyzoUiVCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2021 at 02:54:36PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Feb 04, 2021 at 02:38:40PM +0100, Thierry Reding wrote:
> > All I'm saying is that I don't think we need to require everyone to
> > adopt a prefix, especially if this hasn't been followed consistently,
> > because then we don't actually gain anything.
>=20
> Is "we didn't do this consistently in the past" a reason to never
> improve here? I hope it's not ...

You're implying that consistently using a prefix is an improvement. I
don't agree, so I don't see a need to introduce any new rules for this.

Thierry

--zbXPBPsjyzoUiVCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAcb6wACgkQ3SOs138+
s6HnlA/+O4I3Ic/hHwHv24pmoOwjrXfNBCbW5xETutQq3l6YecKxSIfMniy7S/V1
TjMKYp181CYpumXIPAk1KJWEcbgLQbyJMKqVPWF3AJvzX7ImTUFpJb87NRGt1Yh0
fTAh9DB4EtpOo2lW0YUsix8rtjoBws2WB7+yvkDV093HaGJ2MadL4UWl3SUw6x93
+VgfUW/y66blcnSW3lW+mXjKjj7R7ArO45QmU0VhKDyFpGdcTAdk2hzTQqeygqWb
GnGKps5ce8/rViEbvr1DvyytGp8voPSt7NMg0jnaQqcrA2dgsH/A3bY1HF5S3K15
+ev0+Jq+PThhUA8SsDQiK3eL+uQ0TvfZrqBvYU4Lk9ASBh97+BmBQFIl9xgqDbcc
jHZM00icitCQAObwWQFnZD50sZtSkfDZ6RweiReMTboSMBvI2BtpF04jkFPWzjU0
wgx18jLtNAl0jautotaQfYv3FLBNHBL35kgf29Slrc17fFv7vLrPS/OLTrPkZXgV
VS96pULfFDI//4XgYRt6T6lFxvyBjXGfkc4Gk8dM5RaW4pXyEz8ApgpU+OLNIaMt
wU8H84tX0nSuFohBmfouw1Bzc5bHOJp2CaKlW9B5RRjF6JJ8F48G3DR5JELWQVSf
WKisWSVVujHOnQlfFIhOXVjqEOzYQfxjZTSb/Fx76Bo/+m5em3s=
=R7MP
-----END PGP SIGNATURE-----

--zbXPBPsjyzoUiVCH--
