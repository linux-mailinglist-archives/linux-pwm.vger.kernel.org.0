Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8773624A8
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhDPPzR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 11:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhDPPy7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 11:54:59 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB0C061574;
        Fri, 16 Apr 2021 08:54:33 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id BA89BC725CF;
        Fri, 16 Apr 2021 17:54:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618588472;
        bh=NNhXDYoC79S3jl0E1hHE8FZsVS7dE0pqNK7RzyynuQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6JcobtsF82hH+WsspU/mpQG3YuMZtuT6nnQ8F3qfyh40O62l3GguyqXZ7wEBDZSI
         zn5GdSH/YhU9IHvwaj0qh7ropwustLYTWKfmIjFaG0VllXat/ZeF3SIpUfHBs4tSPm
         wddnDEQ2XlwugRbRA61Tq8kpRUYcRGEkPV8hwW7k=
Date:   Fri, 16 Apr 2021 17:54:29 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHmzNaxMjPJMcPmK@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <YHmXPyf+XjgJs3C8@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHmXPyf+XjgJs3C8@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 16, 2021 at 03:55:11PM +0200, Thierry Reding wrote:
> On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> >  include/dt-bindings/pwm/pwm.h                 | 1 +
> >  2 files changed, 4 insertions(+)
> 
> Rob, what are your thoughts on this? I've been thinking about this some
> more and I'm having second thoughts about putting this into device tree
> because it doesn't actually describe a property of the PWM hardware but
> rather a use-case specific hint. It's a bit of a gray area because this
> is just part of the PWM specifier which already has use-case specific
> "configuration", such as the period and the polarity.
> 
> Perhaps a better place for this is within the PWM API? We could add the
> same information into struct pwm_state and then consumers that don't
> care about specifics of the signal (such as pwm-backlight) can set that
> flag when they request a state to be applied.

I just want to note that in my opinion, this is not a flag that is
changed often, so is it really a good idea to require setting this
wherever PWM state is applied? Also, this can't be read-out in
.get_state.

Thierry: If this discussion carries on and a v10 is required: Could you
maybe merge the uncontroversial patches 1 to 3 of v9 separately and
maybe get those in 5.12 ? Patches 4 to 8 can probably wait for 5.13 and
have some time in linux-next.

Thanks,
Clemens
