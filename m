Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B10257829
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHaLVU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgHaLR6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:17:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB37C061A02;
        Mon, 31 Aug 2020 04:16:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id b17so7924342ejq.8;
        Mon, 31 Aug 2020 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZTtymY1waFOvQOwsLNqggU5bT+3mUvNOZsCRMAvPRas=;
        b=fNIzhqpTsOH1zDgcqrkm6eT2FxZM5JptN/pSFYkSuN7E7tL762Y9OWPlfV59vPRMnN
         KJWWbHqEbAvyD960uzowyBKQLXlYIrafYvajZ1RNHsRz5rLjpRI0C/6zIZZPil/UnVGz
         +BHqFkr7QZKX+Ad2/qSOHU2MtWgpLmSx5fVGtCHQky6fpebjhkMQY1UXDVYUTiUB3hKt
         XETdY7aZJlnM3eUVCw7/AgXzr45SBSgorQH4dqzWfkfNvn/2TTnN/JlIJFYZQSJqvCpc
         TtzcTWxiiZa4x1x3gftJRZ5+pALECacgRqnPXi51vT20JwpQgpdWG4TgQQ4BRNDEWTL1
         1fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZTtymY1waFOvQOwsLNqggU5bT+3mUvNOZsCRMAvPRas=;
        b=bGe4V+avMEFNADkmurUhteb6cVNMAz4pCYiPI0UTCmm5GKwswQNypPfixkBaPzKxVq
         FmD3ad7L6X41wBrA4Y3JRKWsa7lxz94vXGLFPLeOaIdhI8hkc22cXPk7Imkyrg3hACLC
         b1GjsqbcrGLd/vNePVg4dDqC8gg14JaMGPWm7sbSHM8olc+mIVy4xKqmP5XPTOYGsfYj
         pXgy9b9j2nEE3v88e6yu0irfmhmWTOFzhW88o2cxtAfprQ1LiiMArzgelAtvYdBJ9kpC
         J6ez9pRddbvt8ZRR/Af6P1KD3XD6nUyHQxZJWmsZhDtPmpaXjdY0cXYN2Xs2/nsqrYpL
         meOg==
X-Gm-Message-State: AOAM530greRk3W+Lwba8XLnqZhSydUHdstTEaVv+LeCeG/34J/w0OPn4
        h/YhxqARGucWX7s6kvow5vs=
X-Google-Smtp-Source: ABdhPJzotGlbD5NfItBcSRE3Z5cStQ3EuAjruXFrODvQJL9yNrHxXDF3A5ZTYht4Ids6e3qv76Arqg==
X-Received: by 2002:a17:906:f957:: with SMTP id ld23mr621987ejb.187.1598872589352;
        Mon, 31 Aug 2020 04:16:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a26sm7956389eje.78.2020.08.31.04.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:16:28 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:16:27 +0200
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
Subject: Re: [PATCH v8 11/17] pwm: crc: Enable/disable PWM output on
 enable/disable
Message-ID: <20200831111627.GJ1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-12-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:47PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
>=20
> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
> this commit makes crc_pwm_disable() clear it on disable and makes
> crc_pwm_enable() set it again on re-enable.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Remove paragraph about tri-stating the output from the commit message,
>   we don't have a datasheet so this was just an unfounded guess
> ---
>  drivers/pwm/pwm-crc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M3AoACgkQ3SOs138+
s6EUhxAAqOyFk4YOHZ0q1M0s3MiWg2o5JRPl597Q/FuVMDlLNPSHqYQGo8XNsauY
eTT7GKVu6y1mXSkc75KJi4FpBqnCepoCqtBEWqABNvjNGYsS/88m70kVmf73ZQBp
/4W1yIxIpIli3s8YRyZweaFXrEA54qhokh2m7LNcxuqro6FaFjszUJ6CTqwdXf8m
v6v3onrRov+vdt1vgBumJORDpfd/H02hUWcSL3V0aD6y2BeRAtrEj72QFqLbr2jo
2pJpEa+gdFdLfgcOLnmzXciBDAtjB+foU7LcQTwMUfvPWnuUi2ltgNPWt000X21x
hyCkjSWIxGQ9YdGryKgHETe3DVsJL0WCi04uI49H6sevupB1NEzp7/vj5gCfI38s
c8aIH0B03Rn3K+pW4YfuQFGYDVjZV3Pt9Xtv/XMC+tWdv37hQyd055hBpi/bpPuD
49usRQxckKeJ/pBplg3RT5EP8tQrjP0cOXFgnr25s2HaRlIUFHvtlVaZRtOs9n6J
44e3XPWbRvDbXco341AkiffDUDvi7EYPRM5kxaX9TuSWB3idlGPKZPHohD+ENb/Q
RW8o4qHRS4cfRyXchuq6WWoyXGrj9588+Dl3ueqAgE7YCq9j/aRVu+18q0H+VRVB
JKavgjXYLZQBlFWDg3Fa+MXibEYCVnAaI5I5K7KPxZ3PP0NxyIQ=
=fUlj
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
