Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668AAACC5E
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2019 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfIHLQ0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Sep 2019 07:16:26 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:52996 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfIHLQ0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Sep 2019 07:16:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C92309E74EA;
        Sun,  8 Sep 2019 12:16:22 +0100 (BST)
Date:   Sun, 8 Sep 2019 12:15:24 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to
 bus subsystem
Message-ID: <20190908121524.49b4874d@archlinux>
In-Reply-To: <20190902150245.GE1445@ulmo>
References: <20190901225827.12301-1-david@lechnology.com>
        <20190901225827.12301-2-david@lechnology.com>
        <20190902150245.GE1445@ulmo>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 2 Sep 2019 17:02:45 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Sun, Sep 01, 2019 at 05:58:22PM -0500, David Lechner wrote:
> > The TI PWMSS driver is a simple bus driver for providing power
> > power management for the PWM peripherals on TI AM33xx SoCs, namely
> > eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
> > it does not make sense to have the bus driver in the PWM subsystem
> > since the PWMSS is not exclusive to PWM devices.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>
> > ---
> > 
> > v3 changes:
> > - none
> > v2 changes:
> > - new patch
> > 
> >  drivers/bus/Kconfig                           | 9 +++++++++
> >  drivers/bus/Makefile                          | 1 +
> >  drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} | 0
> >  drivers/pwm/Kconfig                           | 9 ---------
> >  drivers/pwm/Makefile                          | 1 -
> >  5 files changed, 10 insertions(+), 10 deletions(-)
> >  rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)  
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Do we need an immutable branch for these precursor patches to the
driver addition? It's not going to make 5.4 via my tree as cutting it
too fine so we'll be in the position of holding these in a non obvious
tree for a whole cycle. 

Thanks,

Jonathan


