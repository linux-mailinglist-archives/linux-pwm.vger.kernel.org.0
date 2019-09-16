Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2BB3BD9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2019 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfIPNxj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Sep 2019 09:53:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38009 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733036AbfIPNxi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Sep 2019 09:53:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id o184so10509015wme.3
        for <linux-pwm@vger.kernel.org>; Mon, 16 Sep 2019 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fSEdpPDyZqycInQTS3mVG6b2QMkYr0nanU12z4k/OAQ=;
        b=oZEctWp1b44VLxai69LHKDoSRf7pDu5Z/VsQsiInWUGxzwpzAtQWgWUkdRjngkpb10
         uwW9GyuvasM42yv973yqX4ZbpFctIeUNifIVbgg64HnocTG4jFoaePRHU4wVWiVetycD
         GrsZCNGQcK01XB+wC7PJ+BO/RG+6VgzLxXCQZS0d4Rbo2A8I90q/3p8vdT7jFGv/cuhH
         fGIdGvr+SU78L63xvYenSks2zr60mzW69TEF/A6oKMbj0AthbnguR5uRiHjUZqa6eoLd
         4Ks/KiGsMxFCX3HHKjgiNfWWZY1wBvTKoPhV2I+FLvL2TiJi1dJs/AlOTFJhNIk6SMru
         3N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fSEdpPDyZqycInQTS3mVG6b2QMkYr0nanU12z4k/OAQ=;
        b=UbubHOFshMXj7btV5kBsgSYYW+cLkQNEqVL5X7HmgyYxbgnA5arRsv4AaM7l+sszVD
         G9ZTiW3H5nD62X7tS1uk1KKd4OhPfPvcHINxwW9kSYN1qvIojrxEA8YBx8kurATZu3Eh
         YdRkKEQFzhT0yhAPO08jsQZTkPUjdLWWTpfS2yOFrD39vZ56FcgGGrXB6DZTO4WKWzu6
         PgqlR4mrWY0xg9hD4G3J1DTfrsAOxFQtBJLYixVzXESuxLIvwE2doKGZxMFRhJT2yoJ3
         CjTPzR0s/jz2YimwjtiFjnEjxmq9te2hSIbsiU6kDo8X7FAPqTWWdlZfregnIB18OmXl
         IBVw==
X-Gm-Message-State: APjAAAX5BbVg72EYcPju7Vb4otSGUH23ouopi7yvg1rfVhfOT7ARmOxn
        E8fyhUoikTtYEBlhjqMc9GA=
X-Google-Smtp-Source: APXvYqw6W59ZUMwa0P92PCVYP9rwHQsyB3RfOo6GPeMA1RQnI3jFlA/DMBnGoOpoVNwzMkVuaiEluw==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr13405977wmf.72.1568642016556;
        Mon, 16 Sep 2019 06:53:36 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y186sm24283068wmb.41.2019.09.16.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:53:34 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:53:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Offer to co-maintain drivers/pwm [Was: Re: [PATCH] PWM: drop
 legacy wrapper for changing polarity]
Message-ID: <20190916135333.GB18267@ulmo>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
 <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
 <20181120165758.pwprvrhzpftkghap@pengutronix.de>
 <20181130085942.epcatcj3zeegprz6@pengutronix.de>
 <20181206092057.avcew6a33l3lo7kk@pengutronix.de>
 <20181211212658.vxxci7npev2dnjou@pengutronix.de>
 <20181212102547.GN15092@ulmo>
 <20190916130547.xflkrm7dwgnec7dx@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190916130547.xflkrm7dwgnec7dx@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 03:05:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Dec 12, 2018 at 11:25:47AM +0100, Thierry Reding wrote:
> > I certainly wouldn't mind a little help. Reviewing patches will
> > definitely help move things along.
>=20
> I'm a bit frustrated with the state of the list of open patches. There
> were little feedback from you on the list since July, during this time
> https://patchwork.ozlabs.org/project/linux-pwm/list/ grew by ~1.5 pages
> and there are still topics that I want to bring forward that depend on
> you to cooperate. As I spend quite some time reviewing patches here, I
> wonder if you'd be willing to give me maintainer-status for the pwm
> patchwork to update the state on the various patches there. If you want
> I can also add me to the MAINTAINERS file (as reviewer or maintainer --
> whatever you consider sensible). I'd also like to have pwm patches
> applied in a more expeditious way and expose them in next.

Feel free to send a patch to add you as reviewer, you've been doing good
work so far.

I know I've been lagging behind on review and maintainance tasks since I
have been busy with a bunch of other things lately and I've had little
to no spare time at all for a few weeks. I'm hopeful that things will
get back to mostly normal for the next cycle (things have been slowing
down recently). I'm also considering making a few changes to my daily
routine so that I can hopefully get around to patch review sooner.

Thierry

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/k90ACgkQ3SOs138+
s6G7mg/9HPPeekZHXtCEwOPswUkOp6lidlJhOFh92O4eJHtcUnBk6tivb9DiWUXl
ZZmBiRzt/fvXEHvOhvrcgg5shZemve9jKjYyp0CAwVsIS8aHU9Qne6P19pCFrLgz
nFpbOodlm77hqR/LqsHYX5Is0N3sEjSsgrP9NVbKCR3Ri/BBm57tEQjCTpywSfeZ
NO1/g1/5F12m3DwTSWM9P/OvE20VDTM9VM3Lp63J5ZvG8pYuzGzMh3QFXi4COgxr
JUVyku6AaJeV//svUclrUN2IPMSaCr0u/FSS2o/8ZHuBVZ9Dn7vethcOgrcCCPIC
rz7NzHj6Tks5HZ03bfZDUjsvlNfVX2Xk++b6lftniQ0oR3EYeyNNt2Dss0PMXZYM
l+3euEeZQh2RocWWYpGg4e/RD8sgbeJxxuKNR5n3iakb4a0INHV8bcgHMExmbx8J
AdC8KLI1RY+TJVLYSL8RpTbpoh6VMfZSHtYqQeohUWJDUgJaxN5J79XCxB6lREQk
JvptmVsu4Ok5USP8bt00k9dKwh1kAzJxwp/lhZu8EvCKbiO2zsWqWAQasReNLjH/
llqj7lr3pCje7vNrPqTzyGYM8mfKV4HtrCENa2o3ZPE1BLzNGP/0zC39gs/AjpXR
s7xvXBJ02Vp89vokROCi5/gbExfMXzC5N3MyVIOdi6toD2faYqI=
=t1q2
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
