Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308021DB26
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2020 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgGMQEb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jul 2020 12:04:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44876 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQEb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 12:04:31 -0400
Received: by mail-io1-f65.google.com with SMTP id i4so14006285iov.11;
        Mon, 13 Jul 2020 09:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0sunnV9kDrUsUSO/lW1Logo3b4p4WNuGPhwv9k+yy78=;
        b=CDL5Dt3PPhI0ChMjEqhu/vdu8NqDoXjUnaVcNafdkb7GsgpKiR9B2Iw6IxEu+30s0U
         8BICW3ode1gsiUVC4U8z4rWVZl28QM/wCwynWO+PoRnVc5KUyZv49AZdwvvs9PG5rm8j
         Z/5cglDvhd38abiRrqzxVeY2cd/m6lw35wV1EPlH1kIrV+wEqmtKMquKKXaN8KDur9pQ
         O9nNAUe2hdRIbj3AhnHxAjsyerUa0I0Jt23ts3E3ofA8qVvLPbaGXKHpwSBQEpVvxPw0
         ouzG0Qz85L574ekv4qM7251yIBVjKBrADU3M93vUIK2G9ytEzu+hq5l+VVimwdlSSb9K
         e5jA==
X-Gm-Message-State: AOAM531ILEb7cDrzlGt8qdXtRZPFk2upAsHCMqpPF7bjkaIMmGjsCNft
        MtjQS+CYYs5nyGtqjy6g3w==
X-Google-Smtp-Source: ABdhPJxD7uq5WmIrqpNMEk2ms+CZADoNvoKAM2eqWWrJFaO+FKRn2p5bDlePNgpedl3T+/Pf63xtTg==
X-Received: by 2002:a6b:d31a:: with SMTP id s26mr429334iob.48.1594656270186;
        Mon, 13 Jul 2020 09:04:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w15sm8941248ila.65.2020.07.13.09.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:04:29 -0700 (PDT)
Received: (nullmailer pid 303717 invoked by uid 1000);
        Mon, 13 Jul 2020 16:04:27 -0000
Date:   Mon, 13 Jul 2020 10:04:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 03/13] dt-bindings: mfd: Add bindings for sl28cpld
Message-ID: <20200713160427.GA303616@bogus>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706175353.16404-4-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 06 Jul 2020 19:53:43 +0200, Michael Walle wrote:
> Add a device tree bindings for the board management controller found on
> the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:
>  - fix the regex of the unit-address
> 
> Changes since v3:
>  - see cover letter
> 
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

Reviewed-by: Rob Herring <robh@kernel.org>
