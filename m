Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3CAC4B9D
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfJBKjJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 06:39:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35860 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBKjJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 06:39:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so6434693wmc.1;
        Wed, 02 Oct 2019 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=34wC0n//44F6y79I2b4AAd2CW4tyXa/jyiOQHai4gS8=;
        b=LCgk8yPhc7jdn3eNstggPqAH1MafZ3eYuEY8P7C5YN5g1R5aludwgXD2nJg95ofiNG
         4ozU4VPR1n9Yttjm5dPW5nxL8tHIWUZGgorGiy85f8Cz5dRb2G3ozE7PS0MHQWSVZsWH
         lsx2EjLC2+Q+JagvxQ0JSgS0qsjc76n3R0a8lsGwrn9blviD8Ck2aGmrVQedw2iB9auq
         LMNQQ72enoHc2AoOggzyfPeshI1XzYIByHrvwbomiXkJZrEoi4nGU2KaX8TM/9+jDnwm
         0+KvhTEL63nQ3hgangxKkUGt6+tK84Kq16gL7pzV5fxYgCrx86OmWJYkaLTzfjL/9V4A
         CG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=34wC0n//44F6y79I2b4AAd2CW4tyXa/jyiOQHai4gS8=;
        b=Wc5CjDKZ03UTtoqZbhTd1is8XON/Qz/+FF78tBuhDj7nlMrXJmvZVjuLe/ZYJ/eK3G
         2bReygAAly/rBFsuPNLIEUPNDoIIasZkwMhwXCCw0h1sUFKvdpefm6ymzDv1XRaJeYDi
         DDnK3oXEVje9ss6QJbulXbEW7uGHC0P1/GxCkJpYu/PTo9fLQNmtzXH6yy1a+nvUByLh
         vBSbMp91xEIL6EDxOzWqfcnW8bIJ4Ud/r8wSV2ifg7j79BCxB3p/mG6FHpXip/0rpzpI
         X/wGWbV2jF02YTEAe+K6vs5MgG9rblWnShbVKyi2fTIMAAR6cZfE6JDgd84YXU2/o8CV
         Gzhw==
X-Gm-Message-State: APjAAAVRtXglX3+gfVMjgi5QvmI3iCiZkqBOl6mPlbm9EStWiXteiXbv
        9b6wSzqxAIrG+kLK2Dh0xSE=
X-Google-Smtp-Source: APXvYqzKaVdz2ys0q7Ajk0apq2a5ruazTjoX3Ns1yPUR64X5X1zjyBQv/KrerK3HFQV0RaCjeaFObg==
X-Received: by 2002:a1c:5fd6:: with SMTP id t205mr2286748wmb.124.1570012747064;
        Wed, 02 Oct 2019 03:39:07 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c18sm19817723wrv.10.2019.10.02.03.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 03:39:06 -0700 (PDT)
Date:   Wed, 2 Oct 2019 12:39:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: sun4i: redundant assignment to variable pval
Message-ID: <20191002103904.GI3716706@ulmo>
References: <20191002100844.10490-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RwxaKO075aXzzOz0"
Content-Disposition: inline
In-Reply-To: <20191002100844.10490-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RwxaKO075aXzzOz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 11:08:44AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Variable pval is being assigned a value that is never read. The
> assignment is redundant and hence can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--RwxaKO075aXzzOz0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UfkYACgkQ3SOs138+
s6EokA//eXZuyZhqQNANMBM0nG+CkHKuKs+iC0DOXQ4NyZMNNoXNy6I2UvGg7Yxr
hSiF5hYwZqfU12j33qdvne88q+Qh4R6UVyH9+doCh2SYpO928hUyrcBP7cutZ6LQ
pXxUyssDZCWpzr95yrKXhFdtp1KARRdeIjvnu2qdAUXVbJ9LsYpWVKBZQ+5qzrit
p0oR4l9K1T8m4wJ+DM9ejM8SPRsT+LMhaqPDWzqSRy6OewNPhcHiQk26XwZ2SWDH
tUMLk5vuGoHxKHOYorOG3IFjfNjCWqJbsRyYIYdjk0hqBrZ6UWhAI1EKdeb6qK5V
oPyxLIIhiTMZ6JiSN/RgY3zO+/0Mak0YLrouaVCpt6mI/OcsTh6u6++bDvQchQmB
vcNFScHVLuwUnNV1Bh4FEjocX3i5ucDQsAhDQfX1HriCX4MTXt3QArdQLx2s1CYS
AcntnIIYWzT+YIc6FObtL4ml/FPmwBKT6V5F5eA78AwcsRDV6dMcqRO1I8wkkypF
gAh5KLSjWfibX+nYC2vgMsP8Ab6wD40fu8sa8W8q/Q6A4Yc267hqHgsMKTnVQP4t
TK/kv4TqVADa7mV6sGsvQUvtKn2+3rBUnv+WU06VXgw4ZhzyjybuZbGi5rkugGm8
eUDcoodpzE8EJSlgjgpygmouU5EUezWzh/tfCGR3HKeTPQBs47E=
=VQ2m
-----END PGP SIGNATURE-----

--RwxaKO075aXzzOz0--
