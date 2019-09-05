Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80DAA57A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2019 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfIEOK6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Sep 2019 10:10:58 -0400
Received: from muru.com ([72.249.23.125]:59740 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfIEOK6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Sep 2019 10:10:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D319A810D;
        Thu,  5 Sep 2019 14:11:26 +0000 (UTC)
Date:   Thu, 5 Sep 2019 07:10:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
Message-ID: <20190905141053.GU52127@atomide.com>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190905133721.GA728346@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905133721.GA728346@icarus>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* William Breathitt Gray <vilhelm.gray@gmail.com> [190905 13:38]:
> On Sun, Sep 01, 2019 at 05:58:21PM -0500, David Lechner wrote:
> > This series adds device tree bindings and a new counter driver for the Texas
> > Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> > 
> > As mentioned in one of the commit messages, to start with, the driver only
> > supports reading the current counter value and setting the min/max values.
> > Other features can be added as the counter subsystem gains support for them.
...

> I'm satisfied with this version of the patchset.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Jonathan, if you have no objections please pick up this up so that it
> can make it to the 5.4 merge window coming in soon. Alternatively, I can
> merge it into my repository instead and hold it for a while longer
> there, if you prefer that route.

Looks good to me too:

Acked-by: Tony Lindgren <tony@atomide.com>
