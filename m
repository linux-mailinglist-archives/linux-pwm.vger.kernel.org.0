Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20207199FCC
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgCaUKU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 16:10:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52626 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgCaUKT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 16:10:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id t8so575523wmi.2;
        Tue, 31 Mar 2020 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ImEIaV3nXuK6yquJu5EukWx7JhTMru+TXwYXIQyAaI=;
        b=E99eDqdY4HJGId13EKiYbpscE70iR0/OVbLNeuthXDg+Ohbo2KcDauSJWxb0ASyQVv
         pYtqeU24eUsVwyzRPse4B/iCch2Uk9Y2SgI4Urh/RqfciqNNJz5AAtNXjBb+O+yrWJ6n
         bgO8T3NBS3UUQ4W0W5Yma8lcQAgrKjzdJd6kAaRhhEd3taqRjHXaeFGY7CGu/qRIm4fS
         CkdIntsYlG7ZeuCFx7F497Cg6xjaEv7c1TW3+rAaY40LzE5GnDeNjFKdoF1lF65yy4FC
         DQOzN0AmTrCs8/iKrv5BoJ2QUvZTPDuBfqL4xq54WOFRzvOUeBfPrWOIYZ/0u6oAtGT3
         oEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ImEIaV3nXuK6yquJu5EukWx7JhTMru+TXwYXIQyAaI=;
        b=hBgt/p88NmAwj2H0O4K9CXBSIWZfmp0jZX8zFihdWy+RGDUA/RQ4QkFe6AQ1ZWO6IB
         F1Xmc7mzxtxvmc126x6zEZf+BSDSHP0TIn7aitaK3dntbkD9G7VtlZF7IFe/rkuZBENl
         5ZRSVfc9nfZvFoT3OaNfNRmuBw9Aglljsc90up6p9Kyef/U0A19Y49w+f9HB7mZGErZm
         jG0Udq6vcsi2JDGk3JeKP7YbkDOv4Lh69vLxv3VwVU8Pyt5XeyBHikTfVSOGuMbEFIY2
         h1pK6e+j/c3FuOBCvm+MzoVc57pFrrWmsbyXurQOuUpz9B3jVxJOSAkTXcPyf/2v/YEJ
         KRZg==
X-Gm-Message-State: AGi0Pub4jO/GqjgiPhtQRvjgG7JTscOrGXrvsnd5I/YA3cxIgMyablVV
        rDs65gMYBWKdMO1e/BRlnKA=
X-Google-Smtp-Source: APiQypIXhVEBSl058ScHcaAUhfncpA1Z+DlZ2N/DTT5Emn6Kqlx3gbOH/lW9gKvpR8ZCm0MkBthHrg==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr565380wmf.130.1585685416991;
        Tue, 31 Mar 2020 13:10:16 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id w9sm30494935wrk.18.2020.03.31.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:10:15 -0700 (PDT)
Date:   Tue, 31 Mar 2020 22:10:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200331201014.GA2954599@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <638d7136-6a74-8069-5331-b2248c948ed4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <638d7136-6a74-8069-5331-b2248c948ed4@ti.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 08:59:47PM +0530, Lokesh Vutla wrote:
> Hi Thierry,
>=20
> On 30/03/20 7:44 PM, Thierry Reding wrote:
> > On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> >> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> >>> Only the Timer control register(TCLR) cannot be updated when the timer
> >>> is running. Registers like Counter register(TCRR), loader register(TL=
DR),
> >>> match register(TMAR) can be updated when the counter is running. Since
> >>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> >>> timer for period/duty_cycle update.
> >>
> >> I'm not sure what is sensible here. Stopping the PWM for a short period
> >> is bad, but maybe emitting a wrong period isn't better. You can however
> >> optimise it if only one of period or duty_cycle changes.
> >>
> >> @Thierry, what is your position here? I tend to say a short stop is
> >> preferable.
> >=20
> > It's not clear to me from the above description how exactly the device
> > behaves, but I suspect that it may latch the values in those registers
> > and only update the actual signal output once a period has finished. I
> > know of a couple of other devices that do that, so it wouldn't be
> > surprising.
> >=20
> > Even if that was not the case, I think this is just the kind of thing
> > that we have to live with. Sometimes it just isn't possible to have all
> > supported devices adhere strictly to an API. So I think the best we can
> > do is have an API that loosely defines what's supposed to happen and
> > make a best effort to implement those semantics. If a device deviates
> > slightly from those expectations, we can always cross fingers and hope
> > that things still work. And it looks like they are.
> >=20
> > So I think if Lokesh and Tony agree that this is the right thing to do
> > and have verified that things still work after this, that's about as
> > good as it's going to get.
>=20
> Yes this is needed especially in the use-case[0] that I am trying to enab=
le
> using PWM. In this case PWM cannot be stopped in between and needs to be =
updated
> dynamically. Also hardware doesn't provide any restrictions on updating t=
he
> period. So IMHO, this might be the right thing to do.
>=20
> Tony did provide tested-by and I measured PWM signals on scope with these
> changes. Let me know if any thing else is required?
>=20
> [0] https://sourceforge.net/p/linuxptp/mailman/message/36943248/

=46rom you measurements, can you tell whether or not the signal actually
gets updated in the middle of a period, or does it only get updated at
the end of a full period?

Does the reference manual document this?

Thierry

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6Do6YACgkQ3SOs138+
s6GpWw/9En4Lm+RFouT2oX8bU3PqB2/Osqii7EKJN3vMtai+xafLPW9dtxA4SKqv
+YwY883PKm0oRZZIdXu7Ul+3d01c+oMD4BA6DqQkUbi9UUd4an+Dk+lYLsy6iIjc
4xx2ntB7GD5zpNXBqMJuU91nQ5bDiaKhp7UuwE+unO4QslHephbnyV5QGxWAUEOC
FP+f8WBPIm/xmwNGWkgVVOrmWDPptJFLSL0j0nBGB4En9Gm7hAaNnVPJUNUeuUE2
iNBV27uNrREKX6zUumZvTWzSABA8Cx6zd8/nA2Hra+PO2LmmDfdpl3dKqZDXuu8b
luR+Cm0DFXpAC+3xuTD50pYqN0fWB5POvXvqBb3eZxpXd8z8vAdypgvmJi/gqb4P
8jPgMdkeO/6ilLphZMLfyvl1AfcBp5XtZ0V70Uj75mC6MgOZAvbVqcRAT2U4ZGnn
HI1YY8Ae/QfVqZetuK4sjIrt9h4a60RZ45CFX/+2uAo1imzYHItsk+9NtWSxr2nh
DrzNK5RW6MfRPfyRMNhpcsbOH0wHuHAhFCDjNSzRpYmXc4C4qb1JFnkzbZng+XP+
KcYJ1mDsJ1IfU9+mGVowb5QDPb4xo9mfn4TIqNzN0nBLFYInI/bGEz2gRtdfAT+X
BBimFPPVbr1udSQJGTJ7Ei9wh89lmBdKW39XnVvsjI0407anivQ=
=SKaG
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
