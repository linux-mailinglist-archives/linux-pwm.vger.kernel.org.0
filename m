Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A88189057
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQVbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 17:31:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50237 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVbJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 17:31:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEJnd-0005vE-6Z; Tue, 17 Mar 2020 22:30:57 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEJnc-0004oR-3H; Tue, 17 Mar 2020 22:30:56 +0100
Date:   Tue, 17 Mar 2020 22:30:56 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Message-ID: <20200317213056.futfiwn4qgr2njye@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317174344.GB1464607@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > Add the description of PWM_POLARITY_NORMAL flag.
> > 
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> > index 084886bd721e..440c6b9a6a4e 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > @@ -46,6 +46,7 @@ period in nanoseconds.
> >  Optionally, the pwm-specifier can encode a number of flags (defined in
> >  <dt-bindings/pwm/pwm.h>) in a third cell:
> >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> 
> This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.

"is not part of the DT ABI" is hardly a good reason. If it's sensible to
be used, it is sensible to define it.

(And as far as I understand it, the term PWM_POLARITY_INVERTED isn't
part of the DT ABI either. Only the value 1 has a meaning (for some PWM
controlers).)

> The third cell of the specifier is a bitmask of flags.
> 
> PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
> makes absolutely no sense as a flag.

Using 0 or PWM_POLARITY_NORMAL doesn't have an effect on the compiled
device tree, that's true. But having the term PWM_POLARITY_NORMAL (in
contrast to a plain 0) in a dts file is useful in my eyes for human
readers.

> PWM signals are considered to be "normal" by default, so no flag is
> necessary to specify that.

GPIOs are considered to be active high by default, still there is
GPIO_ACTIVE_HIGH (which also evaluates to 0). Also there is
IRQ_TYPE_NONE.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
