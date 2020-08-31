Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59DB25783F
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHaLYY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgHaLWv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Aug 2020 07:22:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C349C09B047;
        Mon, 31 Aug 2020 04:18:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so2463214eja.3;
        Mon, 31 Aug 2020 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2UbH7nyi0AzxoN4/HtEDtyeYbzdgvbboDc5iNNOozuA=;
        b=q2WuEbVxohARvB4Qoi9K1TlmUo3Tgr9p15PC50hyeczvRXO0i5nkPqtcDrhXfLq/hB
         GT/EhUKQXWE1iyuvndV1Cp0YwAETUznP2jnQHFDVLTQQcMknNVnQtYkTiRpaigMaBUH/
         rr9hfbpUgmW1xhaC1oP9L0Drb9fHj77gtwdL+zjK1uGxpplGsbqU4k+ykftDR97vYCoS
         YaSYswZO5dYYfBI7mcWglU/g6YWbRoO+OXdlBtb9e7F33dnqMG4QK1ZswNVT3FFVX/ZV
         C6J+P8WHY7YnaAc2d/JPES+3QSdz4yD28Eg1OyTzFAbZOux3v8ttPPBwDx+0UI1xoZ3p
         CNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UbH7nyi0AzxoN4/HtEDtyeYbzdgvbboDc5iNNOozuA=;
        b=XGsE0yhWRzUYy0lh3VpF/ZFNAJoVJASGe3YAlkRSdoLOIfZB1mMhwfBlsJO9iOQqyp
         9SpoGMW94RIzXE4A4PqSHdaBJ8I7Qh7mYMj2nUbCPNrcruFpoF4vVQbTka91sj/cfmh8
         /DZTacoe80PuEthVemnvdm2OlRaMqtvEk3kwdUjAMGEjxyv8WcmjuFcENqGft6gx6vNq
         LgVnkviqv0k9gOv/0yRix3a0cLiwKB6IjP7DbWnTk8E7ouVPd/yd1fG/5Po2QhdZbf8c
         KtVlmXTZvpLjdfcVCLWlkCEHm/qnq3PM6MH1+Lx9CahvnveR/4Mn/EV2XUEsfNL+U+5O
         vcRw==
X-Gm-Message-State: AOAM530axSMw79HGOHWPK+m4+Js4TQDbK9eKW35kP+ZJSBYb6FdwwWqf
        Qs6AOlLsMN/R3Yu7SC0lq+U=
X-Google-Smtp-Source: ABdhPJybJO3HGYkWU9kdY1Mxc+UjAiVH4EAhTo9VGUWfQXMQrFBgj/2Mff1SFpVi3mp1OVhiDj++cQ==
X-Received: by 2002:a17:906:7856:: with SMTP id p22mr643614ejm.262.1598872689810;
        Mon, 31 Aug 2020 04:18:09 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id nh1sm3984880ejb.21.2020.08.31.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:18:08 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:18:07 +0200
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
Subject: Re: [PATCH v8 13/17] pwm: crc: Implement get_state() method
Message-ID: <20200831111807.GL1688464@ulmo>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-14-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-14-hdegoede@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 02:57:49PM +0200, Hans de Goede wrote:
> Implement the pwm_ops.get_state() method to complete the support for the
> new atomic PWM API.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v6:
> - Rebase on 5.9-rc1
> - Use DIV_ROUND_UP_ULL because pwm_state.period and .duty_cycle are now u=
64
>=20
> Changes in v5:
> - Fix an indentation issue
>=20
> Changes in v4:
> - Use DIV_ROUND_UP when calculating the period and duty_cycle from the
>   controller's register values
>=20
> Changes in v3:
> - Add Andy's Reviewed-by tag
> - Remove extra whitespace to align some code after assignments (requested=
 by
>   Uwe Kleine-K=C3=B6nig)
> ---
>  drivers/pwm/pwm-crc.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M3G8ACgkQ3SOs138+
s6E/+BAAocda+M6anWstR2+VY/j/fIRJqp9Uutp3/NB5Evzr7HJoJNH5vvaX0CRu
XqzhdH7nr5WJwWuAXjWc9HLsWYOlVxD7cjQZp4mb/jDtO4p/JKjmY2x2lPoajMm7
CzjyPXwOg+WBW0xcaJmgfxJE8acB7wRWK9HeJ/yfUNiaya0/gR0iNcZfAfr+9SlZ
aXglvu1KK14kNRYZRgu+hZWooP1aPa330ldfzrh2nfV8lALUdpV0dbu4WhGrSudW
wevvN4Ss9tynApqlWTY0o8HikNnwttIbMGx7XZnkrOyTvFLrSuXHi1YHGMMUIycl
6rdsp0cdK9nrnxAFPZiYISgZAWEQPiDR//xTlSMCxbasYNAG+saK6EWM1chAW1vS
BLQPfD0aOxD9wngV8SV7AedZcUoRy224s5ko/NQWy/EYYgWg73ta24hNkX1GqUp/
2l66DbLyaFhGg3xTiUCk3E7yrFxbjgOrtpUhN6t9i6cPzDhJI8akbf2gS419EUjo
uKJvEUa4YJERUbWp2KQgoZnOyTFpv/7xIblyHsujcFJ/t7hxLLVV14yHs1iBu2k5
ZPmChGQaUO1eXAbCHThintTquvR+IvY+SeXceX1kCIe44JJYjm4nupX1gW33lLrl
nIQCrgA5W5YtASdRZIQ2hwCInbabfpv0TVSjdQKLvHasrC2MPqE=
=YZ0E
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
