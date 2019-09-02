Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD674A5A18
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfIBPCu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 11:02:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52820 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIBPCu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 11:02:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so14949395wmi.2;
        Mon, 02 Sep 2019 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V0QC7l1ZAHBC37nciCVz+hD6vR5ujcLNIOHx5Ail9V8=;
        b=sD3ba2zobMVSqXvV1TL5qdw9q/KlllvuwnvEwPV3wsPue/gPP2lXS8ilqpOty4Jya/
         lZzKayaGo+0vFQ3ACv5nAsf3V/krhz68TOvxg1vYjnDC68WquwlkTAYSj8K6NrQTJyxT
         8Bi5hqZYQaNYsqkP/xiVe4+v5h+rKsaLP3TBlP1RTIlZYreGcw9MDiGZH3FZjrjH7SiE
         /BLe/QI7fiQBj5K1hL+BhWkgbyTudbc6vAsDGX+PAGwUI9LLHaOEotsISlUtl+UMNi1O
         sP4UCpw8oAwVI0GROY4iqWjBFIbQXgqHpdk5KEIKvYNhhO98qpMNgs3fn+67litLJckM
         pbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V0QC7l1ZAHBC37nciCVz+hD6vR5ujcLNIOHx5Ail9V8=;
        b=LMnOCqXVQ6qXwWmjxN6bvZvU2i/aq4hHR8Tg2I03jaj+faHYHHmWRQM5SHK/Ggjata
         2zn6qpFrHP7uWQINmSXb5BUe0uHhQl2qHtI6cm0I4UFWgJaLNcLjufEsayetHTPFcBSk
         18s3xJLsWJYjXSLCAE1TyzgmAJyVigfYBTE0LfDf8MqCR445t9+197DuAXfrUjynW3vi
         5eKlryFPCZldVIU2b4w4utJF5fA7R2Oo4Ms9aeVqNUHbm/+O2uuWqM8P5Zj1Vh5EtiPK
         rFWpy9HksLeyNxlrYLgM4B7z0DrEN2OdG11zoWnZk/+4tZneYOSbhn1dvVIyVs6GfUjI
         nEPw==
X-Gm-Message-State: APjAAAU42sK/4Hwdvx7rqpjpx2cDs9lR4pdfgfzL3U23/P4OVoFVxQbA
        v7759PLXgJ+ltu31jqQOnXloM4aC
X-Google-Smtp-Source: APXvYqyRWvnKMnSM98+I7HYqBNsQWVC/pXJ3FGiKsgQOI1mXh7rupygOkL63+CRXj6VKKTvU0UaKqg==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr4615948wmm.45.1567436567679;
        Mon, 02 Sep 2019 08:02:47 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id b194sm33888347wmg.46.2019.09.02.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 08:02:46 -0700 (PDT)
Date:   Mon, 2 Sep 2019 17:02:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to
 bus subsystem
Message-ID: <20190902150245.GE1445@ulmo>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190901225827.12301-2-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
In-Reply-To: <20190901225827.12301-2-david@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2019 at 05:58:22PM -0500, David Lechner wrote:
> The TI PWMSS driver is a simple bus driver for providing power
> power management for the PWM peripherals on TI AM33xx SoCs, namely
> eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
> it does not make sense to have the bus driver in the PWM subsystem
> since the PWMSS is not exclusive to PWM devices.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>=20
> v3 changes:
> - none
> v2 changes:
> - new patch
>=20
>  drivers/bus/Kconfig                           | 9 +++++++++
>  drivers/bus/Makefile                          | 1 +
>  drivers/{pwm/pwm-tipwmss.c =3D> bus/ti-pwmss.c} | 0
>  drivers/pwm/Kconfig                           | 9 ---------
>  drivers/pwm/Makefile                          | 1 -
>  5 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/{pwm/pwm-tipwmss.c =3D> bus/ti-pwmss.c} (100%)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1tLxUACgkQ3SOs138+
s6Ex9g//T+ZKzUz859zn7FRpj13m+ndi84IulhyCYr54G2sXpuiLxVOo9q9WVI/v
QNkuu8KOb1W91FXpJudcY4eagg0PoJtE0/8u2kO7PX9QNe5vMoUbIm0j/CrMJH1O
3RJEfArqrHlRIfWxik5gkAnbVMvkhTrEv+zVUZyNAQFNua8qw1mTCSDac+iX7QLH
/zubXqDPaDP/FCq/avt+hB4Rlzywv6G6GFzs4boUjwXN814RsVTdf2XBz8Hx+So2
a3o0Qtht/NVcO5p1/UM/Ps9JChuTHB0gy7/pOe2sx3ayQ7Nd/wgcUsaVkwOlQ02z
emSxOqYCLze1rHba6O1iqJb3QwKKVaIFfswfH2xSy94gSCZZmExukdDfVRunfQcS
YO//p3px8p8wdxUR3E6CwgylIo8QlQthMLEywC3BZkVR29W/bE7301GfDEw4MmQa
kT+GmJF4Fh1Zp7WYMsD4peV71pEAvycWO56CS83uSOSJ0kF0gGG6f9SFuIqD/lYj
Zn+ODFy5c3VEbSfOIUBtKy+IFG5lhYhjXHc9SfPXAtk/5Mybv2/NI9hP8PtKbRRN
q/wfXpZ/S/C+rRJ00HkO8druk8zMfts87+q5XUMg/Sr3OixDQvW4qT4T2bKUzRBB
bCA5jRYdMVnX2eAdrMNsZY2ZQL+/3YF3B2j5R8ZmWTIP1AI2xsQ=
=6nvw
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
