Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA75225786E
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaL3D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHaL2J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:28:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C0EC0619D1;
        Mon, 31 Aug 2020 04:15:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q21so5069171edv.1;
        Mon, 31 Aug 2020 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2rrQHLBYa1+tiZ8Q7iWizy3NNCeteIY8vsFlUNQofBI=;
        b=kxNuPgHUfvNcf9tL5W+rXd6xrtB7YipguU0tt0fPSQljMG3UMCHXCRzutv3qAia288
         sFwT1hEFtqvAdVQe8OuhzDKhz9GOGPOrrQobgDjU2Mzabc2k6Mczhjd4mu3+hnKbYHBf
         ac/XbAfMZtjKZtL2/uXOSYjMOqHyMCwZiIx7tf4+IYejjaGP1dFwHWdjOlkq5mooXEgH
         Uy7zT2rPm3VrDZrSuyNGy0kW0JZQO9ix+bOsDJIqCZHHgoYf0ak2gkhH5mzvo7b5QGVi
         yC8jTv2EEqJsmNPSb6iso1Q6WK9e5TdgFCdIul1N+NQVlGxcZHrNrY4Av4rMl8GN0+No
         SY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2rrQHLBYa1+tiZ8Q7iWizy3NNCeteIY8vsFlUNQofBI=;
        b=BdC00WIqb37bukIngpgV6eCFt7x1Y2CkC6LsBk+pii4HQIU1KYIKLtEC8l12fAoAvM
         fl8++CqbcZVPqrmLcnnuCF9MSJVwT5N30VmBYi9rdfYD3BgVR9xoEiSY3eqTYs41nHIg
         MSQgcscgX78VmpElSogtnP1ugLHlEK7j6yi6mqzmCujdABBFD9GV0FWC8c6REJMuDHqQ
         gZPuCaUGPkmRs8cBeZJp55zMy/WKYr3o0zKL+W69VSJerAAY7C1Xs9OuXYJv/YoLFC0Z
         7wL/RFnA9h+Dm+G6rrPhi1IUcYGx4iZckfeCGYwGV37PZQoELsRVCKMOGFOu4nbBuYio
         oxPA==
X-Gm-Message-State: AOAM5322KJ2e+sccM2+AI767PS1TUxx+Iv9t0GZLPMoKCDev64+zB84u
        k1sCVAdV3lvEeYjAfxLFgE8=
X-Google-Smtp-Source: ABdhPJwsk4qn+3BRHDfqdQOc30c9nW4c0A3sudJ9mpSXWOHXX9O6dVsnd0LHjhATK3j7rKrC7tvg8Q==
X-Received: by 2002:a05:6402:6d6:: with SMTP id n22mr717531edy.79.1598872504008;
        Mon, 31 Aug 2020 04:15:04 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g19sm7824486ejj.124.2020.08.31.04.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:15:02 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:15:01 +0200
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
Subject: Re: [PATCH v8 09/17] pwm: crc: Fix off-by-one error in the
 clock-divider calculations
Message-ID: <20200831111501.GH1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-10-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:45PM +0200, Hans de Goede wrote:
> The CRC PWM controller has a clock-divider which divides the clock with
> a value between 1-128. But as can seen from the PWM_DIV_CLK_xxx
> defines, this range maps to a register value of 0-127.
>=20
> So after calculating the clock-divider we must subtract 1 to get the
> register value, unless the requested frequency was so high that the
> calculation has already resulted in a (rounded) divider value of 0.
>=20
> Note that before this fix, setting a period of PWM_MAX_PERIOD_NS which
> corresponds to the max. divider value of 128 could have resulted in a
> bug where the code would use 128 as divider-register value which would
> have resulted in an actual divider value of 0 (and the enable bit being
> set). A rounding error stopped this bug from actually happen. This
> same rounding error means that after the subtraction of 1 it is impossible
> to set the divider to 128. Also bump PWM_MAX_PERIOD_NS by 1 ns to allow
> setting a divider of 128 (register-value 127).
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Introduce crc_pwm_calc_clk_div() here instead of later in the patch-set
>   to reduce the amount of churn in the patch-set a bit
> ---
>  drivers/pwm/pwm-crc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M27UACgkQ3SOs138+
s6Gs7BAAkDVsNGuKpdYxyV/XBnq4T6ySPHcL3M15sN9QMC7UTr1DhcOGFHWlfC9E
cJK7ctPCe74/xareIjriY3xTCumhIOj1dAYvFxJGiw4W6qzNG6bXUNrrn/QpGOTy
tIUbrhj//YOgqwpzYvwwKbUjHtRRakOgAl6ayfXu1XggtVB2Tq/bf7wioyjNQGjy
bFrN97KYyePQZ9dv9ig6/8Z4dsLaMNc1pcYSnOsixUewDxscC9rQYmtovoqyZTS2
AWSNnCzp0YZqVhVFssYArwzMiimxESmAfTqsc9L9D3vVj6EYiJoc9CYsX46nkmbr
xeggxecSNtrGMSS8uce2krUt9KkqTTl8Li2tVtJZQ6N+jsEKEREnUISVJ7jvWCVJ
ygTtZahw6Qx/aafFFaXjPoivcWc40QJS3obin8hUV452ktoX7p9DjWtHDbeiW8s/
wggeEy5ySja9kp1zzwz7Ijg3aW97wFvcAGHpGEpTCPXF4acWq6WbVLjWC3h+QQ9w
II7rAObTNua3i+UDJ5JVS/bbxR9AwGMtYn3JwqLlXIUP7QvN8v8U8uCatj2Hg2Bd
+C/jjZJeNM7TA8BayiZ9qUaXRjjD1V0cHM5h4GOSAQsBMA2emE8wY43PGwZCx3CW
DgFi43ZSBldkZLZZQzm3CRXxWFWWdLv/k6rGHTy+B4Md1cqqIVw=
=MFCA
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
