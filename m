Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336A4447F51
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 13:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhKHMMc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 07:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbhKHMMc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 07:12:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B132C061570
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 04:09:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s13so26493875wrb.3
        for <linux-pwm@vger.kernel.org>; Mon, 08 Nov 2021 04:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DOXyyD2rqyjGZNde5lYZu67VLsff2gCxf01W7VyHPqE=;
        b=In4l2KS0k0/gF+x3tv+2qIOm0mYKrIPYHACREAVuViL14wmtyBsAgUWHjr27FaEgnc
         KnzjHTLFIBT/a+SKcXIHiivUh180/FXhq72PitLsPKDWNlrhnJ5aENwZz7P3k1N2JVX8
         M4acJOkUXKyDrbLDs//w4Lb4Z3ISQHHmNkB+2qK1g6iFr6X0JXje8ojCR/cDNA3J2uXz
         zMwqVWONHEjFKhD7zhiaZCLJAifbrD8zutICnoVyWhGzFKirjeLlEYTktIqWTUoZOT77
         XaXoV0fjPPJUpmIoPbBJYKFvxIWyK93xrpqcqUsRzUoRTCjht0aT2QyvohU/jiT9HJVS
         PbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOXyyD2rqyjGZNde5lYZu67VLsff2gCxf01W7VyHPqE=;
        b=qEKsbg9i3rdU6RSOzD1hn5yUf5aoupydxnmLyV5wusj/Gs9dYWp5lPU/C4NaEwzxBv
         VU0u2WuQ2xo85TnY0s977YUxSKTTepba+oeujN0Y7Pv5B5mKr/f/4Qb7kNeLulvzw/dh
         Ify+az3r9HJN2C1EcUqyYufJmwC+azQhUnKEy7BKLX0dML1Zmp/5xpSS2FRc/Xr31bfD
         vZ+82BPLi8ejx4lgqZLaPq7ctRXC49fStiKPbAVERKAJ96NEKfbGwx8u78WolEI/VBBJ
         8pzE7jDS7YdKCeaMC7XDXMLn0TJxSDp3Gs9wu17a1vzGa9gFGs31liz+yam4JXdzlWmH
         z63w==
X-Gm-Message-State: AOAM532UxLBFpWf6+Oc8ZNFAo6TJcWM5vAK6O6wLk6/M28rAUKE32RaB
        YZBhxc9BWIEl8APoTq7UtqWiFAaXstPx/w==
X-Google-Smtp-Source: ABdhPJwD1PC55FEoOIvtcNwVJ5W0xOXX23rx0rHNVxVc/e2CWLT78WAyf+ehzYhvTIxpcwQxxTc7Eg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr70330982wrn.421.1636373386803;
        Mon, 08 Nov 2021 04:09:46 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id f18sm16423823wre.7.2021.11.08.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:09:45 -0800 (PST)
Date:   Mon, 8 Nov 2021 13:09:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 2/4] pwm: berlin: Put channel config into driver data
Message-ID: <YYkThshvvjq06KNU@orome.fritz.box>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
 <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TjfxxWl3vh+vZciA"
Content-Disposition: inline
In-Reply-To: <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TjfxxWl3vh+vZciA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 04, 2021 at 03:25:35PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Instead of allocating extra data in .request() provide the needed memory
> in struct berlin_pwm_chip. This reduces the number of allocations. A side
> effect is that on suspend and resume the state for all four channels is
> always saved and restored. This is easier (and probably quicker) than
> looking up the matching pwm_device and checking its PWMF_REQUESTED bit.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-berlin.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)

This doesn't look like a worthwhile change to me. The per-PWM channel
data was originally introduced to support exactly this type of use-case,
so I don't see why we shouldn't keep using it here.

Thierry

--TjfxxWl3vh+vZciA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGJE4YACgkQ3SOs138+
s6EihhAAoixle/yHz7/UIZKx8/U/FHRD6+/6iHXc2W/jVDK6gPwBsaldj4uJ5yjz
BB4i/GO/mOf1eXSY70z0waElo+j629T33nrNHibJ+IvO5LRvwYKlWdx92cHq18oA
eFgoIjr0vo4Y8GpVRZuB1rlFZw6R68wbT5UMM7l8U7k3xPpbGeImhILZhWwWniOa
9PgBuWs6t6BtIen4Aco0guegPO78x/imyPOp6AQ/ek2H05UQih00USWPaM9reOAi
Qd+RFPXsy/VZaGoUU93MxnssBFI24X6AO8iOvxa7VXC1nn2s/LqSQKbSLG3AzaLS
VlteUEetY3E1/BTAqpr98E/9T7ZwMhNMqzqkF3YOlcabiKB9H8TCxThI4Yty8eeH
tHVyRWmYrY5CwhkiwPhknRXbswCDjSszgJO3I3lwO2i9mcnD8Rg1qDosNWe3xZ4k
zgx2DFjsZ16MfYAIIcyeythhjWNEjULwFksAMhDKFZGWZfRGBRrL268tgPpMtl/Y
k/eqI7HpQ+KgGandD7KbOHDL4UsRgVTsm/CTRwZn7+1Uvxu5+7WbC9glDb65NDFA
/IjpQO8iVxyOuPBfDgh7FrfsAMqTvXwR+hXp2InAzZPtT1+nIHe5w5DJtCquDXXX
lO+A5Jk1aE+8gHgXNqBfS8FZkKr3pk9ERbGjdkAdcPbX/g4OR04=
=vFMo
-----END PGP SIGNATURE-----

--TjfxxWl3vh+vZciA--
