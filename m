Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964D4DEF75
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJUO1G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 10:27:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44788 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfJUO1G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 10:27:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so14237623wrl.11
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EKfyviuwtYSJdmsCBb+wvwCGeQAhWC2hus8KbAxcTNI=;
        b=YqkyRoJSprVdZpPMar7wpiO9HIkufiK+6T/OiI/q2BIAv4Qof79a23My1uXOMjvT3g
         hYstfMYYow9cyRbR2/waBZFJckmsnXQ6k/RvRC7jB6yNn9hC1CVotCxEmAR5ueyCjhy9
         sVn8j0OAqsDr5kdomPRgG2qz21H66DOzYgI05Z8F9eKXspMHDAIWA1C/lHAzi3ZTx6NS
         ZBvbDnWNr4FkxdpP7DKj7kWKLrj9aQJaPbEauEdd2OprihDpNOeMNaSGQcVYTHZt2xR7
         IHZI1VjP+GqyBL4l4wDAEd6xauuO1KCkbfkhLL6iveATbCoyD+ionq0bU+1HwgQI7IjV
         CrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EKfyviuwtYSJdmsCBb+wvwCGeQAhWC2hus8KbAxcTNI=;
        b=TUR08NAyitICcch01G5kQwUaczNWSXtXWI8fa809EXC9xHoIVHbzql/YF438Itm0Y3
         SBIg9q9Q5cuQuThqOUKL+4+PT5eefsjwqFJULKsHn/Hzc4agiTpx6a6tM1PNdruuzUXL
         DPSP07wVIWErgo1rpv38gmDTd94UejiDvchI8LC4Px+Eb0vu0S15dMW+DOvLCfETelqL
         ssYovyitf4vkBEHDb26DG09Y6GoQct1QSdTgyTqhubQQ7p2xzfoprJ/NrGtBrsdqEUjg
         uNE5HZFxzubOGDQ87tuzL/xuku4D6y/aplSdwyt0m6EXZPD5MFfpkphgj6eyibfo/762
         JHAA==
X-Gm-Message-State: APjAAAWF7sN/avyRw3q42UEm69dLo/O7uqkkl6a55bPNHMY8V6BlagiM
        vPUPKAiW7f1m83M4UcyvO4c=
X-Google-Smtp-Source: APXvYqyz0+cwEe+wdzKlNOb89ggmmPTfYOQes/sUikSVmHy8nU9qL06JrIMdHuZo3zmlAN1EsCYc7Q==
X-Received: by 2002:adf:d1aa:: with SMTP id w10mr4017615wrc.127.1571668023966;
        Mon, 21 Oct 2019 07:27:03 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id z125sm21269134wme.37.2019.10.21.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:27:02 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:27:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: Read initial hardware state at request time
Message-ID: <20191021142701.GB1476994@ulmo>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021111112.n24kme2va6net7g3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20191021111112.n24kme2va6net7g3@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 01:11:12PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Oct 21, 2019 at 12:57:36PM +0200, Thierry Reding wrote:
> > The PWM core doesn't need to know about the hardware state of a PWM
> > unless there is a user for it. Defer initial hardware readout until
> > a PWM is requested.
>=20
> A side effect is that for an unused PWM the get_state callback is never
> called (which is good), in return it is called more than once if the PWM
> is requested more often (which is bearable).

You can't request a PWM more than once. PWMs are always exclusive to a
single driver. Now I suppose you could have a single driver request it
multiple times (that driver would then also have to release it before
requesting it again), but I think it's reasonable for the subsystem to
query the hardware state everytime before a PWM is handed to a consumer.
The hardware state could have changed between the time where a consumer
releases the PWM and another requests it.

>=20
> > As a side-effect, this allows the ->get_state() callback to rely on
> > per-PWM data.
>=20
> Given that this is the motivation for your change I'd give more stress
> to this part of the commit log. Also I think this could be more
> understandable if you point out that the effect is that .get_state is
> only called after .request was called successfully which gives the low
> level driver more freedom by (for example) relying on memory allocated
> there.

Isn't that pretty much already in the above commit message just with
different words? I can try to reword this in a different way if that
makes you happier.

> I assume you target the next merge window for this change?

Yes. I'm not sure yet about the remainder of the series. Depending on
what we decide to do about drivers that can't (or don't want to) write
all state through to the hardware, patches 2-4 may become moot.

Thierry

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2twDUACgkQ3SOs138+
s6FE/A//WLGShPijQImzdd+J5VI6y4yoMor5q0yxH+wpGAdrn/xpCP/4DE5Qsvfg
hBatD1ufGpLwsRIsBj1RuCRYFyQiJyrZuzP5Hc3suEQ2/IvVVeRJGIf6b39fZIW1
Eg9C4K6yqZSZLhS2ELAHXN/6uW8NeGeyVztj+TPU0EMTV1TUiFdgOlIOXtbRX8XN
QFSQJMTPLpxGEfqkZJdUhFVy20/TE7WcKWPc+pfIQO+iPe/Ugv8HESMx7272yOpv
VrbX/VX6BMMHBbPVOfdJ8lvjKZ4+hyV5bAFNlSo34jzzYX95/qFMtiMqTt1chfB2
K0pq98geOlwxEIGsYW++pPTKJjKIOd/n+IdZ0IdeW01DYmRtagJa8U8oTPEXCPfM
RMjpLdnuqIcxwFP33wERBowVuRWN7NasIZVon3OlnA8b6wk2fvVGvnYXvheJromb
n77uIAB2V2y/gCkM8ZZuG1dxE4wfZbwNuesuGVq9zKySOhgvmsr9/ULDitO107zt
U7VE3wAs97t7yBKpWCuB3qPmD4+d7jY2Yz7Jbr2/1MzGwLQ9g4kNj6qJ+ZW5bn40
Ecpp07Kufk3XR8HpWkWb76PiRlGQT7cvidAJy/X66Sm7ahuDLBJQeEDGpdFrVRUv
3qf69Gq/dmEqKD7JeX4s48cgzeBV5o9IWt+5+bdF1+DtfFGZt5c=
=QR6c
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
