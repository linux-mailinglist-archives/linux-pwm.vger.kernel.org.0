Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F235254
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2019 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFDVyb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Jun 2019 17:54:31 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55592 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFDVyb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Jun 2019 17:54:31 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 018CD803F1;
        Tue,  4 Jun 2019 23:54:25 +0200 (CEST)
Date:   Tue, 4 Jun 2019 23:54:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu.Beznea@microchip.com
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        alexandre.belloni@bootlin.com, bbrezillon@kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
        daniel@ffwll.ch, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Message-ID: <20190604215424.GA1959@ravnborg.org>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
 <20190507182713.GA16862@ravnborg.org>
 <c361b013-2d98-76e3-d30f-cec83000933c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c361b013-2d98-76e3-d30f-cec83000933c@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=toYhtMco48c0QF2qMRYA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Claudiu.

On Tue, Jun 04, 2019 at 04:18:33PM +0000, Claudiu.Beznea@microchip.com wrote:
> Hi Sam,
> 
> On 07.05.2019 21:27, Sam Ravnborg wrote:
> > External E-Mail
> > 
> > 
> > Hi Thierry.
> > 
> >>   pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
> > OK to add the "pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM"
> > patch via drm-misc?
> > Then we can add all 6 patches in one go.
> 
> Since we don't have an answer from Thierry till now, do you think it could
> be feasible to take the rest of the patches in this series? After that I
> will re-send the PWM patch to PWM list.

Thanks for the reminder.

Patches 1,2 and 4,5,6 applied to drm-misc-next.

Reworded changelog a bit in patch 6.

	Sam
