Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2614A19F2EB
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2020 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDFJv3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Apr 2020 05:51:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgDFJv3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Apr 2020 05:51:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so2918602wmc.0;
        Mon, 06 Apr 2020 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VM8BXPopEtF/vWMO6fH4OBxYXzchIKT+rdSCRSo1hE=;
        b=ETEKmsikJ7lNFax7fOsUxRzi5ybSvI9m3Ia2HjDWRVIYXlCGjP17IanQ/eOg4VQyfC
         +0PzrRtw7jpxn+SgX+OHxqGwHNWAqSXvFzGqXlfElOdSYgVVZNxVJNS9nFXHYAu/GhEc
         63xlMnvUvT0jHUipg9GgKYJICFjQhb7LVSQ/tnFSx9CJ/StAXxaZEaw5vel+g0lrSBWg
         Ghj1nA41ky3OBPjP+Feqb64MYrhWafhhchC2ltvwaror65/IpDUEWSOTeobsnsWSBbQw
         mPgVuaUmASzy4/oGLPsEDJWJwFzCECmkmIbFR44sAYChgQJt15tbQaeqAvXkVgFOwn9S
         cSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VM8BXPopEtF/vWMO6fH4OBxYXzchIKT+rdSCRSo1hE=;
        b=oCz/DSJYkwPk+6XEeasoxgDreMK5yGfFLCi8bl/R00c3EoL/kyjjdXGljiw6HRtTcY
         f4RakM1cpm6rpq3pY6rdl8atYX1iJvKCymMvqF0IwZJ5QYO/GBhWp4BIdBypY5+68yRf
         js+kWOACTSG36xaHE/vj2fKEk9buZOesl7uZs3Gtru9euYMII/fHtoovNOhQZuM6AheA
         GW0D5oWNMeUzb/rmWIHbhJoZ8UPmAhizbRS5y6wWvSA98H/9dxKBS9w3NoJH9N7y+Tts
         Nac5J/t0RrlT8yfgWMmUCT7yO/fzprqR2G6u+3hYt6SNrwd8dYpzwMYnGUAQ7mCiqDt2
         XHaQ==
X-Gm-Message-State: AGi0PuatCpQF88QiWyBI+sHqqCpbLqSywkGyxpu2GoCaQ4ZYk7jKwteC
        IsiXYy2LIYj/7MMTVnBePNs=
X-Google-Smtp-Source: APiQypKHLa6tX6IVcch/Q0+KCyUEc5LV6iQn8Mv+dkUDCEh4ACEjxzAq5d5bMU9TnSMpsN6uBZoH3w==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr21808723wmj.84.1586166686663;
        Mon, 06 Apr 2020 02:51:26 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id l185sm24394718wml.44.2020.04.06.02.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 02:51:25 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:51:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Message-ID: <20200406095124.GA475759@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
 <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet>
 <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
 <20200404173546.GA55833@workstation.tuxnet>
 <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2020 at 04:17:00PM -0400, Sven Van Asbroeck wrote:
> On Sat, Apr 4, 2020 at 1:35 PM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > As the user is setting the duty cycle in nanoseconds, it makes sense
> > that the relative duty cycle decreases in an absolute period increase.
> > As for the behavior that the other channels remain at the same relative
> > duty cycle: Not sure how we can avoid this, other than reprogramming all
> > 15 other channels if one of them is changed and that's not really
> > acceptable, I think.
>=20
> Thank you for the explanation, Clemens.
>=20
> Yes, it does make sense that the relative duty cycle changes when we chan=
ge
> the period. A relative duty cycle of duty_cycle / period is what the user=
 would
> expect to see.
>=20
> It also kind-of makes sense that the relative duty cycles of the other
> pwm channels
> do not change: after all, the user is not touching them, so would not exp=
ect
> them to change.
>=20
> However, the following does not make sense to me. Imagine pwm0 and pwm1
> are both active and at 50%: period=3D5000000, duty_cycle=3D2500000. Then,=
 change
> the period on pwm0:
>=20
> $ echo 10000000 > pwm0/period
>=20
> Then pwm0 gets dimmer (makes sense) and pwm1 keeps the same relative duty
> cycle (makes sense). However, if we now read out sysfs for pwm1, we get:
>=20
> $ echo pwm1/period
> 5000000 (wrong!)
> $ echo pwm1/duty_cycle
> 2500000 (wrong! although relative duty cycle is correct)
>=20
> Although the pwm1 period has changed, the API calls do not reflect this.
> This makes it next to impossible for users to know what the current period
> is set to.
>=20
> Moving to the atomic API won't help, because .get_state is called only
> once, when the chip is registered.

The .get_state() callback is actually called when the PWM is requested,
which could be much later than when the chip is registered. That doesn't
change the fact that it would be useless for this case, though.

> It does look like we have a square peg (this chip) in a round hole (the
> standard assumptions the pwm core makes) ?

There are other chips where a single period is shared across multiple
PWM channels. Typically what we do there is once a period is configured
for a given channel, all subsequent PWM channel configurations must use
the same period, or otherwise the driver will return an error code.

See for example:

  - stm32_pwm_config() in drivers/pwm/pwm-stm32.c
  - lpc18xx_pwm_config() in drivers/pwm/pwm-lpc18xx-sct.c
  - pwm_imx_tpm_apply_hw() in drivers/pwm/pwm-imx-tpm.c
  - fsl_pwm_apply_config() in drivers/pwm/pwm-fsl-ftm.c

The rationale behind that is that we must not change a PWM configuration
without a consumer having explicitly requested it.

It seems like PCA9685 is somewhere halfway between in that it will
actually keep the same duty-cycle/period ratio, but that doesn't mean it
is automatically okay to do this. The problem is that the duty-cycle to
period ratio is only relevant in some cases. If all you care about is
the power output of the PWM signal, which admittedly seems to be about
95% of all cases, then yes, this behaviour would be okay. But what if we
have a consumer that relies on a particular width of the PWM pulse in
absolute terms rather than relative to the period?

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6K+5kACgkQ3SOs138+
s6HhFA/+PEiXL6s/Cq43Hd4WNCKlr04FsvoDJM6O5IuLU1Juh8TT2IZImpKY/BKD
J6xXeqCkuOHbeWNpV4w8TM/ZD8UJ4JLM95l9fVs363tFZ/+UG34Oem3pSzLAv793
gtGz5gQXgCBWcoe3dvKXdADVwuhhveigg/W0dINZJ90lwW+nfYTQKRveQTa73+EG
1J/D7vHORq7d3Lmfa6clKNTuz/mtZ+OizAZK02a9YUJiZ9ZTB9T2UItNIZBJzjsg
B00O/NE7siC/un37QUYgb68fryLCcRfDnuVkZGTAjx1lIXPMWID162oGhlyHqaKC
s6rD1f7VwGOZZDaXmlj6a+gnkoGdArnOhTc4NzNiLOl5opuJjMXWTarxsP411oW5
v31nksb37+Nr2rTbyvhUEqmeCbqiNoYFvFXsleJsF2LIrroYGTU0GrucCzXh5v7U
Z+phxutOZMAW0OrhVS26/kNr8oOKgyVX2UHi2KI+c6n9/ccwv7LBDtgVC7/1/r0B
ZChU1ymVrBNLSyDgclBc5DnR4FTYYiOBE5Mh/jRkccHu8HMUHCdpw6DPerrcIMil
hxkz9CPn6tgVUgXdMNxDM/J8zn5t6IY27PP0S96ZejCZZqot7SzyxnuF25UaMeqL
xmuRlJjDF0X2yCn/+6FflGG4Rm3RfIMfj+Zo6v5iYMtj7CmXCpo=
=0CGN
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
