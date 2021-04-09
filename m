Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D666B359E59
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhDIMI6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIMI4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:08:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114DC061760;
        Fri,  9 Apr 2021 05:08:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u17so8302060ejk.2;
        Fri, 09 Apr 2021 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cEi4dBMf1BkmuY14gGbElJbBTh//wd4dN7gILare5wE=;
        b=pQ+ZrITvRJMq9gBKBD5zfu3ZTxMiQ0leTkBxsvGMVbkQw/+/nGowpbVKDkLnwkIvf1
         rr4UDyF83OUFNyun0b/I8NlZzgYFhUWaSZsBn00AYCh/72n3ePyYZVlPB/Ma40c6mdsk
         SOKXCjAuNMB5QXHfNXqBeE5RAcnyp3n0aG1Z/c5AVFW2SHNhN0P3e0RCLvosgCS85T1V
         shoITnsV/MmRNuMOih8rWULq78meoIiVsqp7Ll+G9nHexsotUoPN0MZsF7cNCgU10CpJ
         6URgdTD3ejvZc+FmgmuX49Rxa98bdXURDxEcTAzejG2L+vjnu0jzkWrXwhPBzD8cDx/t
         68GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cEi4dBMf1BkmuY14gGbElJbBTh//wd4dN7gILare5wE=;
        b=C+lAc+fVS2nRJK9DIp2DuzuGnJlRvWFw8c36f2asbr/rfodaPS0lSKov04vxlhJh/f
         6pNLjMuxu2AmgjN7c2n4w7vwGnx+pHJMBhb5X0IWWgqrlUsabaq0G4n//jUjcc5ssbE4
         T/9Te/jeBQ7/U2ztdIRHYRk85abAeP3lt6kcH6L/w9N6A7tlva+d+7odu9tHAU9qWwxn
         6SXe9tezDvT0MgIF0RS2/EkUrw/TQhN2lsEVd769szp/zgHfd10Gs+RyViwiOA3nZksw
         ZYxU1sqrUhsmqOErqveBzckc//M8pHPQPcEiKxQt0Er27DYf9bNfNcg2umtVG2hKYcHJ
         /G+A==
X-Gm-Message-State: AOAM530/LYi8y9Wrl0N33U4WlpxrFu4l+6saX/R28oMd60YncWgUFV6X
        ISrUM+p9H8w4Pd9RXI1cxLA=
X-Google-Smtp-Source: ABdhPJx8h9Pc3BjF3vRa5o1sWGyI42O8E2SC22STz2KAQ0OfGsoMxl6LpxVlci6LyxYc8HpCRIYF8g==
X-Received: by 2002:a17:906:1115:: with SMTP id h21mr16575768eja.352.1617970121833;
        Fri, 09 Apr 2021 05:08:41 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id h13sm1345521edz.71.2021.04.09.05.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:08:40 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:09:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-input@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        intel-gfx@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] pwm: Rename pwm_get_state() to better reflect its
 semantic
Message-ID: <YHBD7AhOJGyELpVZ@orome.fritz.box>
References: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
 <YGxDD4jVZx/H/Zdr@orome.fritz.box>
 <20210406134356.dda74heeshkwdarw@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PvYVwmcUBFdXJjNu"
Content-Disposition: inline
In-Reply-To: <20210406134356.dda74heeshkwdarw@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--PvYVwmcUBFdXJjNu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 03:43:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Tue, Apr 06, 2021 at 01:16:31PM +0200, Thierry Reding wrote:
> > On Tue, Apr 06, 2021 at 09:30:36AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Given that lowlevel drivers usually cannot implement exactly what a
> > > consumer requests with pwm_apply_state() there is some rounding invol=
ved.
> > >=20
> > > pwm_get_state() traditionally returned the setting that was requested=
 most
> > > recently by the consumer (opposed to what was actually implemented in
> > > hardware in reply to the last request). To make this semantic obvious
> > > rename the function.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  Documentation/driver-api/pwm.rst           |  6 +++-
> > >  drivers/clk/clk-pwm.c                      |  2 +-
> > >  drivers/gpu/drm/i915/display/intel_panel.c |  4 +--
> > >  drivers/input/misc/da7280.c                |  2 +-
> > >  drivers/input/misc/pwm-beeper.c            |  2 +-
> > >  drivers/input/misc/pwm-vibra.c             |  4 +--
> > >  drivers/pwm/core.c                         |  4 +--
> > >  drivers/pwm/pwm-atmel-hlcdc.c              |  2 +-
> > >  drivers/pwm/pwm-atmel.c                    |  2 +-
> > >  drivers/pwm/pwm-imx27.c                    |  2 +-
> > >  drivers/pwm/pwm-rockchip.c                 |  2 +-
> > >  drivers/pwm/pwm-stm32-lp.c                 |  4 +--
> > >  drivers/pwm/pwm-sun4i.c                    |  2 +-
> > >  drivers/pwm/sysfs.c                        | 18 ++++++------
> > >  drivers/regulator/pwm-regulator.c          |  4 +--
> > >  drivers/video/backlight/pwm_bl.c           | 10 +++----
> > >  include/linux/pwm.h                        | 34 ++++++++++++++------=
--
> > >  17 files changed, 59 insertions(+), 45 deletions(-)
> >=20
> > Honestly, I don't think this is worth the churn. If you think people
> > will easily get confused by this then a better solution might be to more
> > explicitly document the pwm_get_state() function to say exactly what it
> > returns.
>=20
> I'm not so optimistic that people become aware of the semantic just
> because there is documentation describing it and I strongly believe that
> a good name for functions is more important than accurate documentation.
>=20
> If you don't agree, what do you think about the updated wording in
> Documentation/driver-api/pwm.rst?

Yeah, that clarifies this a bit. I can apply that hunk of the patch
separately.

> > But there's no need to make life difficult for everyone by
> > renaming this to something as cumbersome as this.
>=20
> I don't expect any merge conflicts (and if still a problem occurs
> resolving should be trivial enough). So I obviously don't agree to your
> weighing.

I wasn't talking about merge conflicts but instead about the extra churn
of changing all consumers and having to type all these extra characters
for no benefit.

Thierry

--PvYVwmcUBFdXJjNu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwQ+wACgkQ3SOs138+
s6FoaQ/9EG+snyNuisvtyU5qYi/2TVmPDZz6j1D/s1DAK1Op6AtOQksGAH7dqHgw
bT+jTMJi5bTnc4RSeUNrVFcVtb5qVWZEvN3D4c1wcr3PLtM8O4XxRQaMULo2+3pN
CCrHZKWyvB50hVFEs9CUSozlWk3HO/MNjef2MmwxBHiro1JBdAJivwFZEX8xQo2h
/y0HVDlrH2A1soG/WaGEeR6s3TzquHZiOawgNu51xgxIaxrEBs/ca7gBCuEfvy7d
Mu2yR+6VpjNWA0m3e53Nc4QkbQUDG89Thdf2i2HjVYsHX8wpVKWiA3OogCpVbTlQ
BUqEvvRQ5krW5IcneASEEKMOJSkX6zf86kC3RoYSbKmydCc6BlYVePr25yoTMAPK
XaYqd7i5ocueQZF5RdxrIXIoRgjU3Wu8v34N2mgaCCrHIwTHFJHAdim4h18Mbj+3
hVgZ+cuQ8Kaz0YjF4nAGQTQLsAQb7u7CjH6BqRzKUveMfInqD5wij6bP+jN0IYZA
4eUL5tfEdajQBvosPm4aQm0xULcg5jxq7rG/hpTa9y+J7s31IzXQ73dx2gse4kOt
0QY36evBxZKnvM5LGwWOkHK3aB8T2RqQP4l0kA9fmiQYYBudAL3VSEyE4mWU2Iza
P1UoRFFrCJ9K6dYBRX19nE+N1kAi2axBa0+KTMxQAUo0KzYGB0w=
=aO1m
-----END PGP SIGNATURE-----

--PvYVwmcUBFdXJjNu--
