Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B850235DE0F
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbhDMLvA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbhDMLu6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 07:50:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235DAC061574;
        Tue, 13 Apr 2021 04:50:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j5so15170555wrn.4;
        Tue, 13 Apr 2021 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrBQReSgCMY+OanYzHXGQEOPpNoJlLuJMLlJaEtW1GU=;
        b=CsRT1I3hZPY9u/p2FbsnDSev8v2QMEjS3cJqBgCLCg6lodkHQzSP5vp6ZcaY0o+GhG
         9N5JfcuRwViPByhzv35X/kFQ6ebe2QWP96cjrTAf6/Hdqt5anv0UMFUC/CpJPTRT16KK
         2uweAE4wqyLvq5V+qYLVmhd5UFEMPn2cRTZijnzkx7U4bUH6qvgnK74jam8WfDRS/StP
         BPlzEAAKE9I0TTjX7Lf0Hi0GFJMMys/+dGI0770muxYKN4SHyeOakbkM3hGwsy7BJuO/
         8+LZZ+UOETw4oHPyrhesEs33Pzn9B71PTln3/PvNaj3clpoEvRYdfqz71Y+F3HTKzv/i
         NRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrBQReSgCMY+OanYzHXGQEOPpNoJlLuJMLlJaEtW1GU=;
        b=mwGoN1Icyr9LOY12ogxolFc88rJjrklhUxGNsQAiq8x5rMfH4eoiJX63FdjiPkzwEo
         E682Nu9n1IkA1+vB+jV+a7ZmZXAyvuI4G4cq5DCWtxTFwA6bErqxSNg07bnSegXJk5I/
         DNistydEHkhX7sWCN1F748iUrGI34i3lHAu6w/2DRGu34sDoKRojgM1cBE/8TJGMUWx5
         4JJnAa3ZdQAHF+yVnOPc7PGelbI8C5b8RqH3p8qFWb3y12veFtnYt+vReo7ipXGg3eK5
         qhywm77L5b5qgSJkkZS7bZesoNloRMyIEe3UC/cXbTBJO0rxvmv2ZnFYtKVAZHY4IVW0
         BiSg==
X-Gm-Message-State: AOAM533ueMT+pmOsiE5YEwzu8+EQ8HxGiu2VEYbNsEF79pWKsR/ybb1N
        U1FE+85r+hlZ/IPyWWZBaaMCZAvAuRM=
X-Google-Smtp-Source: ABdhPJyt+FUGCR4EoaJA2Km+HzTa59IB9H8Kfio//rf4dR28tjz9KfRPxIa5rvfDSR+QmLODHnQlsg==
X-Received: by 2002:a5d:5914:: with SMTP id v20mr11125063wrd.402.1618314635917;
        Tue, 13 Apr 2021 04:50:35 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id v185sm2339354wmb.25.2021.04.13.04.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:50:34 -0700 (PDT)
Date:   Tue, 13 Apr 2021 13:51:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHWFs1f0XHkqbddp@orome.fritz.box>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CeMXB2IKKXvrsAIH"
Content-Disposition: inline
In-Reply-To: <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CeMXB2IKKXvrsAIH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > Add the flag and corresponding documentation for PWM_USAGE_POWER.
>=20
> My concern here in the previous round was that PWM_USAGE_POWER isn't a
> name that intuitively suggests its semantic. Do you disagree?

I suggested PWM_USAGE_POWER because I think it accurately captures what
we want here.

> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> >  include/dt-bindings/pwm/pwm.h                 | 1 +
> >  2 files changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentat=
ion/devicetree/bindings/pwm/pwm.txt
> > index 084886bd721e..fe3a28f887c0 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > @@ -46,6 +46,9 @@ period in nanoseconds.
> >  Optionally, the pwm-specifier can encode a number of flags (defined in
> >  <dt-bindings/pwm/pwm.h>) in a third cell:
> >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > +- PWM_USAGE_POWER: Only care about the power output of the signal. This
> > +  allows drivers (if supported) to optimize the signals, for example to
> > +  improve EMI and reduce current spikes.
>=20
> IMHO there are too many open questions about which freedom this gives to
> the lowlevel driver. If the consumer requests .duty_cycle =3D 25ns +
> .period =3D 100ns, can the driver provide .duty_cycle =3D 25s + .period =
=3D
> 100s which nominally has the same power output? Let's not introduce more
> ambiguity than there already is.

The freedom given to the driver should be to adjust the signal within
reasonable bounds. Changing the time unit by a factor of 1000000000 is
not within reason, and I doubt anyone would interpret it that way, even
if we didn't document this at all.

To be frank I think that quest of yours to try and rid the PWM API of
all ambiguity is futile. I've been trying to be lenient because you seem
motivated, but I think you're taking this too far. There are always
going to be cases that aren't completely clear-cut and where drivers
need the flexibility to cheat in order to be useful at all. If we get to
a point where everything needs to be 100% accurate, the majority of the
PWM controllers won't be usable at all.

Don't let perfect be the enemy of good.

Thierry

--CeMXB2IKKXvrsAIH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB1hbMACgkQ3SOs138+
s6HYLhAAhdf86s3re5qOKds5oPjtXld/X7JkGE4TVl5uSJ57Lft2n3oVTuXtIbMJ
j07WfvLgEDG2B2dX7LcSoCd6VH1A3f4iop/VbkyLe5xT0NZ4AtEA2rZBRuUs5gvw
K3GrPOtQeU2V1WX2rRcVGZDBqlv+Hrwy0AF09MrZw8XW4YIYnkXPDmp5OD/oBzKv
Jk9ZPWZngieA3y5KGaA25sWOSoz5owkEBcHlw0FDr0y3lGljl8yVXxVs0fbXio9V
IgFL1mU6cFz3Xh71H6qBy0aql/I+tnB3Q/cKVFk5N3pnh5j3K0nxYuNG2NXnNkd2
9lMt/5rk8SRwa0UWbarxGBK1bZAEUpFAfVaWmKB2uzp1iixyNxvDJOKuYnmpIrE3
kBMKguVf7Xj8OJKcBkk6R3RRgORPdEKTKE890wqRx/NISsp5gNnqRTdWNfrmnIzS
zPJK1vqmymqggapL2/xuvdIFfntTaR6THH1R5i5tRS7RrVb+jswLwk7fBn1F7St0
6dh/fJ0qR0uqtq4Pw2TQVmBc/ku+/dxae41YAcM+tLM20JWECQOUerVTWB6F9Hfm
bw6M8AQYZIkUCGbImBNJlqC7kSiqfyGH0gss82y4nNvk6hmfeBX0cs6glX6WPOLd
tXrTwTktfGcS+xfBVUo2qqt5P4qmBH7HzCxP1TRlaTu9BQG1jAQ=
=nXbs
-----END PGP SIGNATURE-----

--CeMXB2IKKXvrsAIH--
