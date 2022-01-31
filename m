Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D264A3E14
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jan 2022 08:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiAaHK0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jan 2022 02:10:26 -0500
Received: from mail.thorsis.com ([92.198.35.195]:39398 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233543AbiAaHKZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 Jan 2022 02:10:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 3914B3554;
        Mon, 31 Jan 2022 08:10:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gGoWGySXr6xZ; Mon, 31 Jan 2022 08:10:24 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id B6D1A19C0; Mon, 31 Jan 2022 08:10:23 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RECEIVED,NO_RELAYS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: hackaday.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Mon, 31 Jan 2022 08:10:07 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, pavel@ucw.cz,
        sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <YfeLTxVAmwjU6PFr@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>, pavel@ucw.cz,
        sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
References: <20220126104844.246068-1-sven@svenschwermer.de>
 <20220126104844.246068-2-sven@svenschwermer.de>
 <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
 <20220128213609.7a60e9fe@thinkpad>
 <09b46d05-5dd0-a585-2ca3-0bc04e613343@gmail.com>
 <20220129002639.33c7d4c0@thinkpad>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220129002639.33c7d4c0@thinkpad>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

Am Sat, Jan 29, 2022 at 12:26:39AM +0100 schrieb Marek Behún:
> On Sat, 29 Jan 2022 00:04:01 +0100
> Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> 
> > On 1/28/22 9:36 PM, Marek Behún wrote:
> > > On Thu, 27 Jan 2022 22:24:21 +0100
> > > Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> > >   
> > >> Hi Sven,
> > >>
> > >> On 1/26/22 11:48 AM, sven@svenschwermer.de wrote:  
> > >>> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> > >>>
> > >>> This allows to group multiple PWM-connected monochrome LEDs into
> > >>> multicolor LEDs, e.g. RGB LEDs.
> > >>>
> > >>> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> > >>> ---  
> > >> [...]  
> > >>> +
> > >>> +additionalProperties: false
> > >>> +
> > >>> +examples:
> > >>> +  - |
> > >>> +    #include <dt-bindings/leds/common.h>
> > >>> +
> > >>> +    rgb-led {
> > >>> +        compatible = "pwm-leds-multicolor";
> > >>> +
> > >>> +        multi-led {
> > >>> +          color = <LED_COLOR_ID_RGB>;
> > >>> +          function = LED_FUNCTION_INDICATOR;
> > >>> +          max-brightness = <65535>;  
> > >>
> > >> It doesn't make much sense to have such a big resolution of global
> > >> multi color brightness. 255 will be sufficient.  
> > > 
> > > If the PWM supports it, why not?
> > > On Omnia the default is 255, and since it is PWM, the change from 0/255
> > > to 1/255 is much bigger then from, say, 15/255 to 16/255. So if 1/255
> > > is too bright, you are then unable to set it less bright. I think 1024
> > > or ever 65535 makes sense with PWMs.  
> > 
> > With values other than 255 we will not achieve 24-bit RGB, which is one
> > problem, and the other one is non-linear brightness that can be achieved
> > with PWM. So probably we would need to add an additional note in the
> > documentation [0], saying that changing global brightness allows to
> > preserve combined LED hue only when all sub-leds are linear, and that it
> > will not be the case for PWM LEDs.
> > 
> > And I propose to change multi-led 'color' DT property value from
> > LED_COLOR_ID_RGB to LED_COLOR_ID_MULTI to avoid the impression that it
> > will work as traditional 24-bit RGB.
> > 
> > [0] Documentation/leds/leds-class-multicolor.rst
> 
> I know that color curves were being discussed at the time multicolor
> was being introduced, and AFAIK Pavel didn't like it, but I don't
> remember the reasons anymore.
> 
> As far as I understand it though, for PWM LEDs there is an equation for
> gamma correction. 

That's right, and it gets a little more complicated if you have RGB
instead of a single LED.  A start for reading might be this:

https://hackaday.com/2016/08/23/rgb-leds-how-to-master-gamma-and-hue-for-perfect-brightness/

(I had bookmarked that back when I was hacking on firmware for an 8bit
microcontroller controlling an RGB LED through soft PWM few years
ago.  A very simple solution is a precalculated static lookup table.)

> So either we need to rename this LED to MULTI, or the
> driver needs to do gamma correction so that the LED behaves RGB.

Do those devices marked as RGB currently, have that gamma correction
integrated on chip? Examples?

Greets
Alex

