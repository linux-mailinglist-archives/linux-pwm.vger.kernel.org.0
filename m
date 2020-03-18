Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C359818A8F1
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 00:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCRXG1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 19:06:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32810 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCRXG1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 19:06:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id r7so3437816wmg.0;
        Wed, 18 Mar 2020 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eXqEATx1cHCE6b1YUNmz27V8QulAkcDr6NsFEVWEUTs=;
        b=I6fd3oWk7eCeslO37Pf3NgBc40F0lpZdb8bFpohRDG+92ohbjxeemlC6tnQY68z7W0
         +iwvd9O8KbJbFl/2cWf/ihcaGZPimfCYtFl1Uvlioh/B2o3FuZz0pX2BEyi/B+end7+s
         3K0dRLTdskv1kij93NliSjpQDJp0yXVRjTD/bcZ6KoAd60Fs7Erk+5zSmpZ36FVfwkHK
         9wMv3YWk/NVyjHli6KBwgRJ4ePhEBCW4EWbrWqGENyyzRGntlE5yMT4/r5V16RZkZWH/
         ChiHdr/YJT2OKsn0rWhI3iLxI+peaT6i3NmhDk8s1STyhmxyra6xn5lN8mx8chYicJRk
         PRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eXqEATx1cHCE6b1YUNmz27V8QulAkcDr6NsFEVWEUTs=;
        b=S1ZnSZb0T3LFdOgrCyGsdf6qedUdNR8SzChvurdJXz/4ucw5//9MgS7balorurl5Or
         Rmbj4xJ4RWhPt0zMWWD3sW6A2F/pLiA99rgCDoIZAcZ3OpEipRs7TyG9xOOqTjIoenBo
         UjFpsGwx9ZvH3rt0nYzK4yY3/LJ5+EHLCzYaQUw6Q0bChg5ZZrRF5AGr5vZClze0CXxo
         m13RyTtNti/nsRuQz4WV10omjC72fKrpLqMlk2yBgxwvgTcN4jCrxokiGlIPcI0+EvsY
         Yy+2Gzvr9+5BOpWfKy0hrjUafYG6t2xRh4h1DI0yFVFjX0ygis+V2ORVrSOFaZzICfOi
         vdOA==
X-Gm-Message-State: ANhLgQ10vOiObwPBHQLFfqN2AZ5N3Y7vwrSNyeuH3nrbM4oh5ay//svh
        oRgRt3E9ewq6vh6+xy7vZfI=
X-Google-Smtp-Source: ADFU+vt/J0MYwlO9CPUQgByfWWXH5b7TgrL+z3Wh4tAoRPqpG7gQho9plNNs3gagJ7PuIsG9jNVx7Q==
X-Received: by 2002:a1c:b4c6:: with SMTP id d189mr46558wmf.132.1584572783705;
        Wed, 18 Mar 2020 16:06:23 -0700 (PDT)
Received: from localhost (p2E5BEE6C.dip0.t-ipconnect.de. [46.91.238.108])
        by smtp.gmail.com with ESMTPSA id l5sm476370wro.15.2020.03.18.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 16:06:22 -0700 (PDT)
Date:   Thu, 19 Mar 2020 00:05:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Message-ID: <20200318230539.GB2874972@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20200317213056.futfiwn4qgr2njye@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 10:30:56PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> > On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > > Add the description of PWM_POLARITY_NORMAL flag.
> > >=20
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > > ---
> > >=20
> > >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Document=
ation/devicetree/bindings/pwm/pwm.txt
> > > index 084886bd721e..440c6b9a6a4e 100644
> > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > @@ -46,6 +46,7 @@ period in nanoseconds.
> > >  Optionally, the pwm-specifier can encode a number of flags (defined =
in
> > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> >=20
> > This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
>=20
> "is not part of the DT ABI" is hardly a good reason. If it's sensible to
> be used, it is sensible to define it.

That's exactly it. It's not sensible at all to use it. If you define it
here it means people are allowed to do stuff like this:

	pwms =3D <&pwm 1234 PWM_POLARITY_INVERTED | PWM_POLARITY_NORMAL>;

which doesn't make sense. What's more, it impossible for the code to
even notice that you're being silly because | PWM_POLARITY_NORMAL is
just | 0 and that's just a nop.

> (And as far as I understand it, the term PWM_POLARITY_INVERTED isn't
> part of the DT ABI either. Only the value 1 has a meaning (for some PWM
> controlers).)
>=20
> > The third cell of the specifier is a bitmask of flags.
> >=20
> > PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
> > makes absolutely no sense as a flag.
>=20
> Using 0 or PWM_POLARITY_NORMAL doesn't have an effect on the compiled
> device tree, that's true. But having the term PWM_POLARITY_NORMAL (in
> contrast to a plain 0) in a dts file is useful in my eyes for human
> readers.
>=20
> > PWM signals are considered to be "normal" by default, so no flag is
> > necessary to specify that.
>=20
> GPIOs are considered to be active high by default, still there is
> GPIO_ACTIVE_HIGH (which also evaluates to 0). Also there is
> IRQ_TYPE_NONE.

I'm aware of those. That doesn't mean that everything needs to have
symbolic names.

Thierry

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5yqUMACgkQ3SOs138+
s6GPcg/+N73P7VPsn68ABt9OMpT62+RvFprrJJFPeRfRvnxjtQfvnfdV5KblV8Z2
Cq2KKBVSeFkWWLLXWQHsBZYJ9oXXgkBHfIU4vdlkW55L8DWMyAztCu+0gob8tufk
u9AoYhvAfZN4hWa03WweDIFpX7jfbqeQCQ5LOygJDAcRb426xowyzNwGtMtXpHo4
Sl4KI08IN5WUFqG78ywvGIcogQ7Y4YTVYmU/wbPDrN2I65kqEn4YIZLWRes0t2gp
CF8DaJfUXPMPiutTpCqiq19Tvr95RbrIPaYCAOW9jdH6oo51q148ghg/03WuDuxD
Q3Q/B7ElsGw5Pw19jBGcVVXVOs60iZbkkMqtRWRGAvM+HKbADDYNyl1dVLH0yG9U
6Ac912W/rhdGsT6wSgZk3k+ecl4QhKfvxGrDqKzZ9zuVs8qDMYIiUPWzLxLolljG
bScb9XRW0O2ToPjGSQKZlKJj7vdC9eHwP3EM1/84oetS5AOajIL7DXhPtjtnOhhP
1T8sI2JT6uLoy9kQ5X9jQRi1yAkGfXGlHH8MyM5lr6kUFkoe2KBrV5hp6wDhi81b
AvYpL1vUilGov/jpaap4Z5Kx1KupIFvKmWWkGwsxFtCec5Onpvs9dpEOSXU7HWTE
rpN4N0KeMiUqd+NTCK3OV9R/OidbZMy5ewERSyxPVR7oGL3JpM8=
=VpZF
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
