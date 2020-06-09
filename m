Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0641F41F6
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 19:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgFIRP1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 13:15:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35545 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgFIRPY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 13:15:24 -0400
Received: by mail-io1-f68.google.com with SMTP id s18so23677110ioe.2;
        Tue, 09 Jun 2020 10:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JGLI/jshAv4UOtJl5rWJiq7REK+PfEQZi+2RrLn3IFA=;
        b=FJ2BXV8fElHPvhxX1kqSat7dr5hUgWprvrK07L0mkCWxEbdS1F1gDpdk6HJ1l4jpqw
         abSkXzUmBlH+3DWJI0POhl2FaWihi6dHbGf/evOvRazwzUU9M0cDL8k8hjwYKG0qUXjc
         4Se9i2lNnOPKMpTGuNCKcEUadEleAcAMdGc5pdf908mFt+qZsBGYLwEvytAbTCRM/J6w
         wTYSpIEh7onBnmiK5q0Z80B2U4jl4cjh3S4d1rpguF/vRvwBYE600PoE3h4h/4lnnIQ3
         YNHEm9WCMOGEUjVQo2eu2WfyYCbOuE+QQHXhozpcYrHH68953yQ0SUka9vDSD+efImfx
         kihA==
X-Gm-Message-State: AOAM531N4hhgDIsMVjjiFbhxdcU7tRPzNDBUqUsX88+6lT6kwLc8wQEP
        fq6T02nb/8kKTwbCyKEjyA==
X-Google-Smtp-Source: ABdhPJyom2HW81zaEPBo0bO0otJQ7le36pAHDKSbZIdASMosYcxXzc1o/KabAiMefhklBHue5cmzqQ==
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr28764204iod.156.1591722922294;
        Tue, 09 Jun 2020 10:15:22 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k5sm9534836ili.80.2020.06.09.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:15:21 -0700 (PDT)
Received: (nullmailer pid 1093153 invoked by uid 1000);
        Tue, 09 Jun 2020 17:15:20 -0000
Date:   Tue, 9 Jun 2020 11:15:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200609171520.GC1019634@bogus>
References: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
 <a2bae71634fe288f067d5e92090b7561@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2bae71634fe288f067d5e92090b7561@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 09, 2020 at 05:01:17PM +0200, Michael Walle wrote:
> Am 2020-06-09 16:42, schrieb Mark Brown:
> > On Tue, Jun 09, 2020 at 04:38:31PM +0200, Michael Walle wrote:
> > 
> > >   mfd-device@10 {
> > >     compatible = "simple-regmap", "simple-mfd";
> > >     reg = <10>;
> > >     regmap,reg-bits = <8>;
> > >     regmap,val-bits = <8>;
> > >     sub-device@0 {
> > >       compatible = "vendor,sub-device0";
> > >       reg = <0>;
> > >     };
> > 
> > A DT binding like this is not a good idea, encoding the details of the
> > register map into the DT binding makes it an ABI which is begging for
> > trouble.  I'd also suggest that any device using a generic driver like
> > this should have a specific compatible string for the device so we can
> > go back and add quirks later if we need them.
> 
> Like in the spidev case, yes. But OTOH if I _just_ encode the parameters
> for the regmap a MFD, Lee don't agree because its just a shim. So either
> way I seem to be stuck here.
> 
> Where should I put the code to create an i2c driver, init a regmap and
> populate its childen?

Find another driver doing this already and rename it 'simple-mfd' (no 
relation to the DT binding) and add your compatible string to it. 
'Generic' or 'simple' drivers don't require generic/simple DT bindings.

Or extend the existing syscon driver to look up the bus_type and create 
the regmap based on the bus type?

Rob
