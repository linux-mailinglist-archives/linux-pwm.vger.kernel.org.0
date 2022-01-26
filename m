Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6D49C4E3
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiAZIIY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 03:08:24 -0500
Received: from mail.thorsis.com ([92.198.35.195]:36031 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238131AbiAZIIX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Jan 2022 03:08:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 818EB2984;
        Wed, 26 Jan 2022 09:08:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xwkKSGS77zVZ; Wed, 26 Jan 2022 09:08:21 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 8048F355C; Wed, 26 Jan 2022 09:08:19 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RECEIVED,NO_RELAYS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: disruptive-technologies.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Wed, 26 Jan 2022 09:08:02 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Subject: Re: [RFC PATCH 0/2] Multicolor PWM LED support
Message-ID: <YfEBYjMLdcYfAU70@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
References: <20220125092239.2006333-1-sven@svenschwermer.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125092239.2006333-1-sven@svenschwermer.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Sven,

Am Tue, Jan 25, 2022 at 10:22:37AM +0100 schrieb sven@svenschwermer.de:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> As previously discussed [1] on the linux-leds list I am missing
> multicolor PWM LED support. In the mean time I have put together a
> working prototype for such a driver. This is my first Linux driver
> so I'm hoping for some feedback. Here are some questions that came up
> while putting this thing together:

Wow, I did not expect this so quickly.  Thank you. :-)

>   1. Currently, the max-brightness property is expected as a property to
>      the multi-led node. That seems consistent with the existing
>      multicolor class code, but I'm wondering whether it would make
>      sense to have a max-brigthness for the individual LEDs as well?
>   2. The current multi-led node definition calls for a node index which
>      would in turn require the reg property to be set within the node.
>      In this context, that doesn't seem to make sense. Should this
>      requirement be lifted from leds-class-multicolor.yaml?
>   3. I'm not currently reusing any leds-pwm code because there aren't
>      too many overlaps. Does anyone have suggestions what could be
>      factored out into a common source file?
> 
> I would appreciate if anyone would test this code. It runs on my
> i.MX6ULL-based hardware.
> 
> Best regards,
> Sven
> 
> [1]: https://www.spinics.net/lists/linux-leds/msg19988.html

You can use the lore.kernel.org archive, e.g. in this case:

https://lore.kernel.org/linux-leds/b48eed49-a18e-eed1-f1f4-77b9f1eab39b@gmail.com/T/#t

Greets
Alex

> 
> Sven Schwermer (2):
>   dt-bindings: leds: Add multicolor PWM LED bindings
>   leds: Add PWM multicolor driver
> 
>  .../bindings/leds/leds-pwm-multicolor.yaml    |  73 +++++++
>  drivers/leds/Kconfig                          |   8 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-pwm-multicolor.c            | 184 ++++++++++++++++++
>  4 files changed, 266 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
>  create mode 100644 drivers/leds/leds-pwm-multicolor.c
> 
> -- 
> 2.35.0
> 
