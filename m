Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F65257880
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaLbq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaLbp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:31:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E32C061575;
        Mon, 31 Aug 2020 04:01:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h4so6337995ejj.0;
        Mon, 31 Aug 2020 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BXz+peZRoN53mZjBhUHyzGxKbpfakmCobW+ek8D36sw=;
        b=YoYWDyuKxFsbuhe47h0zGeZJWMYREllqdMwLGPMm9dSkbGYZSYz+QGr7iiu0Gs0gtE
         34zbX8YmP4JWa39VzjK4yz+B412STc6DJ4C1gRTh4rKl+tLpoYAirftsWUjG1lV849YF
         wU0kXK+Ppn9VHSPfmCMlRiQb2CzGp88t+YBcFQyMYjxhGIQt8dGcS1TRkf8us0fUSxJQ
         CsU6IHKIsQ985D+pmoOa75LC/PwtCmYgauzlKhPzOtTiZzEQIkQZzcT/qZ1Sx+iosQ1t
         f+BORbiM6ZLW6IpXNRBHR52XD7iLHIikUc5QtmchQIjiDmnDmr2J3mtvjqmwbdFhnXVh
         aLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BXz+peZRoN53mZjBhUHyzGxKbpfakmCobW+ek8D36sw=;
        b=nbnZLlgiAYel3BmH923lI+aENV/14jtqnqXC38seR2QlBZ0Ahr/g74e6QBBpoueeJS
         vAE2LVDkdUZyR5O9w6MD1N2h+2E6SPBiaC5YEUm8MWNFWEYjW92XHjHjgRaDKUN1bqvp
         e7SqUtAzhmmEfioysoBpHsS8s6ep7m/UeRIKae6GEo3mBAoSXFdaAEu5gN9KrlPWLTn1
         eSAn0uWyMhIYnvfSzpiNCF4XQJ6sQ7dkiJcIZpsZ8Ifa+ma155JZsL7jAEQNBqhRcfkP
         Y5rrx5viqDSdKSVswBFy8Z/4ql1Tj5AfEzuQMTFe8+g+7/ogXgpD4Bgzm16Ox3jC9h7L
         FHdA==
X-Gm-Message-State: AOAM5319wTjI0VE4Hlcu7UHJTKpNzEEz5UVd4ylHoS0xC8KVEp00F3NZ
        K3eZy5eaKUmSSNb9amVysgI=
X-Google-Smtp-Source: ABdhPJwc2sXXD2orqxDFSsb4FyIsXdymVcdkXoweoClyH+lABOlQyLYIk29IWwL/SHhX0erhFgbgGA==
X-Received: by 2002:a17:906:2352:: with SMTP id m18mr617431eja.214.1598871698647;
        Mon, 31 Aug 2020 04:01:38 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id w7sm7837549ejy.4.2020.08.31.04.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:01:37 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:01:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 03/17] pwm: lpss: Fix off by one error in base_unit
 math in pwm_lpss_prepare()
Message-ID: <20200831110136.GA1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-4-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:39PM +0200, Hans de Goede wrote:
> According to the data-sheet the way the PWM controller works is that
> each input clock-cycle the base_unit gets added to a N bit counter and
> that counter overflowing determines the PWM output frequency.
>=20
> So assuming e.g. a 16 bit counter this means that if base_unit is set to =
1,
> after 65535 input clock-cycles the counter has been increased from 0 to
> 65535 and it will overflow on the next cycle, so it will overflow after
> every 65536 clock cycles and thus the calculations done in
> pwm_lpss_prepare() should use 65536 and not 65535.
>=20
> This commit fixes this. Note this also aligns the calculations in
> pwm_lpss_prepare() with those in pwm_lpss_get_state().
>=20
> Note this effectively reverts commit 684309e5043e ("pwm: lpss: Avoid
> potential overflow of base_unit"). The next patch in this series really
> fixes the potential overflow of the base_unit value.
>=20
> Fixes: 684309e5043e ("pwm: lpss: Avoid potential overflow of base_unit")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Add Fixes tag
> - Add Reviewed-by: Andy Shevchenko tag
> ---
>  drivers/pwm/pwm-lpss.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M2I0ACgkQ3SOs138+
s6Hw2hAAqAqAOI9uH2Oa1iIBiZ7kl7dMlH4o44762/BfghrA3zUGN6pkdU81XXek
OzXbmvNQRdJQ9lfcnF+gIchRwyvSALGkKtLrumEl/A20WsXW/2u4ACfHybEZoG2X
pqN3Hr4N0dheBVY9s5L41LJy+MMNrb5y0uKdAAfolLdCzOOVBBYwmpmspzyJ4PDp
LAD+UvHNEv/UIAecUGhK4NQKxvIXbuVWK86WbTox29HvCH5iSr2AEfj2sJBpPWeh
hv6h3615nmmLAATD9iFhVO5ek15uNyrZuCNMV0GLmjBZZS4p84DlqEaxIvZD1QCk
2jbpFS6P16v5VFnQD1l3GAe9gvIMK8iqqwKbn3DKZ/v72TBjpBv5HdEvxyT96npb
Po6oET7Wx8erAqh/T4KPiVzLMnsbFJHOZk2bW5G1C7cBopZGrmIean9d+BhGBldr
qt4r8CY6Mvnx8Vqru5087KrMGCmHlgsNspZ/p77Z2v6/kVcCOZCQVME+hpAkX98Y
1qZIX5VFhuYnFgcCuR1ZzOEV0avpKJUbqQD/bBnJmWmqA20y1Hb0BAHg7Ny3+mVZ
fkf4aMuj+iWzMxnmMqgij8+5OrF5NpcX8x9z4tWgYCmmVw8f/fuu4vfCxEJKcYE9
ohTC5zGrJ9E8jm0PknM4q+Ea7XEAKE5Oc+Ut6DOLoeArxPExaSM=
=DtUS
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
