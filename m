Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AACDB8B9
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502968AbfJQU6I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 16:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502112AbfJQU6I (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Oct 2019 16:58:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FC021D7C;
        Thu, 17 Oct 2019 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571345887;
        bh=ywi2EpqPucJm9ZZBw+AB50L0TzlMJToc3qwSE+LhbPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NSbA2lObggeWzo7orpBJZuEDbJoBePoyCuk7fdcpdksuvCAdILLv7G9ToI5VFarmN
         5CPING3o/snHI5gZUPhkzXx5ZsYwRvZ0IJSot0ZSUjUf73H+rRmhfCzV/j6U+5nnQd
         aVx4DeST9p4L4pIna3E6KyBbmdvse8tApQFUoSLE=
Date:   Thu, 17 Oct 2019 21:58:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to
 bus subsystem
Message-ID: <20191017215751.7d05170c@archlinux>
In-Reply-To: <20190908194447.GM52127@atomide.com>
References: <20190901225827.12301-1-david@lechnology.com>
        <20190901225827.12301-2-david@lechnology.com>
        <20190902150245.GE1445@ulmo>
        <20190908121524.49b4874d@archlinux>
        <20190908194447.GM52127@atomide.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 8 Sep 2019 12:44:48 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Jonathan Cameron <jic23@jic23.retrosnub.co.uk> [190908 11:16]:
> > On Mon, 2 Sep 2019 17:02:45 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >   
> > > On Sun, Sep 01, 2019 at 05:58:22PM -0500, David Lechner wrote:  
> > > > The TI PWMSS driver is a simple bus driver for providing power
> > > > power management for the PWM peripherals on TI AM33xx SoCs, namely
> > > > eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
> > > > it does not make sense to have the bus driver in the PWM subsystem
> > > > since the PWMSS is not exclusive to PWM devices.
> > > > 
> > > > Signed-off-by: David Lechner <david@lechnology.com>
> > > > ---
> > > > 
> > > > v3 changes:
> > > > - none
> > > > v2 changes:
> > > > - new patch
> > > > 
> > > >  drivers/bus/Kconfig                           | 9 +++++++++
> > > >  drivers/bus/Makefile                          | 1 +
> > > >  drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} | 0
> > > >  drivers/pwm/Kconfig                           | 9 ---------
> > > >  drivers/pwm/Makefile                          | 1 -
> > > >  5 files changed, 10 insertions(+), 10 deletions(-)
> > > >  rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)    
> > > 
> > > Acked-by: Thierry Reding <thierry.reding@gmail.com>  
> > 
> > Do we need an immutable branch for these precursor patches to the
> > driver addition? It's not going to make 5.4 via my tree as cutting it
> > too fine so we'll be in the position of holding these in a non obvious
> > tree for a whole cycle.   
> 
> Sure an immutable branch would be nice in case of unlikely
> dts file conflicts. And yeah no need to try to rush to v5.4.
> 
> Regards,
> 
> Tony
immutable branch created based on 5.4-rc1 at:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-ti-eqep-5.4-rc1

I'll pull it into IIO in a few minutes as have one more of these
to do at the same time.  Includes patches 1-4 of this series.

Thanks,

Jonathan

