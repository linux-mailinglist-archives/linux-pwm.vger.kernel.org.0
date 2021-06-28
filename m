Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861673B5D48
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhF1LqY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhF1LqY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 07:46:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F719C061574
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jun 2021 04:43:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso8560599wms.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jun 2021 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BB9C1kHiGfrVLLONHinDPUdn57GDcjujgBigVPRH/NQ=;
        b=FNnUrB5tbatTWRIWbIWjFaBNJUJCo2m/zT8Q9b+bhc4v8TiS6wn/HK2R46xGGffcaD
         Ud9eb0X7jhRcrUJ6oWO/IU/uz+y6Zg4l6Y2Hd2ssHidNxwbJibwO8hprwMv3pzNoNThg
         DL64k1UeI7yvKDvEM6NbaL7KoY/21QQyC5YESTUJWwkXfwfgcrJufK2JkaibHJGf77Mn
         8CwudaFerUwzcT4LJUnT24kBsWTXqZ23LfG9Pu9k4Pl6WCwc2p7egjDrnn7sDzc6pFyi
         O//lgJlp8YMOqahuY/7153xEtJQIzYxvkqFsvf3hwUMCHFsTKY1+LPzYDWQ9A+zwFcnL
         +8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BB9C1kHiGfrVLLONHinDPUdn57GDcjujgBigVPRH/NQ=;
        b=nBSyqZvDUNP24CthMMOCXSZLT3BTcozEo8qUZCQbqoh3mmRK1Mg88TyyiaIh9lSb7O
         66g6bxAuzmsQQf3GpfNtWxZVsStGUL4xOCcM+rpUkC9fSYIPsyOhetEpVKgX/67aV0zu
         jw81RhPuIe/KCoNV6c7N72EzCtVa7KZWhUWSspLoQfb7rznAed5fYNXewMnkbb5YA1rh
         htnI3Ydtwn6supvbZ5PiRUoheDvaw4OgCqx+q3ldfT3sipAwiX3G93QKdiN3iNAcDV8d
         Pq3kEPthFtJNL5h9decWJsHaIvThArV+oH5/zHdirKu7gi+apmp9MAaKB8e3jEKRLIBe
         1rDA==
X-Gm-Message-State: AOAM532Q1hJdEhk5l6jrCCS+y/0gNd0W3uZ5fw2HtrdMiRoGuMBG6eJi
        un4s7UvJz8wMS6HJT5Lbpo4=
X-Google-Smtp-Source: ABdhPJx2xqyyyd4fd9GFh6X1dWy04xwGjGkQ3l9KxKcm6scBcjAX42PbIO6RgDnaOBi8wzjcnyP/0w==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr25772281wmc.18.1624880636522;
        Mon, 28 Jun 2021 04:43:56 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s5sm2063909wmh.46.2021.06.28.04.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 04:43:55 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:46:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays
 consistent
Message-ID: <YNm2ftmwN2Nsgy0I@orome.fritz.box>
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zR/WVagU7u/raQ17"
Content-Disposition: inline
In-Reply-To: <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zR/WVagU7u/raQ17
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 01, 2021 at 06:09:43PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Without this change it can happen that if changing the polarity succeeded
> but changing duty_cycle and period failed pwm->state contains a mixture
> between the old and the requested state.
>=20
> So remember the initial state before starting to modify the configuration
> and restore it when one of the required callback fails.
>=20
> Compared to the previous implementation .disable() (if necessary) is call=
ed
> earlier to prevent a glitch.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> just a small optimisation: At the end of pwm_apply_legacy()
> state->enabled is known to be true, so simplify
>=20
> 	if (state->enabled && !pwm->state.enabled) {
>=20
> to
> 	if (!pwm->state.enabled) {
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/core.c | 139 +++++++++++++++++++++++++--------------------
>  1 file changed, 78 insertions(+), 61 deletions(-)

Applied, thanks. I made a few tiny changes such as dropping the apply
function pointer, which didn't seem very useful.

Thierry

--zR/WVagU7u/raQ17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDZtgYACgkQ3SOs138+
s6EGVw//cDtw6vs8e4hXKi4Hhn4P/mpoPawyVnvj9enXir6/qOUA1yEJsD9uxltY
TwGZSccYSEEXWOB/dGur7WNyNlN/lHzKHHMW0r9qGpGSZEMSF5UI37xNeU3QLkQf
mrnloii3QpISulj8Tp/7VwZKTrEMMGc17vD196FbZ4GfsUoEOcXQGbNvckaHUWPy
gE9DffhZFNmwyiTbtUdAHwLO3jj8dSpUaGAle3sTeu5Vs+inwarudxfQ6Wa3Q5fF
+VPFreb+O7XyAzyOfiQ4msgo4jBaMoCNq+C9NYkunJrIY16n35U/ihmAbGTDX23g
QfWpgDplrtCqi3aJUdu3VOeSRltEI75eMIgrpbrFhWSn75u0d+/evdHDrN8wfmL4
nMaTB3x9rqNP3APfxMTeSmqCdc6DUrG9iu4hIaO3Z2Ech8poXvODDN98nlCXNU3X
3w+BCJYdQWBqUJtj4K/XqhAG7RkHFU0lFhjOYhbNZ9dyOcvPodfMzv68JzC2bLjT
4qJF1Zpq3OWlv1EDCh0BSwSjnlEElw/Y/Evqp00TKtuheYAz2JUsetvmPE3sdqT0
oovCtZbJGg6oyQypHyzcrSVNsyX4+p95LrYjQ27HryS59dVJwbszlu9/w8Qs56qZ
+bshx1sBrX5BR7NPQM8jvD5R69Zx2y/4zRtRr6ljV3R7VIwt97M=
=y4E8
-----END PGP SIGNATURE-----

--zR/WVagU7u/raQ17--
