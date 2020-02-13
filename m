Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64715CCF0
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2020 22:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBMVGt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Feb 2020 16:06:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:18072 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgBMVGt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Feb 2020 16:06:49 -0500
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Feb 2020 13:06:49 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 13 Feb 2020 13:06:49 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 1CEA34AB6; Thu, 13 Feb 2020 13:06:49 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:06:49 -0800
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND v5 2/2] pwm: core: Convert period and duty cycle to u64
Message-ID: <20200213210648.GA12663@codeaurora.org>
References: <cover.1581533161.git.gurus@codeaurora.org>
 <f7986df5d54b2bb84ee14e80d0c1225444608f32.1581533161.git.gurus@codeaurora.org>
 <20200213101802.owpluhixtpor3qi3@pengutronix.de>
 <20200213193926.GA20183@codeaurora.org>
 <20200213202804.pqgbqtphuboqo6af@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213202804.pqgbqtphuboqo6af@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Feb 13, 2020 at 09:28:04PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Feb 13, 2020 at 11:39:26AM -0800, Guru Das Srinagesh wrote:
> > On Thu, Feb 13, 2020 at 11:18:02AM +0100, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > On Wed, Feb 12, 2020 at 10:54:08AM -0800, Guru Das Srinagesh wrote:
> > > > @@ -305,8 +305,8 @@ struct pwm_chip {
> > > >   * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
> > > >   */
> > > >  struct pwm_capture {
> > > > -	unsigned int period;
> > > > -	unsigned int duty_cycle;
> > > > +	u64 period;
> > > > +	u64 duty_cycle;
> > > >  };
> > > 
> > > Is this last hunk a separate change?
> > > 
> > > Otherwise looks fine.
> > 
> > No, this is very much a part of the change and not a separate one.
> 
> Not sure we understand each other. I wondered if conversion of the
> pwm_capture stuff should be done separately. (OTOH I wonder if this is
> used at all and already considered deleting it.)

I see. Could you please elaborate on your concerns? I think this hunk's
being in this patch makes sense as duty and period should be converted
to u64 throughout the file in one go.

Also, it looks like pwm_capture is being used by pwm-sti.c and
pwm-stm32.c currently.

Thank you.

Guru Das.
