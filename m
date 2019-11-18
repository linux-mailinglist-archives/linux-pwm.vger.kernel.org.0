Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439FB1005C4
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 13:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRMnD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 07:43:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33625 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKRMnC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 07:43:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id a17so15923046wmb.0;
        Mon, 18 Nov 2019 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pcFlFVkkMbFljmj2ZrTgP1JMEa4NOdAyJ98aVnMQW90=;
        b=Ius+cbqdRUrpMslhWt5VXcDQyV8qVk+4Q8qQxv7hMKczJGpyf5AodDdZRU1khdJnZe
         Q4+6tbCPCebPkg+5A0jb/EoLTs1WmxuQidwUlRbSSb/ffaZ7C+nEtTVg6FXABkwxbras
         x4A4ihtg4YiqSM61NxV/75lb3wrmL6k+9j9m+cfg0b6huKP3jNwQU3WsukP3z+B9pTDU
         dUyq78+U7spZw6ZTkeehtnN/BbHHbc8uT6zvlhJUWJyf6/GVjKxJeObS6ExLDyuqAkms
         enBH+zA7zk/kcDqaR9SAYY7RwmyZ9cHJ8zMeuaZceL+Eya/l1Hba/Jaesd78fPxf/duP
         pRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pcFlFVkkMbFljmj2ZrTgP1JMEa4NOdAyJ98aVnMQW90=;
        b=hvPMwr8mgjH63cDRy5Ik2h1JbivGDIHT5FFA9sM+j8wReNZPaGMyKmfZ5KothSrc3c
         YS8cocovxHOMZONVvz/FsVq1fJBXVAsiyD6hK0FC1bhNtVVbIqvSLWnCTcpcwnRG5css
         Y/nnK3/j8ok8n3gssApXbyxYKsVIS3IW53TJiR/TWrdBEzrW5OXzJj7feSVv45iiCVjJ
         W4JlDQthHKKfAREvNVYVafK1KDUbEwJv5yIl4++7Q0bI+YxbCuxgNKmmbmTlKhqFH/3j
         PR9AL8sSw/mnaLuDTRpA8xgzy7Q/XXoDMNlqQokN5uRInm4mU4kKBgDMvkMNtOoyWesf
         VZnw==
X-Gm-Message-State: APjAAAWogt3UZ/6CI7Ofk8ucCK7CsZg5RoJQDcY5YPCivl4yYqmLGwgG
        rpDEiH/33IaBG4oICBa+vleYWTMbyBmR4t6HGmY=
X-Google-Smtp-Source: APXvYqxxJYds+5SWA8ug7X01HWT+V/7ibyn0gASw4Jf8VDRK4pON3wae0WJKMIz2zs2OISG78EzX3OjYwfu9ndtgm88=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr27252635wme.4.1574080979808;
 Mon, 18 Nov 2019 04:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20191118110034.19444-1-peron.clem@gmail.com> <20191118110034.19444-2-peron.clem@gmail.com>
 <20191118110640.GE4345@gilmour.lan>
In-Reply-To: <20191118110640.GE4345@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 18 Nov 2019 13:42:48 +0100
Message-ID: <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM description
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Maxime

On Mon, 18 Nov 2019 at 12:06, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM block is basically the same as A20 PWM, except that it also has
> > bus clock and reset line which needs to be handled accordingly.
> >
> > Expand Allwinner PWM binding with H6 PWM specifics.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-=
pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.ya=
ml
> > index 0ac52f83a58c..1bae446febbb 100644
> > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yam=
l
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yam=
l
> > @@ -30,13 +30,51 @@ properties:
> >        - items:
> >            - const: allwinner,sun50i-h5-pwm
> >            - const: allwinner,sun5i-a13-pwm
> > +      - const: allwinner,sun50i-h6-pwm
> >
> >    reg:
> >      maxItems: 1
> >
> >    clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - description: Module Clock
> > +      - description: Bus Clock
> > +
> > +  # Even though it only applies to subschemas under the conditionals,
> > +  # not listing them here will trigger a warning because of the
> > +  # additionalsProperties set to false.
> > +  clock-names: true
> > +
> > +  resets:
> >      maxItems: 1
> >
> > +  if:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          const: allwinner,sun50i-h6-pwm
> > +
> > +  then:
> > +    properties:
> > +      clocks:
> > +        maxItems: 2
> > +
> > +      clock-names:
> > +        items:
> > +          - const: mod
> > +          - const: bus
> > +
> > +    required:
> > +      - clock-names
> > +      - resets
> > +
> > +  else:
> > +    properties:
> > +      clocks:
> > +        maxItems: 1
> > +
>
> Sorry for not noticing this earlier, but this should be at the topmost
> level

No problem, but I don't get what you want, (yaml format is new for me).
Do you mean I should put the if condition before the "resets" ?

Regards,
Cl=C3=A9ment

>
> Maxime
