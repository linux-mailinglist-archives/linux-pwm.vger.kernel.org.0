Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA9343FAD
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCVL1Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCVL06 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:26:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12927C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:26:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e9so16278823wrw.10
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvUcX8KKjwEnsf+aatkUOlpJG/JfjrfXRMJ3uXeNzuo=;
        b=T5pYBShn1HeeeSCi1WjXWvRnDahYuhj4FdplYGzNBi6iq0bEZV8jiiv/1ZpBI/OAny
         w2quKR6gmQ/BNB29BEukHSZ/tOqD3eAVl5Go/Y4oHCptHVmO1+fumMr4tBuZnOAO68pz
         JEbfMXu+msuneZ9xtfd+yZD6k6ZDlTis+3abF5H9Mf5fVFL9YnYfbMBuoFogdKg5jyM4
         GNAlgB2GAE3VKyhMrdm59gs1ThUrMuCmMxNBKETC9aG3hJD/NdxHYACT3zX7YH2QKsxI
         DSsFPMbBgvHkPSJVrHa0gF5SeD/B+cMqijzMVZCnd6G4jOMOV9yMic0DGhB/g5bG/aD/
         ICVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvUcX8KKjwEnsf+aatkUOlpJG/JfjrfXRMJ3uXeNzuo=;
        b=BLXZn1qr2YC/8xe3OidkbkA2YO5jtQ0Kv+hA/Txp68cxp+C3BXYlJrPeNSdpRK0IEH
         hyWe0TlSuuTudPChuO09WWYyATSFJ1mGf9Fn46bXVB5bmqljwm0nwEuU2BpedmPMOneM
         emnzOSNw1s3QWhrJlSXg7z/L84OGBUTrJ+FVLIfHlSkZYZkFuVHPGfDzkngrQJFR6xII
         EMZkG4KDV66E0g/ZmGSq2VJQjSi/f8Pmm4/VmxAKc5JFxVRhBY1qPz/8Y/XFKefLXydw
         G3PkVBFv7tlnA7p56+1TQh5UcYLkaAceh/skRILthAWh0sz1vNcMs03g884ycOmGg/Kd
         Atmw==
X-Gm-Message-State: AOAM533ZYfizkY9AzLNtOiJhhE+z3jk7Ee7HcUFKuOcFcK9Gu+iOD6AN
        /fzTIIoVdOpPZPu3tDcuc3k0qORLs3s=
X-Google-Smtp-Source: ABdhPJyGUQKMs8AQjQa8KQQUuR0e+hm5KEJqiqpPqVF3V2xKeMEoLVcPzyEBd5trcaf+8OpWa4Xh7w==
X-Received: by 2002:adf:a4d0:: with SMTP id h16mr17585112wrb.52.1616412413845;
        Mon, 22 Mar 2021 04:26:53 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id k24sm15911184wmr.48.2021.03.22.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:26:52 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:27:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: bcm-kona: Use pwmchip_add() instead of
 pwmchip_add_with_polarity()
Message-ID: <YFh/Dt/g76bjHmm5@orome.fritz.box>
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
 <20201207134556.25217-2-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2F6o+NWTqpj/7iET"
Content-Disposition: inline
In-Reply-To: <20201207134556.25217-2-uwe@kleine-koenig.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2F6o+NWTqpj/7iET
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 02:45:54PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The only side effect of this change is that pwm->state.polarity is
> initialized to PWM_POLARITY_NORMAL instead of PWM_POLARITY_INVERSED.
> However all other members of pwm->state are uninitialized and consumers
> are expected to provide the right polarity (either by setting it explicit=
ly
> or by using a helper like pwm_init_state() that overwrites .polarity
> anyhow with a value independent of the initial value).
>=20
> The eventual goal is to remove pwmchip_add_with_polarity() and so simplify
> the data flow in the PWM core.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I was initially reluctant to apply this because the purpose of this API
was to mark chips as deviating from the default polarity. That is to say
that this chip's default is to produce an inversed PWM. However, I see
that the driver already deals with that properly during ->apply(), so
there is no reason for this to stay around.

The details are now a bit blurry, but I think initially the idea had
been to let the core handle this in some way (e.g. by rejecting a
polarity setting if ->set_polarity() wasn't implemented and the polarity
was not INVERSED for chips like this), but that's not happening in
practice.

Going forward this should all be dealt with at the driver level. Drivers
that support both polarities should just program them appropriately and
drivers that support only one should flat out refuse to set the other
one. One potential issue is for drivers that will use "normal" polarity
by default, but will work fine with "inverse" polarity (and,
correspondingly, an inverted duty-cycle/period ratio). I guess for those
they could always try with "normal" polarity and if that fails retry
with an inverted polarity and invert duty-cycle/period ratio.

Applied, thanks.

Thierry

--2F6o+NWTqpj/7iET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYfwcACgkQ3SOs138+
s6EC7Q/+NxU4BGomeTm2oZueyh/b1v2meOEh+rsyOqxO9Jjkys8pd/18VFgX0b4j
pLQCjQSW6ApiO6ANKcI29KU6e7WPXEXv6ic4KfXu20OF8OfFWmid23N5ZsDwTD1D
uwQU0FD6iF+y0hCJUYK7n5QguQZ3ukSw3/8ve80P8nlSzDniqfTa2gsM2/GLFQLy
aukkUWcDDwZARV5PwdlImg5yv0O2nQoVzpgzZ/2rtjbTr8B1SVyv7dMn34l3VC1N
gq/H4FYAZl+ZbQdr+/pLrUhzLZ2Ecw4BUfiwUrnJgyyr/gz8+LvIhJH7jC0YVZay
FOerCVM0PQ6JkvJdwHcviv9mned0wiEfG+kO1ZHjgQwdtJf2ylLuSwDT2d46zwzm
1v49xyBKZXy9fI3b8r4RM7LEm7VRiWYVK2p2BhnD0uGnb1R2/TgfpCyI+91inOZv
MPR4BcEEck4mS8a67j3FfnV5tS9NzE9GoyFgX4S7GbsL5+smSoJCb5oXPQHGViL1
448SiSAHz4w8OWVFhpLR/nwEzRcjKD+jtLgrupKz2Glgra/O+J/rMRFiayyIgeN1
Dy/AG2lBBLSP3Q59OWVuDmpSWEaM7G/EZHVk6Orri8mFHw/xB15NNOrBDBZDPgTG
1SDHAXJu9WYgOCE4uYIqy19m7hi6eFg6CMWkMwOzrsb0t0l2/WY=
=NZaM
-----END PGP SIGNATURE-----

--2F6o+NWTqpj/7iET--
