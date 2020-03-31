Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535E019A025
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCaUtj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 16:49:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUtj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 16:49:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id j19so4539598wmi.2;
        Tue, 31 Mar 2020 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2GGUtuqPV80x5b5ujQqCYnpRIHjyJKm9Pub6eW25UY=;
        b=KgNI6YSOTCOMSyctOP/WId8uQxhFnY81WYm/UyoylUkWXdRWYswu073xDZ/VJvuYkC
         ZRmPLPqvJh1uH7Wj9r3B36fh0oPexN2HByev8izzhSzaYLrJewWUi4WXii/9rfydQwOy
         EfeomR0eDDw+wXcV03aJXHz8NxVp0FR9M99MP9YBmvM8ZpaKsziRrtVKtQ3h4nCOY5wy
         ml0/Pr5roUkxLdacGfvDDElt+vwG/Vcx+t1U057WMzW4qii9/nfXeP1p9SMai/IbCo78
         FuzbnZEVQek52TIj32M2AbY0NRhSmjU1NbzO0qxAKiaiOLqmF+F94Z+80Meh2j6uVr3Z
         c+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2GGUtuqPV80x5b5ujQqCYnpRIHjyJKm9Pub6eW25UY=;
        b=YI7lTGyK9hxgokJSbOqYn3YcyVcw50XEoGUMudcxFO1VbhrmJDA7kgp5jDB5yfaex0
         +zGd3qK42LSojVtIY0AM4IuIpsPb59NOLxMkdl1BJBhXHO9bNDxbzNvDTShiZiP77DLu
         D4PQ+M3vzlnbwgVMLWVRuj1jwaRf9wsGRWKLWmhyHRnd6cmXbVrWe4NATMrfjZacuSDj
         0HTQ1NYvCaBvrPEMp7NwWLnocMEcfeCCG5P8A6v5NX9XLE8n4KtwVR63NhAUZyd3ty6L
         zqfGXH+ovstPFqWlJCZrS29hTGBscBaOYGILHs2UaH/epypVF9eyNkNsj7bK2sXLHdWO
         jd0g==
X-Gm-Message-State: AGi0Pub4nvAHDwxSoZ4p77cxemI27385THufKw4t/VzFKx81ch+uKtUv
        FSg+yoQFzQfQMh+LSHQPLbs=
X-Google-Smtp-Source: APiQypKFgpXradD7Y/oeeIl8Qd75lgtfcDe3ZaaJBMJFR1mcRlrBcuch5uNeJOFa1ZvxT9koqqvepg==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr733124wmd.8.1585687775099;
        Tue, 31 Mar 2020 13:49:35 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id r3sm28241814wrm.35.2020.03.31.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:49:30 -0700 (PDT)
Date:   Tue, 31 Mar 2020 22:49:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and
 function
Message-ID: <20200331204929.GC2954599@ulmo>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org>
 <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20200331202058.GB25781@codeaurora.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 01:20:58PM -0700, Guru Das Srinagesh wrote:
> On Tue, Mar 31, 2020 at 05:24:52PM +0200, Arnd Bergmann wrote:
> > On Mon, Mar 30, 2020 at 10:44 PM Guru Das Srinagesh
> > <gurus@codeaurora.org> wrote:
> > >
> > > On Fri, Mar 20, 2020 at 06:09:39PM +0100, Arnd Bergmann wrote:
> > > > On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeauror=
a.org> wrote:
> > > >
> > > > > @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> > > > >
> > > > >         period_cycles /=3D prescale;
> > > > >         c =3D (unsigned long long)period_cycles * state->duty_cyc=
le;
> > > > > -       do_div(c, state->period);
> > > > > -       duty_cycles =3D c;
> > > > > +       duty_cycles =3D div64_u64(c, state->period);
> > > > >
> > > >
> > > > This change looks fine, but I wonder if the code directly above it
> > > >
> > > >         c =3D clk_get_rate(imx->clk_per);
> > > >         c *=3D state->period;
> > > >         do_div(c, 1000000000);
> > > >         period_cycles =3D c;
> > > >
> > > > might run into an overflow when both the clock rate and the period
> > > > are large numbers.
> > >
> > > Hmm. Seems to me like addressing this would be outside the scope of t=
his
> > > patch series.
> >=20
> > I think it should be part of the same series, addressing bugs that
> > were introduced
> > by the change to 64-bit period. If it's not getting fixed along with
> > the other regressions,
> > I fear nobody is going to go back and fix it later.
>=20
> Makes sense, I agree. Would this be an acceptable fix?
>=20
> Instead of multiplying c and state->period first and then dividing by
> 10^9, first divide state->period by 10^9 and then multiply the quotient
> of that division with c and assign it to period_cycles. Like so:
>=20
> 	c =3D clk_get_rate(imx->clk_per);
> 	c *=3D div_u64(state->period, 1000000000);
> 	period_cycles =3D c;
>=20
> This should take care of overflow not happening because state->period is
> converted from nanoseconds to seconds early on and so becomes a small
> number.

Doesn't that mean that anything below a 1 second period will be clamped
to just 0?

Thierry

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DrNkACgkQ3SOs138+
s6F2rRAArLSEhXAhgvFqFz7p1Jyl3a2QkW2gk0K5vu5cqJQzOMB/CGTnJlkpte4r
OPEsS/IrnNJjMNvLMLZQ/92OqmWdK1ve0y8aFlhLAhGn5KdelcOcnf8Id/rxV2YJ
BV7oMSVS9dZa5+gNJaFARNkYs+5dWAFQoKKvSxpaTMBMMMzN9TgoKZKa0W7xZQmh
CbJve7ZWx/MsubZTneoudgf3Vi+SYak6kFEHhw/rqE9lFWb5pfKXwyVxpPHqW0uk
ooJ1g5VkQxKPnaUtz3N2EK4+K4gUlh87myfPiH0k35FCJ9N+ENOIe9vtepJ33+u9
UFD/GJUtPimSBDHKAcZyc0Gtvw4Cka4dmDeAgIMe+QviRjEd/pvI4MS+s8KCAYKk
kn4AG2KDeC0w5bufJQnlXuziYw95gUYQ2nrRPFgI0yJMtdwvd+Pch5skoklz6GSZ
2Q7Ao5wGRoRpV/cXb28lBNOgD4w0R1upufK/7I4lSwTRMBWXzBK57ItEXfeTO7V7
2HEiAXYXt6oqM27RxedshqKGe9d5gwvdGLIy6NjfnQkJ4QySu13nLTas4yPlz3Lx
ZTv+Cl8EElQnC7n2erxOjTcCPQaM14MslHRFhk+wtacQ3+Escb2lPndAzD8lQinS
ncFajYcMWrIYy3l0rK0o6juMpEqV2vxl7Y8x04xvV/vr88q9OKY=
=Ht11
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
