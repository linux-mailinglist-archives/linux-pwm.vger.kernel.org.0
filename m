Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E785D1A0CBB
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2020 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgDGLSz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Apr 2020 07:18:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgDGLSz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Apr 2020 07:18:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jLmFf-0005po-L5; Tue, 07 Apr 2020 13:18:43 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jLmFe-0002q9-MB; Tue, 07 Apr 2020 13:18:42 +0200
Date:   Tue, 7 Apr 2020 13:18:42 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
Message-ID: <20200407111842.hp7mhrlsuesa74ep@pengutronix.de>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
 <20200405192246.3741784-3-oleksandr.suvorov@toradex.com>
 <20200407061646.pcglaw43kfmrag6a@pengutronix.de>
 <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGgjyvH5nmnXH068QTNPKzsjocNXfEP_yh0HO=L-oGaqQdYRuA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 07, 2020 at 01:51:42PM +0300, Oleksandr Suvorov wrote:
> On Tue, Apr 7, 2020 at 9:17 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Sun, Apr 05, 2020 at 10:22:42PM +0300, Oleksandr Suvorov wrote:
> > > Add the description of PWM_NOFLAGS flag property.
> > >
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> >
> > As I already wrote in reply to the v1 series I'd prefer a name for 0
> > that explicitly handles normal polarity.
> 
> Uwe, AFAIU, there is no flag that forces normal polarity, the normal polarity
> is the default state if there is no flag to invert the polarity is set.

Yes, that's the status quo.

> '0' value in the bit flags cell really means there are no flags set
> for the PWM instance.

For me the relevance of giving 0 a name is mostly for human consumption.
Currently there is only a single flag encoded in the number in question.
But as soon as we add another, say PWM_AUTOSTART we have the following
possible settings:

	PWM_NOFLAGS
	PWM_POLARITY_INVERTED
	PWM_AUTOSTART
	PWM_POLARITY_INVERTED | PWM_AUTOSTART

Then for the first two a reader doesn't see if autostart is not in use
because the dt author doesn't know this feature (e.g. because autostart
is too new) or if they don't want autostart at all.

If however we had PWM_POLARITY_NORMAL and PWM_NO_AUTOSTART to complement
PWM_POLARITY_INVERTED and PWM_AUTOSTART every flag's setting could be
explicit and if there is a device tree that only has

	PWM_POLARITY_NORMAL

it would be obvious that nobody thought enough about autostarting to
explicitly mention it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
