Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06DACC63
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2019 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfIHLQb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Sep 2019 07:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbfIHLQa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Sep 2019 07:16:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE5221734;
        Sun,  8 Sep 2019 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567941390;
        bh=wVRmKL60wVlOm/tyjEk55fqdWDRTI9BBf/XK/zL+TVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VMGRFkm61R+D4fz5Nj+NsOd1PDoLkb7AKotZy82PByD2dAvfvbogS2baSK0OUp818
         rz1vpKHcxbrh3Y/XKC/G4CiVHad4/rXmytjJWlv9TQ7KoJ0srrU//LX43f1vBStmji
         jHIK9PpCDOpmT2V84oFZaBa81wHXFsXnGuZfop2Y=
Date:   Sun, 8 Sep 2019 12:16:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
Message-ID: <20190908121618.3e7e5618@archlinux>
In-Reply-To: <20190905141053.GU52127@atomide.com>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190905133721.GA728346@icarus>
 <20190905141053.GU52127@atomide.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 5 Sep 2019 07:10:53 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * William Breathitt Gray <vilhelm.gray@gmail.com> [190905 13:38]:
> > On Sun, Sep 01, 2019 at 05:58:21PM -0500, David Lechner wrote:  
> > > This series adds device tree bindings and a new counter driver for the Texas
> > > Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> > > 
> > > As mentioned in one of the commit messages, to start with, the driver only
> > > supports reading the current counter value and setting the min/max values.
> > > Other features can be added as the counter subsystem gains support for them.  
> ...
> 
> > I'm satisfied with this version of the patchset.
> > 
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > 
> > Jonathan, if you have no objections please pick up this up so that it
> > can make it to the 5.4 merge window coming in soon. Alternatively, I can
> > merge it into my repository instead and hold it for a while longer
> > there, if you prefer that route.  
> 
> Looks good to me too:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Sorry, too close to the likely opening of the 5.4 merge window for it to
go via IIO this cycle (unless there is a significant delay for some reason!)
I'm happy to queue it up for 5.5 but before I do this, see replies to patch 1
about whether an immutable branch is needed as we are going across multiple
trees.

Thanks,

Jonathan


