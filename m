Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845E23697F6
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWRHK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbhDWRHJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 13:07:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8ACC061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 10:06:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e5so20401664wrg.7
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QXVyKdtKmKPVeVZofUNr0+IeC5w3wxf4hMn+eBpNKA=;
        b=uYm0w5Mi6VanQv11o4JLlBlQZ7MEr6kt5kluzvQYc6bZnzCpm0vM+gELu8uowhIl6F
         MCd06cSzLmuBZAU2bgOhBD+ezMnjwq8EOwZRn72CV4DMEfSYLdOUArBPsdSyv3Q6RgOf
         /bca1pqo51YP8mhUesVAHyMdmB4Mq4JsKO3Z3kD7/PvlecKDdEtFwFYiGGT8+ZS6TPWf
         f1s74ne5cJgI8HurqHA/h3EIZhxVnNfAEdNzgWIgDfZdtHqDaV3uZTmZykGTjncsUTtT
         q/4boX8HMfdV+zFZa9BCsmtZS89AJm3e4G1vycLoF8U8IvzntlPamsnrIFwi47ARHzyd
         3VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QXVyKdtKmKPVeVZofUNr0+IeC5w3wxf4hMn+eBpNKA=;
        b=bK7ofvVnTDPdx1GKESsI90xcZgqPO63n/CpeqYyBonStfQeCI6onj16HMhTzBYkgkZ
         ufJV/O8MbNELxyMtHG48uCeB0VX49srQvR/f/vh9rpDQq+P3lxKNIHuFbpxAGOCJZTir
         Wjd5Jc14WnCJQmaAI+p6Q2e73L3sA8mAHWw93X0JgkfsA+qWdXx0tF3BIskpGMkrBl5d
         BPllgvVH70nrK//RPeQgqUGhwRixPsa0676k7xCQRiUVabXmQOS67Kk+YpBf6MPI0Mjm
         UjGUlXVnlQQ4kwXxL/jnpUoYbOONTSZd/54um9pjNMV+BRm0/Lrcm4kXYle0ecPztC87
         SBBg==
X-Gm-Message-State: AOAM533IMU5dwNMK7dhBR5y+uTpeuLdLiKYUELRn8Bg4SOgR7khZwPIZ
        2k2EsHmtyHq+VCarY2owA4w=
X-Google-Smtp-Source: ABdhPJx8koitRsz+nbZlk61M8frM1mF0EodBEl+r8ZNsbOku0vq0lBNMvkCNrXbbyiy4fj9BNCwTiQ==
X-Received: by 2002:adf:dbc2:: with SMTP id e2mr5819643wrj.398.1619197590758;
        Fri, 23 Apr 2021 10:06:30 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 3sm13680285wma.45.2021.04.23.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:06:29 -0700 (PDT)
Date:   Fri, 23 Apr 2021 19:07:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: atmel: Fix duty cycle calculation in
 .get_state()
Message-ID: <YIL+xs0jstJZAs8p@orome.fritz.box>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Yhq2U1i8SyotV9I"
Content-Disposition: inline
In-Reply-To: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4Yhq2U1i8SyotV9I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 11:51:17AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The CDTY register contains the number of inactive cycles. .apply() does
> this correctly, however .get_state() got this wrong.
>=20
> Fixes: 651b510a74d4 ("pwm: atmel: Implement .get_state()")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--4Yhq2U1i8SyotV9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC/sYACgkQ3SOs138+
s6HQaBAAo2/cIfePk7snkvy/WVbS+Fo9O7Clk0dcstuqxeSLgg1kzM76Wp09KtgS
b7x+wjgM89cP8iulXAnEQVAvZeh9kbP4J+8RA8my6/AQ9KHrB5QeyhYmAfJlkSjC
nLGD5UVXSGAOgag2HSFZX2lbXtjONrztnpKMpwis0x0Et6z5gdqoCSPLdi2T4O12
UZlB3Pt/QM3jYN2sadrrtidwNAXcYp/HbmqrJtSrN1J74b/dltPrhp+suwTJryP6
A1Sikurj8036zkUCxXuVV56b0Egujo+lliMKIsw6y++PsnTbrqHVwoXZflXU2wkF
1Hj5SnkKVGVBx/MijPPzFkwZX7Q4G6K3RiO71FaaFhgnBgPOznEkCt7tfiVDPE/2
aoasBZ3+tD1auCbSmJZuBEjI9tRbcXSDRwcRNQWmqCMZI2Se7FyvINLEmDcAyBQf
VjiC+VzMRDTn13DUuOkyqMnDLts6dSL0366tqxZvtxkVt8WO8PRQ3jh+oAB94J62
3MJpZOxZyx1BSWuyi9luZWacMyo7AxiaFMJGKiCbhzrE6rzA5ndVYZVWcr6HFdp+
/dJ71JZo/zkCy0l16Ghe2Jf9mkdG1dNMzJMB8rreSCkPLgC8fllERTt56MxfGt4e
fv9S/dmjJ7PpjMW3yJcp7i/U4V/oWulv45wtnbdS0SV8NQUTxRw=
=UFL4
-----END PGP SIGNATURE-----

--4Yhq2U1i8SyotV9I--
