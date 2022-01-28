Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665214A01F9
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jan 2022 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiA1UgN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jan 2022 15:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiA1UgM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jan 2022 15:36:12 -0500
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A522C061714;
        Fri, 28 Jan 2022 12:36:12 -0800 (PST)
Received: from thinkpad (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPSA id BF7E514138D;
        Fri, 28 Jan 2022 21:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1643402169; bh=0/RfUNvk2c0Mdda81ByapiD/k7XaXHtMar15aQPaZCo=;
        h=Date:From:To;
        b=jEiyKVZS5F0NOnmjSTEmQTQsK75biTpyN5VHQ9MXBAsijN29Uq7YuVUAO4ueGc2yD
         xuyze2+WxcSd1HjRR1UrhxgrLofe3RJXJ0wCZTn/oREUcHXzaFErjdQhsdkaoMTz1o
         RoZWBVkGoi2DOH2UpZVk5ZFAsHi8Wal0mUWT5PIw=
Date:   Fri, 28 Jan 2022 21:36:09 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED
 bindings
Message-ID: <20220128213609.7a60e9fe@thinkpad>
In-Reply-To: <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
References: <20220126104844.246068-1-sven@svenschwermer.de>
        <20220126104844.246068-2-sven@svenschwermer.de>
        <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.4 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 27 Jan 2022 22:24:21 +0100
Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:

> Hi Sven,
> 
> On 1/26/22 11:48 AM, sven@svenschwermer.de wrote:
> > From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> > 
> > This allows to group multiple PWM-connected monochrome LEDs into
> > multicolor LEDs, e.g. RGB LEDs.
> > 
> > Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> > ---  
> [...]
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/common.h>
> > +
> > +    rgb-led {
> > +        compatible = "pwm-leds-multicolor";
> > +
> > +        multi-led {
> > +          color = <LED_COLOR_ID_RGB>;
> > +          function = LED_FUNCTION_INDICATOR;
> > +          max-brightness = <65535>;  
> 
> It doesn't make much sense to have such a big resolution of global
> multi color brightness. 255 will be sufficient.

If the PWM supports it, why not?
On Omnia the default is 255, and since it is PWM, the change from 0/255
to 1/255 is much bigger then from, say, 15/255 to 16/255. So if 1/255
is too bright, you are then unable to set it less bright. I think 1024
or ever 65535 makes sense with PWMs.

Marek
