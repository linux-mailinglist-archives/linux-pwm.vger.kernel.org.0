Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E452EDF7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 May 2022 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbiETOTf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 May 2022 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiETOTe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 May 2022 10:19:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F71611C7;
        Fri, 20 May 2022 07:19:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m20so575180wrb.13;
        Fri, 20 May 2022 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Heq5HViSRVLPbnvHc7QenObIQfHo9RAeEcWGUwWIy8w=;
        b=NhVQH7CvywDmnRBBHKaYX8+KdKPCio2sjNgcctQqECdNWivg3hqobbJSFq7BDXmPWG
         7AFKIxZw9vSjJYEWzmHMigQNJDFURBZYX/nJbDzRlqWrUMu6pBW4/8d4f31RUwmHrtWF
         FDo5EEo2ElTNy0JvWOyhv9HfwA3WDlGgWmXQvjenzpD6ZTs9QcazPQE7RgG7uYapbXEX
         2JTV0qgaXVpRmXjgxRCBLRf2p8Th7QJWrfIOHyRm0SHlrtxT92QJHqqrmLs80hF5VeCQ
         vuT6O9m6GEHkKOpLPV8wO2XG7CQS64JVxr+zA8n1htCy5DJ7KYbJFRpj922M+ArrFhiV
         NfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Heq5HViSRVLPbnvHc7QenObIQfHo9RAeEcWGUwWIy8w=;
        b=S/UTJzFXlTxohrofjTgmPWqMm7A9Lgz2dUmeg9p/RZO+GZPlNf59NUAq6IBYXUd5WR
         eAp8MWJ/jbj7P8L78LRbVHapHlbqbWQxofif0bhHVIq7ZGN2XRS9cA5647fvh/N6tc77
         Ow9ykzHoHxf5EtjACY3IqSUP2Z0hR3i5WCxPrfaZiyJfPDjCvJLnztdd1fVCnEfaZIpO
         dMThCIlQJAWHBs1bzz6Ya2PNCQOhYZPBZ9IWtnEqT6H9Gsl2U///KZh+I9zTvQznQhie
         HSHds3y/wyjtbB524w20fWd2obJ6ToiGNphERP22TWYTR4/EHh66bvyD1UWbOYpVOOBd
         Y+MA==
X-Gm-Message-State: AOAM5325XJKO/PoRmG6fWICEA97/46WjGfm+pqq7QBGwDyklrIxAzNA5
        uAvDGQTZfFuSRLxOMd6K1LshkM+iync=
X-Google-Smtp-Source: ABdhPJwgH+0zhWNOFCNb2p2utbBDSEa/0gFooHXZvgMK0Kb3ffDW9y2gKMWwdrz0rAYi73nL9oOfOQ==
X-Received: by 2002:a5d:65d2:0:b0:20d:7e7:8298 with SMTP id e18-20020a5d65d2000000b0020d07e78298mr8616294wrw.668.1653056371762;
        Fri, 20 May 2022 07:19:31 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i66-20020a1c3b45000000b003942a244f51sm2062072wma.42.2022.05.20.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 07:19:30 -0700 (PDT)
Date:   Fri, 20 May 2022 16:19:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 0/6] pwm: renesas-tpu: Various improvements
Message-ID: <YoejcKmXGbKUJkJd@orome>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aNkGJh8FDKU9vD2t"
Content-Disposition: inline
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aNkGJh8FDKU9vD2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 02:12:34PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> I reworked the series to improve the renesas-tpu PWM driver after
> feedback I got from Geert. The changes are:
>=20
>  - Add Geert's tags for the first two patches
>    (I didn't add them for the other patches as I changed these enough to
>    not carry the tags forward.)
>  - Use tpu_pwm_disable instead chip->ops->disable (which is NULL now)
>    fixing a crash in v1.
>  - The calculation now uses a switch instead of ilog2.
>    Looking at the compiled code for ARM this is more effective and I
>    assume the same holds true for other platforms.
>=20
> Thanks again to Geert for his valuable feedback and testing.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (6):
>   pwm: renesas-tpu: Make use of dev_err_probe()
>   pwm: renesas-tpu: Make use of devm functions
>   pwm: renesas-tpu: Implement .apply() callback
>   pwm: renesas-tpu: Rename variables to match the usual naming
>   pwm: renesas-tpu: Improve maths to compute register settings
>   pwm: renesas-tpu: Improve precision of period and duty_cycle
>     calculation
>=20
>  drivers/pwm/pwm-renesas-tpu.c | 317 +++++++++++++++++++---------------
>  1 file changed, 180 insertions(+), 137 deletions(-)

Applied, with the checkpatch warning in patch 5/6 addressed (I opted to
replace the tabs by spaces).

Thanks,
Thierry

--aNkGJh8FDKU9vD2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKHo24ACgkQ3SOs138+
s6HZxhAAmKfzEjyKQuZFLNdoHHM1cWnzo8vHG5vEMoVIZCy4rMt4RCqQhHQuEzK/
l2X310ZmiuYpUNw7lSaLhIU2tbKxZ+L24M8D/zbh2X7NJdt9F+WHZUcdH+YqWBG/
iZeh9mYzghaV/TOEnp2cvv7mouw2IhJpflmRp6oOYZjUHu4e+gtEyYXOByXjIWPg
9kydrMbTKXJbXy+qRh9GknGRAmeV+K/kJfbtU3t7VZeiOQ19yqgi80cR8WmzHXYI
sIQzVavNW4W5JIssiUFN64808lNXWvZyIIeaMmDXWCFw7azbvbeDySk06NPZLjmF
edrY5qVf+lVgTNo+bG5UudmG1R8tda/XfHsjNcyJLCabp0ql6uA6fcssWx2KQvMs
lI/kMwqcPTDOcGvD+y/649hHKKMgTSepwaskW2GNhPUz3jrMDKFNGEfpa0d2DW2U
SucwG1NlDF1RsHczHCj6+sURfenuAzbqUXAxXcsSf5VdWHtd7Ln4MjvqViZKvqpX
a390BkQ35zFWwnGQC9lHJY0KuU6vsS1m3AOES6Q8CA49D6V1VNI+Nku5oJ03sHAb
LN8zDJiQt0yo3LdpVpmLZKKAlUSj/uSzjyvuGVt3ME+NJoeEjHRzGI0HZEdxWV2j
TZrW2audqdxHgM5z93CFoiabR7+axBkqeErGfIbY09zujtNCvos=
=o86l
-----END PGP SIGNATURE-----

--aNkGJh8FDKU9vD2t--
