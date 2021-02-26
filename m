Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A374326233
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Feb 2021 12:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZLye (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Feb 2021 06:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBZLyW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Feb 2021 06:54:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B5C06174A
        for <linux-pwm@vger.kernel.org>; Fri, 26 Feb 2021 03:53:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u125so7525459wmg.4
        for <linux-pwm@vger.kernel.org>; Fri, 26 Feb 2021 03:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7S3f2dfS9LZlpDVlatJYyesk5uhal0XTdIsv+yQBhTo=;
        b=lqzqmf6wu2XfiletUIywaO39esKJfzTDiETTnV4gliirEsAHJrmRTVy/DjotfZ7cCH
         yinun+A2ynAyoaaMqcP3bU23gxFv4XidotbNGCWBK5/wX2DuCc2/VMHimIYmNJzy0vDs
         FBRCrPlL/0SttzB4dt5xUKysvdNeSkAspnsF8iLFOSWBwN3CoHV83NGGC1z1ltec31P0
         yUprLw6ntlJJi+PCxDDbSgwk1FUE4xgED+ipxlk3O/wbxifzwUHPrbUPTZfifmXZXnMp
         rHhhPCvXB/WijhfjwoctdXA2kXQDi7ZqW08TrvhNUsQyKO6E2cQykT7IRP+vlOWCOvcM
         D02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7S3f2dfS9LZlpDVlatJYyesk5uhal0XTdIsv+yQBhTo=;
        b=RYOhcA0t/Fg1SF0v5es7JsKaAFNVZvd4sxbHYCfdkJFU3zu8X6CifgBltTfhA0ufXp
         YD9DtgPffv5SfwOel5aJnU4DRAl+wmCjA7AeroqhqXrwsWv9DYc+QV0Z9UnESxp0q/HI
         RvBV4jD6vPI4ZJxpZxdp7neJ17Rl1TgXAeKJ/V+4GWUDIpnO74O2mJ2aaCJWgesj3Y/R
         bMdo8l9m6IUQS5nTKnEOdIVFN13yzJAllKNZUQmt63JM6lOWo3gYuau0B9XTcSPIh5vD
         n8ap1WKGVKtkUqZG1MrjGH81JfwU8w+RTF/vg7Wtr0GiIfv7pKHNceZtnlRrNnn9NaH8
         fUGg==
X-Gm-Message-State: AOAM532Y5HjAQLDK9XbWyOwaMk+/Hu0YY44In5UWFto2Q4eCpAZKUii1
        ckp6w6AKsezSbohqm1O7Xc33MAcB5ZI=
X-Google-Smtp-Source: ABdhPJwXT2yVMWNvZoGH/Q5L0HVMqHAXqq+SMTMYYYZvgaPsyyYND/T358pvoPXiJDCaUkUoWk7rQA==
X-Received: by 2002:a1c:2e8f:: with SMTP id u137mr2029197wmu.178.1614340421179;
        Fri, 26 Feb 2021 03:53:41 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e12sm13074152wrv.59.2021.02.26.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:53:40 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:53:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.12-rc1
Message-ID: <YDjhQvv0vYU890Ol@ulmo.localdomain>
References: <20210225193426.3679817-1-thierry.reding@gmail.com>
 <20210226095936.sc27f3un5vnc5o62@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TnLVv22CQzY9AzWu"
Content-Disposition: inline
In-Reply-To: <20210226095936.sc27f3un5vnc5o62@pengutronix.de>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TnLVv22CQzY9AzWu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 10:59:36AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Feb 25, 2021 at 08:34:26PM +0100, Thierry Reding wrote:
> > ----------------------------------------------------------------
> > pwm: Changes for v5.12-rc1
> >=20
> > The ZTE ZX platform is being removed, so the PWM driver is no longer
> > needed and removed as well. Other than that this contains a small set of
> > fixes and cleanups across a couple of drivers.
>=20
> patches I'd have liked to be seen additionally in this pull request are:
>=20
>   pwm: bcm2835: Improve period and duty cycle calculation
>    https://patchwork.ozlabs.org/project/linux-pwm/patch/20210114204804.14=
3892-1-u.kleine-koenig@pengutronix.de/

There was discussion on earlier versions of this, so I was hoping that
Lino and/or Florian would provide a Reviewed-by/Acked-by/Tested-by on
this. I'll go ping them to see if we can get a reaction.

>   pwm: get rid of pwmchip_add_with_polarity()
>    https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D219012

=46rom a quick look I'm not sure I understand what this is trying to do.
The goal of pwmchip_add_with_polarity() was initially to support chips
that support only PWM_POLARITY_INVERSED (or use inversed polarity by
default, rather than normal polarity). So without looking at it more
closely it doesn't seem quite right to drop it.

>   pwm: add a config symbol for legacy drivers
>    https://patchwork.ozlabs.org/project/linux-pwm/patch/20200613155742.31=
528-1-uwe@kleine-koenig.org/

I think we've discussed this in the past. I don't see the point in this
because your patch marks 30 out of 58 drivers as legacy. Calling the
majority "legacy" is a bit of a stretch. Also, I don't see how this
changes anything. It doesn't actually simplify the core because legacy
code can't be removed. It's only "simplified" if we don't actually
select the PWM_LEGACY_DRIVERS symbol, but that's both not going to
happen on most configurations and doesn't actually simplify anything
=66rom a maintenance point of view. If anything it further complicates
things because now we have to test that everything builds fine with or
without PWM_LEGACY_DRIVERS. Also, going forward I don't plan on merging
any drivers that don't use the atomic API, and I don't need a Kconfig
option to remind me of that.

A better way forward would be to start converting some of these drivers
to the atomic API since there's apparently not enough incentive for the
driver maintainers to do that themselves.

Thierry

--TnLVv22CQzY9AzWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmA44T0ACgkQ3SOs138+
s6GLRQ//S2tLzHHw6Q0b2aNGQVmIi9iN7NIGty35YU35Y+ffQ9qMUBqnWYViouLD
FBs6cSKaFRqKOiV3BBK2elEcqKjL4jYmq6MEET2lAqxpRE5BC6kV6WWiCOfHs40l
ThkgjZaA8/KMiW2TxqY8XjlAzKzIRifN34yuZwpuiNS2eJavTsNrJ461RtBJKuJL
b98iH/XCMe+jdtwt9gBmEoM9ITDhYcIxV0L8u+YUiYi8VcOBJIV7B73LsGQ28JAH
XChxyLXKGz/VmpGlpOxPtR8u9uZAyzD3COUMZngPjTLM6G134n82C8YIgVftZfzK
cBW8cq8jjNZUsUjZ+1Pa4sePhuYJfRNzcrbLH9owgzJPLLi6jYKGumIKN+4cts5p
2C+Z2/wYv1j3PBi2ZTGyf2IRGrkWCNlH7YQxFX4LjuLP7oqLATjlpCorsFBEDzgd
xK+C7nYY/fdszkD84OK5NZ2aEi6VCxM168fbs1UsWkAqEawA8H3sAbV4IBqTI7Qc
K4SJy8QjZkPcrPsXwp3X+exOPFahVwGM6iVupMuLQmrdNwmBNut2qgxT0TVpaAz+
fn/vg3IJ+PwsTS2sRSq2lGwaBaPlMlSrhY0aBQQgVSAWlzhZvO9DZxkh1UKbb/5I
5X3N0vWt0MNttLEqHDJBjdh1uU+4iTcvgw3mx09D/gDh7MGuszs=
=F9gz
-----END PGP SIGNATURE-----

--TnLVv22CQzY9AzWu--
