Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269468CC2C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHNHB1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 03:01:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40311 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHNHB1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 03:01:27 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxnHf-0001Go-1r; Wed, 14 Aug 2019 09:01:23 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxnHd-0008VU-W0; Wed, 14 Aug 2019 09:01:21 +0200
Date:   Wed, 14 Aug 2019 09:01:21 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM
 documentation
Message-ID: <20190814070121.o53tj2mtky4hcy3n@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de>
 <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Baolin,

On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
> On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > > +- assigned-clock-parents: The phandle of the parent clock of PWM clock.
> >
> > I'm not sure you need to point out assigned-clocks and
> > assigned-clock-parents as this is general clk stuff. Also I wonder if
> > these should be "required properties".
> 
> I think I should describe any properties used by PWM node, like
> 'clocks' and 'clock-names' properties, though they are common clock
> properties.

Then you might want to describe also "status", "assigned-clock-rates",
"pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-names" and
probably another dozen I'm not aware of.

> Yes, they are required. Thanks for your comments.

required in which sense? Why can a Spreadtrum PWM not work when the
clock parents are unspecified?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
