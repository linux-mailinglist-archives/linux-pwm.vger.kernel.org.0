Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517ACD7858
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2019 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfJOOYF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Oct 2019 10:24:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36532 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfJOOYF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 10:24:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so24146823wrd.3;
        Tue, 15 Oct 2019 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FAnSKJ9Pew82PkAXBmKY6NLtUVGPV5vweCMQygZLvvc=;
        b=vdm+Kl7Gd2y8KQLrE/HVhM8oojADmvZGvILZ1fyliGX2ZgMa9FIC9w8kzDxAMJuDjd
         tqCIlnyOggnEoSYxZJ1Y7rUjNA8gBdVlFKsxpYi6hy+nkIaklBboKo7lkhwMrlJaFdcL
         0MgFqVTbuVUK1wuhcUhTp6rfthPK1vSdRge5O5Pcq3XW0+3kZIbigf+Y6dfavg/k4dCB
         ghGvkniJqx3yGmzSZ/i0UOfsGeMwIDESQLlGA6wl4Sfvol8nxxLE84K0mdY9BbZriZMa
         jRZoCjXC1ZUMbID1bn/0THaqWglcm+43TCn6DU24RN3vOs0NIrGxEtg6aXLoyDPw1t9r
         60rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FAnSKJ9Pew82PkAXBmKY6NLtUVGPV5vweCMQygZLvvc=;
        b=LoRbyyAamea4yIyHmKq3+N3E268YK1cwMt/LUb0XVPDjJtEDael2FatBqbLHPEiMMi
         fdiGNv59qkE+Fnq6mbYcLg2EZ6ZmwCIsgJkIGEsr4AHAHLjavOwhjreUNTot0RnX4x/h
         J01Bw8dGYGhswoScBGuMdluceudXqFREkNj0GcTheUM0KHojga/TQnAVSWuAFNCamrXj
         xVwXyGGwqxBtDKEHHSPDtXCtcmwJeJjaj34PUMAeCiRMIrbuUKoV+gtZ0z+HU4n/GZ/+
         uPH+BE6l7nhu0F8gni6TlJsFdSs1SqzsGx4amiHn/LY++xRjt4a8MJ33Srp8kHPpeStf
         kFXQ==
X-Gm-Message-State: APjAAAU8kNazSvLVC2tY93MIt+OD5xan5O29/OoWkrUSKNk16hKvpL7T
        xnxzCnNxfCWlJH22OZBXxpo=
X-Google-Smtp-Source: APXvYqxMLLgnR0vPxF/fKc2CDYJpM14udBOYJNSRJ7usNIA2JSpBWl8XxRhB+VXeRePSyanx9OYDig==
X-Received: by 2002:a5d:51c8:: with SMTP id n8mr215083wrv.228.1571149442587;
        Tue, 15 Oct 2019 07:24:02 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id f20sm17308471wmb.6.2019.10.15.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:24:00 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:23:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Message-ID: <20191015142359.GA1101003@ulmo>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-11-arnd@arndb.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index e3a2518503ed..8eb738cac0c7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -394,7 +394,7 @@ config PWM_ROCKCHIP
> =20
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>  	help
>  	  Generic PWM framework driver for Samsung.
> =20

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2l1n0ACgkQ3SOs138+
s6Eb7xAAsZ9JZaeRn7IjUZs/yz8zD5TWoNpojsmj6Kzf947MW5cgaZEJei22skVy
3Kv1ogZu1N2WO2L7v//P9waAgCs0EuHgeRkT+UgsW2AapaShdkNmMh0tgJNWGFLm
JwwGVB6rfjuBVYQgICBlfKzPdA9KDQNlxJPJmE3lC2kAQ5KWtsWHJIuWpk3zruQK
rZyp33ecFy4Xa+Sxue8CTgyUoHv+t7fhjtpAn/NgMJGy4WGi5lfn8S9bkb9uULHD
cZY4hv+EPC/GAaMQJ6HX9BwGnY1l+Mh8K7uH323OWAMQUqNAgKYuGvhUYSCtLPB1
WNdTjM1kkz93c1pLaikNdKtO3NhqrmXD+fKwmEF7xCQqEfBvPznq4ipHb4MHJEih
YLw8CGBBCX51LOghEJsYi0dMhvWdq4WFJcmXCcjWBYygVWkbvwkdCZSOTdeyI3GE
QTTlWslD1YDL7FuwCYPLBpldFi1JT8hFwP8oK3VTSxmpd4j8mjDKsMHpHtzzTGe/
6Le5t6ewz0rvR5ZFAnZB04VlIFV+l+Zx3e3Bxaqc2h/I6u1yagTZuPSknB7FJRPs
ic4Qr6sfKbK7LMuIIohElzhuVHcEeIfZ3NYAkWh7t9sqefIRrJUcDcPkz3sQ/8Vn
ChkBlbp/IuPwYuSPNI9nf7EW5vFjV7aTYZFXI7mj5M3kK5suvsU=
=4m87
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
