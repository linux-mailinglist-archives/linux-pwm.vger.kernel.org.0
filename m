Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ADA3551AF
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhDFLQL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhDFLQK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 07:16:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C23C06174A;
        Tue,  6 Apr 2021 04:16:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l4so21252888ejc.10;
        Tue, 06 Apr 2021 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVEDKiVUDMBOpgUCPiSByRWJFXrj0auSVMAOE9mqU+U=;
        b=eF4JkJr9jyFg9X/TymlZbfz77nC1P0sRTQUA4jzF2Pz25yTkHXNWicf0Y3N/KFEMBg
         KtSkAXw6WXUHAv+8G32fsEH635mZevPOihNO49sWpIUwQ8I+CT7CtQPtkW/QGFq++k4G
         DugHhWhubTu0yLiWjuT4VrSF+WfFquNFrxVCrC1TNcnPl0rMnOGvaV9aGYrbZAzbZNpu
         9yQpA9rBcDGa9ucFhda2RoVxLSvBByHuklnjvrjh/XFUcSAl0FBhHnUi5liXQC7P2Y7F
         amxG+oFeNkRZcvjRNXSyUoD3p7KU9lroDVDd7/X+I9p9hMyzHQ1rVvwPMlTMRP6CZn4f
         MRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVEDKiVUDMBOpgUCPiSByRWJFXrj0auSVMAOE9mqU+U=;
        b=IeS++rfXilZ/G4ir8hdOnzYZLFF3ozZYok0TXARs0LmpVdFL6ibFPs4m601+wGcAd4
         tort+ct+LRerhk2WRRxMkrATU005tHegG/MIk66dpsJvbJ+x9ObwgAJ27hYBPzi6zNw4
         71Ar2zB1DgqU4IYD/0Tx014cvurS4ZQD3MIvCsiGTDZaCcmCWVvcnyQHT0Xio92e9roa
         tWeJnsS3scN2lQUaseE0eH7uj+hJuEsC+9+/Ia7FOHasTngvUNMzOg3KUSlr+xGIdDPz
         AwCsf+awTkL2D8w+gO6ak9xo2gNkTiqwFlBpbTeD9+WrjN1TeZz97qA7IZ/iUR1s5Si7
         dWGA==
X-Gm-Message-State: AOAM5304uslQRYuEx82aOvWDYyxcx6V0Gf+QURywMZjAjeAGPFDhMb+o
        bHPC+aKXjWNSka3EYwhzGOE=
X-Google-Smtp-Source: ABdhPJySr3mBbF07VyzFBl9k8WSX0iBzHT1u+7rCFpmxkrk+5FOaupGQM5xmxtmv1+7X7Xid4NTPbA==
X-Received: by 2002:a17:907:2da7:: with SMTP id gt39mr1456317ejc.193.1617707760199;
        Tue, 06 Apr 2021 04:16:00 -0700 (PDT)
Received: from localhost (p2e5be490.dip0.t-ipconnect.de. [46.91.228.144])
        by smtp.gmail.com with ESMTPSA id y24sm13894442eds.23.2021.04.06.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:15:58 -0700 (PDT)
Date:   Tue, 6 Apr 2021 13:16:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] pwm: Rename pwm_get_state() to better reflect its
 semantic
Message-ID: <YGxDD4jVZx/H/Zdr@orome.fritz.box>
References: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kAjYvSBiDvNQ2JMa"
Content-Disposition: inline
In-Reply-To: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kAjYvSBiDvNQ2JMa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 09:30:36AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Given that lowlevel drivers usually cannot implement exactly what a
> consumer requests with pwm_apply_state() there is some rounding involved.
>=20
> pwm_get_state() traditionally returned the setting that was requested most
> recently by the consumer (opposed to what was actually implemented in
> hardware in reply to the last request). To make this semantic obvious
> rename the function.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/driver-api/pwm.rst           |  6 +++-
>  drivers/clk/clk-pwm.c                      |  2 +-
>  drivers/gpu/drm/i915/display/intel_panel.c |  4 +--
>  drivers/input/misc/da7280.c                |  2 +-
>  drivers/input/misc/pwm-beeper.c            |  2 +-
>  drivers/input/misc/pwm-vibra.c             |  4 +--
>  drivers/pwm/core.c                         |  4 +--
>  drivers/pwm/pwm-atmel-hlcdc.c              |  2 +-
>  drivers/pwm/pwm-atmel.c                    |  2 +-
>  drivers/pwm/pwm-imx27.c                    |  2 +-
>  drivers/pwm/pwm-rockchip.c                 |  2 +-
>  drivers/pwm/pwm-stm32-lp.c                 |  4 +--
>  drivers/pwm/pwm-sun4i.c                    |  2 +-
>  drivers/pwm/sysfs.c                        | 18 ++++++------
>  drivers/regulator/pwm-regulator.c          |  4 +--
>  drivers/video/backlight/pwm_bl.c           | 10 +++----
>  include/linux/pwm.h                        | 34 ++++++++++++++--------
>  17 files changed, 59 insertions(+), 45 deletions(-)

Honestly, I don't think this is worth the churn. If you think people
will easily get confused by this then a better solution might be to more
explicitly document the pwm_get_state() function to say exactly what it
returns. But there's no need to make life difficult for everyone by
renaming this to something as cumbersome as this.

Thierry

--kAjYvSBiDvNQ2JMa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBsQwwACgkQ3SOs138+
s6ECqA//Zd57LkVbLnSm51dMJdU3OzbgvA2eSnrblJcbIJaVQX93rfojOCA72Loe
UqwrOYm9kh6H6Drl9Z2koBzoW1IW0UteSwPwn/KhORLXqdbDPnLWhQgEiMpykEIy
avZbWjX1fgz6pX0CGwmbns0dJs7knTCFroGMjOnZamRoU9fe5fj6MzhlPtIVluBz
LDUa5s1k74PnNc5REcD53DNOtFBWYUQa/2mv1MGIOKNdFmJBfb+gVJrayUN9iAmn
jVUy50BHt0Hrp6GunWAAEsjogOTtXbV+X2opyG3aXM/EMfCli06XHEsI+rTcHl07
F4cU9K4gQOprj2pQ+5CX3QZ1VPi17rk1/Ny5EoFMRIfPuFWQtiJIoWCG11eEv7Xv
D0at6sonV6l9zuH60/udcqMoq+ktq9v5bgCZJkY2lswkR1u4droUBsEaak7fm3/E
DfRVgSBTCVnPhEBtL06UXQURErSP6GFShSeOflPXKudYj2OPRb/xYSw5iLbJDL2U
L9o7KxbaYeSdNcT0q+ubQuegWdUfc289Om3VbTBPz8H61FpSsgt5YEpYGgpUx84G
ZQkIs5iv3dgUm0ip3GbUtT5FxHXUoqCRhFJBZfaCJMTEaBFlmT413aZthMWmdYJY
RJeTHFTLUaptPV26ZSqYpNRLr070C4wJMNCnleCoYFAJY/gdZ8w=
=zxs0
-----END PGP SIGNATURE-----

--kAjYvSBiDvNQ2JMa--
