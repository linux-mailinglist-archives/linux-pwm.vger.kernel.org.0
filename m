Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99335CECA
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbhDLQtK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 12:49:10 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:33104 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345363AbhDLQrO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Apr 2021 12:47:14 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 3A59AC725C8;
        Mon, 12 Apr 2021 18:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618246013;
        bh=ddZOwCcmLSLlpehTOdB6y2QZnRm5env2RjYzgjkBfGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCCSXkcvmf3hDLc942ft97uWA4vXCnETVp35x/UuDWMbKYm1EYubMaM4ZBhheRinZ
         MAWgXpViB1EfLMzohLaHIwp0UB82JZaIHrmLcjWCYkjeBVgCTSB1WL+LGkYZYe0StY
         lQUkmivF9qcLTZEKXdDP8GzFrWPPdNaD7Thkui54=
Date:   Mon, 12 Apr 2021 18:46:51 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHR5eyLPqiwhTGrr@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> 
> My concern here in the previous round was that PWM_USAGE_POWER isn't a
> name that intuitively suggests its semantic. Do you disagree?

No. It is more abstract and requires documentation. But I also didn't
want to waste too much time on discussing names, so I used Thierry's
suggestion.

I guess we need his input on this subject. I can live both with
PWM_ALLOW_PHASE_SHIFTING and PWM_USAGE_POWER, as long as it is
documented well enough.

> 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> >  include/dt-bindings/pwm/pwm.h                 | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> > index 084886bd721e..fe3a28f887c0 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > @@ -46,6 +46,9 @@ period in nanoseconds.
> >  Optionally, the pwm-specifier can encode a number of flags (defined in
> >  <dt-bindings/pwm/pwm.h>) in a third cell:
> >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > +- PWM_USAGE_POWER: Only care about the power output of the signal. This
> > +  allows drivers (if supported) to optimize the signals, for example to
> > +  improve EMI and reduce current spikes.
> 
> IMHO there are too many open questions about which freedom this gives to
> the lowlevel driver. If the consumer requests .duty_cycle = 25ns +
> .period = 100ns, can the driver provide .duty_cycle = 25s + .period =
> 100s which nominally has the same power output? Let's not introduce more
> ambiguity than there already is.
> 
> This is a NAck.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


