Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518A97FEC6
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfHBQlH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 12:41:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbfHBQlH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Aug 2019 12:41:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so36337075pgj.7;
        Fri, 02 Aug 2019 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CVpBs1wIkzRja/cCCJj5b8klNanFvn6r1661ZlbMMD4=;
        b=rMvXitfas3tyO3EHUbn48F69eylMWeu3gclWOEszcGF1/mNTamg3kk+xjpa8p1dJUD
         YIt2MRS7etmOkbLokPwD7sWbsrHaZQgxclyoG1emouMb3tjOKPO+dSnweHxBtZIHSwJf
         le+8XREQK4y5ybVVXxvYJy2aOfJvg4hx/BJi1NyYpBsCuTxNlDodetsYx8L6Nh/K1hKP
         sATibdKsPcMH7Rdkon82VReKAgmAmKYjL8YxrzrOolpfKfNsE3qYRyZUA75s1DtGIgl/
         j6PeXMInbFZJHOxNbKGZRiwL6NOqICPy6NwD08qsoGTsaY/kVjThb91iXPfAvNsgd6XK
         MTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CVpBs1wIkzRja/cCCJj5b8klNanFvn6r1661ZlbMMD4=;
        b=Uah4k1sbDTpiN8/1O9jQaXnIGVa0RYr1NdIXyjj5NxYxUxE6c+u0ZLyPyTrS0fKZPH
         QA0g9sdU16LF8rZF6qqMRq90N2O8tUKJALtO167T5/AbLiVxMBJtZN36nOT8KKrc4uX7
         ulpvB1n9AkQedzjE7akTg2PrZ534xi37xlY5r5y9MqNP8zEU/ce+KIgireEnaPsRLOVu
         62isNSDlz5YySpE2cPfEfFEYO6j6CtAxvJciM8lUb0t+tFE4G1cnfy5y7djLnyCGxuD5
         roTU5n8r35SbKcsx9gG6flpWDN15fUyHkdGdlqnhyMuMYoXJ8nKY9oZJaC7uE9Vrqs+B
         Dmug==
X-Gm-Message-State: APjAAAV+5x7m6HaAPGQPP5J3ks8EJFBos3mHwM2pDczGyo+XTZ1qVXew
        4M5ZVSTlWeuqM9dYCndBGBk=
X-Google-Smtp-Source: APXvYqw8+Fe+lWBPIIdgGBzLlZW3DfEmtxQ8VIQTrpvsnGrr3fEr53uXM0+LdsTEpy917EkKIxjywQ==
X-Received: by 2002:a62:be02:: with SMTP id l2mr62038253pff.63.1564764065978;
        Fri, 02 Aug 2019 09:41:05 -0700 (PDT)
Received: from icarus ([2001:268:c147:64b2:f351:c489:c6c9:377a])
        by smtp.gmail.com with ESMTPSA id r75sm98477830pfc.18.2019.08.02.09.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 09:41:05 -0700 (PDT)
Date:   Sat, 3 Aug 2019 01:40:45 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Message-ID: <20190802163926.GA29963@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com>
 <20190802092727.GB30522@icarus>
 <680ed555-c5db-6640-8fd3-121422077eff@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <680ed555-c5db-6640-8fd3-121422077eff@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 02, 2019 at 11:17:11AM -0500, David Lechner wrote:
> On 8/2/19 4:27 AM, William Breathitt Gray wrote:
> >> +static const struct counter_ops ti_eqep_counter_ops = {
> >> +	.count_read	= ti_eqep_count_read,
> >> +	.count_write	= ti_eqep_count_write,
> >> +	.function_get	= ti_eqep_function_get,
> >> +	.function_set	= ti_eqep_function_set,
> >> +};
> > Are you able to provide a signal_read function, or are the Signals not
> > exposed to the user by this device? Sometimes quadrature encoder devices
> > provide an instanteous read of the signal lines to tell whether they are
> > high or low, so I figured I'd ask.
> 
> No, it does not look like these signals can be read directly.

All right, in that case you can ignore signal_read.

> > 
> > You should define an action_get function as well along with Synapses
> > corresponding to each Signal. This will allow users to know whether the
> > Synapse fires on a rising edge, falling edge, no edge, or both edges.
> > 
> > For example, consider the drivers/counter/104-quad-8.c file. Each count
> > register has three associated signal lines: Quadrature A, Quadrature B,
> > and Index.
> > 
> > Quadrature A and B are your typical quadrature encoder lines and
> > depending on the function mode selected (quadrature x4, pulse-direction,
> > etc.) could have a Synapse action mode of none, rising edge, falling
> > edge, or both edges; see the quad8_synapse_actions_list array.
> > 
> > In contrast, the Index signal line only has two Synapse action modes:
> > rising edge (in the case preset functionality is enabled) or none.
> 
> The encoders I have don't use the index or strobe signals, so I was
> thinking maybe I should omit those two signals from the driver for the
> time being since I don't have a way of testing.

That should be fine for now. We can add them in a later patch down the
road and keep this introduction patch simple.

William Breathitt Gray
