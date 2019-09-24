Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F46BC191
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 08:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405904AbfIXGBv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 02:01:51 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:44392 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387676AbfIXGBu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 02:01:50 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Sep 2019 23:01:49 -0700
IronPort-SDR: vK8/umuqEFWQ0rVpu8YljNLdhgZhlREppBCK6oa9v8SfwR/Yqrd4zgLnSdn3qmSqVHcpa/DTXO
 28cWDdISNOk2Zf4u7n1H0n6LVqh925nFmAYtMI87L7XJIvRULzLGAj47/bQ6Nwuu9Z0cSkWOKv
 BBZb50Jd9ywj76lKOWzUwRMdu9QXoWE9CZe+tylWw9x9gYIHZ90xYBfwQ4SrybweTYE80awzCE
 N/YXlPpRCMIiGVtd7UZgy9dOCqkrzah/2JIb4QcknMQ6sFtgLcZmzuYkF2l/wa1+dj62JxbV3o
 1bm1e3VVIq6U5IWXU4RgirZZ
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 23 Sep 2019 23:01:49 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 4A1FB467E; Mon, 23 Sep 2019 23:01:49 -0700 (PDT)
Date:   Mon, 23 Sep 2019 23:01:49 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add different PWM output types support
Message-ID: <20190924060149.GB12462@codeaurora.org>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
 <20190916182524.5ebby6pbsbkuahci@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190916182524.5ebby6pbsbkuahci@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 16, 2019 at 08:25:24PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Sep 13, 2019 at 03:57:43PM -0700, Guru Das Srinagesh wrote:
> > From: Fenglin Wu <fenglinw@codeaurora.org>
> > 
> > Normally, PWM channel has fixed output until software request to change
> > its settings. There are some PWM devices which their outputs could be
> > changed autonomously according to a predefined pattern programmed in
> > hardware. Add pwm_output_type enum type to identify these two different
> > PWM types and add relevant helper functions to set and get PWM output
> > types and pattern.
> 
> I have problems to understand what your modulated mode does even after
> reading your commit log and the patch.

Hi Uwe,

I have posted a reply to Thierry's email in which I provide some
background and details about this patch for your review. Hopefully that
clarifies things - I can provide some more clarifications if necessary.

> 
> Also you should note here what is the intended usage and add support for
> it for at least one (preferably more) drivers to make this actually
> usable.

The PWM_OUTPUT_MODULATED mode is useful for PWM peripherals like
Qualcomm's Light Pulse Generator (LPG) that can output a duty-cycle
pattern in hardware as well as output a fixed duty-cycle signal. All
this mode really does is to provide a way for drivers to carry out some
actions for the "pattern" mode of operation that are not required (or
relevant) for the "fixed" mode of operation.

> 
> > Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e
> 
> In Linux we don't use these. You're making it easier to apply your patch
> if you drop the change-id lines.

Sorry, forgot to strip these before sending out the patch.

> 
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 2389b86..ab703f2 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -215,11 +215,60 @@ static ssize_t capture_show(struct device *child,
> >  	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
> >  }
> >  
> > +static ssize_t output_type_show(struct device *child,
> > +			     struct device_attribute *attr,
> > +			     char *buf)
> > +{
> > +	const struct pwm_device *pwm = child_to_pwm_device(child);
> > +	const char *output_type = "unknown";
> > +	struct pwm_state state;
> > +
> > +	pwm_get_state(pwm, &state);
> > +	switch (state.output_type) {
> > +	case PWM_OUTPUT_FIXED:
> > +		output_type = "fixed";
> > +		break;
> > +	case PWM_OUTPUT_MODULATED:
> > +		output_type = "modulated";
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%s\n", output_type);
> > +}
> > +
> > +static ssize_t output_type_store(struct device *child,
> > +			      struct device_attribute *attr,
> > +			      const char *buf, size_t size)
> > +{
> > +	struct pwm_export *export = child_to_pwm_export(child);
> > +	struct pwm_device *pwm = export->pwm;
> > +	struct pwm_state state;
> > +	int ret = -EINVAL;
> > +
> > +	mutex_lock(&export->lock);
> > +	pwm_get_state(pwm, &state);
> > +	if (sysfs_streq(buf, "fixed"))
> > +		state.output_type = PWM_OUTPUT_FIXED;
> > +	else if (sysfs_streq(buf, "modulated"))
> > +		state.output_type = PWM_OUTPUT_MODULATED;
> > +	else
> > +		goto unlock;
> > +
> > +	ret = pwm_apply_state(pwm, &state);
> > +unlock:
> > +	mutex_unlock(&export->lock);
> > +
> > +	return ret ? : size;
> > +}
> 
> So in sysfs you cannot set a pattern. Doesn't that mean this makes using
> modulated mode hardly useful?

The pattern has to be set through the devicetree and not sysfs. Will
change the output type sysfs parameter to read-only.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
