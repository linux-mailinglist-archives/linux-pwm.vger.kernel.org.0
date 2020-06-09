Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109E41F40D1
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgFIQ2e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 12:28:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFIQ2e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 12:28:34 -0400
Received: by mail-io1-f67.google.com with SMTP id r77so10472969ior.3;
        Tue, 09 Jun 2020 09:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6vd48ocHYfhIgGf9VmwdBfWMzr2z9+KHgzkdfZG/Pw=;
        b=gdc5NQvllc6HFYMiHDxPVFrXN1WzeG6f8xWMyfju/+9W1a/dTIaU/TiTGVumkwsnmk
         N1rfHuKlDQimxSYMvp91xWBOHVyuT1wOSVDxYlTJYqjTb6IM3kYrdj1QB2gnztgHDVVx
         T9jeeXvkmkPvPj7RyutsbMgkJ8UxJ/QcJQpHgWazEt0SENDEy1G9OBRhv3XvO19yxEa3
         vywbsfTsCsQgIgQIhlmAxS/ecYzbEUJlbQ6/5MCJVV5eVhrbkMEp7lAB35SxCelzlRNV
         ezzpl+DW8XdZHIRw8OxyW6D7XxUMyw3ZDt+Q58/KcjndZ0DjF9+TFCX85SKtXBqvqFch
         SrcA==
X-Gm-Message-State: AOAM5321vBUx3YzsRbR/08cBtvMMGXjHs0lmIQkXipXsR38MJDA8fFgp
        V1gko/kAdGR1ZRfkDt1qZA==
X-Google-Smtp-Source: ABdhPJxppbDKoA41o6uRyry3FgAKOA+jukh4Ub5WxT2GMgvWiM/pMXyEGjvEw/XePOisx3B4ZJrI5Q==
X-Received: by 2002:a05:6638:1483:: with SMTP id j3mr27698460jak.65.1591720112867;
        Tue, 09 Jun 2020 09:28:32 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y13sm7449594iob.51.2020.06.09.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:28:32 -0700 (PDT)
Received: (nullmailer pid 1020807 invoked by uid 1000);
        Tue, 09 Jun 2020 16:28:30 -0000
Date:   Tue, 9 Jun 2020 10:28:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-watchdog@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Lee Jones <lee.jones@linaro.org>, Li Yang <leoyang.li@nxp.com>,
        linux-gpio@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/11] dt-bindings: mfd: Add bindings for sl28cpld
Message-ID: <20200609162830.GA1019634@bogus>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604211039.12689-2-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 04 Jun 2020 23:10:29 +0200, Michael Walle wrote:
> Add a device tree bindings for the board management controller found on
> the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
>  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
>  .../kontron,sl28cpld-intc.yaml                |  54 +++++++
>  .../bindings/mfd/kontron,sl28cpld.yaml        | 153 ++++++++++++++++++
>  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
>  6 files changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>  create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
>  create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.example.dt.yaml: sl28cpld@4a: 'gpio@1a', 'gpio@1b', 'hwmon@b', 'interrupt-controller@1c', 'pwm@c', 'pwm@e' do not match any of the regexes: '^gpio(@[0-9]+)?$', '^hwmon(@[0-9]+)?$', '^interrupt-controller(@[0-9]+)?$', '^pwm(@[0-9]+)?$', '^watchdog(@[0-9]+)?$', 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1303780

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

