Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1356197CB3
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgC3NSx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:18:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37711 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbgC3NSx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:18:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so21644394wrm.4;
        Mon, 30 Mar 2020 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2hvwNsxGGoO0pzi/Em3O5cdPmuRnC0D6RSkiPvs25I=;
        b=XV2xFw16MXBfAvDlm+SvR8+FdBkaovVlErtwaEroTgAuQGkcRWK4fKRDqNTh7Nrw/f
         FarwhZwc4SS5z4hzGzLzlVuPL1poYylWGJAjeEXA+h/Ym0XRTR+xSYgix4fBj+guIuB3
         P3voPWCjsaBjb3zTRfcUq2wwCBvQIqhIx9yYiyzfyp+cqnNgbE8vscpqOR2ogJ731HE8
         D6jD7c3tIejLXkX0mqElZBruWaYwAjPu7MtMuq6cx/SGa+R3NC6w6+/Bbsfb18hvhlIs
         1P0FY0CYuTOMfnX0/pkLOqPCt352T4b1bDI6BlQuLVhEBr2LzaPhYtfKpVq7DNp4zu+m
         y05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2hvwNsxGGoO0pzi/Em3O5cdPmuRnC0D6RSkiPvs25I=;
        b=YfPiNDQ72v5WWxZHtwuKnbyBepyLOdt27rE1UG9wQu4OCOXmjCxfaG1phizxYKzuFv
         EDV3nVZ9sVDP8tfUK4RlnzrUb+Z1ky32G6Kpi+DkCJQX2lC/N9arnMcutdjPa9BShp0S
         i0Lhs2PaRpsl+UDw+VRtW66S8URNEuE8Ve2hekHt0O+2RobXrm+bPYMhv6fx2/GV2gay
         0Sx4M7Cc0XGuD9J/WufDK5gFyusXYqlLAlbGDuqkashAE3RMWast4auAilPvHeKzzHLc
         Q7r+0ldml5r6vaWvz6x5eDDH847+zoJevm1BG1aIJUUcDrgzcwvlfyITz+/ClobAfcQf
         hKmQ==
X-Gm-Message-State: ANhLgQ3xZOlhnhdhvBaqMkogEDJtxwSu3FIVnlTW6/1zkcxgASdwJTJ9
        3pdDm9jTqS76dDyIX/4bPy0=
X-Google-Smtp-Source: ADFU+vvsS34AfATt3QTrDIwC9rfKDsE8vKKkJvC6sLGLRYk0AVlaELjEw7OjUo46eOpZZuMaRCnXIw==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr16235993wrm.153.1585574330594;
        Mon, 30 Mar 2020 06:18:50 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id t12sm24275864wrm.0.2020.03.30.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:18:48 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:18:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 6/6] clocksource: timer-ti-dm: Enable autoreload in
 set_pwm
Message-ID: <20200330131847.GE2431644@ulmo>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200305082715.15861-7-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-7-lokeshvutla@ti.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 01:57:15PM +0530, Lokesh Vutla wrote:
> dm timer ops set_load() api allows to configure the load value and to
> set the auto reload feature. But auto reload feature is independent of
> load value and should be part of configuring pwm. This way pwm can be
> disabled by disabling auto reload feature using set_pwm() so that the
> current pwm cycle will be completed. Else pwm disabling causes the
> cycle to be stopped abruptly.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/clocksource/timer-ti-dm.c          | 16 +++++-----------
>  drivers/pwm/pwm-omap-dmtimer.c             |  8 +++++---
>  include/linux/platform_data/dmtimer-omap.h |  5 ++---
>  3 files changed, 12 insertions(+), 17 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B8bcACgkQ3SOs138+
s6GHXRAAsrVQlvWFy21hBIzF6GkkySuSLfUoa99TThDUvtL3Kiy2x/ZGXSRnA4GD
DpdJWpka1MkXPruK3aLfH9vAXNGX2HhtUjNY2tlQmw3JwrNTB4UnpSIYj7tJ0WWU
CXOL6UPMoT6OSKGXrm2gYe/f0otVAKjJWDsT0CsJRgUeTpA0gZwX6BRTTtxbebRe
urFAuAvQhBbpK8tEvPLRyiiO/utpYUPxBU/NpCgtyG6ZyKPg6WbWAgHGO5jRoGB9
A/0GHJvCX50yz/3b3sVrZN5KCaOoR57tB1yTOaDsFCCnMLtipFZQ9xehGoDies32
EHtb+8D3Lp283gWXkoU/RgfF2CNCArYxtdNprx6J7yQg7yKViYLHMNNNr69BN+aY
yx9Y03lIx6LBHRok+zjB5wPxFA53DJzUhqztNOfZGEEM9PD3GfppgnjX1L+IjyiP
vV34rKNS7VX05xUc9A4IinMlJrpGqWebxaC9ADLNUdGOGMUb/tVY8iii7E3joIq7
EY9VA4GH58Z9ndjNv+ou3ySB+3fNyVpjBiVHcJPrTc4iElj5A07huaTnStwlvs1W
TmeVKqgdjNGFuMUtjP6N74EsTgIGpWp0KWDfHGnHPOeCegWX2h/xFY3VqhMfyi9v
cRr5NoAipz0LwaNtQPiROUMI4N1AjY+hm+4Xp7HRYrk+3EDPezY=
=CayU
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
