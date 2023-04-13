Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716846E09AD
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDMJGz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDMJGy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:06:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0D10F3
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:06:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qb20so35258935ejc.6
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681376807; x=1683968807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZJ1jMcWj/e+ilDQKZ9bfvzxyk2884OkiD2zDnsE4N4=;
        b=WcBZg4QcwJIC8s4SMGYh9KK0Gg1J2IAG8VfKFgfjAJbbozCa+xlCuhTCeAEM7lfjw1
         31GAnJ0JxJuQ84AKzAOGs7xZX4bi+l2fcML3zpLnZ3IF07hOCB6Xx8QXbbdgHR8yZFz8
         yDzpAqJS96HYFpWipQr38uw4A8WtWn03YnLhbqG52vQV5oc/qc82x+kwx30YnhDIS8lV
         E5AZmyxT2gsk+diwhH9hDuUAMD3oRjcVF/usFhO+CUZLMKzukx1y2BNf00CjOhPYtkzS
         eKqh71smeginzTwaSs84AA3w+wW9kTHWUiXxpRtlOgghFbf3ZmbA27f6SB0m9MBIZ64J
         Szpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376807; x=1683968807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZJ1jMcWj/e+ilDQKZ9bfvzxyk2884OkiD2zDnsE4N4=;
        b=F5WKU54oN0C9JASu5L7PKTlrb+OQxbVfKSGDQbj4Aeb6BD1zpQ73KBb5VdflYBICVE
         4r8SaaKSvTIAKNxRDYsxt43HoPLhqkDq6Rwu8EYUVziEk6DbtPjjADzxo/1dfOX3IBx2
         VkcAh1kJdIAdPuRi2Tl+0bDC831un9WeRLx1xgm2pgdNkP/IrDnY/QctXTF3BQitG5mk
         RjcWCNs9dpDqIP8XitgSW4L6tr4j9m0aGAgqdhwFBnwT54eqRmJNJczDGy1n5/Pw8oO5
         d6ZRgPVCjsFdTNrMnhnNt9LsB620cxtAR6qUPpGM3jPZmLJwF3JZ4N3wfaaAP+lt6NRv
         ES7g==
X-Gm-Message-State: AAQBX9e8++S19WHMJEB5x5I98ez6pIk92vRZXUKxygENze3MZfOy4BWw
        AAHNlfh7jb7lmbok81T5lZU=
X-Google-Smtp-Source: AKy350Y75jl/2HbEZkAqua0OH3KdsRDgyPUTmSBpee5hkzSLOamRcPd/6j7Z7zzVXMmCfx7OGQVVew==
X-Received: by 2002:a17:907:3112:b0:933:3b2e:6016 with SMTP id wl18-20020a170907311200b009333b2e6016mr1750790ejb.7.1681376806789;
        Thu, 13 Apr 2023 02:06:46 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090638ca00b0094a44867e0asm676166ejd.52.2023.04.13.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:06:46 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:06:44 +0200
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
Subject: Re: [PATCH v3 3/4] pwm: meson: change clk/pwm gate from mask to bit
Message-ID: <ZDfGJM24xZbfSur5@orome>
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
 <f7291bab-eb51-3f2d-4eb4-78f6330242ef@gmail.com>
 <CAFBinCDs=EQo8-HSSbaprfJB+93sz+Ng1H=MX3hBG_00PTko3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NHBS40KK0p/++cKO"
Content-Disposition: inline
In-Reply-To: <CAFBinCDs=EQo8-HSSbaprfJB+93sz+Ng1H=MX3hBG_00PTko3g@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--NHBS40KK0p/++cKO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 10:47:05PM +0200, Martin Blumenstingl wrote:
> Hi Heiner,
>=20
> On Wed, Apr 12, 2023 at 9:23=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail=
=2Ecom> wrote:
> >
> > Change single-bit values from mask to bit. This facilitates
> > CCF initialization for the clock gate in a follow-up patch.
> >
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
> meson8b-odroidc1, sm1-x96-air
>=20
> [...]
> >  #define REG_MISC_AB            0x8
> > -#define MISC_B_CLK_EN          BIT(23)
> > -#define MISC_A_CLK_EN          BIT(15)
> > +#define MISC_B_CLK_EN          23
> > +#define MISC_A_CLK_EN          15
> >  #define MISC_CLK_DIV_MASK      0x7f
> >  #define MISC_B_CLK_DIV_SHIFT   16
> >  #define MISC_A_CLK_DIV_SHIFT   8
> >  #define MISC_B_CLK_SEL_SHIFT   6
> >  #define MISC_A_CLK_SEL_SHIFT   4
> >  #define MISC_CLK_SEL_MASK      0x3
> > -#define MISC_B_EN              BIT(1)
> > -#define MISC_A_EN              BIT(0)
> > +#define MISC_B_EN              1
> > +#define MISC_A_EN              0
> Personally I'm fine with this change but it's not how I would have done i=
t:
> - I would have kept the BIT() macro for MISC_{A,B}_EN
> - then I would have renamed MISC_{A,}_CLK_EN to
> MISC_{A,B}_CLK_EN_SHIFT (to be consistent with _SHIFT of the mux and
> divider) and drop the BIT() macro there (like you did)
>=20
> This is possibly/likely personal preference, so my suggestion is to
> wait for some more feedback.

It looks like these aren't used outside the meson_pwm_per_channel_data
array, so why bother with a #define (and any potential inconsistencies)
in the first place?

Thierry

--NHBS40KK0p/++cKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ3xiQACgkQ3SOs138+
s6Fb3RAAwid6cv5PHAgfTDQ9OSpBYIyf2UGxtdf1g6jyu1dqxitvH3iIKMnUsmL/
RwRqKg4wQWGw8fqfmiKR8i36M485cL/Vobo3pbxbzPIA8vfs1HoBinaRbJC0YHMe
TQGOi/tn9gA1EJpCx7k/q5rTGaKq0/tVK9QfOYgDbWUJ1CU0u0lROuotXWgYbo14
4+ED775iMkM/XBBmORdi16mv5DUmzXBoG3YerAPTLHkQKNVE2M09kmuD51iOe3sm
HJ/LfqePuxw1ZSx7AqQ5zaeWURhX+CXxT1oK6Ps1pGpGFDVs3FKqZfmubGc4abVi
7p4eWQzDe27HK4alVbHpbmbT/D8QNfXmdIECYH4TI9xcjE7fkcLuOBVX5tg4MV+s
8j7gJCTjHBXNWaBfb58SgrgOzk4/6ZQ5oGSeCkaMmmRe6RUgjyrMODyxk4liUsKr
4qWVr6WdzvhU4RFwLcA7Qw8bcf5gsMtBQscS5u6CxbJvl14DxdEH12yfBoDywys2
j4v/Z5HLOP82VaKitHNCkmVkxihUbpXNFBAAMBhFm+h6ASypTdTcjTi74AS/9xyi
yyAgRFoMMUDtbk/Plon/U+yz4o1DcG5VmxC28b6Le+9ywxMuR0y/yPpwN72GnsHn
pMJgdxcb4JwEDuGqLS0n6lUspqD3Cu1EJYk4HDbA41f5fuHd1Hg=
=w+FE
-----END PGP SIGNATURE-----

--NHBS40KK0p/++cKO--
