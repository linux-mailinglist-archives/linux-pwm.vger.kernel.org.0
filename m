Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F3454AB5
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 17:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhKQQPY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 11:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbhKQQPW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 11:15:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20F8C061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:12:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d27so5709506wrb.6
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UshUxrcH8TT2TkDIiABSIKerhFaxwdLFBUF1DPuMI1w=;
        b=C5kOHwbQP8c2wSgIbRv7KI+VlHWzBJSnjnA8ZqPyoMkvijR8430yGFoS6/AKX30j4S
         /GJ9lOd+T1Bokr/U0LqKK0ZufC0l+sATTllT9XnKTNSeuvKGtCab8eFV+GOFktgJJzL/
         +BpLddV4tnM4Jtr7x+Q777hqXO4S4x+yioc3YuYJnr/c7orSV6XVLAAug0zhPMFhVq3y
         Gf/bJzqVIJM+twuZMZl9P4yy784kgXGyXtOfX28K1ETTmDaN8qkE2OVpsX3gdr7px7ZG
         H8CokVRx46CQEsWmqTm98J0INmq6SSIUFNCjnpR/RN8S4tubaK0MraYkyf19DhmtNfRd
         T2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UshUxrcH8TT2TkDIiABSIKerhFaxwdLFBUF1DPuMI1w=;
        b=0zBRD39Xv7A547+rZ2DIc5//RLHGwGdLW/8d0e6rj5ey0LuoQ8h/LZ4gHYnH77V/1a
         vOnJd3MjJebzPIELKJIZ7Njs6Bz8MRm1QpIgOJ3sPD3Tuhr3DGkeEWgczWHbGpT4ely9
         /9jwkOqlbwFwQAtqSZC9o77tfX0vYVfCaP2cEw+onsJalyYS+6p6mHPeM9A3ihkbVSiB
         WoZv/bRBg2OAnEKtu6DZUw+xk6lm87/RPFbkuZ+mVu70spOKCK+zQYcflZhSlQ7LFqJI
         Fb8a/zuw+VMpv2mldo2uGnmPkJAOfBaA1i3VSFHCDK8YO42Ch6ECgJawtcGW1paNwm7m
         Dj1Q==
X-Gm-Message-State: AOAM530MFW8igeINAZhWWbCwKoNF7LJn2kSsGLtGAaNrJcEdaMP4Xe83
        L4vvqrezcaJsDYFaNFP6Dm8=
X-Google-Smtp-Source: ABdhPJwd3/BhVS8wEN937874iSSffD7puuWekF1VMsr/t46+3KrtunCafGUu+BVLz2vem0HCU4/91Q==
X-Received: by 2002:adf:f60c:: with SMTP id t12mr21744567wrp.341.1637165541487;
        Wed, 17 Nov 2021 08:12:21 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id m34sm6872502wms.25.2021.11.17.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:12:20 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:12:17 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
Message-ID: <YZUp4ZdTpXrpCKjg@orome.fritz.box>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="06V78GaJMtEOBeMJ"
Content-Disposition: inline
In-Reply-To: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--06V78GaJMtEOBeMJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 09:29:24AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this is the successor of my earlier patch "pwm: Ensure for legacy
> drivers that pwm->state stays consistent" that was applied shortly to
> next until Geert found a problem with it.
>=20
> I split the patch in three parts now: First the legacy handling is just
> moved to a separate function without any semantic change. Then a glitch
> is fixed, but without the regression I introduced initially. In the
> third and last patch the longstanding FIXME about breaking pwm->state if
> a callback fails is addressed.
>=20
> Uwe Kleine-K=C3=B6nig (3):
>   pwm: Move legacy driver handling into a dedicated function
>   pwm: Prevent a glitch for legacy drivers
>   pwm: Restore initial state if a legacy callback fails
>=20
>  drivers/pwm/core.c | 139 ++++++++++++++++++++++++++-------------------
>  1 file changed, 79 insertions(+), 60 deletions(-)

I've applied this to for-next, let's see if this blows up or not.

Thierry

--06V78GaJMtEOBeMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGVKeEACgkQ3SOs138+
s6FOgA/+JX3nx9RyOQ5q09P9u7/otUc+X9B76n0Uh5yynHHlxM3Up40MOrGKdD1g
HiP5S0ia1uj51EHgL1OQFBig6FDjaMxCcFi4eeAstdbKt25yfUueFhcdRQybBlAY
6ES19ZYG8HQjGYpRUGa8usy5VRL4vZa46cSGtZ4gY3MfsaK1gOxSfPrTzZ6ILIo4
IF8uLy4GbCmszBQLYEBNKI5TgrxSceGeMQ/37S/rP5scr/mwLn69EA/3P05NeKCS
4EcOs8BYaPpLckpDLEsq6EKiEI/FWQ/t79tMJCp5px8s2qqNkPCa2DikC80eHa9/
gWxyEklxnQlt2ZJroE/6i0CqxqTxJ05RJ1M1f/Sep4fMjXaONxKVjjt0jATNnQc0
KgoUYexhWctlBAvHeQGTG7dWl7svx9p8HBZbbhaWCjSbRPnwxnAJ4gDIfCSpOZvw
70TZ6zbfTKrhQtYGxlrHce8itZu/uL8PKl+gJSfBYD+wv6wp2LMzvv2aGsPN+cm6
ij4jl7SpIZkK+ioeYonuz5HZ7A5qG1ElYVyVCEpGU46beju4LwSj4j0bWfwp5ynA
/Q7ccyM3yFEkGUQ1qPVK1bLd/KSRvnjMqPMhcJUK6JYEOFVwkyWlp/ak2vjs3vng
o07va+e+4PlT9WNWjG3xwHaItAAIuU2leC0jYgoI1nOjEMhCPYM=
=l+gW
-----END PGP SIGNATURE-----

--06V78GaJMtEOBeMJ--
