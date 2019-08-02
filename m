Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82CA7ED6A
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 09:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbfHBHZf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 03:25:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39499 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbfHBHZf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Aug 2019 03:25:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so31574347pfn.6;
        Fri, 02 Aug 2019 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=waO3Kw8FCsucFcZzTAvjkiHidk4K6PfJ+TshbSYUeOg=;
        b=NKx9LvdQydMZbNGxoLLC31zHPVPOE3fFKDcu7RldPyOJRCHr0W/06zpCpaxBf/L1cj
         CIkZPu3CGbYzuVp1pgI9a4UXhgkvtOf0/RvzeH2lF4heUPE41FI8XJTQ++kzz0DPhIoy
         s7PRTzEzdSoVdfBKDwaBnKD6cUDs42Ttnn6Wx4CIWqlzMCK52QuoEneW/8nv0u0vLJ3p
         V+WkXTMK5UYyYrqbH/vdZuCH8qkeJeVxERK0nhGrzcGXk213DkacNvqvxmLQPVIpFL1j
         ZkLcflMNg5LJtDNAtSaf9qaYv/G+wX/AH00ZD6kXFg+nmrdHkCb0xg9csyRoEbjb7YX8
         pD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=waO3Kw8FCsucFcZzTAvjkiHidk4K6PfJ+TshbSYUeOg=;
        b=sc8n2dStURTnnBOezjQHqoMNuI0cqqmCtfD7o69yNJvp3f3lXtRWSMzl06Gv+rBo0d
         1YPHN1J1DTu/5mQN3Voq8KsThkFRM1j3rf1KhDHHs4p+6bGIgeZm32r8AEBxOOKe43rn
         6Wr825DjqibGHWDgZeHYxzJdybHfo4rjdVoTnA315dbAQfdCj/q9BuSx8Kie9Kn9mgXt
         h41/YgOzPHudnbyx8tglkRjuzmzI7K9yqAd9W8H8vhgfTLTVt0zQ74F/1+9gl2xiVite
         gYekTKmLW/a+0hygbJ0kK9HB4QQLY+iFtVIc9QZYH0h31Xjk4m0spigmdaZGHyk9YefN
         L7gQ==
X-Gm-Message-State: APjAAAXhgnk4svtEruhrb3dxkXLH8g3AdCF17AyXVJgV5SyDTDzd9YqC
        tcYkmSOMIbZOts4W496u3TYJSwp/
X-Google-Smtp-Source: APXvYqyBwlBxpa4TRYIb+gJCDEzgHRKrDQVfR7xfNOMezhcdVeQjXM6y7O8X8ihfbpgJxkbgW1OThA==
X-Received: by 2002:a63:f94c:: with SMTP id q12mr1212430pgk.10.1564730734014;
        Fri, 02 Aug 2019 00:25:34 -0700 (PDT)
Received: from icarus ([2001:268:c146:e9f9:e343:65f1:6148:c56c])
        by smtp.gmail.com with ESMTPSA id p27sm110308059pfq.136.2019.08.02.00.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 00:25:32 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:25:13 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Message-ID: <20190802072513.GA30522@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-2-david@lechnology.com>
 <20190727204836.1514265d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727204836.1514265d@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 27, 2019 at 08:48:36PM +0100, Jonathan Cameron wrote:
> On Mon, 22 Jul 2019 10:45:35 -0500
> David Lechner <david@lechnology.com> wrote:
> 
> > This documents device tree binding for the Texas Instruments Enhanced
> > Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>
> 
> Up to William given it is a counter binding, (unless Rob overrules)
> but new bindings are generally preferred as yaml.
> 
> Content looks fine to me.
> 
> Thanks,
> 
> Jonathan

Rob,

Would you prefer these bindings as yaml, or shall I accept them as they
are now?

William Breathitt Gray

> 
> > ---
> >  .../devicetree/bindings/counter/ti-eqep.txt    | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.txt b/Documentation/devicetree/bindings/counter/ti-eqep.txt
> > new file mode 100644
> > index 000000000000..fbcebc2c2cc2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/counter/ti-eqep.txt
> > @@ -0,0 +1,18 @@
> > +Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
> > +
> > +Required properties:
> > +- compatible:		Must be "ti,am3352-eqep".
> > +- reg:			Physical base address and size of the registers map.
> > +- clocks:		Handle to the PWM's functional clock.
> > +- clock-names:		Must be "fck".
> > +- interrupts:		Handle to the eQEP event interrupt
> > +
> > +Example:
> > +
> > +	eqep0: eqep@180 {
> > +		compatible = "ti,am3352-eqep";
> > +		reg = <0x180 0x80>;
> > +		clocks = <&l4ls_gclk>;
> > +		clock-names = "fck";
> > +		interrupts = <79>;
> > +	};
> 
