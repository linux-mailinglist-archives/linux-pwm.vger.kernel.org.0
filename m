Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75779197E32
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgC3ORC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 10:17:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgC3ORC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 10:17:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so21889354wrd.0;
        Mon, 30 Mar 2020 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pBQqZVEq9iQY3TkOskST4uSFuna+gg54Ys7RpapkQWM=;
        b=lujtqJdPJb/psrSlD2NuWhPp2R7EnCRb96e3qZY71byvANMzufsCgACW8htq/HTCNw
         q0qQGFneoyuYvJ17HsXw/bBpOcHGlCHJok2zU+eoZo509R++/5sqTQ58Sd2L9eODY1bF
         4g6b5WYlbADl5u6U7OsvEXy4AtNSNH4vOifUzBZYTsWPJtL0XlFMcXJYMDFlwixmkdy5
         TStl8BrOSoXRHfXSWLTAg1MEVzRWEb/21Gi826VIVxddtDh8kQ/3ccceI2zRYNQ+Si1r
         EWzyox7gf1XVfJVlJJlToMXN06+cDec+KhNbqgpH4KzBKRVrGjtkABoTVx4XhF80ICL5
         d0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBQqZVEq9iQY3TkOskST4uSFuna+gg54Ys7RpapkQWM=;
        b=Onhb5981oZqjrrssveMe2G/vpTFYARqAQoidQxSGpaTfzMKmC5+66fnlJ3iUMDR6iH
         EhJK68hJHC8Oq/GYQp0MKqKhDDI84d6BSvviz6zX42hm2feWU1UlrqP4BzNKfghoxCXb
         579LHqR0o3whJPTTdQlTq0GFuEUEXFBewHwE0YBtrhC29ARkUwQ3RD+lhcUkO840Ge+1
         oBRF4UZ/hPekv7M4g5SVETU7hDuD5X6Tod4YeuymqLGs7waCEB1HxLnAkjOAHdN7W+Ui
         VWLEUb8WGP6vDs845QTDGSZalSEgcZaWkrg9kl8mhbNH5kzLmNrKAs0DjpPgnUhCjex7
         5l6A==
X-Gm-Message-State: ANhLgQ3G4HFixb8BNq2f2aaUuSUz2AoOljPmkixs+sBdx6hhXOJmL4IJ
        kuOamV/gKaccvAIRsfjxoxo=
X-Google-Smtp-Source: ADFU+vtKQ6aYSmXN4bQziwMlCpsmcaXBaCgjvE5/V9oWoSrehpWwu/MsMEXXPUfNybIGUJX+7pY0Zg==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr14712693wrq.119.1585577820845;
        Mon, 30 Mar 2020 07:17:00 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id v26sm23272574wra.7.2020.03.30.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:16:59 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:16:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH 1/4] pwm: sun4i: Remove redundant needs_delay
Message-ID: <20200330141657.GH2431644@ulmo>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
 <20200317155906.31288-2-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline
In-Reply-To: <20200317155906.31288-2-dev@pascalroeleven.nl>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 04:59:03PM +0100, Pascal Roeleven wrote:
> 'needs_delay' does now always evaluate to true, so remove all
> occurrences.
>=20
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  drivers/pwm/pwm-sun4i.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

I've applied this one since it's obviously correct. I'll hold off on the
others until it can be more broadly tested. Hopefully Maxime or Chen-Yu
can help review the remainder of this series as well.

Thierry

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B/1kACgkQ3SOs138+
s6FuiA//cx1ke/G8okfRZ3jdGF2EHHZNYra6C9bHQDNUFuqoqfLNoWCZ2vGlYDpm
gpE9BAX7AWFq5BkD41Im+NeWH5Z63iQaR3H/+aMW/yiyaR0+bt8wlbmQzFLzUltZ
HP/nEIeM3weYrlNLMJx2t9UGXH7m+jjR9/d/rmfweJPNMfxgWl2b4bbq4nnQFUDN
KQMds94x3Hrzn04CzB+00E7TYIUh75bxBYQnTAnRfASN+F/Tg1tSrCgCamz3WjF8
ry8LFyg3WT/pbZaI+Yv3dq6C5NT04VuJC3qyhQaqH+vHbOK5iIUBUWCsJbkBybXY
+ZguKG2/07rMx6wC/e/NzL/7ChmPVym/O5di3TTtf6T5f8ZkuVwTqacf0V6etOxJ
tYWFG6Yxf97olwc4MhdUqK1SgT3D+0HsKaEZ2R9FCQvSMNByWesHjan7ZpldHjU7
I/xJqQlP6jahCEQYR2sWDw1bcpY4X251V6Mp/07jvks4JWvU2fHDy/CqJKIOWynO
tv2tr0GssCK3ZHt5Olv3mI3wHfkvHIKfI2LWF4kYkkpVcEkVRL2joQuUL0x70Miv
KcickysSrgI9DW24l1NGJe5ZUq6EE/18QETvurlORS7S087RHcwUwXu2Vg7G4s7V
CFTY/EHKeRL638QPV+MvSMudI9DhDRBiCwmGdOVYy7B6rVImsdM=
=LA4s
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
