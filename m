Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13A2D480B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgLIRhM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 12:37:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33291 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbgLIRhJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Dec 2020 12:37:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id d27so2582363oic.0;
        Wed, 09 Dec 2020 09:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bka+gIe2PYYq4ePeK5SsKTLs6SwK5O5OVnbyEVbKVvc=;
        b=Fi0zad0gvqWQcDbCcoWqlU8bqCFJa7rnby+wvMXC7+L3yQB2gdoQdZjyOaNx61AKWh
         3DWG92Sj7V+g+IAyZmLxCrpL9GcLfFF65yY8Os10DpysGZneGvaYiUbQ36WAghvP8aX3
         EIeFw1F29q+DmpBpXJ8izsyC4pi/FFMVk0tj1UZnE8nUCfhzkYYE5D3iWrPiBcdnoo3G
         VjrR/zlrXTi1WhWZl2lMfA6QOxtncJsXYGYJXYguQ+2x2H0i5N+5PYMD1kn1hQiBtPVs
         ftdHkLiTlbkSGS+nWigMsKScVmCj/Q+VZdR58GrYZYLsKczjYQrkFVoc0v0uzbbuNovc
         8yqQ==
X-Gm-Message-State: AOAM533iwS8g37L+wb5qi2LNm30ZlO1quG3PO+SaU3/fnRlJp2plLN9N
        m9UXcd2SgIdYouDTM4Q17Q==
X-Google-Smtp-Source: ABdhPJwfX4MV4Pd4gkJYdfqaNpb5JzpyOTvPjdxnCE/rfTZkEEStMybE/u7/b04DDpwcwNS7MNIHRQ==
X-Received: by 2002:aca:b686:: with SMTP id g128mr2565481oif.82.1607535388097;
        Wed, 09 Dec 2020 09:36:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm455253oii.45.2020.12.09.09.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 09:36:27 -0800 (PST)
Received: (nullmailer pid 654142 invoked by uid 1000);
        Wed, 09 Dec 2020 17:36:25 -0000
Date:   Wed, 9 Dec 2020 11:36:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] dt-bindings: ap806: document gpio pwm-offset
 property
Message-ID: <20201209173625.GA652178@robh.at.kernel.org>
References: <cover.1606892239.git.baruch@tkos.co.il>
 <ba17da5dfea6128a2502e5ebd38ed35bcd797deb.1606892239.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba17da5dfea6128a2502e5ebd38ed35bcd797deb.1606892239.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 02, 2020 at 09:15:37AM +0200, Baruch Siach wrote:
> Update the example as well. Add the '#pwm-cells' and 'clocks' properties
> for a complete working example.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../bindings/arm/marvell/ap80x-system-controller.txt      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
> index e31511255d8e..a754e8992450 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
> @@ -80,6 +80,11 @@ Required properties:
>  
>  - offset: offset address inside the syscon block
>  
> +Optional properties:
> +
> +- pwm-offset: offset address of PWM duration control registers inside the
> +  syscon block

marvell,pwm-offset

> +
>  Example:
>  ap_syscon: system-controller@6f4000 {
>  	compatible = "syscon", "simple-mfd";
> @@ -101,6 +106,9 @@ ap_syscon: system-controller@6f4000 {
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  		gpio-ranges = <&ap_pinctrl 0 0 19>;
> +		pwm-offset = <0x10c0>;
> +		#pwm-cells = <2>;
> +		clocks = <&ap_clk 3>;
>  	};
>  };
>  
> -- 
> 2.29.2
> 
