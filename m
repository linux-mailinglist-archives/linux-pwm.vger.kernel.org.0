Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237244A0438
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Jan 2022 00:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbiA1X0o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jan 2022 18:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiA1X0n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jan 2022 18:26:43 -0500
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0922BC061714;
        Fri, 28 Jan 2022 15:26:43 -0800 (PST)
Received: from thinkpad (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPSA id 77675140E6F;
        Sat, 29 Jan 2022 00:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1643412400; bh=J0xeuUES33SqJ2xHXF/aPhmUmmfVXvoJpgE1mXvIjxA=;
        h=Date:From:To;
        b=i4DuCY2XH24UnVJbBDeWfVj8fQ/o5TQ9wWjAYGvyP7IXbA7cMKW0a3HIvDgVrlLbK
         53TfsAH0mEkXKEa+u+ENiMbNuXOifofCiJcEEyymGf8DkFpvXwELTpmHbyL5tCrtvh
         RsSNnnfjrusIO3VPG5Yg9ks3pBvrlrktySGZT80Y=
Date:   Sat, 29 Jan 2022 00:26:39 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, pavel@ucw.cz
Cc:     sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED
 bindings
Message-ID: <20220129002639.33c7d4c0@thinkpad>
In-Reply-To: <09b46d05-5dd0-a585-2ca3-0bc04e613343@gmail.com>
References: <20220126104844.246068-1-sven@svenschwermer.de>
        <20220126104844.246068-2-sven@svenschwermer.de>
        <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
        <20220128213609.7a60e9fe@thinkpad>
        <09b46d05-5dd0-a585-2ca3-0bc04e613343@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.4 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 29 Jan 2022 00:04:01 +0100
Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:

> On 1/28/22 9:36 PM, Marek Beh=C3=BAn wrote:
> > On Thu, 27 Jan 2022 22:24:21 +0100
> > Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> >  =20
> >> Hi Sven,
> >>
> >> On 1/26/22 11:48 AM, sven@svenschwermer.de wrote: =20
> >>> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> >>>
> >>> This allows to group multiple PWM-connected monochrome LEDs into
> >>> multicolor LEDs, e.g. RGB LEDs.
> >>>
> >>> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies=
.com>
> >>> --- =20
> >> [...] =20
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/leds/common.h>
> >>> +
> >>> +    rgb-led {
> >>> +        compatible =3D "pwm-leds-multicolor";
> >>> +
> >>> +        multi-led {
> >>> +          color =3D <LED_COLOR_ID_RGB>;
> >>> +          function =3D LED_FUNCTION_INDICATOR;
> >>> +          max-brightness =3D <65535>; =20
> >>
> >> It doesn't make much sense to have such a big resolution of global
> >> multi color brightness. 255 will be sufficient. =20
> >=20
> > If the PWM supports it, why not?
> > On Omnia the default is 255, and since it is PWM, the change from 0/255
> > to 1/255 is much bigger then from, say, 15/255 to 16/255. So if 1/255
> > is too bright, you are then unable to set it less bright. I think 1024
> > or ever 65535 makes sense with PWMs. =20
>=20
> With values other than 255 we will not achieve 24-bit RGB, which is one
> problem, and the other one is non-linear brightness that can be achieved
> with PWM. So probably we would need to add an additional note in the
> documentation [0], saying that changing global brightness allows to
> preserve combined LED hue only when all sub-leds are linear, and that it
> will not be the case for PWM LEDs.
>=20
> And I propose to change multi-led 'color' DT property value from
> LED_COLOR_ID_RGB to LED_COLOR_ID_MULTI to avoid the impression that it
> will work as traditional 24-bit RGB.
>=20
> [0] Documentation/leds/leds-class-multicolor.rst

I know that color curves were being discussed at the time multicolor
was being introduced, and AFAIK Pavel didn't like it, but I don't
remember the reasons anymore.

As far as I understand it though, for PWM LEDs there is an equation for
gamma correction. So either we need to rename this LED to MULTI, or the
driver needs to do gamma correction so that the LED behaves RGB.

Pavel, what is your opinion on this?

Marek
