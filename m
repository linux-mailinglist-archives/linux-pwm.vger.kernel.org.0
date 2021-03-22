Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E37343F22
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCVLIR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCVLIK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:08:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D969C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:08:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j18so16216489wra.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rRiKix/TwUnpb1USYjs2yHTWY2kpH7fP8bGbo5L4dOQ=;
        b=WocRWLXJzAWbg+rBa6Pj/HPel5RAIwHGExH1ZsIXuw0T+6EqlBSSLl2hkQG2qYXamx
         b+VURWVofEuo/XGAXDYTWJ5ovjh83Wo/vlzJWbUguoIIj3jJnFA6CqAbbu5Amk27mY1C
         VCoq759EhwZe2G4wt5kRYxVd5aEzy5HkNuVOeRIthb794ijBiYtsBWvX41mGpH2ZnaF0
         lbfESBB3HyUkkTCE1w/D7ALrR9bfjjiwGEYh1aSIWln9VIZOTiPG0rRsQ+NIedMz1xHR
         WynDHKggORj7L3X9tob83lKxmZnrBo08ylZcODYXxG70RNwd3znHdgFT+JNgkl4s5bu5
         g+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rRiKix/TwUnpb1USYjs2yHTWY2kpH7fP8bGbo5L4dOQ=;
        b=fnV/1Mwq7ZVXJhOlEyRUJdOvWt06jzjB7wx+AjArALjgS7nt0vBCQ56zf5uxvquYSH
         eUDJUSmqyDBBq+N8HfQTk+btmlDMnwPHFNvPtuVU8S9Nt925B4pr7MLzvUb/c7nW150C
         dxmMuUfvwmslaM9gUuvB/2yNPw/KWjlNkwS31AJwjrLDuXb4KctR3TUGupLasBVwtlpB
         50FgovQXC9oZOcRJYmOTUzbhAGBNii4sfAL9uCY+mnB1BoncMbpe9TFwttcvS1ywuEM+
         Bh57/ckQrYv1ImOS4mIhRnx5FNiO/aN/5U7Da8Xohn0aMqXPOQZsWUxvN2Z7TZhIUyty
         BXUQ==
X-Gm-Message-State: AOAM531eQtgziFGD3w2PbGrI+hVucLvNRUb4ybda2uNm6IN3m5v6ZJBt
        IoPQKOMO4qBvFV9yDvgpA98=
X-Google-Smtp-Source: ABdhPJw0lBwkIkkIl14+58XoCBVasjSlctRlyhua7p06Z7HcEp3gOik8EZU6uxix1T6GS9TA44Ylqg==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr17496184wrx.96.1616411287841;
        Mon, 22 Mar 2021 04:08:07 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a13sm20104735wrp.31.2021.03.22.04.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:08:06 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:08:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: cros-ec: Refuse requests with unsupported polarity
Message-ID: <YFh6qLeIfcCZSUAX@orome.fritz.box>
References: <20210312090058.386850-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="naFyJ2kOClt1eQ2j"
Content-Disposition: inline
In-Reply-To: <20210312090058.386850-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--naFyJ2kOClt1eQ2j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 10:00:58AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver only supports normal polarity and so should refuse requests
> for inversed polarity.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-cros-ec.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

Thierry

--naFyJ2kOClt1eQ2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYeqgACgkQ3SOs138+
s6GTZA/8D3vdtWmntX+R9E6Ozxwin+Xkd1lNqABcYOxCsZOHPGTZ6eKuWojMTYUo
XaQDRc0eFSkFPrpjIWOuz3OK08nywk/9uOvb3S9icvMbqmWS5vkOUu5NP8OriJqm
ROwTdDycVrsgbw0uKYZOPjK5AQyFfZ8z0HO+ti5nQo6XljTMwbmsDxjdoZs4YDcg
2AXQMIOlrP5DJYixejJZ0k2woxFRb7IiHoCBzcUZafgy0raeYQLgy2VBtBgkO4sW
bNdQ0XyC7OWX9G+5HVBpJljNEjYJHXaa++hZktvkDfv/qbnl2limMiLGYNCQjLtF
h/GnSYjpj7qxu71uR0o0vTJlmgOj3pAWcfCHvwql7QJbsIcriGDxCM6ZjzEj4t9o
nWBe00s8Sigfxf2oeJVmfXIQXNLafJbucEImn6jRJDafxsCwWJhiVTsIaAGlQp+n
qW6IsoBPEIsFdq1gy7fH0bVD/hi1euev1xv8sskhdb8VFlb9K11W7oWCAWuk+QgQ
bx9O9VCI8rVbkkf8+UZsAJrcCmTu82afziSo3o6A3UYjPboyRODRV8uEVjH6d/rL
gxxCwuJe0Isj/DSeupqJ+C8hu5nCImNsfBH8HXxTGNY+DG+hHMgyURgepROehWNn
cgvg9FYp8WPYXp9IkjDL6ix/vJRldVyZp1Tt8So+T7HnE/18tiU=
=kUau
-----END PGP SIGNATURE-----

--naFyJ2kOClt1eQ2j--
