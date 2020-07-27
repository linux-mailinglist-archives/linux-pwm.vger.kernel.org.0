Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A422E7AC
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgG0I0F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 04:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0I0E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 04:26:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D0C061794;
        Mon, 27 Jul 2020 01:26:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so16132479eje.7;
        Mon, 27 Jul 2020 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=75BR4ui/0ei5yQ/BbLZ8dQhsQMEbT91i8MLm5t9Nf2U=;
        b=owGCpEAi5GbEfwDmuPJDUCrKJt7+ltvauXcfi7ZysKlykaN4Xutj/4k+7Nb8jeiQKa
         DKbhzfUuMxkk04v6PsYm4qSvEfr9ebImrHCpgOZQqiiAn9iIin70irnOUqhCa+EC99ir
         oo/xuyKZAEplwDDxTpERFQNxxnPmZYpvoyWE2Rz7ehSCe95aOWyGbfQPguKFbJnfEAet
         wZ5SyOEAKaBtf77LTYT9TFv76nmHRYVHOEDtCIriNjxAFLGs/3jusClExbD4IFcR4AMk
         FQs8UtPLxlJqf5vNFOI6GkJEqVAdOafzle4dMFkpR5t5tsd+1xG45KubaX5wods9PuUr
         7RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=75BR4ui/0ei5yQ/BbLZ8dQhsQMEbT91i8MLm5t9Nf2U=;
        b=b7HceWrh/PzFt+GAUAP/Z+BGWGkz8lwmrM+eFQmMGrv9+B78rA/CfpSxtQE8uaxeHc
         JkRWbPMTQFlyhUshZcyA3QPWGZN5ZDhtt1PND/7esvPwh8Be+1wqRnruEFt4eIjzQ5FM
         CEVn3L3TFwtwjqcXr/kBloHfh4scnW/uGkYjaXxfS2gdt/Vj0EPZL5zHOpYszrBTJnE1
         nbJo59eEi6QjqGdmeP4+6SM7YFNQwSpSs8K6TpmAWnA0lGd63JODdLkTT8JCHz5+VDlI
         DxSz8/DvoVaFJIsTfAf+tdaIL1LRhIZqnT17zQ4XADHZv8jiVEosD0DDRX2g0PJKZ93G
         m4YQ==
X-Gm-Message-State: AOAM5314P4jvSmROaiIpHIfrOF4+XZJSKl483YKQAmI54OGRspmOI2U8
        nUhzIpef68+OOweJxdx3NCI=
X-Google-Smtp-Source: ABdhPJzHxkdqn1qV/aCcO7xef5C6AfHKHQxhWk723h9S/iT9wh+cnmJ/koYvl7W9cTYh7pq7YFSMxQ==
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr19622134eji.471.1595838362121;
        Mon, 27 Jul 2020 01:26:02 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t3sm4551175edq.26.2020.07.27.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:26:00 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:25:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: PWM SUBSYSTEM
Message-ID: <20200727082559.GD2781612@ulmo>
References: <20200708175924.15554-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <20200708175924.15554-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 07:59:24PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>=20
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=3DAlexander A. Klimov <grandmaster=
@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
>=20
>  If there are any URLs to be removed completely or at least not HTTPSifie=
d:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>=20
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>=20
>  If you apply the patch, please let me know.
>=20
>=20
>  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
>  drivers/pwm/pwm-tiecap.c       | 2 +-
>  drivers/pwm/pwm-tiehrpwm.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8ej5UACgkQ3SOs138+
s6G28w//T+L8UNnep9xk+vlaQrJ5wQWoIjI1dia7qsVHT8fa9H3tZ2Msk3Erxh1c
27EaNDgue1RqbIbmKy0eiz5D6ualoU83S4VLuuh8gxgMDgVZpnHlyI8IECz/w3LO
2Md2K427Gwx3+vwYmL7bK38gREJKGyfW6dA1k6MkeDZtSOn9yeOW9SEHXp1G7TRn
TlYgVV9NCUkieKGiqHVABFFsnXuM4JVabzUmjxLEM2CibGcpH/Tq8Dpol+i/1YKv
5jpPrGtivvuknF0AVeR9SfXB8nhwc0bcIras6YfQdZNI3UDBJMiOD/+TFrox2g8T
ybG0QL4e1gAUyM3vUNd7qCTk0xCJWKwD0NL0cdu19GCuzVUwY6CQNIyLVFITPAu8
z1j1V5XU2mCj0GHCMfH8yv0AmKTTLyzOx/Z1OX6xxhPhW/Crpu9MA421f5s+63yK
wMy7cccAQ9ho8vYRvZBH91nllSbXqmyPopJm+LQxKgImy2f6vpT6JjL21ESwFXK/
zy0Ost+bMhO+29QlRxALUGbC6Ydo90C6G5b0UdWclLqCZqDLQ5wYcNNbyVO/X9F7
ZJcoAqCSlQXQ/ygaiXsKRXSOvj8Q0Uvk+vG66Z5/lk5UHjs0vU0xmt2DcXXi+0r3
9t1PMWO4DdIDy8MgnermuAEwVXIKnn0yscyEW7NCWZzROzAhE0g=
=kX40
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
