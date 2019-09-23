Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B963FBB7BC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfIWPVB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 11:21:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54659 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfIWPVB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 11:21:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so10456487wmp.4;
        Mon, 23 Sep 2019 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brsvz/rH/l0iuVy/KKjxn5pihaXPh2FmuzxzRBgra3M=;
        b=cUBoXuQkLMLUptz8U4OfiJWCLnY4AmrhYgBKUWeGEYXAE4yF/yW3UHT4opNjqileV2
         gqafZZkdB1IQTQHn9SAcWnYHlqJy92BdD775ILOwH1kDxv3S6kLAN18TX4Ylh6RAhw2h
         YTq1WUEIghzmZGEZ54tpJU8W4HPkVVIlSTFwUW0Li+IyEYxTtrazzrNs8CpWx0yyCrUh
         eyIJEDBpXcakFzccpRMepoVkhNydMT1kz59pFsfr2AHuV4ZGrxva2h72QFb30P9ehPBh
         +ZegkMn9TxEhhW6R6rN2jUasAZvh0UJymC9L6qkgMayVewWKBBUVVW/sArJ5Ownz3ZXw
         09mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brsvz/rH/l0iuVy/KKjxn5pihaXPh2FmuzxzRBgra3M=;
        b=aissu9c8zT5QWaspAstHCkCCWEHxk5j2nUUJbucUlZnKMZhWmQM9zQGCBOt/9crEH2
         zkhiQTE2HA1Obo6TMWf8adga6HecHBGgEOCsb2ub2oDc1keVGZPnHigKywdfD2NWIc4Z
         w2btDq9QofI0wPjog1IdrXGrRVXvS3KzHp0FoyyJ8Z+rf6Y/XF5E/mzQo1Q3OyI++IzR
         iUaFuZC2PYJ7lbfvBJ+udgtMRBHD6+kusQ+0VTS2Q27M4v5akHBnk4cHl31DHLPhcyJm
         hrfeLTvoQQTERFYYmk8wiVOG3WVMUHTvvjM+H5NNXrnUDcJlMHIDF9NMyaX0VA+sz7T7
         hUoQ==
X-Gm-Message-State: APjAAAV9VtsXGroJuHqMhMJtIJvtsruj92xLJYx6djT/iMK11QvkRxob
        8s2YjKfCek/S5uOiNPP1uZM=
X-Google-Smtp-Source: APXvYqya/2MexYGkI++mWd3gYFe3Thgt0DUKr+QWCNbE+n0FjqxPPEKaEtwg0BbaZD9yKd5MtDMbZw==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr155473wmg.13.1569252057854;
        Mon, 23 Sep 2019 08:20:57 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id f8sm12698261wmb.37.2019.09.23.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:20:56 -0700 (PDT)
Date:   Mon, 23 Sep 2019 17:20:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Message-ID: <20190923152054.GA17178@ulmo>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
 <20190921002149.GB86019@mithrandir>
 <1569208857.4102.9.camel@mtksdccf07>
 <20190923133626.GA4671@ulmo>
 <1569251515.4102.31.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <1569251515.4102.31.camel@mtksdccf07>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 11:11:55PM +0800, Sam Shih wrote:
> On Mon, 2019-09-23 at 15:36 +0200, Thierry Reding wrote:
> > On Mon, Sep 23, 2019 at 11:20:57AM +0800, Sam Shih wrote:
> > > On Sat, 2019-09-21 at 02:21 +0200, Thierry Reding wrote:
> > > > On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> > > > > From: Ryder Lee <ryder.lee@mediatek.com>
> > > > >=20
> > > > > This adds a property "num-pwms" in example so that we could
> > > > > specify the number of PWM channels via device tree.
> > > > >=20
> > > > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > > > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > > > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > > > ---
> > > > > Changes since v6:
> > > > > Follow reviewers's comments:
> > > > > - The subject should indicate this is for Mediatek
> > > > >=20
> > > > > Changes since v5:
> > > > > - Add an Acked-by tag
> > > > > - This file is original v4 patch 5/10
> > > > > (https://patchwork.kernel.org/patch/11102577/)
> > > > >=20
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++-=
--
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >=20
> > > > You failed to address Rob's questions repeatedly and I agree with h=
im
> > > > that you can just as easily derive the number of PWMs from the spec=
ific
> > > > compatible string. I won't be applying this and none of the patches=
 that
> > > > depend on it.
> > > >=20
> > >=20
> > > Hi,=20
> > >=20
> > > Thanks for getting back to me.
> > >=20
> > > New pwm driver (patch 04/11 : "pwm: mediatek: allocate the clks array
> > > dynamically") can support different variants with different number of
> > > PWMs by the new property <num-pwms>
> > >=20
> > > For example:
> > > 1. Use "num-pwms" =3D <2> and assign clocks pwm1, pwm2 for mt7622
> > > 2. Use "num-pwms" =3D <6> and assign clocks pwm1, pwm2, pwm3, pwm4, p=
wm5,
> > > pwm6 for mt7622.
> > >=20
> > > If we just as easily derive the number of PWMs from the specific
> > > compatible string in this document:
> > >=20
> > >    - "pwm1-6": the six per PWM clocks for mt7622
> > >   =20
> > > This looks like all "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6" is
> > > required property in DT, It doesn't make sense.
> >=20
> > I don't understand. Why doesn't that make sense? If your hardware block
> > has 6 PWMs and each can be driven by its own clock, then you need to
> > provide references for each of those clocks, otherwise you won't be able
> > to use them.
>=20
> Thank you for your instruction,
> I will add all clock-names and clocks according to
> hardware blocks instead of value of <num-pwms> in DT.
>=20
> > >   =20
> > > So we removed those descriptions and added =20
> > >=20
> > >    - "pwm1-N": the PWM clocks for each channel=20
> > >   =20
> > >   =20
> > > But the max number of clocks from the compatible string are still
> > > important information that should be provide in this document.
> > >=20
> > >=20
> > > What do you think of this?
> > >=20
> > >    - "pwm1-N": per PWM clocks for mt2712, the max number of PWM chann=
els
> > > is 8
> > >=20
> > >    - "pwm1-N": per PWM clocks for mt7622, the max number of PWM chann=
els
> > > is 6
> > >=20
> > >    - "pwm1-N": per PWM clocks for mt7623, the max number of PWM chann=
els
> > > is 5
> >=20
> > That's what's in the bindings already, isn't it?
> >=20
> > 	 - clocks: phandle and clock specifier of the PWM reference clock.
> > 	 - clock-names: must contain the following, except for MT7628 which
> > 			has no clocks
> > 	   - "top": the top clock generator
> > 	   - "main": clock used by the PWM core
> > 	   - "pwm1-8": the eight per PWM clocks for mt2712
> > 	   - "pwm1-6": the six per PWM clocks for mt7622
> > 	   - "pwm1-5": the five per PWM clocks for mt7623
>=20
> Yes, You are right,=20
> I will keep original description and remove "pwm1-N" from this patch.
> 	   - "top": the top clock generator
> 	   - "main": clock used by the PWM core
> 	   - "pwm1-8": the eight per PWM clocks for mt2712
> 	   - "pwm1-6": the six per PWM clocks for mt7622
> 	   - "pwm1-5": the five per PWM clocks for mt7623      =20
>=20
> Actually, MT7629 also use "mediatek,mt7622-pwm" as compatible string,
> but it's hardware only support one pwm, so I was wrongly stick by
> expecting "pwm1-N" in clock-names based on "num-pwms" in DT.
> (that we can assign num-pwms to 1 and only provide pwm1 as clock-names)
>=20
> Maybe added mt7629 description to this document can solve this simply.
> 	   - "pwm1": the PWM1 clock for mt7629   =20

Yeah, if mt7629 support only one PWM channel, you should list it's
compatible string separately and also update the driver to reflect the
number of channels associated with the hardware.

Thierry

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2I4tQACgkQ3SOs138+
s6GbFBAAm+k7tV+3Xh1QL6SPZABvtkVY3oUEY61Cxq5OkODBJ5woXtGKlfmiaBZT
tbj0lYgNMF2G3ZYu43uVxcFDlhkL2sFjHlphN8Y7i+5yQC4Im86JoDf1MEYa0QJm
bVovqvHV0s16V3xpxxYPN1yhERfWXfanTcqVHGiKXyK2eoEPytH6tlNtJr026KhI
sXcMCkZNC/d7orXLoKEh9SWVxaK+G2EGyTW3HxdUyyWDc/aGI5/OfxGmrYCDvSKX
Y+150lc+8CA0pHqklRnUHm5QLX2gUWJC8Mpw4DyvoRW1WQuOyO55Q6et5O251HA7
y/dK85FiLLIfLMU4TaZ0xaF4wtei2+VoZKCJCPEdE8agDLSrXvpe5IlQTQWeC+wm
I/AOv8S0TifOgI54lSwqWiz78JUDMX+RwV04Dh8AC6nBjGL5Jdj7JrOUL6Gh5Jiu
5lsZk5O8xZLBZSiVHKAhK+0ZBQK+rQkhlIE2pa8XeImqwycevxEzv6dACfM3XjvH
KgVFFHCpZBJLteqmlvwif48gjcUkuptJdMFyb7VetH5rmt5ZQsRkw7PeGW1t+TaU
qSUxF3yBpAaL/ZHpywN6F5rQRv+wZ+vQULlChpHijyRfVos3OBF3QzO3mKiGHxhe
XiaTvGqK4KkOvmG7A1i3q99lUOllZZdFqvOGizk2mQbpio/mZeU=
=F38s
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
