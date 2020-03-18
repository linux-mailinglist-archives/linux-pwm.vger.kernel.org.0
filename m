Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C4189BF8
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRM3u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 08:29:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44994 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCRM3u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 08:29:50 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B40E5F9;
        Wed, 18 Mar 2020 13:29:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584534587;
        bh=gQKuXxEqexrnhnz8x/feE0Di0ED55uUAwf+JiJpuBqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/spN90eRK3QaYE5+ZxO+buNeicgh1W8rrPIX/HsQOvcZ3uN9rmiFxuI0dbp0b1vC
         K1JQ6xrmKf86Gyk5BLH3Tmpw5zUcZ3RlkUE+MYTmhyHefS5u2BYAbK7AtJPxSigihk
         jPLHo1OqgQlNtA+r2vMdak+gThMI29/1R5EViXNg=
Date:   Wed, 18 Mar 2020 14:29:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] dt-bindings: pwm: add description of PWM polarity
Message-ID: <20200318122942.GA7833@pendragon.ideasonboard.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-5-oleksandr.suvorov@toradex.com>
 <20200317230115.GM2527@pendragon.ideasonboard.com>
 <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGgjyvEneCwFM8_tnKfNprqw2qkL_94rpsGF=ZgW-m75JBvegw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Oleksandr,

On Wed, Mar 18, 2020 at 01:37:00PM +0200, Oleksandr Suvorov wrote:
> On Wed, Mar 18, 2020 at 1:02 AM Laurent Pinchart wrote:
> > On Tue, Mar 17, 2020 at 02:32:28PM +0200, Oleksandr Suvorov wrote:
> > > Move the description of the PWM signal polarity from
> > > <linux/pwm.h>, prepare for removing the polarity
> > > definition from <linux/pwm.h>.
> > >
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > > ---
> > >
> > >  include/dt-bindings/pwm/pwm.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> > > index 6b58caa6385e..c07da2088a61 100644
> > > --- a/include/dt-bindings/pwm/pwm.h
> > > +++ b/include/dt-bindings/pwm/pwm.h
> > > @@ -10,7 +10,16 @@
> > >  #ifndef _DT_BINDINGS_PWM_PWM_H
> > >  #define _DT_BINDINGS_PWM_PWM_H
> > >
> > > +/**
> > > + * a high signal for the duration of the duty-cycle, followed by a low signal
> > > + * for the remainder of the pulse period.
> > > + */
> >
> > Last time I checked, kernedoc didn't support documenting macros (enums
> > are supported).
> 
> That's why I dropped the kerneldoc tags leaving the descriptions only.

But you forgot to replace /** with /* :-) Sorry for not being clear
about what I meant.

> > >  #define PWM_POLARITY_NORMAL                  0
> > > +
> > > +/**
> > > + * a low signal for the duration of the duty-cycle, followed by a high signal
> > > + * for the remainder of the pulse period.
> > > + */
> > >  #define PWM_POLARITY_INVERTED                        (1 << 0)
> > >
> > >  #endif

-- 
Regards,

Laurent Pinchart
