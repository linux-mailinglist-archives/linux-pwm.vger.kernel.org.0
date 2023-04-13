Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674316E09D3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDMJNb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMJNa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:13:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA56510FC
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:13:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so9324574wmq.2
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681377208; x=1683969208;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PE5vTEL7E8P1zVsVjnu4l049FaIVCSgsce7iMS5wYo=;
        b=aluH8fC3W9eGsPUYb2LM4wkwmi98R96J31nWixQzfv8t0WQFyfXNO3vnupmmW6Uhig
         AKei/SmgO/tZolkFxv8MY6QVNTHXKcVQQDael3AcM//2KsMLVSHZt2aYWvxfh+QF9NWH
         A7U1B8vHiwAYw+KwEUM15VdgU54t+mz9E8KoxcoOwgnEdHmBZBCkL/Iz0cr7L7u1T6HE
         +4CLAGqgxH3ES21VG6SDYb2/EQDOpdjII6sSmSbbkKpSXZTVfzKdWwayKR/pLOgS2YZS
         sAfj+P1PpTacuxGTePgB2arqjECwMCoZGYsKrgZwnjdePLyFhioNfedEOhD+YA3QFu2Q
         aOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681377208; x=1683969208;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PE5vTEL7E8P1zVsVjnu4l049FaIVCSgsce7iMS5wYo=;
        b=YpjQWrLV6dVZkKATSuamAyyz+gPIuDBy0NBZlMR0YtqGNkD3u9W6sGWsDvuqn6B8YB
         TA6ZLwuIZ+jcPF7ih7Kf6hIh4KJHIwrnshssWMGhFjXW1BBNeNy6CkD88iv7c+fn+viv
         nLkvw7lcvtESzhfwL2tIzSds1zCINlqT5Y7NR7z3BUQ3dmjL+tUWPbRy/tKPkySu+6Th
         4xOjFYHkUNW15LFxrjw/8ZCmV4IHu+SbMysF+AgFxGPqJZcsSBlko3p2KsYtoqnbuYL3
         cXZyYVlBmLkwpnn8PDjZ/BK+OIg9eY1he28fPT3I/1MV4PYw3goA8hxNuS+WsnVYKQ8/
         QCFQ==
X-Gm-Message-State: AAQBX9ee9/oEaTqEVr8kJ8h7jwQqJouP18cjFp3rk2n2fqqxK2aOFMV2
        Ed6rdzLwHwjdufhO0yGNLVM=
X-Google-Smtp-Source: AKy350b/VHvKiJPvaShg0z14CliEy1L2m0k16FmmSbuZvbcffbhf/gBX/6b4Pyl2LWtpasJ5krIkNw==
X-Received: by 2002:a1c:7c15:0:b0:3ee:1acd:b039 with SMTP id x21-20020a1c7c15000000b003ee1acdb039mr1282321wmc.34.1681377208102;
        Thu, 13 Apr 2023 02:13:28 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q23-20020a7bce97000000b003e203681b26sm1258853wmj.29.2023.04.13.02.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:13:27 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:13:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] pwm: meson: make full use of common clock
 framework
Message-ID: <ZDfHtvZawSWWGTRP@orome>
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
 <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com>
 <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AfN6U5Lk+axIGN3J"
Content-Disposition: inline
In-Reply-To: <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--AfN6U5Lk+axIGN3J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 09:48:46PM +0200, Martin Blumenstingl wrote:
> On Tue, Apr 11, 2023 at 9:26=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail=
=2Ecom> wrote:
> [...]
> > +               init.name =3D name;
> > +               init.ops =3D &clk_gate_ops;
> > +               init.flags =3D CLK_SET_RATE_PARENT;
> As much as I don't want it: I think we need CLK_IGNORE_UNUSED here as wel=
l :-(
> On GXBB, GXL and GXM SoCs the board design typically uses PWM
> regulators (like the boards using 32-bit SoCs as well as newer boards
> using G12A or later SoCs).
> This means: if we enable that PWM controller and one of the channels
> is firmware managed and the other isn't then we can end up disabling
> the clock - taking away VCCK (which supplies the CPU) or VDDEE (which
> supplies GPU and various other components).
> I'd be happy if there are other suggestions around this though.

What exactly does "firmware managed" mean? Typically we describe all
supplies in DT to avoid these kinds of workarounds. If VCCK and/or VDDEE
are PWM-controlled regulators that should never be turned off, can they
not simply be added to device tree and marked as "always-on"? That would
propagate to the PWM and make sure the corresponding clock remains
enabled.

Thierry

--AfN6U5Lk+axIGN3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ3x7UACgkQ3SOs138+
s6EBdhAAljp7Lr0PxfWyQ82h5k8GfQ/FKW8dR8JGyDEf6YXn4iIV/ewq/8o9WzjE
M8tmZnekwmw2pZ0Lw7zOk+sX1N2RBovBd4NxnFNHSfKw8v1Iw/vj3SVZC2aD+a1I
sAKLOvIrMNJvQSWwz2U6TcLYSKud5T42eN8Pw1QZu3kXr24tXhFWp7hpQ0YvuQCq
oSFb6u4bta924aE16ziVZRA68edFA6K+DTDnstKh1Vrgs/KIGgPstBzScQ3uMTjg
jTKMgaaHNp0T0WXuWEITZoH1pweJ5/sXvIRCC9TDZ1ZGIHniV2KcU3st163h5qLO
TwrkkXSYz0DzBQRmP4YJgSR5gUXZ1jeHgka0LNSTLy+NVhm5mfwzN4lV9J8TOxTx
N5EVrgqjDzx1wCwjb3Dj9tfm9LJBQI7YfFo1SNoM1jyBVrviVO5hikxwdWxfCgtW
eo/CjUmRxOaZBSEFOM3OKkOBiizCaexo7rGIdi3pgk12vPVgQSaKrMackJHMZYSd
u1N9Wfc3/vddOKzErQ5JDCGLgupYiZa0aSxz0DHVGIKFjKFuq/hoUi0ty6mnOuuH
HTdGhtWmS/s5AjBxXQyVf0wUNjbU8J1fxNPajOjJDdgCmHgc9LPIl25BDOiUg9PX
/ji55f15wMB4KzXDBPbD24tbGbRaBJK7wxCXuopMum4TBCAniAw=
=FwfH
-----END PGP SIGNATURE-----

--AfN6U5Lk+axIGN3J--
