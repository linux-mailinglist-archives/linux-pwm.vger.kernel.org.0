Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584441F4675
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgFISlu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 14:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgFISls (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 14:41:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E91C08C5C3
        for <linux-pwm@vger.kernel.org>; Tue,  9 Jun 2020 11:41:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so22445024wru.12
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jun 2020 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nmaejAPqL7w5RZ3rYBTgKoizKjTpzF9/rXO7+RKEnFs=;
        b=bT+muX/ZHRyFVoKnvmGjZYEBoJBSQhFE7M258fsMuSAMDYowHgy3BXIG/jHiBLN3Eu
         j44yKp2S1Qr5XCQKMWibyk0jNOe5ZUqG43z0mTcQgB8TqqYUAilZ/+TflAKsIoD+DYg1
         GiUnrBLUYvuXERBXq188+PcxnG+tGm3IfxkW3Wq0xTDoNESuL/TXFOE+ZgasGd5La3cx
         0RN999iXgJC2v/eadBv1wABQnyJuHz70FaHCXXpaWaEftcJLu5dCN01Qk2HOHHG4dywz
         Noa2fAHca/bEcEoRRIgF3kdGyr3gXsT44NPGuPONy9VKwePCyay2oPzNkfZ81KyeTGx+
         F5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nmaejAPqL7w5RZ3rYBTgKoizKjTpzF9/rXO7+RKEnFs=;
        b=LJ0HU6k8zciS+8doT5Jfwx+7zIodFuEIiKMGoW+rKb3YNP88+rGtpJgDFSdS8HrCb7
         RCc+1Zaav4Eucdu0Q0QC2Rnsp0N0EKdAnxiqxvJm4N6OQF6NecOXXT6kPACxemt+HDZq
         VwWmC7Lzkw4xXktoEg795uxeTiy6vq4fjufu/M9X/5mZWOnsAOYl+by2K7vj2O/nhYPH
         2xswPVBjr5jvb+PMKXnY8xF8cAXxUi0yPPz7accK1pxaIgxhhwj9lxKqLBlqGCTVXH+i
         r/v43p/gHttrVekl3ZfYRUMZkZgGKYy4Se1TRGBxA0NvkUaveXqRaN6mMuKc4xABerma
         Kneg==
X-Gm-Message-State: AOAM533kFMUPzxKbOyoPKgsM8JkSdcDuSkV7JE+581QjOo4udXF1db2i
        4ht5WatbMZsyOdX70obXROMjBA==
X-Google-Smtp-Source: ABdhPJx5FO/vEubUSX2PK6P+KpZvhjPdNngyh29RNODEGr7a4h7Gn46X2+6wYsXyxNUmt6ZTCXwdvQ==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr5884154wrp.165.1591728105471;
        Tue, 09 Jun 2020 11:41:45 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id 40sm4694407wrc.15.2020.06.09.11.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:41:44 -0700 (PDT)
Date:   Tue, 9 Jun 2020 19:41:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>,
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
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
Message-ID: <20200609184142.GN4106@dell>
References: <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
 <a2bae71634fe288f067d5e92090b7561@walle.cc>
 <20200609171520.GC1019634@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609171520.GC1019634@bogus>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jun 2020, Rob Herring wrote:

> On Tue, Jun 09, 2020 at 05:01:17PM +0200, Michael Walle wrote:
> > Am 2020-06-09 16:42, schrieb Mark Brown:
> > > On Tue, Jun 09, 2020 at 04:38:31PM +0200, Michael Walle wrote:
> > > 
> > > >   mfd-device@10 {
> > > >     compatible = "simple-regmap", "simple-mfd";
> > > >     reg = <10>;
> > > >     regmap,reg-bits = <8>;
> > > >     regmap,val-bits = <8>;
> > > >     sub-device@0 {
> > > >       compatible = "vendor,sub-device0";
> > > >       reg = <0>;
> > > >     };
> > > 
> > > A DT binding like this is not a good idea, encoding the details of the
> > > register map into the DT binding makes it an ABI which is begging for
> > > trouble.  I'd also suggest that any device using a generic driver like
> > > this should have a specific compatible string for the device so we can
> > > go back and add quirks later if we need them.
> > 
> > Like in the spidev case, yes. But OTOH if I _just_ encode the parameters
> > for the regmap a MFD, Lee don't agree because its just a shim. So either
> > way I seem to be stuck here.
> > 
> > Where should I put the code to create an i2c driver, init a regmap and
> > populate its childen?
> 
> Find another driver doing this already and rename it 'simple-mfd' (no 
> relation to the DT binding) and add your compatible string to it. 
> 'Generic' or 'simple' drivers don't require generic/simple DT bindings.

Creating a generic driver is one of the options spinning around in my
head.  If nothing better comes of these discussions, I'll turn my hand
to it soon.

> Or extend the existing syscon driver to look up the bus_type and create 
> the regmap based on the bus type?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
