Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C07359ED2
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhDIMeR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhDIMeQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:34:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F1C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:34:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so8388275ejy.7
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRmUBvMEhhwcxKMG4LWatGlefBiVuxWL49Va25oh3rw=;
        b=L4/psNox+i53PyTPqlVW+BIoEvhufGn4+qJ8yVdqpG+73E1kte007CfRe71iubl7OK
         ms9SB5u/ZQ+Q+8ANmXBgBmSuZYXgBDWn1wJoZRYie0ktvEcSYUl15iSmQWBDz32bDyed
         9B9b7u4j23q/EA0h1plQHyZGo/mtYdGuTU5HjehtkCIwrSPAfP5ppHm4JRnY76EPras+
         E/oVS7bFuUwtF0F/x1ZJxZJkvlPau/MWjCUJsf9l/2DNOqUdpCnjuk1G1Ftusc/AVy0n
         VqgrY/p3A2PANPXbUOsxZFDEImDsGYsvtSBYEy8ej4bpWv/I1+z7B/HVajH5o7KhpQh8
         e+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRmUBvMEhhwcxKMG4LWatGlefBiVuxWL49Va25oh3rw=;
        b=HrsNGBUPEFweGwOlxnaBva+L18HLDP/noHQ0eyXgLZrXEs20KLS0aRet6VdC1CPFU6
         gAwI8oybRP+4LcZwh24wTdBdKK5okE6HzRRM/J0RWAKkpOuPNbw3lYinpbLTa3jXkyz7
         xqDKiyEwR4U2UilCkDr8TkEAkTj3+114InjCvWzu49e2bmaqd4t5BKrSZCb9HkyUX0lS
         FlmbATebNb4Q+tD5L4czTspaFnlrhnLITC4a0YpxXkU5mUx3gqe8WaBXvpDCWsWuj7rV
         C8R5IXnTdJFDMSPNfn99fBFtYUEuHFe3F4RH5KTcJDvn+L5wtv/GvMMHxi/PPGTXZGcN
         8iaw==
X-Gm-Message-State: AOAM530oGI1D7o31m348MRtaDc11FL0bAyJ7QkiSKkcxaRHiQcOnoy4K
        +x08hBTEBcu5tI034xskTKc=
X-Google-Smtp-Source: ABdhPJyJyErqz0V7q/8mAMoXbn/4p0PYzEBmdNQ/0Ff7S49K0ibRvjqjUDM47I1tpM7jNR0YrIkYtQ==
X-Received: by 2002:a17:906:c45a:: with SMTP id ck26mr15761255ejb.125.1617971641888;
        Fri, 09 Apr 2021 05:34:01 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id k8sm1367066edr.75.2021.04.09.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:34:00 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:34:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] pwm: bcm2835: Free resources only after pwmchip_remove()
Message-ID: <YHBJ3VORidL5HI8q@orome.fritz.box>
References: <20210325082931.81774-1-u.kleine-koenig@pengutronix.de>
 <d16b2937-a697-56e7-5c66-37839253d7c1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fZxrLXij7Eda29gC"
Content-Disposition: inline
In-Reply-To: <d16b2937-a697-56e7-5c66-37839253d7c1@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fZxrLXij7Eda29gC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2021 at 03:37:14PM -0700, Florian Fainelli wrote:
>=20
>=20
> On 3/25/2021 1:29 AM, Uwe Kleine-K=C3=B6nig wrote:
> > Before pwmchip_remove() returns the PWM is expected to be functional. So
> > remove the pwmchip before disabling the clock.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Similar to your pwm-bcm-iproc.c change, I would be inclined to add a:
>=20
> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
>=20
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I think unless this causes an actual problem, which I've never heard of,
there's little sense in having this backported all the way back.

Thierry

--fZxrLXij7Eda29gC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwSdwACgkQ3SOs138+
s6HCnQ//RaL2LKDQfrnzfCX23iZlu/2nlkTBT1+vsWbQYC6+eMDux+te+YODEnvc
6uGeLx3ZdT8C5F3OJS4Lqug9vfms7qt3nddfo/unM011aFRR9h3+/ayAHRKKyaS8
G2DWXpWnO9TEmBf3EdWXh6fmEm15SD1556zO0U6vR79ctC/85U6R25K3XmXfXFmv
rcV6KZ99sdL3a5AuAPQLrP7Rlqk+fx1qvbM6SkyyBW8x1Pr+iZQHmcwqJ1X5pjrd
qNh3vF4YerTskuerH9KBKZNSkBYPRH4DreXHgYV/x4XaDGKA+AWtbUSlgsEIhSTT
0l8FkmS/KF3gN2Ja0/rN1aw5YPCjbfENRPsu38rBAVBlUulIXaR0Ten2/gXcZLgs
Sl2TaSkcRfJiuYQ2ECNa5Ss83xODgvQg7X6g2H7ZyQfcqet0tFNhIRwE0+ps76fM
YDekwkreWanjkx/pO7k9mdr/r/m5NAwHAjUZ1VrxJ8uHKYTAswVxWV/akJAVVTIB
V65uaVbSAUopzGJk2I1m0vCbVfGk+3Y1MMYjRr39stJ4wv4CNOMxz5bt5g/Yj018
dORKMSlCQ1saJgHkllPcrEF9+Iuzzh8HRzl1HLLpQn/I7wTfbuAOJibNG7cORqhQ
gwNdisFMLP+JF8VdT7vA5yvAgr40K1ewKJ9gXtctKVw2xin7eG8=
=oiaV
-----END PGP SIGNATURE-----

--fZxrLXij7Eda29gC--
