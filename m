Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95E72AFA3F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 22:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKVQj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 16:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVQj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 16:16:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9023C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 13:16:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so3860600wrr.13
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 13:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q/G6APEJUmL5oSVKzQU/H9M4Nxa1gDvTeQPyghSx7u0=;
        b=ZeMYUGojlBDwo1W8yUdtHEfKRRaBmCdThQDc2AxWmcGWh9cIse7Kfd/qXfi3HI62dP
         vPNf9hQ3PoFJXq079RRURsz4UZoj6QOhy0SYcemZX5XjoZ4oazcsUCqyPM3wJAqFHU96
         SSbF1miuwx6u0UB/tDklYrZU43mYqPG60Fg+heZxgbhZcIY+A8oNmjTOLUdgg240lgEM
         rlW0Brnlj1W7pK06vYZ3iAWBOhtSRjxAQOtSo6EFNMa6u76E5Lju1OOgu7Go/zWBlxkC
         CEl8/2aL6E0wjauSFEL02YLHaXO/bkvpXBdTyBMihegTMQi9gGOgTPXLi4taLvkd0tHZ
         CM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/G6APEJUmL5oSVKzQU/H9M4Nxa1gDvTeQPyghSx7u0=;
        b=cGoJOW05VbE1ABjk+AV1fzBfaorffEVML/E1BQdS04UFXBkQ1pWvzjA5A9fSiavysQ
         4wLCFXNSrBFZJSm5pKxfxqBBXr61T+hh7YkUOJPRtm0ACBqXHBFPA5/5YWVXUjtHVojk
         au/5bbSmqZLLqZCf+9zM5GPmfzhRGuCDDoWBZcc7CFo0H93zacRWs/3pRFVudda6bmNf
         8qrqSrXJcS57VzAR87haUk4MWuhmiAYDA9tjfbBwRYGCLqrvKpC8v10oaTgS4c1pn/NO
         PbN8lGXbf/hmHep+/gESYvaPqyhDdg0m6s4K5JcURdeVYiGq4vnzQogMBz+E1dpADu2J
         uyJg==
X-Gm-Message-State: AOAM531AyzVmXqUCnWTcMrD6IU6UI0597rLW+h8V+lE+TwQlRuGm4hpn
        hqpljovIsGZ5jj4txP8cgVY=
X-Google-Smtp-Source: ABdhPJzVdCDv82KsFMP7b0cX11Uv/5R8c3UOGPgVHWlXgxDS+M64kTMbDrkXvW0Uggp0DkL2rx610Q==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr23378705wrp.209.1605129397590;
        Wed, 11 Nov 2020 13:16:37 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id j4sm3687309wrn.83.2020.11.11.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:16:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:16:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <20201111211634.GB571441@ulmo>
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell>
 <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
 <20201106102908.GC2063125@dell>
 <20201111192823.GD6125@ulmo>
 <0d9adfa9-9015-c8c5-c21a-f4ad9b1ef7a9@kleine-koenig.org>
 <20201111195204.GE6125@ulmo>
 <5b401246-62dc-3ed2-4fdc-ff9b0fe2354a@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <5b401246-62dc-3ed2-4fdc-ff9b0fe2354a@kleine-koenig.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 09:39:51PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> [dropped Ajit Pal Singh from Cc: as the address doesn't seem to exist any
> more]
>=20
> On 11/11/20 8:52 PM, Thierry Reding wrote:
> > On Wed, Nov 11, 2020 at 08:43:18PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On 11/11/20 8:28 PM, Thierry Reding wrote:
> > > > I agree with Lee on this one, so I've applied the patch and touched=
 up
> > > > the label names while at it.
> > >=20
> > > Have you tried to follow my reasoning?
> >=20
> > Yes I did, and I happen to disagree.
> >=20
> > >                                         I consider it irritating that=
 you
> > > overrule the preference I justified in such detail by applying a patc=
h with
> > > me as author and the error handling variant I opposed to.
> >=20
> > Well, it was either this or have you respin the patch. I didn't think
> > you'd mind, so I did that work myself but still wanted to credit you for
> > fixing this in the first place (the names of the labels really don't
> > mean much for authorship in my opinion).
> >=20
> > If you prefer I can just remove the patch and you can do this yourself.
>=20
> I sent the version of the patch that does it the way I want. So yes, plea=
se
> drop the modified patch from your queue.

Alrighty then.

Thierry

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sVLIACgkQ3SOs138+
s6EwqBAAs6YNh3Ux56iRqgCMaM/pswIdF0wDvOObTtj3UjZFRnuEYu+rZoI8eLFo
JYVKaKKs5zRFaXQk3OOQM1PIUv8nkNyW3zkDp7fVOeMjeThcV3NOAb6OueDAd8X9
rz72gUyNuDWleE6ZzXmbdZiFw6T+VTa5c3JHbtl/MR7A6xyu79bhUuK7j+H2QvZN
vas7EpdU4Xot3u7xa6MNJjk3KAnsqAs1tZt/nvzUF8tKhfk6kfXVh25CYrqBaTEJ
si+ROuPvPehre/amq4yJn+ewm06FOsf3loJZaiEnrkY+cixy6tw8jFOmLryi72L5
2mV9cEayaFiIdbbcQt6mEcdW8xIX7VBwMiy4y2IgeWFpXg0qlq60e8SqJGXXQOZx
fnz7lE3H30iJdkMs6ugVT3uC9Lez9ySkUMibN6+FB665RqsVF9DBeoUC3VJ0pAJ7
S7BLD30NZZpyFsSIMa8abYAmvk1ryO7X3wsUnOApJtpqdnsHO4Z/D7LGCn4VgFqQ
st3oyFhYLTcKH9204aD7WE0IBw1D1sJcBWYGIcd5RfQJ+RcaCbYImefN+5sV18yP
8Ik/53aK9eLwu+268kFw3Jmv5dgDrXlOdLq91V1yPuxKfWBW7M71Uph5zcHwz5YZ
Z1BsXfQdJsbBjevxng+uS/paiIGZ5KOI+hWMMUJKhmgCz9ixFb4=
=RnSA
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
