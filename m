Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F731AB2CB
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2020 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442057AbgDOUgJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Apr 2020 16:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442076AbgDOUgB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Apr 2020 16:36:01 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D9E206E9;
        Wed, 15 Apr 2020 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586982959;
        bh=V2P/p0WdlVmm6s1T99zNgD7LVt8conGYoIAN3hef6OU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JX5bJsh7HfaWQESZbbi6MVq7mW90DmIKBBFqeqbmwH+e0OqOboWC4eRQmjh75EJeC
         qL5kfxEzLkqNZWb6NhJGvSpBPfIafaS1LK5avXYtJJjHTYlUfBdLVPGXwFkS0ZqZV6
         gngu+0fPBs5TZLnT7ey1i9OneourIzPGBOc+bYKw=
Received: by mail-qt1-f182.google.com with SMTP id s30so14609478qth.2;
        Wed, 15 Apr 2020 13:35:59 -0700 (PDT)
X-Gm-Message-State: AGi0PuaXsMCkfTu+93B3idDFJZqbEkVKjOvW/c6nJh9kS3HhURoApryu
        ilnfuYCj7FtGNtIlAzvwYdrpxcAvFUQERF5XTw==
X-Google-Smtp-Source: APiQypKdAtKOLeMWJ/D1BvB7ZXEW29X4XYOYycR6x8j+EJbzgjzjIbaXHkX74YNb0tcs08YeLBbvDSIhg3w7EhgjYpw=
X-Received: by 2002:ac8:39e5:: with SMTP id v92mr23150670qte.224.1586982958434;
 Wed, 15 Apr 2020 13:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200415182639.18534-1-robh@kernel.org> <20200415192928.tjmh2m6a63lmnp3b@pengutronix.de>
In-Reply-To: <20200415192928.tjmh2m6a63lmnp3b@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Apr 2020 15:35:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJs1mvJU53RFsv0PeGkzaX0xdryrqBA1SWm5Ka_a8uJ=Q@mail.gmail.com>
Message-ID: <CAL_JsqJs1mvJU53RFsv0PeGkzaX0xdryrqBA1SWm5Ka_a8uJ=Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg' warning
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 15, 2020 at 2:29 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Rob,
>
> On Wed, Apr 15, 2020 at 01:26:39PM -0500, Rob Herring wrote:
> > The example for the CrOS EC PWM is incomplete and now generates a dtc
> > warning:
> >
> > Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dts:17=
.11-23.11:
> > Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit na=
me, but no reg or ranges property
> >
> > Fixing this results in more warnings as a parent spi node is needed as
> > well.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: linux-pwm@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/pwm/google,cros-ec-pwm.yaml        | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > index 24c217b76580..41ece1d85315 100644
> > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > @@ -31,10 +31,17 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > -    cros-ec@0 {
> > -        compatible =3D "google,cros-ec-spi";
> > -        cros_ec_pwm: ec-pwm {
> > -            compatible =3D "google,cros-ec-pwm";
> > -            #pwm-cells =3D <1>;
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        cros-ec@0 {
> > +            compatible =3D "google,cros-ec-spi";
> > +            reg =3D <0>;
> > +
> > +            cros_ec_pwm: ec-pwm {
> > +                compatible =3D "google,cros-ec-pwm";
> > +                #pwm-cells =3D <1>;
> > +            };
>
> Looks reasonable
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks.

> Is this supposed to go via the pwm tree, or do you apply yourself via a
> device-tree tree?

I'll take it for rc2.

Rob
