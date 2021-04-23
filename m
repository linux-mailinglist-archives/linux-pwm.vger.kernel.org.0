Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4703697F1
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbhDWRG2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWRG1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 13:06:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46872C061574;
        Fri, 23 Apr 2021 10:05:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e7so58118397edu.10;
        Fri, 23 Apr 2021 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQyizf+7h3833Tu6UXCm8h39mHaVLtzkSeXq40Y8eG0=;
        b=LFduqtoAmtYGRKmJME8wHpF+n+PM2wv34lPG2KVuQGjSwOA/OBEbsUzpurSfPjtLdF
         aHZAqiDJPvPi8FxZzxfmrXIthkjnXUw3UUwvj/GMUKUPXzTGI6j6261m6cUhe/caaojR
         RUutHq5dwX1HS+0bbWh89ywotEF+l8n2N7DSmI4rKQHgH8QnQ09U6OaaIiCrxoByd3L3
         DoemlySZx+OnDaJzUHbHMZQnvk8oYRFiIO0dueKBircb1uHMBH+u8HEdemdZroCU1Ze+
         oucifu68OGV9IXfVBzIBkgDAO18VYrSuRg73hqwgHJ/8NS7zim6ri8OLa+H2do8lu0ZY
         4H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQyizf+7h3833Tu6UXCm8h39mHaVLtzkSeXq40Y8eG0=;
        b=tTWVjt+52XIKowMkkdqO2QnFHYUHSKmWqg0KxoeMS5pJrYBCnW8NzdJ8l/68mZATUA
         eqxgPrO51rcITdLBPZ70fm4d1ia+1isjvqvg/QDTnvYV5OfD0R1MN6kNqB5JnIiLJy+u
         I4ImGFrEJqNSKBrCxYnQVvdNUOxmeAZzkp3vqaltOcoDfXWTNjHCNJrvNnNj65iDRpCs
         7vXX31cCCz7S+BEt/Recj63q8XIXv7GNF+CW0vKnwaZJyt9lf4rWp9vVQFVb2X1+jzT4
         pIXI42PDfrKrWeu0KrxNsP7cDT3TzzBcMBYNdjhcvtn6C2D5bOZ7F54aQkcN2lienSLW
         6Ggw==
X-Gm-Message-State: AOAM530EeKO+eqbpnaWNLsZ+nLGSa6JXhxewzVXqIgU2VC0L2BvEJbY7
        Die/PhOC34H+rVFrZTKouwc=
X-Google-Smtp-Source: ABdhPJwlJkXYJRMaTQtZKNRfobN4KHHQWXOII38GvKtGqCm1CWwKJV0J+xdD63f/tMEl5tRJNbgRRw==
X-Received: by 2002:aa7:d693:: with SMTP id d19mr5785888edr.8.1619197549092;
        Fri, 23 Apr 2021 10:05:49 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id w13sm5477585edx.80.2021.04.23.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:05:47 -0700 (PDT)
Date:   Fri, 23 Apr 2021 19:06:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] pwm: reword docs about pwm_apply_state()
Message-ID: <YIL+nQGNmNvZZ4Wa@orome.fritz.box>
References: <20210423074411.2167332-1-u.kleine-koenig@pengutronix.de>
 <20210423163225.2438763-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZaURXP/REy8v30Lq"
Content-Disposition: inline
In-Reply-To: <20210423163225.2438763-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ZaURXP/REy8v30Lq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 06:32:26PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The main issue is that the current documentation talks about the
> non-existent function pwm_get_last_applied_state. (This was right in the
> context of
> https://lore.kernel.org/linux-pwm/20210406073036.26857-1-u.kleine-koenig@=
pengutronix.de/
> but was then missed to adapt when this patch was reduced to a
> documentation update.)
>=20
> While at is also clarify "last applied PWM state" to "PWM state that was
> passed to the last invocation of pwm_apply_state()" to better
> distinguish to the last actually implemented state and reword to drop a
> word repetition.
>=20
> Fixes: 539ed98e2bd3 ("pwm: Clarify documentation about pwm_get_state()")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> the only change compared to v1 is that I didn't use --word-diff to
> create the patch. I just found out that git am cannot apply patches
> created with --word-diff.
>=20
> Best regards
> Uwe
>=20
>  Documentation/driver-api/pwm.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--ZaURXP/REy8v30Lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC/p0ACgkQ3SOs138+
s6EKiw//WUlw9oSjjOjq0rwT1RkI/6JVX0NVzD6JnI+x1LT44jrLmuxqj16xgzj/
4Fntlu+TH/fcXyK2Qw1CCdrsGtYXuBi1YnZPb/u+Od4zIR25+4tUqTRMu7ogjG9F
e5XzJybkMKbOJQP8vNe9buCjOvPGP1zVAsgtmat6uIoNMe7cFkP/0ptps5pqkcx9
UteVm5YM1KtKrD+TYnY0lZ4pyCYJtFefrA4OvXtaqsenNLvw9zSVAmSuX8igZ733
gyQnd/8Z83c2A3e2nWiw33k6Hib65cZDr0qWFspYRqcC3PS8xG3DecN6lepda6gw
4tWvJez9xdeVnSHJ3IYGfbytVKwe5ZBws+9Q+B8ywWUOYxk9xPAKlt5X0njYaQpT
ioLg9+WfQ73euSMJjSHwQbFG8hbQPUiDU15K2xrQSOx8ZhDTV9oN5XdQ6Lt+USZH
0CD4+kF89dLrDYC0qAFIVIosJChHNtJ2Fb32Y8VVVaB7YJINeqF8+5qMoacShAST
BAIkLaIbR/cTG8/1ceAzDJSYGqoCxVSitN7rrDMNxe7aBdorsVoIVcyWY+l9KBvk
Ny9yj/wQpzNIuhsh26PiCjw/tIUcD25KA/okaweNd3xkj1+HHIFcvk53ATqX34b4
JUmplAV33cqQQRrJLBGFFALAFAaBbE6xXTun7+squG6MpxxFmf8=
=gUX5
-----END PGP SIGNATURE-----

--ZaURXP/REy8v30Lq--
