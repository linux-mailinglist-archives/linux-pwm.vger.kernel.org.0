Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B89355298
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbhDFLoj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 07:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245749AbhDFLoV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Apr 2021 07:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54559613A3;
        Tue,  6 Apr 2021 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617709453;
        bh=2Vm9ityjyZldn07RFATp/5Z6vJvrtF34+UIuw8/w51g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GReFQWQpMbEkyEVsTKHs7ItqEeoFaP16m5Z3rbHGee/xUg8t97DrCK353XkdbGbf9
         lao7igukf7FQKFGApt0frZlorzz/1m9K6PSQnaNs8KWGe74p49eVqMnMWSMWr/eWb6
         h0E6V8WCjhzowkzHQKaBkT6y+Zl0z1OLo0UBhroRVCHDhJe0Nw2db833UnCeJjEsF5
         vFXsftpWcfKnGw/Wg7KJBeV7IdlAJh6JaV2qku9wWyxeJQCnvfMWFJ4nXmMzAkQKYp
         MBgfG9A4tCMG1nh+ayjA722WXw/iGJ434k7CUQ3wegQio0D9yZSJwuwQyNNFxp3+dF
         yc6IGZsD1CfUg==
Date:   Tue, 6 Apr 2021 12:43:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20210406114357.GC6443@sirena.org.uk>
References: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 09:30:36AM +0200, Uwe Kleine-K=F6nig wrote:
> Given that lowlevel drivers usually cannot implement exactly what a
> consumer requests with pwm_apply_state() there is some rounding involved.

Acked-by: Mark Brown <broonie@kernel.org>

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsSXwACgkQJNaLcl1U
h9CeAAgAg9/Q2RgSOxhbh64cI3whEBi2rDoy4JrnVOIaezDbl1KVpYtyba0y715D
Y+27eAxh97zRr3AOb8di8IGVTcKZqEJvwbFWeAxIYTqr7yewyfFV2r3+aj1n6uji
E06xtLVSajGadFJ8cwDdQmB2HGTiOraS8BIQTq8UgV4X6S2LOC6RRZ/BADXxlSXZ
awgIor1dw+uVGentYfCseXYt3xOeoBGm1kcv2bLWZOf7p34NrBErZxEelYeZycnR
FVaAHx4aGe2/1xPGOYGRdXxub+JSiKOXp8tFNWDNnrr/343S2A8pBE8u1GWqB2tu
i/C2E1EQmwot6hIKN5/6hIg/LOb4cA==
=bscb
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
