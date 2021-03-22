Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE6343FD9
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCVLbp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCVLbg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:31:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430FC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:31:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so8874409wmd.4
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V4N66vXAmfYrhmbYdLSQwSEiK3IQDimJESwyKsLVSKw=;
        b=Me1cJp3Ruk3b0s9/1DceQdj5wHIFiU84zugmHMtmaX2hQDNgw86YdEH1cz7TmLrH3T
         sBOmR9Oys13YebjO1PB6/Dzd/ZHroxa0B3teqf4JCB8/Hi1G/tbxHR7mgZoQ1hj/IV28
         2IB5sFzgRD+MdIHC90LS2jbgpiq9SFA54rA4hqlCUp7en8pFUKiiLvi+DJXBhmvjOJqn
         cWLQltc8/iZI89ySfU2DONeHadzozSnfIXzGOPbwlQB0gNFq3hLdS3x6W3TkToG/4d9M
         sqYI+DH/EvlQ3OXl6fm2wF1jSAlqHnr455t190JmMqpFSvqK6VBwSxjOW/nKdBGxmKFp
         vJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V4N66vXAmfYrhmbYdLSQwSEiK3IQDimJESwyKsLVSKw=;
        b=Z4V5w80DJu8pxY5CAXpgvL+TRs48R68Sp/3pOx5kKEHhVQUuJaVBXdKGFHQ3QqCQq1
         wqb9eGFNNlH81Ia6XdFcWmSMZHoRZ5Ixv04OJWLKqb3lrPp/DVTp5Wx5o2l0eR8ypLQt
         ImkJqoWBqPccZhhS6A3GZMGwgJFz29Nq2f+hrhWzrLpXbE9OQq2bdijQgp7IcPnZ0Jnd
         pIf/+Ix+8xqANQletXRokO62N5NLnNEM1BcBNkVe3etvDkyFcW25uxZqvhVV09kdkfi+
         mRzjWG2nkwQKmr3lavTHa861Nd2hgwuLABGdz8mqTZ4ulK0dDPPnwi8G1PItAViOPAnQ
         n7HQ==
X-Gm-Message-State: AOAM532jJIf8y92cbG1Nk0W0X72HecO7FBc33LUtysfyNTqDfUroDLzt
        EsYEWcm7uiQu6e7HW8hDlJ1kqvFjsdc=
X-Google-Smtp-Source: ABdhPJx+MjLgpLLl0eYp9CIAzsEDVOQewAGNHtpIVx4KhhHeFQEnizQ+BIrPUcqBHzpwNSFjtVy9MA==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr15326508wma.43.1616412694935;
        Mon, 22 Mar 2021 04:31:34 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h10sm19783589wrp.22.2021.03.22.04.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:31:32 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:31:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: atmel-hlcdc: Use pwmchip_add() instead of
 pwmchip_add_with_polarity()
Message-ID: <YFiAJuJXk4MjWJoB@orome.fritz.box>
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
 <20201207134556.25217-3-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uR4+2ANF67ooPuV"
Content-Disposition: inline
In-Reply-To: <20201207134556.25217-3-uwe@kleine-koenig.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3uR4+2ANF67ooPuV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 02:45:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The only side effect of this change is that pwm->state.polarity is
> initialized to PWM_POLARITY_NORMAL instead of PWM_POLARITY_INVERSED.
> However all other members of pwm->state are uninitialized and consumers
> are expected to provide the right polarity (either by setting it explicit=
ly
> or by using a helper like pwm_init_state() that overwrites .polarity
> anyhow with a value independent of the initial value).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--3uR4+2ANF67ooPuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYgCYACgkQ3SOs138+
s6ElHQ//Q5qHjKwUSvoX9gT43bAdp8kjJlqLyuS86aV+Dur1TfEOVkX/Ffecc+ax
411/QpOO4NKfXr70s52OVaVlcP2oFOtqmCgnPVUEfaq4I19JuyO+mbe/e9ni1xHS
/+jYZN5dVvMXy6Yt0Vra5kqi7d0RPLdk+vKiaucygilaEbfMoLDM/R5q2dSDDzTU
jraKw1D9kDip5imRCBXou+9lgDe2knqLU2VgGchN4dIlrzRcZDcSQMVzKswsiEnp
QgY8Srod9U5mH+0AtGvN9d+edPBixQIIOmtAgzIEw/niVo3VxlkZwYXYuLEHtP7e
rSP4GYDBWtU1BwxGsxNoczmkCT2mYOhtEBNwwPryT3vMQR0PL1YLbJBlXLBxnFQl
MrEvcSIXmTdBSlPJEqTc8rUbmzm2OxSpS2D39UxPk1DFcQ3FovgTap0EYUlbgrAc
vDaDFg8pegq5H/alnP6uw3sVuWZhE9yRb62HHXbL6wXFLYlLE+lsodsOToxMBZ7D
8381gJkQbU1DK9YPMLgvxHTqfkYyeDBJnuRbNc19Pm/HsaQ6grFuJnWlmjMcek7F
QI/vtMzT+MkyOI1FQqAd+T7C2ITId9+vI0YFW+QjUJBXJXvausVF8jCYAVFKK2R7
8c8PvxI4zRGnqtbngQDwjEW41qvhYrmVbp0vizNm7nByxzVvGyo=
=1Omd
-----END PGP SIGNATURE-----

--3uR4+2ANF67ooPuV--
