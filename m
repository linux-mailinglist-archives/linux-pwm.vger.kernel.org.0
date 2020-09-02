Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E9725A915
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBKHR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 2 Sep 2020 06:07:17 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:54560 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBKHQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 06:07:16 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id 45EB644AD6DD;
        Wed,  2 Sep 2020 12:07:14 +0200 (CEST)
Date:   Wed, 2 Sep 2020 12:07:14 +0200
From:   David Jander <david@protonic.nl>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] drivers: pwm: pwm-pcs9685.c: Make comments more
 consistent
Message-ID: <20200902120714.5344af5f@erd988>
In-Reply-To: <20200902070844.bqb6ic7fju4j6wwm@pengutronix.de>
References: <20200828121415.1292388-1-david@protonic.nl>
        <20200828121415.1292388-2-david@protonic.nl>
        <20200902070844.bqb6ic7fju4j6wwm@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2 Sep 2020 09:08:44 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Fri, Aug 28, 2020 at 02:14:13PM +0200, David Jander wrote:
> > Make all explanatory comments start with an uppercase char.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 76cd22bd6614..0f1a3e07e501 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -91,7 +91,7 @@ static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
> >  	mutex_lock(&pca->lock);
> >  	if (pwm_idx >= PCA9685_MAXCHAN) {
> >  		/*
> > -		 * "all LEDs" channel:
> > +		 * "All LEDs" channel:  
> 
> I'd not replace this one, assuming "all LEDs" is a term from the
> datasheet.

It is not really a "term" in the datasheet. The string "all LEDs" occurs twice
in the datasheet, but AFAICS in both cases it is just a regular sentence that
does not imply a special meaning to this string:

"LED output frequency (all LEDs) typically varies from..."

and

"Remark: When all LED outputs are configured..." (which isn't strictly the
same complete string anyway (missing plural form "s").

So, do you still want me to change it? (no problem with me if you insist in a
v3 patch for this).

> >  		 * pretend already in use if any of the PWMs are requested
> >  		 */
> >  		if (!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN)) {
> > @@ -100,7 +100,7 @@ static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)  

Best regards,

-- 
David Jander
Protonic Holland.
