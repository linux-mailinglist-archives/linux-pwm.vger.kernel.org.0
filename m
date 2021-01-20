Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0372FD5F6
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 17:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391560AbhATQrU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 11:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbhATQqv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Jan 2021 11:46:51 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469FC061575;
        Wed, 20 Jan 2021 08:46:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 19so25928910qkm.8;
        Wed, 20 Jan 2021 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xPJXpjgk3V30+lydtz3hNrB60KcZVVAu0KQldhg/ajU=;
        b=C0nHxcnmlDXhX2R/7zo3NnICFQ7dGJiITnNv76P+QArPkjAUzjP0TM24h9DIp9G11m
         cYcemn3WzsBNfEMDnVK5HF9pB+BI92fPXuU/LdUKbebAz7vUhJWfZdEQDMF/4ZlLH0qt
         KaZf1QhMVWOyHrFuE6MFBXHDa8H5Ys0nfO6G/c70/Dzr0XN60tHKWtLYozVB1ZBuOnWW
         kn0hIFVoFIaQ/cQp/H3Ju2NZxrL/K+1QuE/Rn8xdzPMYjjQBLDxfOjEzG8D+Sxm6xQ0g
         qrOfXTsbNWJ59/rWizeW2C22jdZ2IUXlIcXQYEaKZEIioMSKNc1HdcCrADDFPM5xp9gY
         62Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPJXpjgk3V30+lydtz3hNrB60KcZVVAu0KQldhg/ajU=;
        b=Br+f1iBPbYgyDFNGLSvh/i6oij0hvluxK9jziumPMI/T5I2140c38I63PSYuGCb381
         xzeeXdxliXrzobgwqV47GcwI8jDp+FfLFEh6+ggmbf4b2c2jAPPVh8WXjqBJA6MT65Kf
         dVDKNcx1qSs1EGptXqHR7CNrAN5upzGsMFcKxtYAYd0gIa/+41XLZ33nD4BGdK0gCpYn
         F0y9vy7WYHhNa8uyx4woY3Kx1eRKZyLQhUsrXISmQCoxNYIRe59WKqx4+s9ziD0nLno+
         SCDCc4RdV+n8VRysqOMO5lALzcwaQhdstUeuASvAThV7xST51nQASEoXd8Qaf6ICRl0W
         L9HQ==
X-Gm-Message-State: AOAM5304XynBoY1QqIglKbkgHJjBZaXGP3D0eii2umDqZf2p1zmmUj6S
        l4gfqOXZrzhlV2qEEVUvhR8=
X-Google-Smtp-Source: ABdhPJzReeSv8cDFaEYd1BOXiQGjbXaR1YMMv2BlKWvMDykTVzY+6VLoRX4zqGZx6c4danro1bqSNw==
X-Received: by 2002:a37:6442:: with SMTP id y63mr10222452qkb.192.1611161170512;
        Wed, 20 Jan 2021 08:46:10 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b12sm1504717qtt.74.2021.01.20.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:46:09 -0800 (PST)
Date:   Wed, 20 Jan 2021 17:46:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: remove zte zx driver
Message-ID: <YAheTtSLm4C2K9bD@ulmo>
References: <20210120150944.1688327-1-arnd@kernel.org>
 <YAhRMaJhYJZat2SI@ulmo>
 <CAK8P3a2JhcRnaDXK1V4=FgRJrGjqrj5-LzhCaC+jpLa1hDL+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/9yMM0sT+zOg2Sc"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2JhcRnaDXK1V4=FgRJrGjqrj5-LzhCaC+jpLa1hDL+Pw@mail.gmail.com>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5/9yMM0sT+zOg2Sc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 05:04:36PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 20, 2021 at 4:50 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > On Wed, Jan 20, 2021 at 04:09:22PM +0100, Arnd Bergmann wrote:
>=20
> > > -config PWM_VT8500
> > > -     tristate "vt8500 PWM support"
> > > -     depends on ARCH_VT8500 || COMPILE_TEST
> > > -     depends on HAS_IOMEM
> > > -     help
> > > -       Generic PWM framework driver for vt8500.
> > > -
> > > -       To compile this driver as a module, choose M here: the module
> > > -       will be called pwm-vt8500.
> > > -
> >
> > I assume that you dropped the PWM_VT8500 symbol by mistake? I can fix
> > that up while applying, so no need to resend.
>=20
> Indeed, thanks for catching my mistake and fixing it up!

Fixed up and applied, thanks!

Thierry

--5/9yMM0sT+zOg2Sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAIXkwACgkQ3SOs138+
s6HKixAAukfD/Du+eHGX3/DGbQONoE0kUAM83BGtaX+yrUhKsShiHFesfndVV3A6
iA51zuRyUr6n99suKhcGcsE6Zxt2uKiLlEEuPe920cjDquLF/VvCsamJKtP3Bwfy
QCr08+Zf+KBL3YItlShgCok19+k4D4FFxOjFL5jNo7d3pfVJBnevfUhCM+xnVvHx
kOrKln4E1UwMvCtELTLfCoJdVef++ZkNn2D6kuuLGsuiTlPVQcMqRRrlvJxovSV1
88ZRqIvjeT1Qp6rzkB+XsGiRipuNOvq2uMXSZ3LdRE5Ch4Z1UZ1md8wQ1ev9iVI/
IPeVWchcO7K3HeydsEmEw1Y1i1gS6HEoHIwFT5lsXI1HQqY0T6hb6x0aoOu7j3H1
PZzdDCCDGP8Z3N58cxdozVpFuxS91h/nKyt23HUCayGidaLHunQkX6vtLy2R8NiP
/xGYcByX5kWD/52Jic9O9KW98tcj3zEbU+QZ7v8TuOXixse2TTUeTrOElg0KnnE4
tUOy2fJOQlUWiNyrwB1e/OCjCYWcMZgcZBQh1m8dvBMq8z7k0AowkjK2mL5nLTkT
yfhf+DSgW/PLd24KF+rZg26GB4+zFdEihr639UBWZ8XdhhJ0mkeSZ837jyHWKIZr
TPN4qOMA0H4ZZI6Y7uAN6S+d2deKXVZ2A3aIo88/etb5Bdn8D7o=
=bnN+
-----END PGP SIGNATURE-----

--5/9yMM0sT+zOg2Sc--
