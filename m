Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6CF275740
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWLle (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIWLle (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 07:41:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC3EC0613CE
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 04:41:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so4941249wmh.3
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4mihPRoQCANp4qVuEkbYRoFAh2NqYQy3VWqKlKO1vI=;
        b=c3KyNeHQUzvRPGV9gSMHgJBgCdcOJVCIicxTeiug9tMVL6LDnGahm6kQL+UdN1nSKa
         wlAwr5aytLR91YbO9Nui/nTvDksXG3tM4oEf/1WQe9XFESby7odQm/XUheLPn7S+SdEL
         7UwlAxOOr+KYUS0Haq6h/GEB6LuJHfuFQ8dI19/i/2cadrvF0oAgd2s92UBoJwPFLIsg
         QzwxeRwx7Iyd4gblp0gyNVnxPQa8+8VS1HbBouFgFr6j8IxDZ/jSmPLaOBfw0zZbOeqr
         NyriY5RhWXEGsv8low+SI/QAM9j3VaoEmRQ9gnTvMvv9u5eGhVObPiUAql0/Gv4jR4ku
         7JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4mihPRoQCANp4qVuEkbYRoFAh2NqYQy3VWqKlKO1vI=;
        b=kIbHhvrw5dXl4LDe02ZVMiUdKJZV21oY89C1mfA05ux2GAaWhFYhufdIheQ6cfs/E+
         Qn9lgDSqLctYuMWSh/YtcPDTLZxhWrAgOUB/sKN5tuUC4VryWd1IreTIb0PTIcJlQMj+
         IdiTI+MIgmYHeZ8vjZcGZBXcHbV4vq6jmmImKiwzc5HxqPk8ulNKTN/QZz4MenEuML/3
         dGa6Z7Z4JeLVDOQQdespZC/M+kkDiIwJxaLCazNtcJzjXgipOQGAvH80nefv74j+EmZW
         IJ1R3n/KoqWuC5TZIbSgwFd6WQ/g4cp1hz+G0Na926oU8gJbJIrRuRqFDKorjEJm2u+5
         bYfg==
X-Gm-Message-State: AOAM532XCjqNKQB+F48GnM/fQc6/Jhpd+jy7v4VQdQEHNdxTZLoJ2EzY
        LqqQzODI2hi/6WPYpmjVT0c7Ap4ZF5A=
X-Google-Smtp-Source: ABdhPJw58cU4aJogL+numudSDKYtNdPm8z83Q3R0F0oTiHb08B9pS4k+5R6LWmDN0C5XZ1wYJUBX5w==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr6234350wmc.45.1600861292623;
        Wed, 23 Sep 2020 04:41:32 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id p1sm9950378wma.0.2020.09.23.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:41:31 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:41:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Simon South <simon@simonsouth.net>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] pwm: rockchip: Keep enabled PWMs running while probing
Message-ID: <20200923114129.GB1846003@ulmo>
References: <20200919193306.1023-1-simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20200919193306.1023-1-simon@simonsouth.net>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2020 at 03:33:06PM -0400, Simon South wrote:
> Following commit cfc4c189bc70 ("pwm: Read initial hardware state at
> request time") the Rockchip PWM driver can no longer assume a device's
> pwm_state structure has been populated after a call to pwmchip_add().
> Consequently, the test in rockchip_pwm_probe() intended to prevent the
> driver from stopping PWM devices already enabled by the bootloader no
> longer functions reliably and this can lead to the kernel hanging
> during startup, particularly on devices like the Pinebook Pro that use
> a PWM-controlled backlight for their display.
>=20
> Avoid this by querying the device directly at probe time to determine
> whether or not it is enabled.
>=20
> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rNGkACgkQ3SOs138+
s6H5vg/7BLq+yp7GbrJXifMXvsI3VsHdW7jTyQZmcOK7uKngyYnNZyzUHdzPf4gA
FSmVLNwUtKkwFZ7nEdkoJt3htRj365B6AehpphCsK75q1WvojkWpscAeY82GzYTr
2XCcFYMi2akQFKufsTZdgUwNLHirHv4Ezp/Q32pA3jZe354yaOqo4c/qUsSyr11a
aarWMneooGRbEndssSFU9ejCOGSGfg8w1i/4glh3tzttwra1wt9TlV5vemjvhd3/
GKEW0vQEM8cRWz78IQ8z1Gufk/4NnJWldfH3Flz0NLlGRUQNCoHvcflMIu2Tlag5
zamhTqXuzJNGndwxz2eR7jIHXeu/rxzssJhtyMgiotootLpNkIKpJKczlJaaN9Sv
+lE5Ut3SUwf1p5B2E5ckfeurzpOn2HoeH7RxC2YyAUMK6u7m9Wd3p5s9ogwYPIhD
9IMDJHy8JL7pnjlVKY71DsX+jHAOkGbZ621Jh2PbAAD7HsJGu+H2iaE4YH5gdy0l
mbl9KRujfdxxAeP4rPYm6DIjgx07lWg4emp9ZT6zoT8B1mujoHF3P2RNzhwWzShu
eNCMo8epcAL5WM/UwKleEfh92RvNakmdtuSJ3QfhJ3IG0vX9uieXHYbYoCRumZl/
OMHSprXljJGc6mS/M7FEvWfW99hkA9OUml9xJb60nPdINtwBuF0=
=f+D5
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
