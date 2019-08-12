Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052428AB4C
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHLXj4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 19:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfHLXj4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Aug 2019 19:39:56 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A609620820;
        Mon, 12 Aug 2019 23:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565653194;
        bh=g1oGI/RT7q+tWZ2BW7Bj/hckAKrhiNedFdjBEplqisA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jWZvvpDMOZIOxvbu8qTb1T1bHujYnWZxRtUuMOJ88SX+lJ+yl2x4LvXD0CCOJJ6Cm
         JFSXqg4V1bgoVpqM1qTM0Cink5TzT0+WVXAmtWmZOT/edkdNbwOUcUPQ1ZyccQyVpE
         16E1cGwOeMwhIPkcvVNS6MJSmzEdlPhJANNdq2Ak=
Received: by mail-qk1-f169.google.com with SMTP id u190so14687778qkh.5;
        Mon, 12 Aug 2019 16:39:54 -0700 (PDT)
X-Gm-Message-State: APjAAAU0JIN/FhOIDrEyUDfEWt24dL5xBMz3HrBIE45i16OsUxPAVDEb
        27Ii/PZYLj34Wh1BiU+jq+RRsUQzz4sOjvVLng==
X-Google-Smtp-Source: APXvYqx7EbPjgLHVpq/dM8qT7Al9/ZfUvTi6FAz8DRCcUvaxEZ+RFwA37wmOT/6EmvBt557f0GUFFOvVpEKHIXy2qu8=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr24941301qkn.254.1565653193835;
 Mon, 12 Aug 2019 16:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190607154410.10633-1-paul@crapouillou.net> <20190607154410.10633-2-paul@crapouillou.net>
 <20190709020425.GA7984@bogus> <20190808082829.i6enaout5ozvdnwj@pengutronix.de>
In-Reply-To: <20190808082829.i6enaout5ozvdnwj@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Aug 2019 17:39:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJv8kv_xXwoOUa-avTZhq0NkkDHCUmA5HbQFydWKu=n-g@mail.gmail.com>
Message-ID: <CAL_JsqJv8kv_xXwoOUa-avTZhq0NkkDHCUmA5HbQFydWKu=n-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 8, 2019 at 2:28 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Jul 08, 2019 at 08:04:25PM -0600, Rob Herring wrote:
> > On Fri, Jun 07, 2019 at 05:44:05PM +0200, Paul Cercueil wrote:
> > > Right now none of the Ingenic-based boards probe this driver from
> > > devicetree. This driver defined three compatible strings for the exac=
t
> > > same behaviour. Before these strings are used, we can remove two of
> > > them.
> > >
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > ---
> > >
> > > Notes:
> > >     v2: Rebase on v5.2-rc3
> > >
> > >  Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +--=
--
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm=
.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> > > index 7d9d3f90641b..493bec80d59b 100644
> > > --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> > > @@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >
> > >  Required properties:
> > > -- compatible: One of:
> > > -  * "ingenic,jz4740-pwm"
> > > -  * "ingenic,jz4770-pwm"
> > > -  * "ingenic,jz4780-pwm"
> > > +- compatible: Should be "ingenic,jz4740-pwm"
> >
> > Are you sure all 3 chips are exactly the same features and bugs?
> >
> > The correct thing to do here generally is the 4770 and 4780 would also
> > have ingenic,jz4740-pwm as a fallback compatible. Then the driver can
> > match on that until you find some difference and can use the more
> > specific compatible.
>
> Note that Thierry already applied this patch before your concern reached
> the mailing list. Is this bad enough to revert
> 925488e8df4f396ad96ff008a84f5b14d8b73347?

It won't be my problem when you find and need to handle any of the
differences in the driver.

Rob
