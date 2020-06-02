Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2825D1EC520
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBWgY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 18:36:24 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:7122 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgFBWgY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 18:36:24 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2020 15:36:23 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 02 Jun 2020 15:36:22 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id F3B494D82; Tue,  2 Jun 2020 15:36:22 -0700 (PDT)
Date:   Tue, 2 Jun 2020 15:36:22 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: imx27: Fix rounding behavior
Message-ID: <20200602223622.GB470@codeaurora.org>
References: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
 <20200602124835.GF3360525@ulmo>
 <20200602204211.GA1693@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200602204211.GA1693@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 02, 2020 at 01:42:12PM -0700, Guru Das Srinagesh wrote:
> On Tue, Jun 02, 2020 at 02:48:35PM +0200, Thierry Reding wrote:
> > On Thu, Apr 16, 2020 at 10:02:45AM +0200, Uwe Kleine-König wrote:
> > > To not trigger the warnings provided by CONFIG_PWM_DEBUG
> > > 
> > >  - use up-rounding in .get_state()
> > >  - don't divide by the result of a division
> > >  - don't use the rounded counter value for the period length to calculate
> > >    the counter value for the duty cycle
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-imx27.c | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > Applied, thanks.
> > 
> > Thierry
> 
> Hi Thierry,
> 
> Just FYI, This change conflicts with one of my patches [1] in the "Convert
> PWM period and duty cycle to u64" series.
> 
> [1]: https://patchwork.ozlabs.org/project/linux-pwm/patch/848494725fd1240ed877d0a1471dd11ccea01ff5.1590514331.git.gurus@codeaurora.org/

Uploaded v16 that resolves this issue.

Thank you.

Guru Das.
