Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931803443AE
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCVMx2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 08:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhCVMva (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 08:51:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB8C061756
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 05:51:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j18so16574404wra.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZZSiLY/GncxvtjYgYTO320JEPV0WjTf6ilZz0mnbEnU=;
        b=Yx3NzexeucbsYKnju4Tdv8r2XrSne5c1UOECyPq9RbGVK1jydlEhdEOrYWdqfuaSGk
         1qghgkvg0qYc/IUafK9o1RX51MpSk4Nj9uCe+kGnqpDwQSXz5rqAo2hYBWtNcvR81h0w
         PFcJQQ+btQgqJmLlRAbm5Hoi/KrY2OiQyhV+8JnmSsum78BEqg9EyY5w9Nj0X2XyIkwL
         ynNAwq88AZsOEiSlEMiJq+3BTvD0Y+1YpWdE6AJWM25MXI8F7VQWbyO2H2y3x5hBN44c
         XwUwt3glG4rWqzXjwqmzCezks5MI6GzpMhHEAhv0BNf/nXfR5X85Q+IEg8DF5Z+zzO0D
         lWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZZSiLY/GncxvtjYgYTO320JEPV0WjTf6ilZz0mnbEnU=;
        b=EBiAbr7MKKN+oobhppssXNq82vokxE/069z79p7Zdg5U4yhlxRrm8P6dDa8fXVs6HZ
         27bg8W9msCiC9TMFPisUY9dkjremlDtKOOrWxmPcj5zegHMhM7nlGua9NSvn9JTtQPb2
         CCEjuD8OiYYUAS/9l7PqOvl5EkbBj5r2Pgub4lDjbUjQ9sLRf7EOX+xzqFVgnbdnSIL8
         Y8XA30HI9btO6tSi5NMyVc7duHVd/gzQBZkq0GY48NM8PHIq983hvMa55lqgpmy+Tgja
         Z7+4y6xTUHWTc6+jhtJ54+aqZfkjit2UQoZ9wAnEoQIMbf+Njac1BbskZ0z5ckKP9hfc
         +llg==
X-Gm-Message-State: AOAM533IWDTy9Yo0Urlpu0ytcrnvuYguQCbC8C8SgtH2zAFDSKSmvgbq
        RLr+uhA3StIzPVO01LXfavBU2h9sEx0=
X-Google-Smtp-Source: ABdhPJwnqkeamsuQVNtNkv9Bmhbv7/JnTverp1AK3C4X63cSptD99DQ/Gx8CdJojGiEXBHX682KHLw==
X-Received: by 2002:a5d:6103:: with SMTP id v3mr17525989wrt.375.1616417487717;
        Mon, 22 Mar 2021 05:51:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h20sm15809785wmp.38.2021.03.22.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:51:25 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:51:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: lifetime of pwm devices
Message-ID: <YFiS31ZPBe+UwHbe@orome.fritz.box>
References: <20210312083449.5htbbr2zgqfxc3wo@pengutronix.de>
 <YEtAdbNA/c/FtVgX@kroah.com>
 <20210312131531.wzstoal33gscr4ws@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dY01IpEK59SU+oST"
Content-Disposition: inline
In-Reply-To: <20210312131531.wzstoal33gscr4ws@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dY01IpEK59SU+oST
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 02:15:31PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Mar 12, 2021 at 11:20:37AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 12, 2021 at 09:34:49AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Now I wonder if it is just harder to trigger such a crash or if the l=
ink
> > > is good enough to cover all corner cases.
> > >=20
> > > I wonder if the pretty approach would be to ensure that the pwmchip's
> > > lifetime is tracked using a struct dev that ensures that the pwmchip
> > > doesn't go away until the consumer releases it. Is there an urge to
> > > address this?
> >=20
> > Preventing user-causable oopses is always good :)
>=20
> The key question is: Is the device link good enough to prevent all the
> nasty things. Or is there an urge to address problems?

Device links were specifically designed to address these problems, so
yes, hopefully they are enough to prevent these issues.

> > The driver model should solve this, if it is used properly, why isn't
> > the pwm layer using a struct device today?
>=20
> I think this isn't used today because the PWM framework hasn't evolved
> enough. I tried to do this already but I don't understand the driver
> core and pwm code good enough yet to be done with that quickly. Ideally
> without changing the uservisible sysfs stuff.

It's not so much that the framework hasn't evolved enough. It's more
that there was never a need for it, so there was never a need to evolve
the framework. It was only until around the time when the need for
device links was discovered that I realized PWM was in the same boat,
but since device links were going to solve this anyway it didn't seem
worth the effort to add a full-blown struct device to the framework.

I recall that I had briefly looked at implementing proper struct device
and the associated reference counting, but once you get into the details
it all gets very tricky real quickly. If I recall correctly the place
where things stalled at the time was that you can't really prevent a
device from being unbound (consider devices on a hotpluggable bus like
USB - we don't have any PWM controller on USB, at least not yet, but any
solution would have to support that use-case, or it wouldn't be any
good). So while you could keep around a struct device reference for each
consumer, you'd still have to figure out how to operate (or rather, not
operate) on the backing devices that have physically disappeared.
Essentially you'd have to refuse every subsystem-level operation on the
objects because the hardware has gone and can no longer be accessed. Any
consumers would also have to learn how to deal with that situation.

That's around the point where I reached out to Greg and Rafael at the
time and Rafael came up with the idea (or had already been working on
it, I don't recall exactly) for device links that would ensure that
consumers would automatically be unbound when one of their resources
goes away. It's a much more elegant solution, in my opinion, because it
is both simpler and can be applied uniformly to a wide range of drivers
and subsystems.

So unless you have a very pressing need that device links don't solve, I
don't think this is a very good use of your time.

Thierry

--dY01IpEK59SU+oST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYkt0ACgkQ3SOs138+
s6Erdw/+P1ywBK7YLgI1dcJe76gad8e1jyNU0i0aVql9l2J9Rehx+7AchLSzuQAj
m1EVlfpWmS08PRa9oPA7PrtSfcYYQVFLfheqfUk4e2Komu8bC6kDbWom/qjJlM/S
tNQ+IFhPM7F1uVhwUgcmPf5wgCwTcBizCzlsjRSN1RFyjROI7vJgyJK0fimr7pqZ
VVgVR8vaoK+StxWTPvDR1DKVSmWUTwLL9cQy6U40x3RasMSkXrKrtez+tnVs2BUA
+XOyEUxGZMDimIGiLnbpDeSzICt4Dx+bZgySSKjAtpgMU357LZ5z7YagdxxrE9D2
ZyEdvhfyKWkazD5hy+KGUkbL5SjDwU/fLvlUzndChSg9AJrPD0fEABmHGakT1YNa
bVGLrEUIrsKUcgXxx9EfwtKpH0mATyriX1HZ5blFpRnrN3yr2awfiizHQVX8+u0d
+A/GL3JLJrVHya2wQUdpbkTqUjF/dsDx4oiMWyFBwqeZ3PlLICrl/TTjYSZyihA3
UpFWu7Qx3gNcIT30s1Oc6/TgU1RF2c5rNqeF4cfmUs5BgOgB0PSq0m5oInJDbXMP
eELd++X+L93knI8/lPokyACw6X7aOZKR9bf2zHtUDF0SuaeK2RpEupTVw1Co+77E
Cr8yjIvCK73MjETUWq3Znd6Ks2SH2dEBnfRMiPz/KI6R5Antiuc=
=M6Ig
-----END PGP SIGNATURE-----

--dY01IpEK59SU+oST--
