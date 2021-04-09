Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055D3359EA9
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDIM2i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIM2h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:28:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C72C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:28:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so8379270ejc.4
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yWagNCrnV+Q9G+uZPLJNBk/j9kETtWK5AXPYULIHrg0=;
        b=n0jomT1XyHeGSllChb0FMh/iB8PC/3OKHJu6Nn5h0g9I/BUl9wLyL46C/m9P1nBhC9
         dcpn+CvbkldfeMI/wqYuD2q5ReKLCaLQLy/pCTNhQLptRgXUgZrC+l0OvN9Yv7jSeAJF
         +IicUuliARt9qDYKwDWvThlosht2FoJTCK/TtHhWAY0uugrYaI5WfGu3EmQeQgkwyYvv
         xZI+hO8zdzODAF+j1CWhJodioFxfFoqsUmf2NVQhalKkQWrTAjYMzavxs/CWGHGNK/xK
         b6UVXSqU3VMQ84yRFRUHspAY5akWmwBG0fAkkiw2SFJpI5QZsRXRHzCmFnfz1aw9ZeyV
         DUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yWagNCrnV+Q9G+uZPLJNBk/j9kETtWK5AXPYULIHrg0=;
        b=kOMIa9RzSXb1g8Y6HyosXm3Mmqbs0vqrmcvaXjbBswkPsMzlta2WxHzHQk+bm2x0iS
         riaXx4a70vpqeaU7edbcYE7HZzNzPZEvDoPaaunTTRGh504voV3sLluecloVE1IhUU7h
         E5FG4lP9+T2FXtVeSPIU4kXd4Z+25oXShxN2HvdInswfA04VgitYcz7k5rw2VL3qPzAu
         bbnmxW48TcyuuJQZL4qklSmdTtavS+hC4y53bchm7nNursdYlcffuk3Ed0SqHtfodqfv
         Qdw1TY+Y5itS7dkm+srkmZRTNPB0rB1n+c7wt6O1Y9P4fLVF3YX2IgYUjDlWhwbujzGZ
         /OdQ==
X-Gm-Message-State: AOAM5321C++PA1NeTdf7EBspkYSxn49/13nPWa8hoHJvrCrw4cJlb0gt
        fZtwJNG1qKjtHPuvIBfGbik=
X-Google-Smtp-Source: ABdhPJyeYVhpi4q6FxKD2w0IpldBJYHJzxTtUlrUUfRF+8GBwwHeR+XnaeVKlw3tsLvSMcF1dzVNrg==
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr15786372ejy.211.1617971303810;
        Fri, 09 Apr 2021 05:28:23 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id n17sm1390616edq.32.2021.04.09.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:28:22 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:28:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Message-ID: <YHBIinNruQHdk9c3@orome.fritz.box>
References: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zHBox8gfAI3drvxx"
Content-Disposition: inline
In-Reply-To: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zHBox8gfAI3drvxx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 08:56:35PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clock.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--zHBox8gfAI3drvxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwSIoACgkQ3SOs138+
s6FA/RAAj0YRS0QQL+9yZxppU7lHDoyCLfHrQuEc7lJ9865UgDJDEYTQJTGPpDDj
8XOGX3M42YIo1uEPHTD+qUCKtgE4fBG2mBebV6Z2RvRnQZRbhoXHBM1+rr0cQ0jo
7tXaqCUPd/0g9vHm4JZqQN9aDZyWXH8hn6u6zC5vtrfWGG1N6yvYnFUnX/J2ubzq
VjkYu8ey/m8BOK2fWo43OnFHdcmIZH9g2GkXnfDUfa7PklEonakoC5lGHhXgBQJ2
K0D4ZtfzdLWWAU3CkDR1xLI0CbikVIblah+/1y2TUxUY04ACddodht6OcAsK92jv
GLE2qc57+b3GP8ww/MQNC4mR45EIHdh+Tu9nGpNTyY6zhEw156tMd/6yv1D8VbS8
MaKbfs/i7TTzlQAbST707iYX0jh+ywW21ouD5/6KLdXjAf5p9Eah24GxznlppWl7
cfVIA2z3zc1yZfY638qtRN9IS/lkfLJRZJzM2STb8OlfChTle8HyB8bYiqw10cFP
9F9977jco8ks+P/iZ0DxiYCl9B/LXxk7KTRyBdY8JR1QNJDrDbDQTTh3Ae2zf0dZ
/A7L9cdTzikOgBqtXojqlPRYPBD0vTpgTxU6Fgh4LmGh+r+duJn6hH6+NByqlMCu
HxpcAxOXhIM9jAjUzW+RS7kA22wt14Kc51AI1gW3Z1wtVuNY+LE=
=j+F8
-----END PGP SIGNATURE-----

--zHBox8gfAI3drvxx--
